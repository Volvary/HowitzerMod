script.on_init(function()
    for index,force in pairs(game.forces) do
        if (force.valid) then
            force.reset_technology_effects()
        end
      end
  end)