local Orion = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/OrionLibrary/Orion/main/lib.lua",
    true
))()

local Window = Orion:CreateWindow({ Name = "GwimWare Aimbot Test" })

-- Aimbot Tab only
local AimTab = Window:CreateTab("Aimbot")
AimTab:CreateToggle({
    Name = "Enable Aimbot",
    CurrentValue = false,
    Callback = function(v) print("Aimbot toggled:", v) end
})

Orion:Init()
print("🎯 Aimbot tab loaded!")
