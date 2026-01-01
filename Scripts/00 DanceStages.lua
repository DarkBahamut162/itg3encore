--Thank you for using this project.
--Please consider all the effort that has been made, so remember to play fair.
--Enjoy! See you later alligator.
--Author: Enciso0720
--Last Update: 20230813
function HasAnyCharacters(pn)
	return GAMESTATE:IsPlayerEnabled(pn) and GAMESTATE:GetCharacter(pn):GetDisplayName() ~= "default"
end

function AnyoneHasChar()
	return (HasAnyCharacters(PLAYER_1) or HasAnyCharacters(PLAYER_2))
end

function BothPlayersEnabled()
	return GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2)
end

function DancerMateEnabled()
	if GAMESTATE:IsPlayerEnabled(PLAYER_1) and getenv("DancerMate") ~= "None" then
		return true
	else
		return false
	end
end

function ResetCamera()
	local cFOV = 90
	if THEME:GetMetric("Common", "ScreenHeight") >= 1080 then cFOV = 91.3 end
    return Camera:fov(cFOV):rotationy(180):rotationx(0):rotationz(0):Center():z(WideScale(300,400)):addy(10):stopeffect()
end

DEDICHAR = {}

function DEDICHAR:SetTimingData()
	setenv("song", 	GAMESTATE:GetCurrentSong() )
	setenv("start", getenv("song"):GetFirstBeat() )
	setenv("now",	GAMESTATE:GetSongBeat() )
end

Config = {}

function Config.Load(key,file)
	if not FILEMAN:DoesFileExist(file) then return false end
	
	local Container = {}

	local configfile = RageFileUtil.CreateRageFile()
	configfile:Open(file, 1)
	
	local configcontent = configfile:Read()
	
	configfile:Close()
	configfile:destroy()
	
	for line in string.gmatch(configcontent.."\n", "(.-)\n") do
		for KeyVal, Val in string.gmatch(line, "(.-)=(.+)") do
			if key == KeyVal then return Val end
		end		
	end
end

function SlowMotion(self)
	local SPos = GAMESTATE:GetSongPosition()
	
	if not SPos:GetFreeze() and not SPos:GetDelay() then
		self:SetUpdateRate(1)
	else
		self:SetUpdateRate(0.1)
	end
end

function setenv(name,value) GAMESTATE:Env()[name] = value end
function getenv(name) return GAMESTATE:Env()[name] end

function VideoStage()
	local DanceStage = getenv("SelectDanceStage")
	if string.match(DanceStage, "MOVIE") or string.match(DanceStage, "REPLICANT") or string.match(DanceStage, "BIG SCREEN") or string.match(DanceStage, "CAPTURE ME") then
		return true
	end
	return false
end

------------------------

function IndexKey(tab,el)
	for index, value in pairs(tab) do
		if value == el then
			return index
		end
	end
end

function Contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

function SortList(list1,list2,value)
    for index, x in pairs(list1) do
        if string.match(x,value) then
            table.insert(list2,list1[index])
        end
    end
end

function ReFillList(list1,list2)
    for index, x in pairs(list1) do
        if not Contains(list2,list1[index]) then
            table.insert(list2,#list2+1,list1[index])
        end
    end
end

function GetAllCharacterNames()
    local chars = {}
    local _chars = FILEMAN:GetDirListing("/Characters/", true, false)
    SortList(_chars,chars,"%(A%)")
    SortList(_chars,chars,"%(X2%)")
    SortList(_chars,chars,"%(X%)")
    SortList(_chars,chars,"%(SN2%)")
    SortList(_chars,chars,"%(SN%)")
    SortList(_chars,chars,"%[PiX%]")
    SortList(_chars,chars,"%[JB%]")
    SortList(_chars,chars,"%[DW%]")
    SortList(_chars,chars,"%(DDRII%)")
    SortList(_chars,chars,"%[DDRII%]")
    SortList(_chars,chars,"%(HP4%)")
    SortList(_chars,chars,"%[HP4%]")
	SortList(_chars,chars,"%(HP3%)")
    SortList(_chars,chars,"%[HP3%]")
	SortList(_chars,chars,"%(HP2%)")
    SortList(_chars,chars,"%[HP2%]")
	SortList(_chars,chars,"%(HP1%)")
    SortList(_chars,chars,"%[HP1%]")
	SortList(_chars,chars,"%(HP%)")
    SortList(_chars,chars,"%[HP%]")
	SortList(_chars,chars,"%(WINX%)")
    SortList(_chars,chars,"%[WINX%]")
    SortList(_chars,chars,"%(5th%)")
    SortList(_chars,chars,"%(4th%)")
    SortList(_chars,chars,"%(3rd%)")
    SortList(_chars,chars,"%(2nd%)")
    SortList(_chars,chars,"%(1st%)")
	SortList(_chars,chars,"%(CUSTOM%)")
    ReFillList(_chars,chars)
    table.remove(chars,IndexKey(chars,"DanceRepo"))
    table.remove(chars,IndexKey(chars,"default"))
    table.insert(chars,1,"Random")
    return chars
end

function OptionRowCharacters()
	local choiceList = GetAllCharacterNames()
	local t = {
		Name = "Characters",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = choiceList,
		LoadSelections = function(self, list, pn)
			if getenv("SelectCharacter"..pn) == nil or tonumber(getenv("SelectCharacter"..pn)) then
				setenv("SelectCharacter"..pn,"Random")
			end
			local Load=getenv("SelectCharacter"..pn)
			list[IndexKey(choiceList,Load)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then
					WritePrefToFile("SelectCharacter"..pn,choiceList[number])
					break
				end
			end
		end
	}   
	setmetatable( t, t )
	return t
end


function ResolveCharacterName(pn)
    local name = getenv("SelectCharacter"..pn)
    return name
end

function WhichRead(pn)
	if getenv("SelectCharacter"..pn) == "Random" then
		return getenv("CharaRandom"..pn)
	else
		return getenv("SelectCharacter"..pn)
	end
end

function RandomCharacter(pn)
    if ResolveCharacterName(pn) == "Random" then
        ChoiceList = GetAllCharacterNames()
        table.remove(ChoiceList,IndexKey(ChoiceList,"default"))
        table.remove(ChoiceList,IndexKey(ChoiceList,"None"))
        setenv("ChoiceRandom"..pn,ChoiceList[math.random(#ChoiceList)])
    end
end

function GetAllDanceStagesNames()
    local DanceStagesList = {}
    local _DanceStagesList = FILEMAN:GetDirListing("/DanceStages/", true, false)
    table.remove(_DanceStagesList,IndexKey(_DanceStagesList,"StageMovies"))
    SortList(_DanceStagesList,DanceStagesList,"%(A%)")
    SortList(_DanceStagesList,DanceStagesList,"%(X2%)")
    SortList(_DanceStagesList,DanceStagesList,"%(X%)")
    SortList(_DanceStagesList,DanceStagesList,"%(REPLICANT%)")
    SortList(_DanceStagesList,DanceStagesList,"%(2014%)")
    SortList(_DanceStagesList,DanceStagesList,"%(SN%)")
    SortList(_DanceStagesList,DanceStagesList,"%(DDRII%)")
    SortList(_DanceStagesList,DanceStagesList,"%[DDRII%]")
    SortList(_DanceStagesList,DanceStagesList,"%(HP4%)")
    SortList(_DanceStagesList,DanceStagesList,"%[HP4%]")
	SortList(_DanceStagesList,DanceStagesList,"%(HP3%)")
    SortList(_DanceStagesList,DanceStagesList,"%[HP3%]")
	SortList(_DanceStagesList,DanceStagesList,"%(HP2%)")
    SortList(_DanceStagesList,DanceStagesList,"%[HP2%]")
	SortList(_DanceStagesList,DanceStagesList,"%(HP1%)")
    SortList(_DanceStagesList,DanceStagesList,"%[HP1%]")
	SortList(_DanceStagesList,DanceStagesList,"%(HP%)")
    SortList(_DanceStagesList,DanceStagesList,"%[HP%]")
	SortList(_DanceStagesList,DanceStagesList,"%(WINX%)")
    SortList(_DanceStagesList,DanceStagesList,"%[WINX%]")
    SortList(_DanceStagesList,DanceStagesList,"%(YA%)")
    SortList(_DanceStagesList,DanceStagesList,"%(CUSTOM%)")
    table.insert(DanceStagesList,1,"OFF")
    table.insert(DanceStagesList,2,"DEFAULT")
    table.insert(DanceStagesList,3,"RANDOM")
    return DanceStagesList
end

function SelectDanceStage()
	local choiceListDS = GetAllDanceStagesNames()
	local t = {
		Name = "DanceStage",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = choiceListDS,
		LoadSelections = function(self, list, pn)
			if getenv("SelectDanceStage") == nil then
				setenv("SelectDanceStage","DEFAULT")
			end
			local DSLoad=getenv("SelectDanceStage")
			list[IndexKey(choiceListDS,DSLoad)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then WritePrefToFile("SelectDanceStage",choiceListDS[number]) end
			end
		end
	}   
    setmetatable( t, t )
    return t
end

--------------------

function CutInOverVideo()
	local t = {
		Name = "CutInOverVideo",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"ON", "OFF" },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("CutInOverVideo") ~= nil then
				if getenv("CutInOverVideo")=='ON' then
					list[1] = true
				elseif getenv("CutInOverVideo")=='OFF' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("CutInOverVideo",'OFF')
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("CutInOverVideo",'ON')
			elseif list[2] then
				WritePrefToFile("CutInOverVideo",'OFF')
			else
				WritePrefToFile("CutInOverVideo",'ON')
			end
		end
	}
	setmetatable( t, t )
	return t
end


function VideoOverStage()
	local t = {
		Name = "VideoOverStage",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"ON", "OFF" },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("VideoOverStage") ~= nil then
				if getenv("VideoOverStage")=='ON' then
					list[1] = true
				elseif getenv("VideoOverStage")=='OFF' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("VideoOverStage",'OFF')
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("VideoOverStage",'ON')
			elseif list[2] then
				WritePrefToFile("VideoOverStage",'OFF')
			else
				WritePrefToFile("VideoOverStage",'ON')
			end
		end
	}
	setmetatable( t, t )
	return t
end

function VoverS()
	if getenv("VideoOverStage") == "ON" then
		return true
	else
		return false
	end
end

function BoomSync()
	local t = {
		Name = "BoomSync",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"Normal", "BPM Sync" },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("BoomSync") ~= nil then
				if getenv("BoomSync")=='Normal' then
					list[1] = true
				elseif getenv("BoomSync")=='BPM Sync' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("BoomSync",'Normal')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("BoomSync",'Normal')
			elseif list[2] then
				WritePrefToFile("BoomSync",'BPM Sync')
			else
				WritePrefToFile("BoomSync",'Normal')
			end
		end
	}
	setmetatable( t, t )
	return t
end


function CharacterSync()
	local t = {
		Name = "CharacterSync",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"Normal", "BPM Sync" },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("CharacterSync") ~= nil then
				if getenv("CharacterSync")=='Normal' then
					list[1] = true
				elseif getenv("CharacterSync")=='BPM Sync' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("CharacterSync",'Normal')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("CharacterSync",'Normal')
			elseif list[2] then
				WritePrefToFile("CharacterSync",'BPM Sync')
			else
				WritePrefToFile("CharacterSync",'Normal')
			end
		end
	}
	setmetatable( t, t )
	return t
end


function DiscoStars()
	local t = {
		Name = "DiscoStars",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"Normal", "A few", "None"},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("DiscoStars") ~= nil then
				if getenv("DiscoStars")=='Normal' then
					list[1] = true
				elseif getenv("DiscoStars")=='A few' then
					list[2] = true
				elseif getenv("DiscoStars")=='None' then
					list[3] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("DiscoStars",'Normal')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("DiscoStars",'Normal')
			elseif list[2] then
				WritePrefToFile("DiscoStars",'A few')
			elseif list[3] then
				WritePrefToFile("DiscoStars",'None')
			else
				WritePrefToFile("DiscoStars",'Normal')
			end
		end
	}
	setmetatable( t, t )
	return t
end

function RMStage()
	local t = {
		Name = "RMStage",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"Random Movies", "Jacket" },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("RMStage") ~= nil then
				if getenv("RMStage")=='Random Movies' then
					list[1] = true
				elseif getenv("RMStage")=='Jacket' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("RMStage",'Jacket')
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("RMStage",'Random Movies')
			elseif list[2] then
				WritePrefToFile("RMStage",'Jacket')
			else
				WritePrefToFile("RMStage",'Random Movies')
			end
		end
	}
	setmetatable( t, t )
	return t
end


function CharaShadow()
	local t = {
		Name = "CharaShadow",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"ON", "OFF" },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("CharaShadow") ~= nil then
				if getenv("CharaShadow")=='ON' then
					list[1] = true
				elseif getenv("CharaShadow")=='OFF' then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("CharaShadow",'ON')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("CharaShadow",'ON')
			elseif list[2] then
				WritePrefToFile("CharaShadow",'OFF')
			else
				WritePrefToFile("CharaShadow",'ON')
			end
		end
	}
	setmetatable( t, t )
	return t
end

function SNEnv()
	local t = {
		Name = "SNEnv",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = {"Intense", "Colored", "Normal"},
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("SNEnv") ~= nil then
				if getenv("SNEnv")=='Intense' then
					list[1] = true
				elseif getenv("SNEnv")=='Colored' then
					list[2] = true
				elseif getenv("SNEnv")=='Normal' then
					list[3] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("SNEnv",'Intense')
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			if list[1] then
				WritePrefToFile("SNEnv",'Intense')
			elseif list[2] then
				WritePrefToFile("SNEnv",'Colored')
			elseif list[3] then
				WritePrefToFile("SNEnv",'Normal')
			else
				WritePrefToFile("SNEnv",'Intense')
			end
		end
	}
	setmetatable( t, t )
	return t
end

--------------------

function Mate1()
	local choiceList = GetAllCharacterNames()
	local t = {
		Name = "Mate1",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = choiceList,
		LoadSelections = function(self, list, pn)
			if getenv("Mate1") == nil then
				setenv("Mate1","None")
			end
			local DMLoad=getenv("Mate1")
			list[IndexKey(choiceList,DMLoad)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then WritePrefToFile("Mate1",choiceList[number])
				end
			end
		end
	}   
	setmetatable( t, t )
	return t
end

function Mate2()
	local choiceList = GetAllCharacterNames()
	local t = {
		Name = "Mate2",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = choiceList,
		LoadSelections = function(self, list, pn)
			if getenv("Mate2") == nil then
				setenv("Mate2","None")
			end
			local DMLoad=getenv("Mate2")
			list[IndexKey(choiceList,DMLoad)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then WritePrefToFile("Mate2",choiceList[number])
				end
			end
		end
	}   
	setmetatable( t, t )
	return t
end

function Mate3()
	local choiceList = GetAllCharacterNames()
	local t = {
		Name = "Mate3",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = choiceList,
		LoadSelections = function(self, list, pn)
			if getenv("Mate3") == nil then
				setenv("Mate3","None")
			end
			local DMLoad=getenv("Mate3")
			list[IndexKey(choiceList,DMLoad)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then WritePrefToFile("Mate3",choiceList[number])
				end
			end
		end
	}   
	setmetatable( t, t )
	return t
end

function Mate4()
	local choiceList = GetAllCharacterNames()
	local t = {
		Name = "Mate4",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = choiceList,
		LoadSelections = function(self, list, pn)
			if getenv("Mate4") == nil then
				setenv("Mate4","None")
			end
			local DMLoad=getenv("Mate4")
			list[IndexKey(choiceList,DMLoad)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then WritePrefToFile("Mate4",choiceList[number])
				end
			end
		end
	}   
	setmetatable( t, t )
	return t
end

function Mate5()
	local choiceList = GetAllCharacterNames()
	local t = {
		Name = "Mate5",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = choiceList,
		LoadSelections = function(self, list, pn)
			if getenv("Mate5") == nil then
				setenv("Mate5","None")
			end
			local DMLoad=getenv("Mate5")
			list[IndexKey(choiceList,DMLoad)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then WritePrefToFile("Mate5",choiceList[number])
				end
			end
		end
	}   
	setmetatable( t, t )
	return t
end

function Mate6()
	local choiceList = GetAllCharacterNames()
	local t = {
		Name = "Mate6",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = choiceList,
		LoadSelections = function(self, list, pn)
			if getenv("Mate6") == nil then
				setenv("Mate6","None")
			end
			local DMLoad=getenv("Mate6")
			list[IndexKey(choiceList,DMLoad)]=true
		end,
		SaveSelections = function(self, list, pn)
			for number=0,999 do
				if list[number] then WritePrefToFile("Mate6",choiceList[number])
				end
			end
		end
	}   
	setmetatable( t, t )
	return t
end