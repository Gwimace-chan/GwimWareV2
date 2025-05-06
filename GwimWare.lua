-- UniversalHub.lua (LocalScript in StarterPlayerScripts)
-- UI: Orion Library
local Orion = loadstring(game:HttpGet('https://raw.githubusercontent.com/OrionLibrary/Orion/main/lib.lua'))()
local Window = Orion:CreateWindow({
    Name = "Universal Hub",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "UniversalHub",
    ConfigFile = "Default"
})

-- SERVICES & VARS
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer, Camera, Mouse = Players.LocalPlayer, workspace.CurrentCamera, Players.LocalPlayer:GetMouse()
local AimEnabled, AimFOV, TeamCheck = false, 90, true

-- UTILITY: get closest target in FOV
local function getClosest()
    local best, bestDist
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if not TeamCheck or plr.Team~=LocalPlayer.Team then
                local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X,pos.Y) - Vector2.new(Mouse.X,Mouse.Y)).Magnitude
                    if dist<=AimFOV and (not bestDist or dist<bestDist) then
                        bestDist, best = dist, plr
                    end
                end
            end
        end
    end
    return best
end

-- AIMBOT TAB
local AimTab = Window:CreateTab("Aimbot", 1234567890)
AimTab:CreateToggle({
    Name = "Enable Aimbot", CurrentValue = false,
    Flag = "AimToggle",
    Callback = function(v) AimEnabled = v end
})
AimTab:CreateSlider({
    Name = "FOV", Range = {0,300}, Increment = 1, Suffix = "°", CurrentValue = 90,
    Flag = "AimFOV",
    Callback = function(v) AimFOV = v end
})
AimTab:CreateToggle({
    Name = "Team Check", CurrentValue = true,
    Flag = "TeamCheck",
    Callback = function(v) TeamCheck = v end
})

-- SCRIPTS TAB
local ScriptsTab = Window:CreateTab("Scripts", 9876543210)
ScriptsTab:CreateButton({
    Name = "Inject Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})
ScriptsTab:CreateButton({
    Name = "Inject CMD-X",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source'))()
    end
})
ScriptsTab:CreateButton({
    Name = "Inject Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/SPDM-Team/ArceusX-V3-Scripts/main/Dex-Explorer.lua'))()
    end
})

-- RENDER LOOP
RunService.RenderStepped:Connect(function()
    if AimEnabled then
        local target = getClosest()
        if target and target.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.Head.Position)
        end
    end
end)

Orion:Init()
