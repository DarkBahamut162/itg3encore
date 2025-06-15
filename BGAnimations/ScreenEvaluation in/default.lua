local extra = STATSMAN:GetCurStageStats():GetStage():lower():find("extra")
local failedExtra = false

if extra then
	local played = STATSMAN:GetCurStageStats():GetGameplaySeconds()
	local supposed = STATSMAN:GetCurStageStats():GetPlayedSongs()[1]:GetLastSecond()
	failedExtra = played < supposed
end

local currentStage = GAMESTATE:GetCurrentStageIndex()
local offsetInfo = getenv("OffsetTable")
local scores = isOpenDDR() and {
	"TapNoteScore_W1",
	"TapNoteScore_W2",
	"TapNoteScore_W3",
	"TapNoteScore_W4",
	"TapNoteScore_Miss"
} or {
	"TapNoteScore_W1",
	"TapNoteScore_W2",
	"TapNoteScore_W3",
	"TapNoteScore_W4",
	"TapNoteScore_W5",
	"TapNoteScore_Miss"
}

function playerData(player)
	local Step = {}
	local early = {
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	}
	local late = {
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	}
	
	if offsetInfo and ThemePrefs.Get("ShowOffset") then
		for t in ivalues(offsetInfo[player]) do
			if t[2] and type(t[2]) == "number" then
				if t[2] < 0 then
					early[t[3]] = early[t[3]] + 1
				elseif t[2] > 0 then
					late[t[3]] = late[t[3]] + 1
				end
			end
		end
	end
	for score in ivalues(scores) do Step[score] = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores(score) end
	for score,amount in pairs(early) do Step[score.."_Early"] = amount end
	for score,amount in pairs(late) do Step[score.."_Late"] = amount end
	Step["Score"] = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
	Step["Grade"] = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetGrade()
	Step["Difficulty"] = GAMESTATE:GetCurrentSteps(player):GetDifficulty()
	Step["Meter"] = GAMESTATE:GetCurrentSteps(player):GetMeter()
	if player == PLAYER_1 then
		P1[0] = PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player)
		P1[currentStage] = Step
	else
		P2[0] = PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player)
		P2[currentStage] = Step
	end
end

if ThemePrefs.Get("ShowSummary") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do playerData(pn) end
	Master[currentStage] = {
		["Banner"] = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetBannerPath() or GAMESTATE:GetCurrentSong():GetBannerPath(),
		["Title"] = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayMainTitle() or GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),
		["Subtitle"] = GAMESTATE:IsCourseMode() and "" or GAMESTATE:GetCurrentSong():GetDisplaySubTitle(),
		["Artist"] = GAMESTATE:IsCourseMode() and "" or GAMESTATE:GetCurrentSong():GetDisplayArtist()
	}
end

return Def.ActorFrame{
	loadfile(THEME:GetPathB("_fade in","normal"))(),
	Def.Actor{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75):diffusealpha(1) end,
		OnCommand=function(self) self:sleep(4):linear(0.3):diffuse(color("0,0,0,0")):addy(-30) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX() end,
		BeginCommand=function(self) self:visible( STATSMAN:GetCurStageStats():OnePassed() and not failedExtra ) end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay out/_round",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(1) end,
			OnCommand=function(self) self:sleep(0.1):linear(0.4):diffusealpha(0):addy(-30) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay out/_cleared bottom",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+15*WideScreenDiff()):zoom(0.9*WideScreenDiff()):diffusealpha(1) end,
			OnCommand=function(self) self:sleep(0.1):accelerate(0.4):diffusealpha(0):addx(-100) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay out/_cleared top",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+10*WideScreenDiff()):zoom(0.9*WideScreenDiff()):diffusealpha(1) end,
			OnCommand=function(self) self:sleep(0.1):accelerate(0.4):diffusealpha(0):addx(100) end
		}
	},
	Def.ActorFrame{
		Name="Cleared",
		BeginCommand=function(self) self:visible( STATSMAN:GetCurStageStats():OnePassed() and not failedExtra ) end,
		Def.Sprite {
			Texture = "cleared glow "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropleft(1):cropright(-0.3) end
		},
		Def.Sprite {
			Texture = "cleared text "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropright(-0.3):sleep(1.95):linear(0.3):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		Name="Failed",
		BeginCommand=function(self) self:visible( not STATSMAN:GetCurStageStats():OnePassed() or failedExtra ) end,
		Def.Sprite {
			Texture = "failed glow "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropleft(1):cropright(-0.3) end
		},
		Def.Sprite {
			Texture = "failed text "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropright(-0.3):sleep(1.95):linear(0.3):diffusealpha(0) end
		}
	}
}