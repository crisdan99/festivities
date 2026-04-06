local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
dofile(modpath .. "/passover/passover.lua")

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

local easter_active = false
local easter_claimed = {}
local data_file = minetest.get_worldpath() .. "/festivities.mt"

-- Función segura para cargar datos
local function load_data()
    local file, err = io.open(data_file, "r")
    if not file then
        minetest.log("warning", "[Festivities] No data file found, using defaults. ("..tostring(err)..")")
        easter_active = false
        easter_claimed = {}
        return
    end

    local content = file:read("*a")
    file:close()
    if not content or content == "" then
        easter_active = false
        easter_claimed = {}
        return
    end

    local ok, data = pcall(minetest.deserialize, content)
    if ok and type(data) == "table" then
        easter_active = data.easter_active or false
        easter_claimed = data.easter_claimed or {}
    else
        minetest.log("error", "[Festivities] Failed to deserialize data, using defaults.")
        easter_active = false
        easter_claimed = {}
    end
end

-- Función segura para guardar datos
local function save_data()
    local file, err = io.open(data_file, "w")
    if not file then
        minetest.log("error", "[Festivities] Cannot save data: "..tostring(err))
        return
    end

    local data = { easter_active = easter_active, easter_claimed = easter_claimed }
    file:write(minetest.serialize(data))
    file:close()
end

-- Cargar datos al iniciar
load_data()

-- Comando para activar/desactivar evento
minetest.register_chatcommand("active_easter", {
    params = "<on|off>",
    description = "Activate or deactivate Easter event",
    privs = {server = true},
    func = function(name, param)
        if param == "on" then
            easter_active = true
            save_data()
            return true, "Easter Event Activated"
        elseif param == "off" then
            easter_active = false
            save_data()
            return true, "Easter Event Deactivated"
        else
            return false, "Use: /active_easter on or /active_easter off"
        end
    end,
})

-- Mensaje al unirse al jugador si el evento está activo y no reclamó
minetest.register_on_joinplayer(function(player)
    if not easter_active then return end
    local name = player:get_player_name()
    if not easter_claimed[name] then
        minetest.after(2, function()
            minetest.chat_send_player(name,
                "Hello " .. name .. "! Welcome back to Just-Craft, Happy Easter! Claim your gift with /easter")
        end)
    end
end)

-- Comando para reclamar canasta
minetest.register_chatcommand("easter", {
    description = "Claim Easter gift",
    func = function(name)
        if not easter_active then
            return false, "Easter Event is not active"
        end
        if easter_claimed[name] then
            return false, "You have already claimed your Easter basket!"
        end

        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local inv = player:get_inventory()
        inv:add_item("main", modname .. ":easter_basket")
        easter_claimed[name] = true
        save_data()

        return true, "You received your Easter basket!"
    end,
})

-- Registro de la canasta
minetest.register_craftitem(modname .. ":easter_basket", {
    description = "Easter Basket",
    inventory_image = "easter_basket.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local inv = user:get_inventory()
        inv:add_item("main", modname .. ":just_craft_egg")
        inv:add_item("main", modname .. ":just_craft_egg_2")
        inv:add_item("main", modname .. ":just_craft_easter_1")
        inv:add_item("main", modname .. ":just_craft_easter_2")
        inv:add_item("main", modname .. ":sign1")
        inv:add_item("main", modname .. ":sign2")
       --inv:add_item("main", modname .. ":sign4")       
        itemstack:take_item()
        return itemstack
    end,
})
