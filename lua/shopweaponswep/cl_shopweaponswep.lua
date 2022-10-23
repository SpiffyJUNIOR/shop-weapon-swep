local entTable = {
    [1] = {
        ent = "arccw_ammo_pistol_large",
        price = 10,
        printname = "Pistol Ammo"
    },
    [2] = {
        ent = "arccw_ammo_357_large",
        price = 20,
        printname = "Magnum Ammo"
    },
    [3] = {
        ent = "arccw_ammo_smg1_large",
        price = 15,
        printname = "Carbine Ammo"
    },
    [4] = {
        ent = "arccw_ammo_ar2_large",
        price = 30,
        printname = "Rifle Ammo"
    },
    [5] = {
        ent = "arccw_ammo_buckshot_large",
        price = 25,
        printname = "Shotgun Ammo"
    },
    [6] = {
        ent = "item_healthkit",
        price = 25,
        printname = "Health Kit"
    },
    [7] = {
        ent = "item_suitbattery",
        price = 50,
        printname = "Suit Battery"
    },
    [8] = {
        ent = "ent_jack_gmod_ezarmor_mhead", -- jmod armor
        price = 200,
        printname = "Medium Helmet"
    },
    [9] = {
        ent = "ent_jack_gmod_ezarmor_mtorso", -- jmod armor
        price = 300,
        printname = "Medium Armor"
    }
}

local OpenMotherFrame = nil
local OpenDropdown = nil
local price = nil
local selectedentity, selectedentityname = nil, nil
local primarytext = (Color(255, 255, 255, 255))

net.Receive("shopweaponswep", function()
    if IsValid(OpenMotherFrame) then return end
    local ply = LocalPlayer()
    if !IsValid(ply) or !ply:Alive() then return end
    local screenwidth = ScrW()
    local screenheight = ScrH()
    local motherFrame = vgui.Create("DFrame")
    motherFrame:SetSize(screenwidth / 4, screenheight / 5)
    motherFrame:SetVisible(true)
    motherFrame:SetDraggable(false)
    motherFrame:ShowCloseButton(true)
    motherFrame:SetTitle("")
    motherFrame:ParentToHUD()

    function motherFrame:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(30, 30, 30, 200))
    end

    motherFrame:MakePopup()
    motherFrame:Center()

    function motherFrame:OnKeyCodePressed(key)
        if key == KEY_Q then
            self:Close()
        end
    end

    function motherFrame:OnClose()
        if IsValid(OpenDropdown) then
            OpenDropdown:Remove()
        end
    end
    ---

    local EntNameLabel = vgui.Create("DLabel", motherFrame)
    EntNameLabel:SetPos(16, 85)
    EntNameLabel:SetSize(300, 20)
    EntNameLabel:SetText("Name: N/A")
    EntNameLabel:SetTextColor(primarytext)

    function EntNameLabel:Paint(w, h)
        -- draw.RoundedBox(8, 0, 0, w, h, Color(200, 0, 0, 10))
        return nil
    end
    ---

    local PriceLabel = vgui.Create("DLabel", motherFrame)
    PriceLabel:SetPos(16, 105)
    PriceLabel:SetSize(300, 20) -- if you unironically fill this somehow you need help
    PriceLabel:SetText("Price: N/A")
    PriceLabel:SetTextColor(primarytext)

    function PriceLabel:Paint(w, h)
        -- draw.RoundedBox(8, 0, 0, w, h, Color(200, 0, 0, 10))
        return nil
    end
    ---

	local BuyButton = vgui.Create("DButton", motherFrame)
	BuyButton:SetPos(186, 160)
	BuyButton:SetSize(screenwidth / 8 - 128, 30)
	BuyButton:SetText("")

    function BuyButton:Paint(w, h)
	    surface.SetDrawColor(50, 50, 50, 255)
	    surface.DrawRect(0, 0, w, h)
        surface.SetTextColor(primarytext)
        surface.SetTextPos(48, 9)
        surface.DrawText("BUY")
    end

    function BuyButton:DoClick()
        if IsValid(price) and IsValid(selectedentity) and IsValid(ply) and ply:Alive() then
            -- net send entity spawn code here
        end
    end
    ---

    local DropDownButton = vgui.Create("DButton", motherFrame)
    DropDownButton:SetPos(16, 30)
    DropDownButton:SetSize(screenwidth / 4 - 32, 30)
    DropDownButton:SetText("")

    function DropDownButton:Paint(w, h)
        surface.SetDrawColor(50, 50, 50, 150)
        surface.DrawRect(0, 0, w, h)
        surface.SetTextColor(primarytext)
        surface.SetTextPos(6, 9)
        surface.DrawText("Select Ent:")
        surface.SetDrawColor(70, 70, 70, 200)
        surface.DrawRect(400, 5, 40, 20)
        surface.SetTextColor(primarytext)
        surface.SetTextPos(418, 8)
        surface.DrawText(">")
    end

    function DropDownButton:DoClick()
        print("button clicked")
        if IsValid(OpenDropdown) then
            OpenDropdown:Remove()
            print("isvalid passed")
            return false
        end

        for k, v in ipairs(entTable) do
            print(v.ent)
            print(v.price)
            print(v.printname)
        end

        local DropDownEntities = vgui.Create("DScrollPanel")
        local DropdownBar = DropDownEntities:GetVBar()
        DropDownEntities:SetSize(screenwidth / 4, screenheight / 5) -- button size (465, 50)
        DropDownEntities:SetPos(1210, 432) -- we need to create a new panel because putting this outside motherframe dont work because garry is a fucking shit
        DropDownEntities:SetDragParent(motherFrame)
        DropdownBar:SetHideButtons(true)
        print(DropDownEntities)

        function DropDownEntities:Paint(w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(30, 30, 30, 200))
            -- return nil
        end

        function DropdownBar:Paint(w, h) -- we still need to figure out how to separate the scroll bar from the frame
            draw.RoundedBox(0, 0, 0, w, h, Color(43, 39, 35, 66))
        end
        function DropdownBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(76, 76, 74))
        end

        OpenDropdown = DropDownEntities

        for k, v in ipairs(entTable) do
            local DropdownTestButton = DropDownEntities:Add("DButton")
            DropdownTestButton:SetText("")
            DropdownTestButton:Dock(TOP)
            DropdownTestButton:DockMargin(0, 5, 5, 1)
            DropdownTestButton:SetSize(50, 20)
            function DropdownTestButton:Paint(w, h)
                local pricestring = tostring("$" .. v.price)
                surface.SetDrawColor(40, 40, 40, 100)
                surface.DrawRect(0, 0, w, h)
                if DropdownTestButton:IsHovered() then -- gradient start: (255, 86, 65) end: (255, 190, 131)
                    surface.SetDrawColor(255, 86, 65)
                    surface.DrawOutlinedRect(0, 0, w, h, 2)
                end
                surface.SetTextColor(primarytext)
                surface.SetTextPos(6, 4)
                surface.DrawText(v.printname)
                draw.DrawText(pricestring, DermaDefault, 456, 4, primarytext, TEXT_ALIGN_RIGHT)
            end
            function DropdownTestButton:DoClick()
                local pricestring = tostring("$" .. v.price)
                selectedentity = (v.ent)
                selectedentityname = (v.printname)
                price = (v.price)
                print(selectedentity)
                print(selectedentityname)
                print(price)
                EntNameLabel:SetText("Name: " .. selectedentityname)
                PriceLabel:SetText("Price: " .. pricestring)
            end
        end
    end
	---
    OpenMotherFrame = motherFrame
end)