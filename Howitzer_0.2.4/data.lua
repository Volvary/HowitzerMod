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

function setScale(array, scaleRatio)
	for i,v in ipairs(array) do
		if v.hr_version ~= nil then
			if v.hr_version.scale ~= nil then
				v.hr_version.scale = v.hr_version.scale * scaleRatio
			else
				v.hr_version.scale = scaleRatio
			end
		end
		
		if v.scale ~= nil then
			v.scale = v.scale * scaleRatio
		else
			v.scale = scaleRatio
		end
	end
end

local howitzer_cannon = copyPrototype("ammo-turret","gun-turret","howitzer-cannon")
howitzer_cannon.attack_parameters.ammo_category = "howitzer-shell"
howitzer_cannon.attack_parameters.min_range = 25
howitzer_cannon.attack_parameters.range = 50
howitzer_cannon.attack_parameters.turn_range = 0.25
howitzer_cannon.attack_parameters.cooldown = 450
howitzer_cannon.turret_base_has_direction = true

howitzer_cannon.projectile_creation_distance = 500

setScale(howitzer_cannon.attacking_animation, 1.5)
setScale(howitzer_cannon.base_picture.layers, 1.5)
setScale(howitzer_cannon.folded_animation.layers, 1.5)
setScale(howitzer_cannon.folding_animation.layers, 1.5)
setScale(howitzer_cannon.prepared_animation.layers, 1.5)
setScale(howitzer_cannon.preparing_animation.layers, 1.5)

howitzer_cannon.collision_box = {
        {
          -1.05,
          -1.05
        },
        {
          1.05,
          1.05
        }
      }

local howitzer_cannon_MK2 = copyPrototype("ammo-turret","gun-turret","howitzer-cannon-MK2")
howitzer_cannon_MK2.attack_parameters.ammo_category = "howitzer-shell"
howitzer_cannon_MK2.attack_parameters.min_range = 50
howitzer_cannon_MK2.attack_parameters.range = 100
howitzer_cannon_MK2.attack_parameters.turn_range = 0.20
howitzer_cannon_MK2.attack_parameters.cooldown = 750
howitzer_cannon_MK2.turret_base_has_direction = true

howitzer_cannon_MK2.projectile_creation_distance = 500

setScale(howitzer_cannon_MK2.attacking_animation, 1.5)
setScale(howitzer_cannon_MK2.base_picture.layers, 1.5)
setScale(howitzer_cannon_MK2.folded_animation.layers, 1.5)
setScale(howitzer_cannon_MK2.folding_animation.layers, 1.5)
setScale(howitzer_cannon_MK2.prepared_animation.layers, 1.5)
setScale(howitzer_cannon_MK2.preparing_animation.layers, 1.5)

howitzer_cannon_MK2.collision_box = {
        {
          -1.05,
          -1.05
        },
        {
          1.05,
          1.05
        }
      }
	  
local howitzer_item = copyPrototype("item","gun-turret","howitzer-cannon")
local howitzer_MK2_item = copyPrototype("item","gun-turret","howitzer-cannon-MK2")

local howitzer_rounds = {
      type = "ammo",
      ammo_type = {
        action = {
          action_delivery = {
            direction_deviation = 0.2,
            projectile = "howitzer-projectile",
            range_deviation = 0.2,
            source_effects = {
              entity_name = "artillery-cannon-muzzle-flash",
              type = "create-explosion"
            },
            starting_speed = 1,
            type = "artillery"
          },
          type = "direct"
        },
        category = "howitzer-shell",
        target_type = "position"
      },
	  icons = {
		{
			icon = "__base__/graphics/icons/cannon-shell.png",
		},
		{
			icon = "__base__/graphics/icons/cannon-shell.png",
			tint = { a = 0.7, b= 0, g = 0.7, r = 0.7}
		},
	  },
      icon_size = 64,
      name = "howitzer-shell",
      order = "d[explosive-cannon-shell]-d[artillery]",
      stack_size = 20,
	  stackable = true,
      subgroup = "ammo",
	  min_range = 25,
	  max_range = 40,
    }

local howitzer_explosive_rounds = {
      type = "ammo",
      ammo_type = {
        action = {
          action_delivery = {
            direction_deviation = 0.2,
            projectile = "howitzer-explosive-projectile",
            range_deviation = 0.175,
            source_effects = {
              entity_name = "artillery-cannon-muzzle-flash",
              type = "create-explosion"
            },
            starting_speed = 1,
            type = "artillery"
          },
          type = "direct"
        },
        category = "howitzer-shell",
        target_type = "position"
      },
	  icons = {
		{
			icon = "__base__/graphics/icons/explosive-cannon-shell.png",
		},
		{
			icon = "__base__/graphics/icons/explosive-cannon-shell.png",
			tint = { a = 0.7, b= 0, g = 0.7, r = 0.7}
		},
	  },
      icon_size = 64,
      name = "howitzer-explosive-shell",
      order = "d[howitzer-shell]-d[artillery]",
      stack_size = 20,
	  stackable = true,
      subgroup = "ammo",
	  min_range = 40,
	  max_range = 120,
    }
		
local howitzer_projectile = {
      action = {
        action_delivery = {
          target_effects = {
            {
              action = {
                action_delivery = {
                  target_effects = {
                    {
                      damage = {
                        amount = 50,
                        type = "physical"
                      },
                      type = "damage"
                    },
                    {
                      damage = {
                        amount = 150,
                        type = "explosion"
                      },
                      type = "damage"
                    }
                  },
                  type = "instant"
                },
                radius = 6,
                type = "area"
              },
              type = "nested-result"
            },
            {
              initial_height = 0,
              max_radius = 3.5,
              offset_deviation = {
                {
                  -4,
                  -4
                },
                {
                  4,
                  4
                }
              },
              repeat_count = 240,
              smoke_name = "artillery-smoke",
              speed_from_center = 0.05,
              speed_from_center_deviation = 0.005,
              type = "create-trivial-smoke"
            },
            {
              entity_name = "big-explosion",
              type = "create-entity"
            }
          },
          type = "instant"
        },
        type = "direct"
      },
      final_action = {
        action_delivery = {
          target_effects = {
            {
              check_buildability = true,
              entity_name = "small-scorchmark",
              type = "create-entity"
            }
          },
          type = "instant"
        },
        type = "direct"
      },
      flags = {
        "not-on-map"
      },
      height_from_ground = 4.375,
      map_color = {
        b = 0,
        g = 1,
        r = 1
      },
      name = "howitzer-projectile",
      picture = {
        filename = "__base__/graphics/entity/artillery-projectile/hr-shell.png",
        height = 64,
        scale = 0.5,
        width = 64
      },
      shadow = {
        filename = "__base__/graphics/entity/artillery-projectile/hr-shell-shadow.png",
        height = 64,
        scale = 0.5,
        width = 64
      },
	  reveal_map = false,
      type = "artillery-projectile"
    }

local howitzer_explosive_projectile = {
      action = {
        action_delivery = {
          target_effects = {
            {
              action = {
                action_delivery = {
                  target_effects = {
                    {
                      damage = {
                        amount = 50,
                        type = "physical"
                      },
                      type = "damage"
                    },
                    {
                      damage = {
                        amount = 225,
                        type = "explosion"
                      },
                      type = "damage"
                    }
                  },
                  type = "instant"
                },
                radius = 7,
                type = "area"
              },
              type = "nested-result"
            },
            {
              initial_height = 0,
              max_radius = 3.5,
              offset_deviation = {
                {
                  -4,
                  -4
                },
                {
                  4,
                  4
                }
              },
              repeat_count = 240,
              smoke_name = "artillery-smoke",
              speed_from_center = 0.05,
              speed_from_center_deviation = 0.005,
              type = "create-trivial-smoke"
            },
            {
              entity_name = "big-explosion",
              type = "create-entity"
            }
          },
          type = "instant"
        },
        type = "direct"
      },
      final_action = {
        action_delivery = {
          target_effects = {
            {
              check_buildability = true,
              entity_name = "small-scorchmark",
              type = "create-entity"
            }
          },
          type = "instant"
        },
        type = "direct"
      },
      flags = {
        "not-on-map"
      },
      height_from_ground = 4.375,
      map_color = {
        b = 0,
        g = 1,
        r = 1
      },
      name = "howitzer-explosive-projectile",
      picture = {
        filename = "__base__/graphics/entity/artillery-projectile/hr-shell.png",
        height = 64,
        scale = 0.5,
        width = 64
      },
      shadow = {
        filename = "__base__/graphics/entity/artillery-projectile/hr-shell-shadow.png",
        height = 64,
        scale = 0.5,
        width = 64
      },
	  reveal_map = false,
      type = "artillery-projectile"
    }

	
--Add the Howitzer technology to the requirements of the Artillery, to incentivize players to use it as an intermediate.
local artytechpre = data.raw["technology"]["artillery"].prerequisites
artytechpre[#artytechpre+1] = "howitzer-manufacture"
artytechpre[#artytechpre+1] = "howitzer-MK2"

table.insert(data.raw.technology["physical-projectile-damage-5"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 0.9})
table.insert(data.raw.technology["physical-projectile-damage-6"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 1.3})
table.insert(data.raw.technology["physical-projectile-damage-7"].effects,{type = "ammo-damage", ammo_category = "howitzer-shell", modifier = 1.0})

table.insert(data.raw.technology["weapon-shooting-speed-5"].effects,{type = "gun-speed", ammo_category = "howitzer-shell", modifier = 0.8})
table.insert(data.raw.technology["weapon-shooting-speed-6"].effects,{type = "gun-speed", ammo_category = "howitzer-shell", modifier = 1.5})

local howitzer_technology = {
	type = "technology",
	name = "howitzer-manufacture",
	icons = {
		{
			icon = "__base__/graphics/technology/artillery.png"
		},
		{
			icon = "__base__/graphics/technology/artillery.png",
			tint = { a = 0.3,  b = 0.2, g = 0.2, r = 0.2 }
		}
	},
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

local howitzer_MK2_technology = {
	type = "technology",
	name = "howitzer-MK2",
	icons = {
		{
			icon = "__base__/graphics/technology/artillery.png"
		},
		{
			icon = "__base__/graphics/technology/artillery.png",
			tint = { a = 0.3,  b = 0.2, g = 0.2, r = 0.2 }
		}
	},
	icon_size = 128,
	effects = {
		{
			recipe = "howitzer-MK2-turret-recipe",
			type = "unlock-recipe"
		},
		{
			recipe = "howitzer-explosive-shell",
			type = "unlock-recipe"
		},
	},
	prerequisites = {
		"howitzer-manufacture",
		"weapon-shooting-speed-5"
	},
	unit = {
        count = 450,
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
    enabled = "false",
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
    name = "howitzer-MK2-turret-recipe",
    enabled = "false",
    ingredients =
    {
      {"howitzer-cannon", 1},
      {"electric-engine-unit", 3},
	  {"steel-plate", 20},
	  {"advanced-circuit", 5},
    },
    energy_required = 30,
    result="howitzer-cannon-MK2",
  },
  {
    type = "recipe",
    name = "howitzer-shell",
    enabled = "false",
    ingredients =
    {
      {"explosives", 2},
      {"plastic-bar", 2},
      {"steel-plate", 2},
    },
    energy_required = 8,
    result="howitzer-shell",
	result_count = 3,
  },
  {
    type = "recipe",
    name = "howitzer-explosive-shell",
    enabled = "false",
    ingredients =
    {
      {"howitzer-shell", 3},
      {"explosives", 3},
      {"steel-plate", 3},
    },
    energy_required = 8,
    result="howitzer-explosive-shell",
	result_count = 3,
  },
  howitzer_cannon,
  howitzer_item,
  howitzer_rounds,
  howitzer_technology,
  howitzer_projectile,
  
  howitzer_cannon_MK2,
  howitzer_MK2_item,
  howitzer_explosive_rounds,
  howitzer_MK2_technology,
  howitzer_explosive_projectile,
  
}
)
