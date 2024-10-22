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

-- Fonction pour obtenir la pièce la plus proche
local function getNearestCoin()
	local nearestCoin = nil
	local shortestDistance = math.huge  -- Initialiser avec une valeur très grande

	-- Chercher "Normal" partout dans l'arborescence du Workspace
	local normal = nil
	for _, obj in ipairs(game.Workspace:GetDescendants()) do
    		if obj.Name == "Normal" then
        		normal = obj
        		break  -- Sortir de la boucle dès qu'on trouve "Normal"
    		end
	end

	-- Vérifier si "Normal" a été trouvé
	if normal then
    		local coinContainer = normal:FindFirstChild("CoinContainer")
    		if coinContainer then
        		for _, coin in ipairs(coinContainer:GetDescendants()) do
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
end

-- Fonction pour obtenir une pièce aléatoire dans le Workspace
local function getRandomCoin()
	local coins = {}

	-- Parcourt tous les objets dans le Workspace pour trouver ceux qui sont des pièces
	for _, coin in ipairs(game.Workspace:FindFirstChild("Normal"):FindFirstChild("CoinContainer"):GetDescendants()) do
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
local function moveToCoin(coin, callback)
	if coin and humanoidRootPart then
		local distance = (coin.Position - humanoidRootPart.Position).Magnitude
		local duration = distance / speed  -- Calcule la durée du déplacement en fonction de la distance et de la vitesse

		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local targetPosition = {CFrame = CFrame.new(coin.Position)}

		-- Si un tween est déjà en cours, on le stoppe
		if tween then
			tween:Cancel()
		end

		-- Crée un nouveau tween
		tween = TweenService:Create(humanoidRootPart, tweenInfo, targetPosition)
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
	-- Si on est dans la boucle active
	if active then
		local currentCoin = getNearestCoin() -- Sélectionne une pièce aléatoire

		while active and currentCoin do
			wait(0.1)  -- Petite pause pour limiter les vérifications

			-- Déplace le joueur vers la pièce
			moveToCoin(currentCoin)
			
			currentCoin = getNearestCoin()
		end
	end
end

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
