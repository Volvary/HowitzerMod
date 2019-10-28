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
howitzer_cannon.attack_parameters.ammo_category = "artillery-shell"
howitzer_cannon.min_range = 20
howitzer_cannon.range = 40
howitzer_cannon.turn_range = 0.3333333333333333

howitzer_item = copyPrototype("item","gun-turret","howitzer-cannon")

howitzer_rounds = copyPrototype("ammo", "artillery-shell", "howitzer-shell")
howitzer_rounds.max_range = 40
howitzer_rounds.min_range = 20

data:extend({
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
}
)
