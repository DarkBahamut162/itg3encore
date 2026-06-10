local player = ...
assert(player,"[ScreenEvaluation IIDXClearRecord] requires player")
local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)

local currentScore = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetCurrentLife()
local currentLevel = 0
if GAMESTATE:IsCourseMode() then currentLevel = getenv("IIDXDifficultyClass"..pname(player)) else currentLevel = getenv("IIDXDifficultyGauge"..pname(player)) end
local visible = currentLevel > 0
local previousScore = 0
local previousLevel = 1
local update = false
local passed = false

if visible and getenv("EvalCombo"..pname(player)) then
	if isEtterna("0.71") then passed = not STATSMAN:GetCurStageStats():Failed() else passed = STATSMAN:GetCurStageStats():OnePassed() end
	if PSS:GetFailed() then currentLevel = 0 end
	if currentLevel > 0 then
		if (isEtterna("0.71") and not STATSMAN:GetCurStageStats():Failed() or STATSMAN:GetCurStageStats():OnePassed()) and GAMESTATE:GetPlayerState(player):GetPlayerController() == 'PlayerController_Human' then
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			if SongOrCourse then
				local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if StepsOrTrail then
					local directory = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseDir() or SongOrCourse:GetSongDir()
					local arr = split("/",directory)
					local difficulty = ToEnumShortString(StepsOrTrail:GetDifficulty())
					local identifier = StepsOrTrail.GetHash and StepsOrTrail:GetHash() or 0
					if identifier == 0 then identifier = StepsOrTrail:GetMeter() end
					directory = arr[4].."/"..difficulty.."/"..identifier

					local table = split("_",IIDXClear[player][category][arr[3]] and IIDXClear[player][category][arr[3]][directory] or "0")
					previousLevel = table[1] or "0"
					previousScore = table[2] or "0"

					if not IIDXClear[player][category][arr[3]] then IIDXClear[player][category][arr[3]] = {} end
					if tonumber(table[1]) < currentLevel or tonumber(table[2] or 0) < currentScore then
						IIDXClear[player][category][arr[3]][directory] = currentLevel.."_"..currentScore
						IIDXClearSave(player)
						update = true
					end
				end
			end
		end
	end
end

local text = {}
local index = 1
local switch = THEME:GetMetric("HelpDisplay","TipSwitchTime")
local start = GetTimeSinceStart()
previousScore = FormatPercentScore(previousScore)
currentScore = FormatPercentScore(currentScore)
local IIDXClearRecord = update and "New IIDX Clear Record!::"..previousScore.." ("..previousLevel..") -> "..currentScore.." ("..currentLevel..")" or "No IIDX Clear Record...::"..currentScore.." ("..currentLevel..") -|> "..previousScore.." ("..previousLevel..")"
if previousScore == currentScore and previousLevel == currentLevel then IIDXClearRecord = "Unchanged IIDX Clear Record!::"..previousScore.." ("..previousLevel..")" end

local HelpDisplay = isEtterna("0.65") and Def.ActorFrame{
	Def.BitmapText {
		File=THEME:GetPathF("HelpDisplay","text"),
		InitCommand=function(self)
			local s = IIDXClearRecord
			text = split("::",s)
			self:shadowlength(0):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5)
			self:zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):vertspacing(-10):sleep(3):maxwidth(333):visible(visible):queuecommand("Update")
			self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF"))
		end,
		UpdateCommand=function(self)
			if #text == 1 then
				self:settext(text[1])
			else
				local currentScore = GetTimeSinceStart()
				if currentScore-start >= switch then
					start = currentScore
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
			self:SetTipsColonSeparated(IIDXClearRecord)
			self:zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):vertspacing(-10):hibernate(3):maxwidth(333):visible(visible and passed)
		end,
		OnCommand=function(self) self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}

return HelpDisplay