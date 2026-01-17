local C
local player = ...
local screen
local glifemeter = 100
local faplus = getenv("SetScoreFA"..pname(player)) or false

local JUDGMENT = {
	["TapNoteScore_W0"]		= "A",
	["TapNoteScore_W1"]		= faplus and "B" or "A",
	["TapNoteScore_W2"]		= faplus and "C" or "B",
	["TapNoteScore_W3"]		= faplus and "D" or "C",
	["TapNoteScore_W4"]		= faplus and "E" or "D",
	["TapNoteScore_W5"]		= faplus and "F" or "E",
	["TapNoteScore_Miss"]	= faplus and "G" or "F"
}
local COMBO = {
	["TapNoteScore_W0"]		= true,
	["TapNoteScore_W1"]		= true,
	["TapNoteScore_W2"]		= true,
	["TapNoteScore_W3"]		= true,
	["TapNoteScore_W4"]		= false,
	["TapNoteScore_W5"]		= false,
	["TapNoteScore_Miss"]	= false
}

local function JudgeCMD(self,TNS)
	if TNS == "TapNoteScore_W0" or TNS == "TapNoteScore_W1" then
		self:stoptweening():diffusealpha(1):zoomx(1.3):zoomy(1.7):decelerate(0.1):zoom(1):sleep(0.85):accelerate(0.1):diffusealpha(0):zoomx(1.5):zoomy(0)
	elseif TNS == "TapNoteScore_W2" then
		self:stoptweening():diffusealpha(1):zoomx(1.3):zoomy(1.7):decelerate(0.1):zoom(1):sleep(0.85):accelerate(0.1):diffusealpha(0):zoomx(1.5):zoom(0)
	elseif TNS == "TapNoteScore_W3" then
		self:stoptweening():diffusealpha(1):zoomx(1.3):zoomy(1.7):decelerate(0.1):zoom(1):sleep(0.85):accelerate(0.1):diffusealpha(0):zoomx(1.5):zoom(0)
	elseif TNS == "TapNoteScore_W4" then
		self:stoptweening():diffusealpha(1):zoomx(1.3):zoomy(1.7):decelerate(0.1):zoom(1):sleep(0.85):accelerate(0.1):zoom(0)
	elseif TNS == "TapNoteScore_W5" then
		self:stoptweening():diffusealpha(1):zoomx(1.3):zoomy(1.7):decelerate(0.1):zoom(1):sleep(0.85):accelerate(0.1):zoom(0)
	elseif TNS == "TapNoteScore_Miss" then
		self:stoptweening():diffusealpha(1):zoomx(1.3):zoomy(1.7):decelerate(0.1):zoom(1):sleep(0.85):accelerate(0.1):zoom(0)
	end
end

local PSS = nil
local current = 0

local timing = GetTimingDifficulty()
local timingChange = { 1.50,1.33,1.16,1.00,0.84,0.66,0.50,0.33,0.20 }
local JudgeScale = isOutFoxV(20230624) and GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
local W0 = 0.0135*timingChange[timing]*JudgeScale
local Wadd = (isOpenDDR() or isEtterna("0.72")) and 0.0000 or PREFSMAN:GetPreference("TimingWindowAdd")
W0 = W0 + Wadd
local W0Counter = getenv("W0"..pname(player)) or 0
local W1Counter = getenv("W1"..pname(player)) or 0
local WXCounter = getenv("WX"..pname(player)) or 0

setenv("checkFantastics"..pname(player),true)
setenv("checkPerfects"..pname(player),true)
setenv("checkGreats"..pname(player),true)
setenv("check"..pname(player),true)
setenv("checkAuto"..pname(player),true)

if not isOutFox(20200530) then GAMESTATE:ApplyGameCommand('mod,savescore',player) end
local judgment = not (getenv("HideJudgment" .. pname(player)) or false)
local combo = not (getenv("HideCombo" .. pname(player)) or false)

return Def.ActorFrame{
	OnCommand=function(self)
		if GAMESTATE:GetCurrentGame():CountNotesSeparately() then GetTrueJudgment(nil,player) end
		screen = SCREENMAN:GetTopScreen()
	end,
	Def.BitmapText{ Name = "_C1", File = (faplus and "FA" or "Normal").."/_C1.ini" }..{
		ComboMessageCommand=function(self,params) if params.Player == player then JudgeCMD(self,params.TapNoteScore) end end
	},
	Def.BitmapText{ Name = "_C2", File = (faplus and "FA" or "Normal").."/_C2.ini" }..{
		ComboMessageCommand=function(self,params) if params.Player == player then JudgeCMD(self,params.TapNoteScore) end end
	},
	Def.BitmapText{ Name = "_C3", File = (faplus and "FA" or "Normal").."/_C3.ini" }..{
		ComboMessageCommand=function(self,params) if params.Player == player then JudgeCMD(self,params.TapNoteScore) end end
	},
	Def.BitmapText{ Name = "_C4", File = (faplus and "FA" or "Normal").."/_C4.ini" }..{
		ComboMessageCommand=function(self,params) if params.Player == player then JudgeCMD(self,params.TapNoteScore) end end
	},
	Def.BitmapText{ Name = "_C0", File = (faplus and "FA" or "Normal").."/_C0.ini" }..{
		InitCommand=function(self) self:blend(Blend.Add):diffuseblink():effectperiod(0.05):effectcolor1(color("1,1,1,0.5")):effectcolor2(color("1,1,1,0")) end,
		ComboMessageCommand=function(self,params) if params.Player == player then JudgeCMD(self,params.TapNoteScore) end end
	},
	JudgmentMessageCommand=function(self,params)
		if params.Player ~= player or string.find(params.TapNoteScore,"Checkpoint") or string.find(params.TapNoteScore,"None") or params.TapNoteScore == "TapNoteScore_" then return end
		if not params.TapNoteScore or string.find(params.TapNoteScore,"Mine") then return end
		if params.HoldNoteScore then
			if isMGD(player) then
				if params.HoldNoteScore == "HoldNoteScore_Held" then
					glifemeter = screen:GetLifeMeter(player):GetLivesLeft()
					if glifemeter < 100 then screen:GetLifeMeter(player):ChangeLives(1) end
				elseif params.HoldNoteScore == "HoldNoteScore_LetGo" then
					screen:GetLifeMeter(player):ChangeLives(-1)
				end
			end
			return
		end

		if GAMESTATE:GetCurrentGame():CountNotesSeparately() then params = GetTrueJudgment(params,player) end
		local judg = params.TapNoteScore
		if judg == "TapNoteScore_None" or judg == "" then else
			PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)

			if current <= 3 and not PSS:FullComboOfScore('TapNoteScore_W1') and not PSS:FullComboOfScore('TapNoteScore_W2')  and not PSS:FullComboOfScore('TapNoteScore_W3') then
				current = 4
			elseif current <= 2 and not PSS:FullComboOfScore('TapNoteScore_W1') and not PSS:FullComboOfScore('TapNoteScore_W2')  and PSS:FullComboOfScore('TapNoteScore_W3') then
				current = 3
			elseif current <= 1 and not PSS:FullComboOfScore('TapNoteScore_W1') and PSS:FullComboOfScore('TapNoteScore_W2') then
				current = 2
			elseif current == 0 and PSS:FullComboOfScore('TapNoteScore_W1') then
				current = 1
			end

			local WX = params.TapNoteScore == "TapNoteScore_W1" and (math.abs(params.TapNoteOffset) <= W0 and "TapNoteScore_W0" or "TapNoteScore_W1" ) or params.TapNoteScore

			if not GAMESTATE:GetCurrentGame():CountNotesSeparately() and faplus then
				WXCounter = WXCounter + 1
				setenv("WX"..pname(player),WXCounter)
				if WX == "TapNoteScore_W0" then
					W0Counter = W0Counter + 1
					setenv("W0"..pname(player),W0Counter)
				elseif WX == "TapNoteScore_W1" then
					W1Counter = W1Counter + 1
					setenv("W1"..pname(player),W1Counter)
				end
				MESSAGEMAN:Broadcast("W0",{Player=player,W0=W0Counter,W1=W1Counter,WX=WXCounter})
			end

			if GAMESTATE:GetPlayerState(player):GetPlayerController() ~= 'PlayerController_Human' and
			getenv("checkAuto"..pname(player)) then
				if not isOutFox(20200530) then GAMESTATE:ApplyGameCommand('mod,no savescore',player) end
				setenv("checkFantastics"..pname(player),false)
				setenv("checkPerfects"..pname(player),false)
				setenv("checkGreats"..pname(player),false)
				setenv("checkAuto"..pname(player),false)
				setenv("check"..pname(player),false)
				setenv("EvalCombo"..pname(player),false)
			end
			if getenv("check"..pname(player)) then
				if getenv("checkFantastics"..pname(player)) and current > 1 then
					setenv("checkFantastics"..pname(player),false)
					setenv("LastFantastic"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
				end
				if getenv("checkPerfects"..pname(player)) and current > 2 then
					setenv("checkPerfects"..pname(player),false)
					setenv("LastPerfect"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
				end
				if getenv("checkGreats"..pname(player)) and current > 3 then
					setenv("checkGreats"..pname(player),false)
					setenv("LastGreat"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds())
					setenv("check"..pname(player),false)
				end
			end
			local curCombo = PSS:GetCurrentCombo()
			local output = (judgment and JUDGMENT[WX].."x" or "")..((COMBO[WX] and combo) and curCombo or "")
			self:GetChild("_C0"):settext(output)
			self:GetChild("_C1"):visible(current == 1):settext(output)
			self:GetChild("_C2"):visible(current == 2):settext(output)
			self:GetChild("_C3"):visible(current == 3):settext(output)
			self:GetChild("_C4"):visible(current == 4):settext(output)
			MESSAGEMAN:Broadcast("Combo",{Player=player,TapNoteScore=(faplus and WX or params.TapNoteScore)})
		end
	end,
	OffCommand=function(self)
		if getenv("checkFantastics"..pname(player)) then setenv("LastFantastic"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkPerfects"..pname(player)) then setenv("LastPerfect"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
		if getenv("checkGreats"..pname(player)) then setenv("LastGreat"..pname(player),isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetAliveSeconds()) end
	end
}