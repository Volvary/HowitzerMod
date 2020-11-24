-- Check in case another mod decided to break the effects of other mods on vanilla technologies...
local effects = data.raw.technology["physical-projectile-damage-5"].effects
local effectFound = false
for index, effect in pairs(effects) do
    if( effect.ammo_category == "howitzer-shell" ) then
        effectFound = true
    end
end

if (effectFound ~= true) then
    table.insert(data.raw.technology["physical-projectile-damage-5"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 0.9})
    table.insert(data.raw.technology["physical-projectile-damage-6"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 1.3})
    table.insert(data.raw.technology["physical-projectile-damage-7"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 1.0})

    table.insert(data.raw.technology["weapon-shooting-speed-5"].effects,{type = "gun-speed", ammo_category = "howitzer-shell", modifier = 0.8})
    table.insert(data.raw.technology["weapon-shooting-speed-6"].effects,{type = "gun-speed", ammo_category = "howitzer-shell", modifier = 1.5}) 
end