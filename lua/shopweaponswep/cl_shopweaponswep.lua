local OpenMotherFrame = nil
local OpenDropdown = nil
local primarytext = (Color(255, 255, 255, 255))

net.Receive("shopweaponswep", function()
    if IsValid(OpenMotherFrame) then return end
    local ply = LocalPlayer()
    if !IsValid(ply) or !ply:Alive() then return end
    local screenwidth = ScrW()
    local screenheight = ScrH()
    local motherFrame = vgui.Create("DFrame")
    motherFrame:SetSize(screenwidth / 4, screenwidth / 5)
    motherFrame:SetVisible(true)
    motherFrame:SetDraggable(true)
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

        local DropDownEntities = vgui.Create("DScrollPanel")
        local DropdownBar = DropDownEntities:GetVBar()
        DropDownEntities:SetSize(500, 210) -- button size (465, 50)
        DropDownEntities:SetPos(1210, 378) -- we need to create a new panel because putting this outside motherframe dont work because garry is a fucking shit
        DropDownEntities:NoClipping(true)
        DropdownBar:SetHideButtons(true)
        print(DropDownEntities)

        function DropDownEntities:Paint(w, h)
            surface.SetDrawColor(200, 0, 0, 100)
            surface.DrawRect(0, 0, w, h)
            -- return nil
        end

        function DropdownBar:Paint(w, h) -- we still need to figure out how to separate the scroll bar from the frame
            draw.RoundedBox(0, 0, 0, w, h, Color(43, 39, 35, 66))
        end
        function DropdownBar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(76, 76, 74))
        end

        OpenDropdown = DropDownEntities

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

	---
    OpenMotherFrame = motherFrame
end)