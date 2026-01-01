local t = Def.ActorFrame{ Name="GameplayUnderlay" }
local stats = false

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if (getenv("ShowStats"..pname(pn)) and getenv("ShowStats"..pname(pn)) > 0) or (getenv("PlayerNoteGraph"..pname(pn)) and getenv("PlayerNoteGraph"..pname(pn)) > 1) then
		stats = true
	end
end

local DanceStageSelected = getenv("SelectDanceStage") or "OFF"
if DanceStageSelected ~= "OFF" and DoesDanceRepoExist() and not HasLuaCheck() then
	local CharaRandom = GetAllCharacterNames()
	table.remove(CharaRandom,IndexKey(CharaRandom,"Random"))
	table.remove(CharaRandom,IndexKey(CharaRandom,"None"))

	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if getenv("SelectCharacter"..pn) == "Random" then
			WritePrefToFile("CharaRandom"..pn,CharaRandom[math.random(#CharaRandom)])
		end
	end

	local style = GAMESTATE:GetCurrentStyle():GetStyleType()
	local st = GAMESTATE:GetCurrentStyle():GetStepsType()
	local show_cutins = GAMESTATE:GetCurrentSong() and (not GAMESTATE:GetCurrentSong():HasBGChanges()) or true
	local filter_color= color("0,0,0,0")
	local screen = Var"LoadingScreen"
	local x_table = {
		PlayerNumber_P1 = THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX"),
		PlayerNumber_P2 = THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX")
	}
	setenv("ForceCutin",false)
	for _, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
		if st ~= 'StepsType_Dance_Double' and ThemePrefs.Get("FlashyCombo") == true then
			if FILEMAN:DoesFileExist("/Characters/"..WhichRead(pn).."/Cut-In") then
				setenv("ForceCutin",true)
				if (not HasVideo() and not GAMESTATE:GetCurrentSong():HasBGChanges()) or (HasVideo() and VideoStage()) or (HasVideo() and not VideoStage() and getenv("CutInOverVideo") == "ON") then
					t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","underlay/Cutin.lua"))(pn)..{
						OnCommand=function(s) s:setsize(450,SCREEN_HEIGHT) end,
						InitCommand=function(self)
							self:CenterY()
							if style == "StyleType_TwoPlayersTwoSides" or GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
								self:x(SCREEN_CENTER_X)
							else
								if getenv("Rotation"..pname(pn)) == 5 then
									self:x(x_table[OtherPlayer[pn]])
								else
									if getenv("ShowStatsSize"..pname(pn)) == 1 then
										self:x(SCREEN_CENTER_X)
									else
										self:x(x_table[pn])
									end
								end
							end
						end
					}
				end
			end
		end
	end
end

local beginnerHelper = PREFSMAN:PreferenceExists("ShowBeginnerHelper") and tobool(PREFSMAN:GetPreference("ShowBeginnerHelper")) or false

t[#t+1] = Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/beginner"))()..{ Condition=beginnerHelper and isRegular() and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner' },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats"))()..{ Condition=stats }
}

return t