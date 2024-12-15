local player = ...
assert( player )

local posX = 0

return Def.BitmapText {
	File = "_r bold 30px",
	Name="DeltaSeconds",
	InitCommand=function(self)
		self:visible(not getenv("HideScore"..pname(player))):valign(1):halign(0):zoom(0.5*WideScreenDiff_(16/9)):y(72.5*WideScreenDiff())
		if player == PLAYER_1 then
			posX = THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX")
		else
			posX = THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX")
		end
		if IsGame("pump") then
			if GAMESTATE:GetNumPlayersEnabled() == 1 and getenv("Rotation"..pname(player)) == 5 then posX = THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerTwoSidesX") end
			self:addy(10)
		end
		self:x(posX + 72*WideScreenDiff_(16/9)):shadowlength(1):skewx(-0.125)
	end,
	CurrentSongChangedMessageCommand=function(self)
		if GAMESTATE:IsCourseMode() then 
			local gainSeconds = GAMESTATE:GetCurrentCourse(player):GetCourseEntry(GAMESTATE:GetCourseSongIndex()):GetGainSeconds()
			self:stoptweening():diffuseshift():diffusealpha(1):zoom(0.75*WideScreenDiff_(16/9)):linear(0.3):zoom(0.6*WideScreenDiff_(16/9)):sleep(3):linear(0.5):diffusealpha(0)
			self:settextf("%+1.1fs", gainSeconds)
		end
	end,
	JudgmentMessageCommand=function(self,params)
		if params.Player == player then
			if params.HoldNoteScore then
			elseif params.TapNoteScore then
				local tns = ToEnumShortString(params.TapNoteScore)
				local prefname= ("TimeMeterSecondsChange%s"):format(tns)
				if PREFSMAN:PreferenceExists(prefname) then
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
					local time = pss:GetLifeRemainingSeconds()
					local width = time < 10*60 and 72 or 86
					self:stoptweening():stopeffect():x( posX + width*WideScreenDiff() ):diffusealpha(1):zoom(0.75*WideScreenDiff_(16/9)):linear(0.3):zoom(0.6*WideScreenDiff_(16/9)):sleep(1):diffusealpha(0)
					self:playcommand( "GainSeconds" )
					self:playcommand( tns )
					self:settextf( "%+1.1fs", PREFSMAN:GetPreference(prefname) )
				end
			else
				return
			end
		else
			return
		end
	end
}