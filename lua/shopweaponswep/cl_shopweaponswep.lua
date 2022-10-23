local entTable = {
    [1] = {
        ent = "arccw_ammo_pistol_large",
        price = 9128341,
        printname = "I'LL ASK AGAIN..."
    },
    [2] = {
        ent = "arccw_ammo_357_large",
        price = 1, -- nobody want that shit :skull:
        printname = "...ARE YOU BLACK?"
    },
    [3] = {
        ent = "arccw_ammo_smg1_large",
        price = 100,
        printname = "smg1"
    },
    [4] = {
        ent = "arccw_ammo_ar2_large",
        price = 250,
        printname = "ar2"
    },
    [5] = {
        ent = "arccw_ammo_buckshot_large",
        price = 50,
        printname = "shotgun ammo (fed killer)"
    },
    [6] = {
        ent = "arccw_ammo_sniper_large",
        price = 9001,
        printname = "fed destroyer"
    }
}

local OpenMotherFrame = nil
local OpenDropdown = nil
local price = nil
local selectedentity = nil
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
            if IsValid(OpenDropdown) then
                OpenDropdown:Remove()
            end
        end
    end
    ---

	local DropDownButton = vgui.Create("DButton", motherFrame)
	DropDownButton:SetPos(16, 30)
	DropDownButton:SetSize(screenwidth / 4 - 32, 30)
	DropDownButton:SetText("")

    function DropDownButton:Paint(w, h)
	    surface.SetDrawColor(50, 50, 50, 255)
	    surface.DrawRect(0, 0, w, h)
        surface.SetTextColor(primarytext)
        surface.SetTextPos(6, 9)
        surface.DrawText("Select Ent:")
	    surface.SetDrawColor(70, 70, 70, 255)
	    surface.DrawRect(405, 5, 40, 20)
        surface.SetTextColor(primarytext)
        surface.SetTextPos(423, 8)
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
            DropdownTestButton:DockMargin(0, 5, 20, 1)
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
        end

        -- for i = 0, 6 do
        --     local DropdownTestButton = DropDownEntities:Add("DButton")
        --     DropdownTestButton:SetText("")
        --     DropdownTestButton:Dock(TOP)
        --     DropdownTestButton:DockMargin(0, 0, 0, 5)
        --     DropdownTestButton:SetSize(400, 44)
        --     function DropdownTestButton:Paint(w, h)
        --         surface.SetDrawColor(40, 40, 40, 100)
        --         surface.DrawRect(0, 0, w, h)
        --         if DropdownTestButton:IsHovered() then -- gradient start: (255, 86, 65) end: (255, 190, 131)
        --             surface.SetDrawColor(255, 86, 65)
        --             DrawOutlinedTexturedRect(self, gradient_mat, 4)
        --             settingsHelpText:SetText("Love.")
        --         end
        --         surface.SetTextColor(primarytext)
        --         surface.SetTextPos(14, 12)
        --         surface.SetFont("MichromaRegular")
        --         surface.DrawText("Button #" .. i)
        --     end
        -- end
    end
    ---

    local NameLabel = vgui.Create("DLabel", motherFrame)
    NameLabel:SetPos(16, 85)
    NameLabel:SetSize(130, 20)
    NameLabel:SetText("Name: N/A")
    NameLabel:SetTextColor(primarytext)

    function NameLabel:Paint(w, h)
        -- draw.RoundedBox(8, 0, 0, w, h, Color(200, 0, 0, 10))
        return nil
    end
    ---

    local PriceLabel = vgui.Create("DLabel", motherFrame)
    PriceLabel:SetPos(16, 105)
    PriceLabel:SetSize(130, 20)
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
        if IsValid(price) and IsValid(selectedentity) then
            -- net send entity spawn code here
        end
    end

	---
    OpenMotherFrame = motherFrame
end)