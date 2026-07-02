local player = ...
if not isGrooveStats(player) then return "" end
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)

local fantastic_plus
local fantastic
local excellent
local great
local decent
local wayOff
local miss
local total_steps
local holds_held
local total_holds
local mines_hit
local total_mines
local rolls_held
local total_rolls

local TNS = { "W1", "W2", "W3", "W4", "W5", "Miss" }
local faplus = getenv("SetScoreFA"..pname(player))

for i,window in pairs(TNS) do
	local number = stats:GetTapNoteScores( "TapNoteScore_"..window )
	if i == 1 then
		fantastic_plus = faplus and (getenv("W0"..pname(player)) or 0) or 0
		fantastic = faplus and (getenv("W1"..pname(player)) or 0) or number
	else
		if i == 2 then
			excellent = number
		elseif i == 3 then
			great = number
		elseif i == 4 then
			decent = number
		elseif i == 5 then
			wayOff = number
		elseif i == 6 then
			miss = number
		end
	end
end

total_steps = StepsOrTrail:GetRadarValues(player):GetValue( "RadarCategory_TapsAndHolds" )

local RadarCategory = { "Holds", "Mines", "Rolls" }
local po = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")

for i,RCType in pairs(RadarCategory) do
	local number = stats:GetRadarActual():GetValue( "RadarCategory_"..RCType )
	local possible = StepsOrTrail:GetRadarValues(player):GetValue( "RadarCategory_"..RCType )

	if RCType == "Mines" then
		if po:NoMines() then
			mines_hit = 0
			total_mines = 0
		else
			mines_hit = possible - number
			total_mines = possible
		end
	else
		if i == 1 then
			holds_held = number
			total_holds = possible
		elseif i == 3 then
			rolls_held = number
			total_rolls = possible
		end
	end
end

local cmod = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):CMod()
local used_cmod = cmod ~= nil and "1" or "0"

local failed = stats:GetFailed() and "1" or "0"
local rate = tonumber(string.format("%.0f", GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate() * 100))

local steps = GAMESTATE:GetCurrentSteps(player)
local hash = LoadFromCache(SongOrCourse,StepsOrTrail,"GrooveStatsHash")
local hash_version = 3

local rows = { "W0", "W1", "W2", "W3", "W4", "W5" }
local rescored_str = ""

if false then
	local columns = getenv( "perColJudgeDataEarly" )[player]
	local rescored = {
		W0 = 0,
		W1 = 0,
		W2 = 0,
		W3 = 0,
		W4 = 0,
		W5 = 0
	}

	for i=1,GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() do
		for j, judgment in ipairs(rows) do
			rescored[judgment] = rescored[judgment] + columns[i][judgment]
		end
	end

	if rescored["W0"] > 0 then rescored_str = rescored_str .. "G" .. ("%x"):format(rescored["W0"]) end
	if rescored["W1"] > 0 then rescored_str = rescored_str .. "H" .. ("%x"):format(rescored["W1"]) end
	if rescored["W2"] > 0 then rescored_str = rescored_str .. "I" .. ("%x"):format(rescored["W2"]) end
	if rescored["W3"] > 0 then rescored_str = rescored_str .. "J" .. ("%x"):format(rescored["W3"]) end
	if rescored["W4"] > 0 then rescored_str = rescored_str .. "K" .. ("%x"):format(rescored["W4"]) end
	if rescored["W5"] > 0 then rescored_str = rescored_str .. "L" .. ("%x"):format(rescored["W5"]) end
end

return ("HTTPS://GROOVESTATS.COM/QR/%s/T%xG%xH%xI%xJ%xK%sL%sM%xH%xT%xR%xT%xM%xT%x%s/F%sR%xC%sV%x"):format(
        hash, total_steps, fantastic_plus, fantastic, excellent, great, decent, wayOff, miss,
        holds_held, total_holds, rolls_held, total_rolls, mines_hit, total_mines, rescored_str,
        failed, rate, used_cmod, hash_version):upper()