local path = "Save/DefaultLuaModifiers.ini"
local file = {
	LuaOptions = {
		Rotation = 1,
		PercentageClearThreshold = 0,

		Flare = 0,
		FlareFloat = false,
		FlareType = 1,
		FlareAccurate = false,

		Effect = 0,

		HideScore = false,
		HideJudgment = false,
		HideCombo = false,
		HideLife = false,

		UnderCombo = false,
		UnderTapJudgments = false,
		UnderHoldJudgments = false,

		ShowMovePlayerfieldStats = 3,
		SetScoreType = 2,
		ErrorBar = 0,
		ShowColumns = 0,
		BeatBars = 0,
		BeatBarsOutFox = 0,
		SetScoreDirection = 1,
		SetScoreFA = false,
		ScreenFilter = 0,

		ShowStats = 0,
		ShowStatsSize = 1,
		ShowStatsPos = 0,
		PlayerNoteGraph = 1,
		PlayerNoteGraphType = 2,
		PlayerNoteGraphRange = 1,
		PlayerNoteGraphData = false,
		SetPacemaker = 0,
		SetPacemakerFail = 0,

		ShowMods = false,
		ShowSpeedAssist = false,
		ShowStopAssist = false,
		SongFrame = "_normal",
		HoldJudgment = "_itg3",
		Judgment = "_itg3",
		GreenNumber = false,
		GreenNumber2 = false,

		IIDXFrame = "_random",
		IIDXLife = true,
		IIDXPercent = true,
		IIDXDouble = false,
		IIDXJudgment = "default",
		IIDXJudgmentBrightness = 1,
		IIDXNote = "default",
		IIDXNoteBackgroundBrightness = 0,
		IIDXNoteBrightness = 1,
		IIDXNoteLength = "normal",
		IIDXBeam = "default",
		IIDXBeamBrightness = 1,
		IIDXBeamLength = "normal",
		IIDXTurntable = "_default",
		IIDXExplosion ="_default",
		IIDXExplosionBrightness = 1
	}
}

if not FILEMAN:DoesFileExist(path) then
	IniFile.WriteFile(path, file)
	if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
else
	local loaded = IniFile.ReadFile("Save/DefaultLuaModifiers.ini")
	local missing = false
	for key,value in pairs(file["LuaOptions"]) do
		if loaded["LuaOptions"][key] == nil then
			loaded["LuaOptions"][key] = file["LuaOptions"][key]
			missing = true
		end
	end
	if missing then
		IniFile.WriteFile(path, loaded)
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
	end
end


local showData = {
	[PLAYER_1] = false,
	[PLAYER_2] = false
}

local function CreditsText(pn)
	local text = Def.BitmapText {
		File = THEME:GetPathF(Var "LoadingScreen", "credits"),
		InitCommand=function(self)
			self:name("Credits"..PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end,
		UpdateTextCommand=function(self)
			local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn)
			if PROFILEMAN:IsPersistentProfile(pn) then
				local data = nil
				if str == "" then str = "PLAYER "..(pn == PLAYER_1 and "1" or "2") end
				if showData[pn] then data = GetData(pn) self:settext("LV"..data["LV"].." | EXP "..data["EXP"].."\n"..str):vertspacing(-8) else self:settext(str) end
			else
				self:settext(str)
			end
		end,
		EnablePlayerStatsMessageCommand=function(self,param)
			if param.PLAYER and self:GetName() == "Credits"..pname(param.PLAYER) then
				if not showData[pn] and PROFILEMAN:IsPersistentProfile(pn) then showData[pn] = true end
				self:queuecommand("UpdateText")
			end
		end,
		DisablePlayerStatsMessageCommand=function(self,param)
			if param.PLAYER and self:GetName() == "Credits"..pname(param.PLAYER) then
				if showData[pn] and PROFILEMAN:IsPersistentProfile(pn) then showData[pn] = false end
				self:queuecommand("UpdateText")
			end
		end,
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen()
			local bShow = true
			if screen then
				local sClass = screen:GetName()
				bShow = THEME:GetMetric(sClass,"ShowCreditDisplay")
			end

			self:visible(bShow)
		end
	}
	return text
end

local t = Def.ActorFrame{}

t[#t+1] = loadfile(THEME:GetPathB("ScreenSystemLayer",isEtterna() and "error" or "aux"))()
t[#t+1] = Def.ActorFrame{
	CreditsText(PLAYER_1),
	CreditsText(PLAYER_2)
}
t[#t+1] = Def.ActorFrame{
	Def.Quad{
		Name="BG",
		InitCommand=function(self) self:zoomtowidth(SCREEN_WIDTH):zoomtoheight(30):horizalign(left):vertalign(top):y(SCREEN_TOP):diffuse(color("0,0,0,0")) end,
		OnCommand=function(self) self:finishtweening():diffusealpha(0.85) end,
		OffCommand=function(self,param) self:sleep(param.TIME):linear(0.5):diffusealpha(0) end
	},
	Def.BitmapText{
		Font="Common Normal",
		Name="Text",
		InitCommand=function(self) self:maxwidth((SCREEN_WIDTH-20)*1.75):horizalign(left):vertalign(top):y(SCREEN_TOP+10):x(SCREEN_LEFT+10):shadowlength(1):diffusealpha(0) end,
		OnCommand=function(self) self:finishtweening():diffusealpha(1):zoom(0.5) end,
		OffCommand=function(self,param) self:sleep(param.TIME):linear(0.5):diffusealpha(0) end
	},
	SystemMessageMessageCommand=function(self,params)
		self:GetChild("Text"):settext(params.Message)
		local _,lines = string.gsub(params.Message,"\n","")
		local _,count = string.gsub(params.Message,".","")
		self:GetChild("BG"):zoomtoheight(10+(lines+1)*18)
		self:playcommand("On")
		if params.NoAnimate then self:finishtweening() end
		self:playcommand("Off",{TIME=count*0.1})
	end,
	HideSystemMessageMessageCommand=function(self) self:finishtweening() end
}

return t