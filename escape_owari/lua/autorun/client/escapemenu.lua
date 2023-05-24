local function Nx(w)
	return ScrW()/(ScrW()/w)
end

local function Ny(h)
	return ScrH()/(ScrH()/h)
end
surface.PlaySound("doors/latchlocked2.wav")

surface.CreateFont( "KnYFonts", {
	font = F606_Escape.Config.Fonts, --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 60,
	weight = 500,
	outline = true
} )

surface.CreateFont( "KnYFonts2", {
	font = F606_Escape.Config.Fonts, --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 60,
	weight = 500,
	outline = true,
    Color( 255, 0, 0) 
   
} )

local function StencilStart()
    render.ClearStencil()
    render.SetStencilEnable( true )
    render.SetStencilWriteMask( 1 )
    render.SetStencilTestMask( 1 )
    render.SetStencilFailOperation( STENCILOPERATION_KEEP )
    render.SetStencilZFailOperation( STENCILOPERATION_KEEP )
    render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_ALWAYS )     
    render.SetStencilReferenceValue( 1 )
    render.SetColorModulation( 1, 1, 1 )
end

local function StencilReplace()
    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
    render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
    render.SetStencilReferenceValue(1)
end

local function StencilEnd()
    render.SetStencilEnable( false )
end

function OpenEscapeMenu()
	if IsValid(F606MainEsc) and not F606MainEsc.Closed then 
		F606MainEsc:SetVisible(false) 
		F606MainEsc.Closed = true 
		return
	elseif IsValid(escape) and F606MainEsc.Closed then
		F606MainEsc:SetVisible(true) 
		F606MainEsc.Closed = false 
		return
	end
	F606MainEsc = vgui.Create("DFrame")
		F606MainEsc:SetSize(ScrW(), ScrH())
		F606MainEsc:SetPos(0, 0)
		F606MainEsc:SetTitle("")
		F606MainEsc:MakePopup()
		F606MainEsc:SetDraggable(false)
		F606MainEsc:SetSizable(false)
		F606MainEsc:ShowCloseButton( false )
		F606MainEsc.Paint = function(self, w, h)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(F606_Escape.Config.BackgroundImage)
			surface.DrawTexturedRect(0, 0, w, h)
		end

	local BanierEscape = vgui.Create("DFrame", F606MainEsc)
		BanierEscape:SetSize(Nx(1900), ScrH())
		BanierEscape:SetPos(Nx(56), 0)
		BanierEscape:SetTitle("")
		BanierEscape:SetSizable(false)
		BanierEscape:SetDraggable(false)
		BanierEscape:ShowCloseButton(false)
		BanierEscape.Paint = function()
			surface.SetDrawColor(0, 0, 0, 255)
			draw.NoTexture()
			StencilStart()
				surface.SetDrawColor(255, 255, 255, 255)
				draw.NoTexture()
			StencilReplace()
				surface.SetDrawColor(255, 255, 255, 150)
				surface.DrawTexturedRect(0, 0, BanierEscape:GetWide(), BanierEscape:GetTall())
			StencilEnd()
		end

	for i=1, #F606_Escape.Config.ButtonList do
		local ButtonInfo = vgui.Create("DButton", BanierEscape)
			ButtonInfo:SetSize(Nx(1450), Ny(70))
			ButtonInfo:SetPos(Nx(190), Ny(200 + (i * 150)))
			ButtonInfo:SetFont("KnYFonts")
			ButtonInfo:SetTextColor(Color(255 , 255, 255, 255))
			ButtonInfo:SetText(F606_Escape.Config.ButtonList[i]["Name"])
			ButtonInfo.DoClick = function()
				F606MainEsc:Close()
				F606_Escape.Config.ButtonList[i]["Function"]()
			end
			ButtonInfo.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
				if ButtonInfo:IsHovered() then
					ButtonInfo:SetFont("KnYFonts2")
                surface.PlaySound("test/12348.wav")
                
				else
					ButtonInfo:SetFont("KnYFonts")
				end
            
			end
	end

-- check point

	local InformationBoites = vgui.Create("DFrame", F606MainEsc)
		InformationBoites:SetSize(Nx(600), Ny(32))
		InformationBoites:SetPos((ScrW() - Nx(200)), (ScrH() - Ny(200)))
		InformationBoites:SetTitle("")
		InformationBoites:SetDraggable( false )
		InformationBoites:SetSizable( false )
		InformationBoites:ShowCloseButton( false )
		InformationBoites.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(42, 42, 42, 190))
			draw.SimpleText(F606_Escape.Config.TextRight, "KnYFonts", InformationBoites:GetWide()/2 - Nx(surface.GetTextSize(F606_Escape.Config.TextRight)/2), 0, color_white)
		end
end


hook.Add("PreRender", "F606:EscapeMenu", function()
	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
		gui.HideGameUI()
		OpenEscapeMenu()
	end
end)