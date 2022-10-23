
AddCSLuaFile()

SWEP.PrintName = "Shop Weapon"
SWEP.Author = "SpiffyJUNIOR (do not care if you give credit)"
SWEP.Purpose = "buys shit lol"

SWEP.Slot = 0
SWEP.SlotPos = 1

SWEP.Spawnable = true

SWEP.ViewModel = Model("models/weapons/c_toolgun.mdl")
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:Initialize()
	return true
end

function SWEP:PrimaryAttack()
	print("attack called")
	if SERVER then
	    net.Start("shopweaponswep")
	    net.Send(self:GetOwner())
	end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Deploy()
	return false
end

function SWEP:Holster()
	return true
end

function SWEP:SetupDataTables( )
	return false
end
