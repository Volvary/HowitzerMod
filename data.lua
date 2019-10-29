function copyPrototype(type, name, newName)
  if not data.raw[type][name] then error("type "..type.." "..name.." doesn't exist") end
  local p = table.deepcopy(data.raw[type][name])
  p.name = newName
  if p.minable and p.minable.result then
    p.minable.result = newName
  end
  if p.place_result then
    p.place_result = newName
  end
  if p.result then
    p.result = newName
  end
  if p.results then
		for _,result in pairs(p.results) do
			if result.name == name then
				result.name = newName
			end
		end
	end
  return p
end


howitzer_cannon = copyPrototype("ammo-turret","gun-turret","howitzer-cannon")
howitzer_cannon.attack_parameters.ammo_category = "howitzer-shell"
howitzer_cannon.attack_parameters.min_range = 25
howitzer_cannon.attack_parameters.range = 50
howitzer_cannon.attack_parameters.cooldown = 5
howitzer_cannon.attack_parameters.turn_range = 0.3333333333333333

howitzer_item = copyPrototype("item","gun-turret","howitzer-cannon")

howitzer_rounds = copyPrototype("ammo", "artillery-shell", "howitzer-shell")
howitzer_rounds.max_range = 40
howitzer_rounds.min_range = 20
howitzer_rounds.ammo_type.category = "howitzer-shell"
howitzer_rounds.icon = "__base__/graphics/icons/cannon-shell.png"

--Add the Howitzer technology to the requirements of the Artillery, to incentivize players to use it as an intermediate.
local artytechpre = data.raw["technology"]["artillery"].prerequisites
artytechpre[#artytechpre+1] = "howitzer-manufacture"

local howitzer_technology = {
	type = "technology",
	name = "howitzer-manufacture",
	icon = "__base__/graphics/technology/artillery.png",
	icon_size = 128,
	effects = {
		{
			recipe = "howitzer-turret-recipe",
			type = "unlock-recipe"
		},
		{
			recipe = "howitzer-shell",
			type = "unlock-recipe"
		},
	},
	prerequisites = {
		"military-3",
	},
	unit = {
        count = 300,
        ingredients = {
          {
            "automation-science-pack",
            1
          },
          {
            "logistic-science-pack",
            1
          },
          {
            "military-science-pack",
            1
          },
          {
            "chemical-science-pack",
            1
          }
        },
        time = 60
    },
}

data:extend({
  {
    type = "ammo-category",
    name = "howitzer-shell"
  },
  {
    type = "recipe",
    name = "howitzer-turret-recipe",
    enabled = "true",
    ingredients =
    {
      {"engine-unit", 3},
      {"iron-gear-wheel", 15},
	  {"steel-plate", 20},
	  {"advanced-circuit", 5},
    },
    energy_required = 30,
    result="howitzer-cannon",
  },
  {
    type = "recipe",
    name = "howitzer-shell",
    enabled = "true",
    ingredients =
    {
      {"explosives", 3},
      {"plastic-bar", 2},
      {"steel-plate", 4},
    },
    energy_required = 8,
    result="howitzer-shell",
  },
  howitzer_cannon,
  howitzer_item,
  howitzer_rounds,
  howitzer_technology,
}
)
