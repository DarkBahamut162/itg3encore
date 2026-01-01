local pn = ...
local style = GAMESTATE:GetCurrentStyle():GetStyleType()
local maskfile = {
	PLAYER_1 = THEME:GetPathB("ScreenGameplay", "underlay/Cutin/_Mask_down"),
	PLAYER_2 = THEME:GetPathB("ScreenGameplay", "underlay/Cutin/_Mask_up")
}

maskfile = maskfile[pn]

local versus_y = {
	PLAYER_1 = -130,
	PLAYER_2 = 230
}
versus_y = versus_y[pn]

local charComboA   = "/Characters/"..WhichRead(pn).."/Cut-In/comboA.png"
local charComboB   = "/Characters/"..WhichRead(pn).."/Cut-In/comboB.png"
local charCombo100 = "/Characters/"..WhichRead(pn).."/Cut-In/combo100.png"
local charCircles  = "/Characters/"..WhichRead(pn).."/Cut-In/Tex_0035.png"
local charColor    = "/Characters/"..WhichRead(pn).."/Cut-In/Tex_0036.png"
local charLight    = "/Characters/"..WhichRead(pn).."/Cut-In/Tex_0037.png"
local t = Def.ActorFrame{}

t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:zoom(480/1080) end,
	ComboChangedMessageCommand=function(self, params)
		if params.Player ~= pn then return end
		local tapsAndHolds = GAMESTATE:GetCurrentSteps(params.Player):GetRadarValues(params.Player):GetValue('RadarCategory_TapsAndHolds')
		local CurCombo = params.PlayerStageStats:GetCurrentCombo()
		if CurCombo == 0 or CurCombo == params.OldCombo then
			return
		elseif CurCombo == math.floor(tapsAndHolds/2) or CurCombo == math.floor(tapsAndHolds*0.9) then
			self:playcommand("Popup", {type='B'})
		elseif CurCombo % 100 == 0 then
			self:playcommand("Popup", {type='C'})
		elseif CurCombo == 20 or (CurCombo % 50 == 0) then
			self:playcommand("Popup", {type='A'})
		end
	end,
	Def.Sprite{
		InitCommand=function(self)
			self:clearzbuffer(true):zwrite(true):blend('BlendMode_NoEffect')
			if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
				self:Load(maskfile)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = charColor,
		InitCommand=function(self)
			self:setsize(450,1080)
			self:diffusealpha(0)
			self:texcoordvelocity(-0.2,0)
			self:texcoordvelocity(-0.053,0) 
			self:texcoordvelocity(-0.053,0) 
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.053,0)  
			self:texcoordvelocity(-0.2,0)
			self:MaskDest()
		end,
		PopupCommand=function(self)
			self:finishtweening():linear(0.2):diffusealpha(1):diffusealpha(0.9):sleep(1):linear(0.2):diffusealpha(0)
		end
	},
	Def.Sprite {
		InitCommand=function(self)
			self:MaskDest():diffusealpha(0):scaletoclipped(450,1080)
			if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then self:y(versus_y) end
			self:Load(charComboA):Load(charComboB):Load(charCombo100)
		end,
		PopupCommand=function(self, params)
			if params.type == 'A' then
				self:Load(charComboA)
			elseif params.type == 'B' then
				self:Load(charComboB)
			elseif params.type == 'C' then
				self:Load(charCombo100)
			else
				error("Cutin: unknown Popup type "..tostring(type))
			end
			self:finishtweening():addy(13):sleep(0.1):linear(0.1):diffusealpha(1):linear(1):addy(-13):linear(0.1):diffusealpha(0)
		end
	},
	Def.Sprite {
		Texture = charLight,
		InitCommand=function(self)
			self:MaskDest():diffusealpha(0):blend('BlendMode_Add'):setsize(450,1080)
			if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then self:y(versus_y) end
		end,
		PopupCommand=function(self)
			self:finishtweening():sleep(0):linear(0.2):diffusealpha(0.5):sleep(0.8):linear(0.2):diffusealpha(0)
		end
	},
	Def.ActorFrame {
		InitCommand=function(self)
			self:MaskDest()
			if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then self:y(versus_y) end
		end,
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.17):diffusealpha(1):x(-85):y(90):zoomx(0.7):zoomy(2.2):linear(0.4):y(-150):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.17):diffusealpha(1):x(60):y(155):zoomx(0.95):zoomy(1.6):linear(0.4):y(-10):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.33):diffusealpha(1):x(10):y(150):zoomx(0.8):zoomy(1.75):linear(0.4):y(-30):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.33):diffusealpha(1):x(-40):y(210):zoomx(0.8):zoomy(1):linear(0.4):y(110):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.53):diffusealpha(1):x(70):y(120):zoomx(0.6):zoomy(2.07):linear(0.4):y(-120):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.5):diffusealpha(1):x(-75):y(-90):zoomx(1):zoomy(4.45):linear(0.4):y(-320):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.63):diffusealpha(1):x(-75):y(85):zoomx(1.2):zoomy(2.2):linear(0.4):y(-150):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.63):diffusealpha(1):x(40):y(185):zoomx(0.6):zoomy(1.1):linear(0.4):y(85):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.86):diffusealpha(1):x(70):y(20):zoomx(0.9):zoomy(3):linear(0.4):y(-190):diffusealpha(0)
			end
		},
		Def.Sprite {
			Texture = charCircles,
			InitCommand=function(self) self:diffusealpha(0):blend('BlendMode_Add'):vertalign(top) end,
			PopupCommand=function(self)
				self:finishtweening():sleep(0.86):diffusealpha(1):x(-30):y(150):zoomx(0.6):zoomy(1.7):linear(0.4):y(-25):diffusealpha(0)
			end
		}
	}
}

return t
