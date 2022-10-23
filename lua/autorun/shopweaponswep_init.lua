AddCSLuaFile()

for i, f in pairs(file.Find("shopweaponswep/*.lua", "LUA")) do
    if string.Left(f, 3) == "sv_" then
        if SERVER then include("shopweaponswep/" .. f) end
    elseif string.Left(f, 3) == "cl_" then
        if CLIENT then
            include("shopweaponswep/" .. f)
        else
            AddCSLuaFile("shopweaponswep/" .. f)
        end
    elseif string.Left(f, 3) == "sh_" then
        AddCSLuaFile("shopweaponswep/" .. f)
        include("shopweaponswep/" .. f)
    else
        print("Shop Weapon SWEP detected unaccounted for lua file '" .. f .. "' - check prefixes!")
    end
    print("Shop Weapon SWEP successfully loaded!")
end
