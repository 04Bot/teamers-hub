local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer.PlayerGui
gui.ResetOnSpawn = false
gui.AutoLocalize = false

local main = Instance.new("Frame")
main.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 300, 0, 300)
main.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 19)
UICorner.Parent = main

local AutoFarm = Instance.new("TextButton")
AutoFarm.Text = "Auto Farm"
AutoFarm.TextXAlignment = Enum.TextXAlignment.Left
AutoFarm.TextSize = 8
AutoFarm.TextColor3 = Color3.new(1, 1, 1)
AutoFarm.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
AutoFarm.Position = UDim2.new(0.023, 0, 0.177, 0)
AutoFarm.Size = UDim2.new(0, 287, 0, 40)
AutoFarm.Parent = main

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = AutoFarm

local on = Instance.new("Frame")
on.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
on.Position = UDim2.new(0.847, 0, 0.25, 0)
on.Size = UDim2.new(0, 34, 0, 19)
on.Parent = AutoFarm

local UICorner_on = Instance.new("UICorner")
UICorner_on.CornerRadius = UDim.new(0, 19)
UICorner_on.Parent = on

local UIStroke_on = Instance.new("UIStroke")
UIStroke_on.Color = Color3.new(0.52549, 0.52549, 0.52549)
UIStroke_on.Parent = on

local frame_on = Instance.new("Frame")
frame_on.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
frame_on.Position = UDim2.new(0.05, 0, 0.079, 0)
frame_on.Size = UDim2.new(0, 15, 0, 15)
frame_on.Parent = on

local UICorner_on_2 = Instance.new("UICorner")
UICorner_on_2.CornerRadius = UDim.new(0, 50)
UICorner_on_2.Parent = frame_on

-- Fixing RandomCoin Button
local RandomCoin = Instance.new("TextButton")
RandomCoin.Text = "Random Coin"
RandomCoin.TextXAlignment = Enum.TextXAlignment.Left
RandomCoin.TextSize = 8
RandomCoin.TextColor3 = Color3.new(1, 1, 1)
RandomCoin.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
RandomCoin.Position = UDim2.new(0.023, 0, 0.33, 0) -- Correcting the position slightly for alignment
RandomCoin.Size = UDim2.new(0, 287, 0, 40)
RandomCoin.Parent = main -- Added this to fix the missing parent

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 10)
UICorner3.Parent = RandomCoin

local on2 = Instance.new("Frame")
on2.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
on2.Position = UDim2.new(0.847, 0, 0.25, 0)
on2.Size = UDim2.new(0, 34, 0, 19)
on2.Parent = RandomCoin -- Fixed the parent to point to RandomCoin

local UICorner_on2 = Instance.new("UICorner")
UICorner_on2.CornerRadius = UDim.new(0, 19)
UICorner_on2.Parent = on2

local UIStroke_on2 = Instance.new("UIStroke")
UIStroke_on2.Color = Color3.new(0.52549, 0.52549, 0.52549)
UIStroke_on2.Parent = on2

local frame_on2 = Instance.new("Frame")
frame_on2.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
frame_on2.Position = UDim2.new(0.05, 0, 0.079, 0)
frame_on2.Size = UDim2.new(0, 15, 0, 15)
frame_on2.Parent = on2

local UICorner_on_22 = Instance.new("UICorner")
UICorner_on_22.CornerRadius = UDim.new(0, 50)
UICorner_on_22.Parent = frame_on2

local TweenService = game:GetService("TweenService")  -- Service pour gérer les animations
local active_RandomCoin = false
local active = false  -- État initial
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()  -- Attends que le personnage soit chargé
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")  -- Cible le HumanoidRootPart
local tween  -- Variable globale pour le tween en cours
local speed = 22  -- Vitesse constante de 22 unités par seconde
local detectionRadius = 5

-- Fonction pour créer et jouer un tween pour déplacer le Frame interne
local function moveFrame(innerFrame, targetPosition)
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  -- Durée de 0.1 seconde avec un easing smooth
	local tween = TweenService:Create(innerFrame, tweenInfo, {Position = targetPosition})  -- Crée le tween pour changer la position
	tween:Play()  -- Joue l'animation
end

local delayBetweenActions = 1  -- Délai de 0.5 seconde après avoir collecté la pièce
local lobbyStayDuration = 2  -- Temps de séjour dans le lobby avant de reprendre la chasse aux pièces

-- Ajuste la téléportation vers la pièce en évitant de cumuler le décalage
local function teleportToCoin(coin)
    if coin and humanoidRootPart then
        -- Remplacer cette ligne :
        -- humanoidRootPart.Position = coin.Position
        -- Par celle-ci :
        humanoidRootPart.CFrame = CFrame.new(coin.Position)  -- Téléportation directe en CFrame
    else
        print("Erreur : coin ou humanoidRootPart est nil.")
    end
end

-- Correction similaire pour la téléportation au spawn aléatoire
local function getRandomSpawn()
    local spawns = game.Workspace.Lobby.Spawns:GetChildren()
    local validSpawns = {}

    for _, spawn in ipairs(spawns) do
        if spawn:IsA("BasePart") then
            table.insert(validSpawns, spawn)
        end
    end

    if #validSpawns > 0 then
        local randomSpawn = validSpawns[math.random(1, #validSpawns)]
        -- Remplacer ici aussi la Position par CFrame pour éviter un cumul vertical :
        humanoidRootPart.CFrame = CFrame.new(randomSpawn.Position + Vector3.new(0, 3, 0))
        return randomSpawn
    end

    return nil
end

-- Fonction pour désactiver les collisions du personnage
local function setCollisions(enabled)
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = enabled
        end
    end
end

-- Fonction pour obtenir la pièce la plus proche
local function getNearestCoin()
    local nearestCoin = nil
    local shortestDistance = math.huge

    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj.Name == "CoinContainer" then
            for _, coin in ipairs(obj:GetDescendants()) do
                if coin:IsA("MeshPart") then
                    local distance = (coin.Position - humanoidRootPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestCoin = coin
                    end
                end
            end
        end
    end

    return nearestCoin
end

-- Fonction pour obtenir une pièce aléatoire
local function getRandomCoin()
    local coins = {}
    for _, coin in ipairs(game.Workspace:FindFirstChild("CoinContainer"):GetDescendants()) do
        if coin:IsA("MeshPart") then
            table.insert(coins, coin)
        end
    end

    if #coins > 0 then
        return coins[math.random(1, #coins)]
    end

    return nil
end

-- Fonction principale pour la chasse aux pièces
local function startCoinHunt()
    if active then
        local currentCoin

        if active_RandomCoin then
            currentCoin = getRandomCoin()
        else
            currentCoin = getNearestCoin()
        end

        setCollisions(false)

        while active do
            wait(0.1)

            if currentCoin and currentCoin:IsDescendantOf(game.Workspace) then
                teleportToCoin(currentCoin)  -- Téléporte le joueur vers la pièce

                -- Attendre 0.5 seconde après la téléportation à la pièce
                wait(delayBetweenActions)

                if (currentCoin.Position - humanoidRootPart.Position).Magnitude <= 5 then
                    print("Pièce collectée : " .. currentCoin.Name)
                    currentCoin:Destroy()  -- Simuler la collecte de la pièce

                    -- Téléportation au lobby
                    local randomSpawn = getRandomSpawn()
                    if randomSpawn then
                        humanoidRootPart.Position = randomSpawn.Position + Vector3.new(0, 3, 0)
                    else
                        print("Aucun spawn valide trouvé dans le lobby.")
                    end

                    -- Attendre 1 seconde dans le lobby avant de reprendre
                    wait(lobbyStayDuration)

                    -- Sélectionner la prochaine pièce
                    if active_RandomCoin then
                        currentCoin = getRandomCoin()
                    else
                        currentCoin = getNearestCoin()
                    end
                end
            else
                -- Si la pièce est détruite ou n'existe plus, rechercher une nouvelle pièce
                if active_RandomCoin then
                    currentCoin = getRandomCoin()
                else
                    currentCoin = getNearestCoin()
                end
            end
        end

        setCollisions(true)
    end
end

-- Fonction pour reconfigurer le personnage lors du respawn
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    if active then
        startCoinHunt()  -- Relancer le farm après respawn
    end
end

-- Gestion des respawns
player.CharacterAdded:Connect(onCharacterAdded)

-- Initialisation du personnage actuel
if character then
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

-- Gestion du bouton AutoFarm
AutoFarm.MouseButton1Click:Connect(function()
    local outerFrame = AutoFarm:FindFirstChild("Frame")
    local innerFrame = outerFrame:FindFirstChild("Frame")

    if active then
        -- Si déjà actif, désactiver et arrêter la chasse aux pièces
        outerFrame.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
        innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
        active = false
    else
        -- Si désactivé, l'activer et commencer la chasse aux pièces
        outerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
        active = true

        -- Démarrer la chasse aux pièces
        startCoinHunt()
    end
end)

-- Gestion du bouton RandomCoin
RandomCoin.MouseButton1Click:Connect(function()
    local outerFrame = RandomCoin:FindFirstChild("Frame")
    local innerFrame = outerFrame:FindFirstChild("Frame")

    if active_RandomCoin then
        outerFrame.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
        innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
        active_RandomCoin = false
    else
        outerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
        active_RandomCoin = true
    end
end)
