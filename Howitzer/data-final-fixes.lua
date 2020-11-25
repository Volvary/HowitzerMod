-- Check in case another mod decided to break the effects of other mods on vanilla technologies...
-- local effects = data.raw.technology["physical-projectile-damage-5"].effects
-- local effectFound = false
-- for index, effect in pairs(effects) do
--     if( effect.ammo_category == "howitzer-shell" ) then
--         effectFound = true
--     end
-- end

-- if (effectFound ~= true) then


--     table.insert(data.raw.technology["physical-projectile-damage-5"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 0.9})
--     table.insert(data.raw.technology["physical-projectile-damage-6"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 1.3})
--     table.insert(data.raw.technology["physical-projectile-damage-7"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 1.0})

--     table.insert(data.raw.technology["weapon-shooting-speed-5"].effects,{type = "gun-speed", ammo_category = "howitzer-shell", modifier = 0.8})
--     table.insert(data.raw.technology["weapon-shooting-speed-6"].effects,{type = "gun-speed", ammo_category = "howitzer-shell", modifier = 1.5}) 
-- end

function FindBiggestResearch(start, researchName){
    local it = start
    local biggestFound = -1
    while (true){
        if (data.raw.technology[researchName + "-" + it] ~= nil){
            biggestFound = it
        } else{
            break
        }
    }
    return it
}

function AddEffectToResearch(researchName, effectToAdd){
    local tech = data.raw.technology[researchName]
    if(tech ~= nil){
        local effectFound = false
        for index, effect in pairs(effects) do
            if( effect.ammo_category == "howitzer-shell" ) then
                effectFound = true
            end
        end
        if(effectFound == false){
            table.insert(tech.effects, effectToAdd)
        }
    }
}

local biggestDamage = FindBiggestResearch(5, "physical-projectile-damage")
local biggestSpeed = FindBiggestResearch(5, "weapon-shooting-speed")

if (biggestDamage ~= -1){
    local effectToAdd = {type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 0.9}
    
    if(biggestDamage >= 5){
        effectToAdd.modifier = 0.9
        AddEffectToResearch("physical-projectile-damage-5", effectToAdd)
    }
    if(biggestDamage >= 6){
        effectToAdd.modifier = 1.3
        AddEffectToResearch("physical-projectile-damage-6", effectToAdd)
    }

    effectToAdd.modifier = 1.0
    for i= 7, biggestDamage do
        AddEffectToResearch("physical-projectile-damage-"+i, effectToAdd)
    end
}

if(biggestSpeed ~= -1){
    local effectToAdd = {type = "gun-speed", ammo_category = "howitzer-shell", modifier = 0.8}

    if(biggestSpeed >= 5){
        AddEffectToResearch("weapon-shooting-speed-5", effectToAdd)
    }
    if(biggestSpeed >= 6){
        effectToAdd.modifier = 1.5
        AddEffectToResearch("weapon-shooting-speed-6", effectToAdd)
    }

    effectToAdd.modifier = 1.0
    for i= 7, biggestDamage do
        AddEffectToResearch("weapon-shooting-speed-"+i, effectToAdd)
    end
}