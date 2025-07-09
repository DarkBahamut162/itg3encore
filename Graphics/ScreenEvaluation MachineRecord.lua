local player = ...
assert(player,"[ScreenEvaluation MachineRecord] requires player")
local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
local record = pss:GetMachineHighScoreIndex()

if getenv("EvalCombo"..pname(player)) and not isOutFoxV() and GAMESTATE:IsEventMode() and record == -1 then
	if isEtterna() then
		local score = SCOREMAN:GetMostRecentScore()
		local origTable = getScoresByKey(player)
		local rtTable = getRateTable(origTable) or {}
		local hsTable = rtTable[getRate(score)] or {score}
		local scoreIndex = getHighScoreIndex(hsTable, score)

		record = (scoreIndex-1) or -1
	else
		local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
		local HighScoreList = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail)
		local HighScores = HighScoreList:GetHighScores()
		for i, highscore in ipairs(HighScores) do
			local name
			if  pss:GetHighScore():GetScore() == highscore:GetScore()
			and pss:GetHighScore():GetDate()  == highscore:GetDate()
			and
			(
				name == PROFILEMAN:GetProfile(player):GetLastUsedHighScoreName()
				or
				(
					(#GAMESTATE:GetHumanPlayers()==1 and name=="EVNT")
					or (highscore:GetScore() ~= STATSMAN:GetCurStageStats():GetPlayerStageStats(OtherPlayer[player]):GetHighScore():GetScore())
				)
			)
			then
				record = i-1
				break
			end
		end
	end
end

local hasMachineRecord = (record ~= -1) and record <= 10

if hasMachineRecord and not STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed() then
	setenv("HighScoreable"..pname(player),true)
end

return Def.ActorFrame{
	Def.BitmapText {
		File = "_v 26px bold white",
		InitCommand=function(self) self:zoomx(0.6):zoomy(0.5):shadowlength(2*WideScreenDiff()):cropright(1):visible(hasMachineRecord) end,
		BeginCommand=function(self)
			self:settext(string.format("Machine Record #%i",record+1))
		end,
		OnCommand=function(self) self:sleep(3):linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}