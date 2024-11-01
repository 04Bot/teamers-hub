--loadstring(game:HttpGet("https://raw.githubusercontent.com/s-o-a-b/nexus/main/loadstring"))()
--loadstring(game:HttpGet('https://raw.githubusercontent.com/04Bot/teamers-hub/refs/heads/main/new-script.lua'))()
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

local function setNoClip(state)
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false  -- Active/désactive la collision
        end
    end
end

-- Fonction pour créer et jouer un tween pour déplacer le Frame interne
local function moveFrame(innerFrame, targetPosition)
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)  -- Durée de 0.1 seconde avec un easing smooth
    local tween = TweenService:Create(innerFrame, tweenInfo, {Position = targetPosition})  -- Crée le tween pour changer la position
    tween:Play()  -- Joue l'animation
end

local farmConnection
local speed = 25  -- Vitesse en unités par seconde

-- Fonction pour trouver la pièce la plus proche dans chaque "CoinContainer"
local function findNearestCoin()
    local closestCoin = nil
    local closestDistance = math.huge

    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj.Name == "CoinContainer" then
            for _, coin in ipairs(obj:GetDescendants()) do
                if coin:IsA("MeshPart") then
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

-- Fonction pour déplacer le joueur vers la pièce la plus proche
local function moveToCoin()
    local coin, distance = findNearestCoin()
    if coin then
        -- Calcul de la durée du tween en fonction de la distance et de la vitesse
        local duration = distance / speed
        
        -- Tween pour le HumanoidRootPart
        local rootTweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local rootTweenGoal = CFrame.new(coin.Position.X, coin.Position.Y, coin.Position.Z)

        local rootTween = TweenService:Create(rootPart, rootTweenInfo, {CFrame = rootTweenGoal})
        rootTween:Play()
        rootTween.Completed:Wait()  -- Attendre que le tween soit terminé
    end
end

-- Fonction pour démarrer l'AutoFarm sans duplications
local function startAutoFarm()
    if not active_AutoFarm then
        active_AutoFarm = true
        setNoClip(true)  -- Active le noclip
        farmConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if active_AutoFarm then
                moveToCoin()
            end
        end)
    end
end

-- Fonction pour arrêter l'AutoFarm
local function stopAutoFarm()
    if farmConnection then
        farmConnection:Disconnect()
        farmConnection = nil
    end
    active_AutoFarm = false
    setNoClip(false)  -- Désactive le noclip
end

-- Gestion du bouton AutoFarm
AutoFarm.MouseButton1Click:Connect(function()
    local outerFrame = AutoFarm:FindFirstChild("Frame")
    local innerFrame = outerFrame:FindFirstChild("Frame")

    if active_AutoFarm then
stopAutoFarm()
        -- Si déjà actif, désactiver et arrêter la chasse aux pièces
        outerFrame.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
        innerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        moveFrame(innerFrame, UDim2.new(0.05, 0, 0.089, 0))  -- Position initiale
        active_AutoFarm = false
    else
startAutoFarm()
        -- Si désactivé, l'activer et commencer la chasse aux pièces
        outerFrame.BackgroundColor3 = Color3.new(0.52549, 0.52549, 0.52549)
        innerFrame.BackgroundColor3 = Color3.new(0, 0, 0)
        moveFrame(innerFrame, UDim2.new(0.5, 0, 0.089, 0))  -- Nouvelle position
        active_AutoFarm = true
    end
end)

-- Réactiver l'AutoFarm après réapparition du personnage
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Redémarrer l'AutoFarm si actif avant le reset
    if active_AutoFarm then
        stopAutoFarm()  -- Pour éviter les duplications
        startAutoFarm() -- Redémarre proprement
    end
end)
