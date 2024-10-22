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

local TweenService = game:GetService("TweenService")  -- Service pour gérer les animations
local active = false  -- État initial pour AutoFarm
local active_RandomCoin = false -- État initial pour RandomCoin
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()  -- Attends que le personnage soit chargé
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")  -- Cible le HumanoidRootPart
local tween  -- Variable globale pour le tween en cours
local speed = 22  -- Vitesse constante de 22 unités par seconde
local detectionRadius = 5

-- Fonction pour désactiver les collisions
local function disableCollisions(character)
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then  -- Vérifie si c'est une partie physique du corps
            part.CanCollide = false  -- Désactive les collisions
        end
    end
    print("Collisions du personnage désactivées.")
end

-- Fonction pour réactiver les collisions
local function enableCollisions(character)
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = true  -- Réactive les collisions
        end
    end
    print("Collisions du personnage réactivées.")
end

-- Fonction pour obtenir la pièce la plus proche
local function getNearestCoin()
    local nearestCoin = nil
    local shortestDistance = math.huge  -- Initialiser avec une valeur très grande

    -- Cherche "CoinContainer" partout dans l'arborescence du Workspace
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

    if nearestCoin then
        print("Pièce la plus proche trouvée : " .. nearestCoin.Name)
    else
        print("Aucune pièce trouvée.")
    end

    return nearestCoin
end

-- Fonction pour obtenir une pièce aléatoire dans le Workspace
local function getRandomCoin()
    local coins = {}

    -- Parcourt tous les objets dans le Workspace pour trouver ceux qui sont des pièces
    for _, coin in ipairs(game.Workspace:FindFirstChild("CoinContainer"):GetDescendants()) do
        if coin:IsA("MeshPart") then
            table.insert(coins, coin)  -- Ajoute la pièce dans la table
        end
    end

    -- Si des pièces sont trouvées, retourne une pièce aléatoire
    if #coins > 0 then
        return coins[math.random(1, #coins)]  -- Sélectionne et retourne une pièce aléatoire
    end

    -- Si aucune pièce n'est trouvée, retourne nil
    return nil
end

-- Fonction pour déplacer le joueur vers une pièce à une vitesse constante
local function moveToCoin(coin)
    if coin and humanoidRootPart then
        local distance = (coin.Position - humanoidRootPart.Position).Magnitude
        local duration = distance / speed  -- Calcule la durée du déplacement en fonction de la distance et de la vitesse

        -- Conserve la hauteur actuelle du joueur, mais change la position en X et Y pour se déplacer vers la pièce
        local targetPosition = humanoidRootPart.Position
        local targetCF = CFrame.new(coin.Position.X, targetPosition.Y, coin.Position.Z)

        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        -- Si un tween est déjà en cours, on le stoppe
        if tween then
            tween:Cancel()
        end

        -- Crée un nouveau tween vers la position de la pièce tout en maintenant la hauteur
        tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCF})
        tween:Play()
    end
end

-- Fonction pour vérifier si le joueur est assez proche de la pièce
local function isNearCoin(coin)
    if coin and humanoidRootPart then
        local distance = (coin.Position - humanoidRootPart.Position).Magnitude
        return distance <= detectionRadius  -- Retourne vrai si la distance est inférieure ou égale au rayon de détection
    end
    return false
end

-- Fonction principale pour la chasse aux pièces
local function startCoinHunt()
    if active then
        local currentCoin

        -- Choisit la pièce initiale en fonction de l'état de RandomCoin
        if active_RandomCoin then
            currentCoin = getRandomCoin()  -- Sélectionne une pièce aléatoire
        else
            currentCoin = getNearestCoin()  -- Sélectionne la pièce la plus proche
        end

        -- Désactiver la gravité pendant la collecte
        humanoidRootPart.Anchored = true

        while active do
            wait(0.1)  -- Petite pause pour limiter les vérifications

            -- Vérifie si la pièce actuelle existe encore
            if currentCoin and currentCoin:IsDescendantOf(game.Workspace) then
                moveToCoin(currentCoin)  -- Déplace le joueur vers la pièce actuelle

                -- Vérifie si le joueur est suffisamment proche de la pièce
                if isNearCoin(currentCoin) then
                    print("Pièce collectée : " .. currentCoin.Name)  -- Imprime le nom de la pièce collectée

                    -- Détruire la pièce pour simuler la collecte
                    currentCoin:Destroy()  -- Assure-toi que la pièce soit détruite dans le jeu

                    -- Sélectionne une nouvelle pièce après la collecte
                    if active_RandomCoin then
                        currentCoin = getRandomCoin()  -- Sélectionne une nouvelle pièce aléatoire
                    else
                        currentCoin = getNearestCoin()  -- Sélectionne la nouvelle pièce la plus proche
                    end
                end
            else
                print("Aucune pièce actuelle ou pièce détruite. Recherche d'une nouvelle pièce.")
                -- Si currentCoin est nil ou n'est plus valide, recherche une nouvelle pièce
                if active_RandomCoin then
                    currentCoin = getRandomCoin()  -- Recherche une nouvelle pièce aléatoire
                else
                    currentCoin = getNearestCoin()  -- Recherche la pièce la plus proche
                end
            end
        end

        -- Réactiver la gravité après la collecte
        humanoidRootPart.Anchored = false
    end
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

        -- Réactiver les collisions quand on arrête l'AutoFarm
        enableCollisions(character)
    else
        -- Si désactivé, l'activer et commencer la chasse aux pièces
        outerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
        active = true

        -- Désactiver les collisions quand l'AutoFarm est activé
        disableCollisions(character)

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
