util.AddNetworkString("shopweaponswep")
util.AddNetworkString("shopweaponswep_spawnent")

net.Receive("shopweaponswep_spawnent", function(len, ply)
    local ent = net.ReadString()
    if !IsValid(ply) then return end
    if !ply:Alive() then return end
    if !isstring(ent) then return end
    ply:Give(ent)
end)