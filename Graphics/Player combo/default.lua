local c
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt")
local Pulse = THEME:GetMetric("Combo", "PulseCommand")

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom")
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom")
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt")

local ComboW1 = THEME:GetMetric("Combo","FullComboW1Command")
local ComboW2 = THEME:GetMetric("Combo","FullComboW2Command")
local ComboW3 = THEME:GetMetric("Combo","FullComboW3Command")
local ComboNormal = THEME:GetMetric("Combo","FullComboBrokenCommand")
local ComboMiss = THEME:GetMetric("Combo","MissComboCommand")

local LastSeenCombo = 0
local player = Var "Player"
local hide = player and getenv("HideCombo"..pname(player)) or false

return Def.ActorFrame {
	Def.ActorFrame {
		OnCommand=function(self) if hide or (IsGame("be-mu") or IsGame("beat")) then self:visible(false) end end,
		Def.BitmapText {
			File = "Combo numbers",
			Name="Number",
			OnCommand=THEME:GetMetric("Combo", "NumberOnCommand")
		},
		Def.Sprite {
			Texture = "_combo "..(isFinal() and "final" or "normal"),
			Name="ComboLabel",
			OnCommand=THEME:GetMetric("Combo", "LabelOnCommand")
		},
		Def.Sprite {
			Texture = "_misses "..(isFinal() and "final" or "normal"),
			Name="MissesLabel",
			OnCommand=THEME:GetMetric("Combo", "LabelOnCommand")
		},
		loadfile( THEME:GetPathG("Combo","100Milestone") )()..{ Name="OneHundredMilestone" },
		loadfile( THEME:GetPathG("Combo","1000Milestone") )()..{ Name="OneThousandMilestone" },
		InitCommand = function(self)
			c = self:GetChildren()
			c.Number:visible(false)
			c.ComboLabel:visible(false)
			c.MissesLabel:visible(false)
		end,
		ComboCommand=function(self, param)
			local iCombo = param.Misses or param.Combo
			if not iCombo or iCombo < ShowComboAt then
				c.Number:visible(false)
				c.ComboLabel:visible(false)
				c.MissesLabel:visible(false)
				if param.Combo then LastSeenCombo = param.Combo else LastSeenCombo = 0 end
				return
			end
			if param.Combo then
				if (LastSeenCombo % 100) > (param.Combo % 100) then c.OneHundredMilestone:playcommand("Milestone") end
				LastSeenCombo = param.Combo
			end
			if isEtterna() then ComboTransformCommand( self, {["Player"] = PLAYER_1, ["bReverse"] = GAMESTATE:GetPlayerState():GetCurrentPlayerOptions():UsingReverse()} ) end

			local Label

			if param.Combo then
				Label = c.ComboLabel
				c.MissesLabel:visible(false)
			else
				Label = c.MissesLabel
				c.ComboLabel:visible(false)
			end

			param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom )
			param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom )

			c.Number:visible(true)
			Label:visible(true)
			c.Number:settext( string.format("%i", iCombo) )

			if param.FullComboW1 then ComboW1(c.Number) ComboW1(Label)
			elseif param.FullComboW2 then ComboW2(c.Number) ComboW2(Label)
			elseif param.FullComboW3 then ComboW3(c.Number) ComboW3(Label)
			elseif param.Combo then ComboNormal(c.Number) ComboNormal(Label)
			else ComboMiss(c.Number) ComboMiss(Label)
			end

			Pulse( c.Number, param )
			Pulse( Label, param )
		end
	}
}
