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
local teleportDistance = 1000  -- Distance maximale avant téléportation
local offsetBelowCoin = 5  -- Distance sous la pièce

-- Fonction pour créer et jouer un tween pour déplacer le Frame interne
local function moveFrame(innerFrame, targetPosition)
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  -- Durée de 0.1 seconde avec un easing smooth
	local tween = TweenService:Create(innerFrame, tweenInfo, {Position = targetPosition})  -- Crée le tween pour changer la position
	tween:Play()  -- Joue l'animation
end

-- Fonction pour obtenir la pièce la plus proche
local function getNearestCoin()
    local nearestCoin = nil
    local shortestDistance = math.huge

    -- Parcours tous les objets dans le Workspace
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

-- Fonction pour téléporter le joueur à la pièce
local function teleportToCoin(coin)
	-- Désactive les collisions pour permettre au joueur de traverser les murs
	humanoidRootPart.CanCollide = false

	-- Positionne le joueur directement sous la pièce (offsetBelowCoin unités en dessous)
	humanoidRootPart.Position = Vector3.new(coin.Position.X, coin.Position.Y - offsetBelowCoin, coin.Position.Z)

	-- Réactive les collisions après une courte période
	wait(0.1)
	humanoidRootPart.CanCollide = true
end

local lastCoinPosition  -- Variable pour stocker la dernière position d'une pièce

-- Fonction pour déplacer le joueur vers une pièce à une vitesse constante ou téléporter si trop loin
local function moveToCoin(coin)
	if coin and humanoidRootPart then
		local distance = (coin.Position - humanoidRootPart.Position).Magnitude
		lastCoinPosition = coin.Position  -- Sauvegarde la position de la pièce

		-- Si la distance est supérieure à 1000 unités, téléportation
		if distance > teleportDistance then
			teleportToCoin(coin)
		else
			-- Maintenir les collisions activées

			-- Calculer la durée du déplacement en fonction de la distance et de la vitesse
			local duration = distance / speed
			local targetPosition = CFrame.new(coin.Position)  -- Aller directement sur la position de la pièce

			-- Crée un tween pour déplacer le HumanoidRootPart
			local tween = TweenService:Create(humanoidRootPart, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = targetPosition})
			tween:Play()
		end
	else
		lastCoinPosition = nil  -- Réinitialiser si aucune pièce n'est trouvée
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

local isHuntRunning = false  -- Variable pour indiquer si la chasse aux pièces est en cours

-- Fonction principale pour la collecte automatique de pièces
local function startCoinHunt()
    if not active then return end

    local currentCoin = getNearestCoin()

    while active do
        wait(0.1)  -- Petite pause pour limiter les vérifications

        -- Vérifie si la pièce actuelle est toujours valide
        if currentCoin and isNearCoin(currentCoin) then
            -- Déplace le joueur à la position de la pièce sans tween
            humanoidRootPart.Position = currentCoin.Position + Vector3.new(0, 3, 0)  -- Position légèrement au-dessus de la pièce

            -- Choisit une nouvelle pièce après avoir atteint la pièce actuelle
            currentCoin = getNearestCoin()
        else
            -- Se déplacer directement vers la pièce si pas assez proche
            if currentCoin then
                humanoidRootPart.Position = currentCoin.Position + Vector3.new(0, 3, 0)  -- Déplace vers la pièce
            end
        end
    end
end

-- Gestion des respawns
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    -- Ne démarre la chasse que si elle est active et pas déjà en cours
    if active and not isHuntRunning then
        startCoinHunt()
    end
end)

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
