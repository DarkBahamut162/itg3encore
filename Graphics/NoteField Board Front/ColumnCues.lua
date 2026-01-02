local player = ...
if not GAMESTATE:IsHumanPlayer(player) then return Def.ActorFrame{} end
local style = GAMESTATE:GetCurrentStyle()
local NumColumns = style:ColumnsPerPlayer()
local width = GetTrueWidth(player)
local widthFixed = {
	["Key2"] = 28,
	["Key4"] = 28,
	["Key6"] = 28,
	["Blue"] = 28,
	["Yellow"] = 28,
	["Key1"] = 36,
	["Key3"] = 36,
	["Key5"] = 36,
	["Key7"] = 36,
	["Green"] = 36,
	["Red"] = 36,
	["White"] = 36,
	["foot"] = 40,
	["scratch"] = 60,
}
local columns = getenv("ShowColumns"..pname(player)) or 0
local bits = NumberToBits(columns,isOpenDDR() and 6 or 7)
local checkJudgments = {}
local judgments = {
	"TapNoteScore_Miss",
	"TapNoteScore_W5",
	"TapNoteScore_W4",
	"TapNoteScore_W3",
	"TapNoteScore_W2",
	"TapNoteScore_W1"
}

if isOpenDDR() then table.remove(judgments,2) end

for j=2,#bits do
	if bits[#bits-j+1] then
		checkJudgments[judgments[j-1]] = true
	end
end

local NoteFieldMiddle = (THEME:GetMetric("Player","ReceptorArrowsYStandard")+THEME:GetMetric("Player","ReceptorArrowsYReverse"))/2
local mods = string.find(GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
local reverse = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):UsingReverse()
if mods then reverse = not reverse end
local posY = reverse and THEME:GetMetric("Player","ReceptorArrowsYReverse") or THEME:GetMetric("Player","ReceptorArrowsYStandard")

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny

local totalDelta = 0
local tmpDelta = 0
local checking = true
local first = true
local c
local noteData = {}
local trueFirst = 0

function setCol()
	noteData = {}
	local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSong() or GAMESTATE:GetCurrentSong()
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSteps() or GAMESTATE:GetCurrentSteps(player)
	trueFirst = tonumber(LoadFromCache(SongOrCourse,StepsOrTrail,"TrueFirstBeat"))
	local timingData = StepsOrTrail:GetTimingData()
	local chartint = 1

	if isOutFox(20200400) then
		if not isOutFoxV043() then
			for i,current in pairs( SongOrCourse:GetAllSteps() ) do
				if current == StepsOrTrail then
					chartint = i
					break
				end
			end
		end
		noteData = isOutFoxV043() and StepsOrTrail:GetNoteData(trueFirst,trueFirst) or SongOrCourse:GetNoteData(chartint,trueFirst,trueFirst)
	else
		local filePath = StepsOrTrail:GetFilename():lower()
		if filePath:sub(-2):sub(1,1) == 's' then
			local firstRow = LoadFromCache(SongOrCourse,StepsOrTrail,"FirstRow")
			local check = {
				["L"] = true,
				["1"] = true,
				["2"] = true,
				["4"] = true,
			}
			for i=1, string.len(firstRow) do
				if check[firstRow:sub(i,i)] then
					noteData[#noteData+1] = {"",i}
					break
				end
			end
		else
			local firstRow = split("_",LoadFromCache(SongOrCourse,StepsOrTrail,"FirstRow"))
			local notes = NumColumns
			if IsGame("be-mu") or IsGame("beat") then 
				if isDouble() then
					local add = ((notes == 14 and player == PLAYER_2) or notes < 14) and 0 or 1
					local half = notes / 2
					for note in ivalues(firstRow) do
						if note == "11" or note == "51" then noteData[#noteData+1] = {"",1+add} end
						if note == "12" or note == "52" then noteData[#noteData+1] = {"",2+add} end
						if note == "13" or note == "53" then noteData[#noteData+1] = {"",3+add} end
						if note == "14" or note == "54" then noteData[#noteData+1] = {"",4+add} end
						if note == "15" or note == "55" then noteData[#noteData+1] = {"",5+add} end
						if note == "16" or note == "56" then noteData[#noteData+1] = {"",1+(7*(1-add))} end
						if note == "17" or note == "57" then noteData[#noteData+1] = {"",6+add} end
						if note == "18" or note == "58" then noteData[#noteData+1] = {"",6+add} end
						if note == "19" or note == "59" then noteData[#noteData+1] = {"",7+add} end
						if note == "21" or note == "61" then noteData[#noteData+1] = {"",half+1} end
						if note == "22" or note == "62" then noteData[#noteData+1] = {"",half+2} end
						if note == "23" or note == "63" then noteData[#noteData+1] = {"",half+3} end
						if note == "24" or note == "64" then noteData[#noteData+1] = {"",half+4} end
						if note == "25" or note == "65" then noteData[#noteData+1] = {"",half+5} end
						if note == "26" or note == "66" then noteData[#noteData+1] = {"",half+8} end
						if note == "27" or note == "67" then noteData[#noteData+1] = {"",half} end
						if note == "28" or note == "68" then noteData[#noteData+1] = {"",half+6} end
						if note == "29" or note == "69" then noteData[#noteData+1] = {"",half+7} end
					end
				else
					local add = ((notes == 7 and player == PLAYER_2) or notes < 7) and 0 or 1
					for note in ivalues(firstRow) do
						if note == "11" or note == "51" then noteData[#noteData+1] = {"",1+add} end
						if note == "12" or note == "52" then noteData[#noteData+1] = {"",2+add} end
						if note == "13" or note == "53" then noteData[#noteData+1] = {"",3+add} end
						if note == "14" or note == "54" then noteData[#noteData+1] = {"",4+add} end
						if note == "15" or note == "55" then noteData[#noteData+1] = {"",5+add} end
						if note == "16" or note == "56" then noteData[#noteData+1] = {"",1+(7*(1-add))} end
						if note == "17" or note == "57" then noteData[#noteData+1] = {"",6+add} end
						if note == "18" or note == "58" then noteData[#noteData+1] = {"",6+add} end
						if note == "19" or note == "59" then noteData[#noteData+1] = {"",7+add} end
					end
				end
			else
				local add = notes-9
				for note in ivalues(firstRow) do
					if note == "11" or note == "51" then noteData[#noteData+1] = {"",1+add} end
					if note == "12" or note == "52" then noteData[#noteData+1] = {"",2+add} end
					if note == "13" or note == "53" then noteData[#noteData+1] = {"",3+add} end
					if note == "14" or note == "54" then noteData[#noteData+1] = {"",4+add} end
					if note == "15" or note == "55" then noteData[#noteData+1] = {"",5+add} end
					if note == "22" or note == "62" then noteData[#noteData+1] = {"",6+add} end
					if note == "23" or note == "63" then noteData[#noteData+1] = {"",7+add} end
					if note == "24" or note == "64" then noteData[#noteData+1] = {"",8+add} end
					if note == "25" or note == "65" then noteData[#noteData+1] = {"",9+add} end
				end
			end
		end
	end
end

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1/60 and checking then
		tmpDelta = totalDelta
		local YoffsetBeat = ArrowEffects.GetYOffset(GAMESTATE:GetPlayerState(player),1,trueFirst)/64
		local currentBeat = GAMESTATE:GetSongPosition():GetSongBeatVisible()
		if YoffsetBeat < 6 and first then
			for note in ivalues( noteData ) do
				if first then c["Column"..note[2]]:accelerate(0.1):diffuse(0,0,0,0) end
			end
			if first then first = false end
		elseif YoffsetBeat < 0 then
			checking = false
		elseif YoffsetBeat >= 6 then
			for note in ivalues( noteData ) do
				if not first then c["Column"..note[2]]:decelerate(0.1):diffuse(Color("White")) end
			end
			if not first then first = true end
		end
    end
end

if columns > 0 then
	local t = Def.ActorFrame{
		InitCommand=function(self) c = self:GetChildren() end,
		CurrentSongChangedMessageCommand=function(self)
			checking,first = true,true
			setCol()
			for _,note in pairs( noteData ) do c["Column"..note[2]]:diffuse(Color("White")) end
		end,
		OnCommand=function(self)
			if bits[#bits] then
				for _,note in pairs( noteData ) do c["Column"..note[2]]:diffuse(Color("White")) end
				self:SetUpdateFunction(Update)
			end
		end
	}

	for ColumnIndex = 1, NumColumns do
		local player = PLAYER_1
		local info = style:GetColumnInfo(player, ColumnIndex)

		t[#t+1] = Def.Quad{
			Name="Column"..ColumnIndex,
			InitCommand=function(self)
				self:diffuse(0,0,0,0)
					:x(info.XOffset)
					:y(SCREEN_CENTER_Y+(posY-NoteFieldMiddle)/currentMini):valign(0)
					:setsize(widthFixed[info.Name] and widthFixed[info.Name] or width/NumColumns, (SCREEN_HEIGHT-math.abs(posY-NoteFieldMiddle))/currentMini)
					:fadebottom(0.333):fadetop(0.333)
				if reverse then self:rotationz(180) end
			end,
			JudgmentMessageCommand = function(self, params)
				if params.Player ~= player then return end
				if not params.TapNoteScore then return end
				if GAMESTATE:GetCurrentGame():CountNotesSeparately() then
					if params.FirstTrack ~= ColumnIndex - 1 then return end
					if params.Player == player and params.Notes then
						local tnt = ToEnumShortString(params.Notes[ColumnIndex]:GetTapNoteType())
						if "Column"..ColumnIndex == self:GetName() then
							if tnt == "Tap" or tnt == "HoldHead" or tnt == "LongNoteHead" or tnt == "Lift" then
								if checkJudgments[params.TapNoteScore] then
									self:stoptweening():diffuse(TapNoteScoreToColor(params.TapNoteScore)):accelerate(0.165):diffuse(0,0,0,0)
								end
							end
						end
					end
				else
					if params.Player == player and params.Notes then
						for i,col in pairs(params.Notes) do
							local tnt = ToEnumShortString(col:GetTapNoteType())
							if "Column"..i == self:GetName() then
								if tnt == "Tap" or tnt == "HoldHead" or tnt == "LongNoteHead" or tnt == "Lift" then
									if checkJudgments[params.TapNoteScore] then
										self:stoptweening():diffuse(TapNoteScoreToColor(params.TapNoteScore)):accelerate(0.165):diffuse(0,0,0,0)
									end
								end
							end
						end
					end
				end
			end
		}
	end

	return t
else
	return Def.ActorFrame{}
end