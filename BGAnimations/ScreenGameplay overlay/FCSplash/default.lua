local pn = ...
assert(pn)

local IsUsingSoloSingles = getenv("Rotation"..pname(pn)) == 5
local NumPlayers = GAMESTATE:GetNumPlayersEnabled()
local NumSides = GAMESTATE:GetNumSidesJoined()

local function GetPosition(pn)
	if IsUsingSoloSingles and NumPlayers == 1 and NumSides == 1 then return SCREEN_CENTER_X end

	local strPlayer = (NumPlayers == 1) and "OnePlayer" or "TwoPlayers"
	local strSide = (NumSides == 1) and "OneSide" or "TwoSides"

	return THEME:GetMetric("ScreenGameplay","Player".. pname(pn) .. strPlayer .. strSide .."X")
end

return Def.ActorFrame{
	Def.Sprite {
		Texture = "bluebeam",
		InitCommand=function(self) self:blend(Blend.Add):x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/9+15):diffusealpha(0):zoom(0.3):cropleft(0.5):cropright(0.5) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:diffusealpha(1)
				self:fadeleft(0.5)
				self:faderight(0.5)
				self:texcoordvelocity(0.5,0)
				self:sleep(0.2)
				self:decelerate(0.4)
				self:cropleft(0)
				self:cropright(0)
				self:zoom(1)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "full combo text",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/8+15):diffusealpha(0):shadowlength(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:sleep(0.4)
				self:diffusealpha(1)
				self:diffuseshift()
				self:effectcolor1(1,1,1,1)
				self:effectcolor2(0.58,0.9,1,1)
				self:effectperiod(1)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "full combo glow",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/8+15):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:sleep(0.1)
				self:linear(0.3)
				self:diffusealpha(1)
				self:sleep(0.5)
				self:linear(0.5)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "_fan",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_HEIGHT/2):zoomx(1.25):blend(Blend.Add):cropleft(0.5):cropright(0.5):faderight(0.5):fadeleft(0.5):zoomtoheight(SCREEN_HEIGHT*1.5):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:diffusealpha(0.5)
				self:linear(1/2)
				self:faderight(0)
				self:fadeleft(0)
				self:cropleft(0)
				self:cropright(0)
				self:zoomx(2)
				self:linear(1/2)
				self:fadebottom(1)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "_fan",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_HEIGHT/2):blend(Blend.Add):fadetop(0.1):fadebottom(0.5):zoomtoheight(SCREEN_HEIGHT*2):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:addy(SCREEN_HEIGHT*2)
				self:diffusealpha(1)
				self:decelerate(1.75/2)
				self:addy(-SCREEN_HEIGHT*4)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","blueflare"),
		InitCommand=function(self) self:x(GetPosition(pn)):blend(Blend.Add):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/9+15):diffusealpha(0):zoom(0.3) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:sleep(0.1)
				self:accelerate(0.4)
				self:diffusealpha(1)
				self:zoom(5)
				self:decelerate(3/2)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "orangebeam",
		InitCommand=function(self) self:blend(Blend.Add):x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/9+15):diffusealpha(0):zoom(0.3):cropleft(0.5):cropright(0.5) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:diffusealpha(1)
				self:fadeleft(0.5)
				self:faderight(0.5)
				self:texcoordvelocity(0.5,0)
				self:sleep(0.2)
				self:decelerate(0.4)
				self:cropleft(0)
				self:cropright(0)
				self:zoom(1)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "full combo text",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/8+15):diffusealpha(0):shadowlength(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:sleep(0.4)
				self:diffusealpha(1)
				self:diffuseshift()
				self:effectcolor1(1,1,1,1)
				self:effectcolor2(1,0.83,0.6,1)
				self:effectperiod(1)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "full combo glow",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/8+15):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:sleep(0.1)
				self:linear(0.3)
				self:diffusealpha(1)
				self:sleep(0.5)
				self:linear(0.5)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "_ex",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_HEIGHT/2):zoomx(1.25):blend(Blend.Add):cropleft(0.5):cropright(0.5):faderight(0.5):fadeleft(0.5):zoomtoheight(SCREEN_HEIGHT*1.5):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:diffusealpha(0.5)
				self:linear(1/2)
				self:faderight(0)
				self:fadeleft(0)
				self:cropleft(0)
				self:cropright(0)
				self:zoomx(2)
				self:linear(1/2)
				self:fadebottom(1)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "_ex",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_HEIGHT/2):blend(Blend.Add):fadetop(0.1):fadebottom(0.5):zoomtoheight(SCREEN_HEIGHT*2):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:addy(SCREEN_HEIGHT*2)
				self:diffusealpha(1)
				self:decelerate(1.75/2)
				self:addy(-SCREEN_HEIGHT*4)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","orangeflare"),
		InitCommand=function(self) self:x(GetPosition(pn)):blend(Blend.Add):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/9+15):diffusealpha(0):zoom(0.3) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:sleep(0.1)
				self:accelerate(0.4)
				self:diffusealpha(1)
				self:zoom(5)
				self:decelerate(3/2)
				self:diffusealpha(0)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:visible(false)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "greenbeam",
		InitCommand=function(self) self:blend(Blend.Add):x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/9+15):diffusealpha(0):zoom(0.3):cropleft(0.5):cropright(0.5) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:diffusealpha(1)
				self:fadeleft(0.5)
				self:faderight(0.5)
				self:texcoordvelocity(0.5,0)
				self:sleep(0.2)
				self:decelerate(0.4)
				self:cropleft(0)
				self:cropright(0)
				self:zoom(1)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "full combo text",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/8+15):diffusealpha(0):shadowlength(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:sleep(0.4)
				self:diffusealpha(1)
				self:diffuseshift()
				self:effectcolor1(1,1,1,1)
				self:effectcolor2(0.3,1,0.56,1)
				self:effectperiod(1)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "full combo glow",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/8+15):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:sleep(0.1)
				self:linear(0.3)
				self:diffusealpha(1)
				self:sleep(0.5)
				self:linear(0.5)
				self:diffusealpha(0)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "_great",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_HEIGHT/2):zoomx(1.25):blend(Blend.Add):cropleft(0.5):cropright(0.5):faderight(0.5):fadeleft(0.5):zoomtoheight(SCREEN_HEIGHT*1.5):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:diffusealpha(0.5)
				self:linear(1/2)
				self:faderight(0)
				self:fadeleft(0)
				self:cropleft(0)
				self:cropright(0)
				self:zoomx(2)
				self:linear(1/2)
				self:fadebottom(1)
				self:diffusealpha(0)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = "_great",
		InitCommand=function(self) self:x(GetPosition(pn)):y(SCREEN_HEIGHT/2):blend(Blend.Add):fadetop(0.1):fadebottom(0.5):zoomtoheight(SCREEN_HEIGHT*2):diffusealpha(0) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:addy(SCREEN_HEIGHT*2)
				self:diffusealpha(1)
				self:decelerate(1.75/2)
				self:addy(-SCREEN_HEIGHT*4)
				self:diffusealpha(0)
			else
				self:visible(false)
			end
		end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","greenflare"),
		InitCommand=function(self) self:x(GetPosition(pn)):blend(Blend.Add):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/9+15):diffusealpha(0):zoom(0.3) end,
		OffCommand=function(self) if PlayerFullComboed(pn) then self:queuecommand("CheckScore") end end,
		CheckScoreCommand=function(self)
			local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
			if fct:FullComboOfScore('TapNoteScore_W1') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W2') == true then
				self:visible(false)
			elseif fct:FullComboOfScore('TapNoteScore_W3') == true then
				self:sleep(0.1)
				self:accelerate(0.4)
				self:diffusealpha(1)
				self:zoom(5)
				self:decelerate(3/2)
				self:diffusealpha(0)
			else
				self:visible(false)
			end
		end
	}
}