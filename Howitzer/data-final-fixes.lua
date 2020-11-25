-- Checks in case another mod decided to break the effects of other mods on vanilla technologies or overloads them without care...

function FindBiggestResearch(researchName)
    local biggestFound = -1

    for name, tech in pairs(data.raw.technology) do
        local Found = -1
        if string.find(name, researchName) then
            if string.sub(name,-3,-3) == "-" then
                Found = tonumber(string.sub(name, -2))
            else
                Found = tonumber(string.sub(name, -1))
            end

            if Found > biggestFound then
                biggestFound = Found
            end
        end
    end

    return biggestFound
end

function AddEffectToResearch(researchName, effectToAdd)
    local tech = data.raw.technology[researchName]
    if(tech ~= nil) then
        local effectFound = false
        for index, effect in pairs(tech.effects) do
            if( effect.ammo_category == "howitzer-shell" ) then
                effectFound = true
            end
        end
        if(effectFound == false) then
            table.insert(tech.effects, effectToAdd)
        end
    end
end

local biggestDamage = FindBiggestResearch("physical%-projectile%-damage")
local biggestSpeed = FindBiggestResearch("weapon%-shooting%-speed")

if (biggestDamage ~= -1) then
    local effectToAdd =  {type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 0.9}
    
    if(biggestDamage >= 5)  then
        effectToAdd.modifier = 0.9
        AddEffectToResearch("physical-projectile-damage-5", effectToAdd)
    end
    if(biggestDamage >= 6) then
        effectToAdd.modifier = 1.3
        AddEffectToResearch("physical-projectile-damage-6", effectToAdd)
    end

    effectToAdd.modifier = 1.0
    for i= 7, biggestDamage do
        AddEffectToResearch("physical-projectile-damage-" .. tostring(i), effectToAdd)
    end
end

if(biggestSpeed ~= -1) then
    local effectToAdd =  {type = "gun-speed", ammo_category = "howitzer-shell", modifier = 0.8}

    if(biggestSpeed >= 5) then
        AddEffectToResearch("weapon-shooting-speed-5", effectToAdd)
    end
    if(biggestSpeed >= 6) then
        effectToAdd.modifier = 1.5
        AddEffectToResearch("weapon-shooting-speed-6", effectToAdd)
    end

    effectToAdd.modifier = 1.0
    for i= 7, biggestDamage do
        AddEffectToResearch("weapon-shooting-speed-" .. tostring(i), effectToAdd)
    end
end