--loadstring(game:HttpGet("https://raw.githubusercontent.com/04Bot/teamers-hub/refs/heads/main/new-script.lua"))()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/s-o-a-b/nexus/main/loadstring"))()
--loadstring(game:HttpGet("https://raw.githubusercontent.com/04Bot/teamers-hub/refs/heads/main/dex.lua"))()
print('V 1.0.0')

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
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

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local active_AutoFarm = false
local TweenService = game:GetService("TweenService")
local rootTween

-- Fonction pour activer le noclip
local function setNoClip(state)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.CanCollide = not state  -- Active/désactive la collision
        end
    end
end

-- Fonction pour créer et jouer un tween pour déplacer le Frame interne
local function moveFrame(innerFrame, targetPosition)
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  -- Durée de 0.1 seconde avec un easing smooth
    local tween = TweenService:Create(innerFrame, tweenInfo, {Position = targetPosition})  -- Crée le tween pour changer la position
    tween:Play()  -- Joue l'animation
end

local speed = 25  -- Vitesse en unités par seconde

-- Fonction pour trouver la pièce la plus proche dans chaque "CoinContainer"
local function findNearestCoin()
    local closestCoin = nil
    local closestDistance = math.huge

    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj.Name == "CoinContainer" then
            for _, coin in ipairs(obj:GetDescendants()) do
                if coin:IsA("MeshPart") then
                    -- Vérifie si le parent du coin contient un objet "TouchInterest"
                    if not coin.Parent:FindFirstChild("TouchInterest") then
                        -- Si pas de "TouchInterest", passer au prochain coin
                        continue
                    end

                    local distance = (coin.Position - rootPart.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestCoin = coin
                    end
                end
            end
        end
    end

    return closestCoin, closestDistance
end

local isFarming = false

local function moveToCoin()
    if not active_AutoFarm or isFarming then return end

    isFarming = true  -- Définir le drapeau pour empêcher la réexécution
    local coin, distance = findNearestCoin()

    if coin then
        setNoClip(true)

        local coinRemovedConnection
        coinRemovedConnection = coin.AncestryChanged:Connect(function()
            if not coin:IsDescendantOf(workspace) then
                coinRemovedConnection:Disconnect()
                setNoClip(false)
                wait(0.1)
                isFarming = false  -- Réinitialiser le drapeau
                moveToCoin()  -- Relancer la recherche de pièce
            end
        end)

        if distance <= 1 then
            coinRemovedConnection:Disconnect()
            setNoClip(false)
            wait(0.1)
            --coin:Destroy()
            isFarming = false
            moveToCoin()
        elseif distance > 300 then
	    if rootTween then
	    	rootTween:Cancel()
	    end
            rootPart.CFrame = CFrame.new(coin.Position.X, coin.Position.Y + 0.5, coin.Position.Z)
            coinRemovedConnection:Disconnect()
            isFarming = false
            moveToCoin()
        else
            local duration = distance / speed
            local rootTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y, coin.Position.Z)

            rootTween = TweenService:Create(rootPart, rootTweenInfo, {CFrame = rootTweenGoal})
            rootTween:Play()

            rootTween.Completed:Connect(function()
                coinRemovedConnection:Disconnect()
                setNoClip(false)
                wait(0.1)
                isFarming = false
                moveToCoin()
            end)
        end
    else
        print("Aucune pièce trouvée.")
        setNoClip(false)
        isFarming = false
        wait(1)
        moveToCoin()
    end
end

-- Fonction pour démarrer l'auto-farm
local function startAutoFarm()
    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.P = 0
    bodyPosition.D = 0
    bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyPosition.Parent = character.HumanoidRootPart
	
    active_AutoFarm = true
    moveToCoin()  -- Lancer la chasse à la première pièce
end

-- Fonction pour arrêter l'auto-farm
local function stopAutoFarm()
    active_AutoFarm = false
    setNoClip(false)
end

-- Gestion du bouton AutoFarm
AutoFarm.MouseButton1Click:Connect(function()
    local outerFrame = AutoFarm:FindFirstChild("Frame")
    local innerFrame = outerFrame:FindFirstChild("Frame")

    if active_AutoFarm then
		active_AutoFarm = false
        -- Si déjà actif, désactiver et arrêter la chasse aux pièces
        outerFrame.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
        innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
		stopAutoFarm()
    else
		active_AutoFarm = true
        -- Si désactivé, l'activer et commencer la chasse aux pièces
        outerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
		startAutoFarm()
    end
end)

local function reset()
	local coinText = player.PlayerGui.MainGUI.Game.CoinBags.Container.Candy.CurrencyFrame.Icon.Coins

	coinText:GetPropertyChangedSignal("Text"):Connect(function()
	print(coinText.Text)
	if coinText.Text == "40" then
		print("yh")
		player.Character.Humanoid.Health = 0
	end
end)
end

-- Gestion des personnages
local function onCharacterAdded(newCharacter)
    character = newCharacter
    rootPart = character:WaitForChild("HumanoidRootPart")

    if active_AutoFarm then
		stopAutoFarm()
        wait(2)
		startAutoFarm()
		reset()
    end
end

-- Initialisation
player.CharacterAdded:Connect(onCharacterAdded)
character = player.Character or player.CharacterAdded:Wait()
rootPart = character:WaitForChild("HumanoidRootPart")
