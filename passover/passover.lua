local modname = minetest.get_current_modname()

-- Items de huevos de Pascua
minetest.register_craftitem(modname .. ":just_craft_egg", {
    description = "item Just-Craft Easter  Egg 2026",
    inventory_image = "just_craft_egg_2026.png",
    wield_scale = {x = 0.8, y = 0.8, z = 0.8},
    stack_max = 1,
})

minetest.register_craftitem(modname .. ":just_craft_egg_2", {
    description = "item Just-Craft first Easter Egg 2026",
    inventory_image = "just_craft_egg1_2026.png",
    wield_scale = {x = 0.8, y = 0.8, z = 0.8},
    stack_max = 1,
})
minetest.register_craftitem(modname .. ":just_craft_easter_1", {
    description = "item Just-Craft first Easter  2026",
    inventory_image = "sign1.png",
    wield_scale = {x = 0.8, y = 0.8, z = 0.8},
    stack_max = 1,
})
minetest.register_craftitem(modname .. ":just_craft_easter_2", {
    description = "item Just-Craft first Easter   2026",
    inventory_image = "sign2.png",
    wield_scale = {x = 0.8, y = 0.8, z = 0.8},
    stack_max = 1,
})
minetest.register_craftitem(modname .. ":just_craft_easter_3", {
    description = "item Just-Craft first Easter   2026",
    inventory_image = "sign3.png",
    wield_scale = {x = 0.8, y = 0.8, z = 0.8},
    stack_max = 1,
})
--end
-- Huevo de Pascua prueba de node_box



-- Prueba de huevo de Pascua con modelo 3D OBJ
-- No funciona todavía, queda como prueba
minetest.register_node(modname .. ":just_craft_egg_node_mesh", {
    description = "Just-Craft Easter Egg giant  2026",
    tiles = {"Just-Craft_egg.png"},
    inventory_image = "just_craft_egg1_2026.png",
    drawtype = "mesh",
    mesh = "egg_2.obj",
    paramtype = "light",
    sunlight_propagates = true,
    groups = {cracky = 1},

    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
    },
    collision_box = {
     type ="fixed", 
     fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
    }, 
})


-- Signs -- prueba para hacer un cartel grande
-- Aún en pruebas, errores notables y mejoras pendientes


-- Extensión futura:
-- Añadir huevos de colores
-- Añadir conejos
-- Posiblemente aplicar modelos 3D si funcionan
--Signs normal
local signs = {
    {name = "sign1", texture = "sign1.png"},
    {name = "sign2", texture = "sign2.png"},
    {name = "sign3", texture = "sign3.png"},
}

for _, s in ipairs(signs) do
    minetest.register_node(modname .. ":" .. s.name, {
        description = modname .. "  " .. s.name,

        drawtype = "signlike",
        tiles = {s.texture},
        inventory_image = s.texture,
        wield_image = s.texture,

        paramtype = "light",
        paramtype2 = "wallmounted",

        sunlight_propagates = true,
        walkable = false,
        is_ground_content = false,

        selection_box = {
            type = "wallmounted",
        },

        groups = {cracky = 1, oddly_breakable_by_hand = 1},
    })
end

local poster ={
    {name = "poster11", texture = "sign1.png", model = "Cubo.obj"},
    {name = "poster2", texture = "sign2.png",model="Cubo.obj"},
    {name = "poster3", texture = "sign3.png", model ="Cubo.obj"},
}


for _, po in ipairs(poster) do
    minetest.register_node (modname .. ":easter" .. po.name, {
    description = modname .. " Easter " ..po.name,
    tiles = {po.texture}, 
    use_texture_alpha = "clip",
    inventory_image = po.texture.."", 
    drawtype = "mesh", 
    mesh = po.model.."",
    paramtype ="light", 
    paramtype2 ="facedir", 
    sunlight_propagates = true,
    groups = {cracky=2},
    selection_box = {
        type = "fixed",
       fixed = {-2, -1.5, -0.05, 2, 1.5, 0.05},
    },

    collision_box = {
        type = "fixed",
        fixed = {-2, -1.5, -0.05, 2, 1.5, 0.05},
    },
    
  })
end



--p
