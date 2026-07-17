local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")
local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
local float = getenv("FlareDisplay"..pname(player))
local flareLevel = getenv("Flare"..pname(player))
local visible = flareLevel > 0 and not GAMESTATE:IsCourseMode()

local currentScore = 0
local currentLevel = flareLevel
local previousScore = 0
local previousLevel = 1
local update = false


if visible and getenv("FlareFloat"..pname(player)) then
	if type(float[#float][2]) ~= 'table' then
		currentLevel = #split("|",float[#float][2])
	else
		currentLevel = #float[#float][2]
	end
end

if visible and getenv("EvalCombo"..pname(player)) then
	if PSS:GetFailed() then currentLevel = 0 end
	if getenv("FlareFloat"..pname(player)) and currentLevel <= flareLevel and tonumber(float[#float][2][flareLevel]) < 0 then currentLevel = 0 end

	if flareLevel > 0 and currentLevel > 0 then
		if (isEtterna("0.71") and not STATSMAN:GetCurStageStats():Failed() or STATSMAN:GetCurStageStats():OnePassed()) and GAMESTATE:GetPlayerState(player):GetPlayerController() == 'PlayerController_Human' then
			local stepSize = 1
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			if StepsOrTrail then
				local holdlifts = isOutFox(20210400) and GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):HoldLifts() or false
				if IsCourseSecret() or not IsCourseFixed() then
					stepSize = RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_TapsAndHolds")
					stepSize = math.max(stepSize + (RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_Holds") + RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_Rolls")*(holdlifts and 2 or 1)),1)
				else
					stepSize = StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds") or 0
					stepSize = math.max(stepSize + (StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Holds') + StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Rolls'))*(holdlifts and 2 or 1),1)
				end
			end

			local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local w1 = stats:GetTapNoteScores('TapNoteScore_W1')
			local w2 = stats:GetTapNoteScores('TapNoteScore_W2')
			local w3 = stats:GetTapNoteScores('TapNoteScore_W3')
			local hd = stats:GetHoldNoteScores('HoldNoteScore_Held')
			local score = (w1 + w2 + w3 + hd) * 100000 / stepSize
			local sub = (w3*0.5) * 100000 / stepSize
			currentScore = string.format("%07d",(math.floor(score-sub)-(w2+w3))*10)
			local temp = split("_",GetFlare(player,SongOrCourse,StepsOrTrail))
			previousLevel = temp[1] or "0"
			previousScore = temp[2] or "0000000"
			update = UpdateFlare(SongOrCourse,StepsOrTrail,currentLevel,currentScore,player)
			if update then SaveFlare(player) end
		end
	end
end

local text = {}
local index = 1
local switch = THEME:GetMetric("HelpDisplay","TipSwitchTime")
local start = GetTimeSinceStart()
local FlareRecord = update and "New Flare Record!::"..previousScore.." ("..previousLevel..") -> "..currentScore.." ("..currentLevel..")" or "No Flare Record...::"..currentScore.." ("..currentLevel..") -|> "..previousScore.." ("..previousLevel..")"

local HelpDisplay = isEtterna("0.65") and Def.ActorFrame{
	Def.BitmapText {
		File=THEME:GetPathF("HelpDisplay","text"),
		InitCommand=function(self)
			local s = FlareRecord
			text = split("::",s)
			self:shadowlength(0):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5)
			self:zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):vertspacing(-10):sleep(3):maxwidth(333):visible(visible):queuecommand("Update")
			self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF"))
		end,
		UpdateCommand=function(self)
			if #text == 1 then
				self:settext(text[1])
			else
				local current = GetTimeSinceStart()
				if current-start >= switch then
					start = current
					if #text == index then index = 1 else index = index + 1 end
				end

				self:settext(text[index]):sleep(1/60):queuecommand("Update")
			end
		end
	}
} or Def.ActorFrame{
	Def.HelpDisplay {
		File=THEME:GetPathF("HelpDisplay", "text"),
		InitCommand=function(self)
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated(FlareRecord)
			self:zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):vertspacing(-10):hibernate(3):maxwidth(333):visible(visible)
		end,
		OnCommand=function(self) self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}

return HelpDisplay