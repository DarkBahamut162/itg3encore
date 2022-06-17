function DifficultyChangingAvailable()
	local pm = GAMESTATE:GetPlayMode()
	local so = GAMESTATE:GetSortOrder()
	return pm ~= 'PlayMode_Endless' and pm ~= 'PlayMode_Oni' and so ~= 'SortOrder_ModeMenu'
end

function SelectMenuAvailable()
	local pm = GAMESTATE:GetPlayMode()
	local so = GAMESTATE:GetSortOrder()
	return pm ~= 'PlayMode_Endless' and so ~= 'SortOrder_ModeMenu'
end

function ModeMenuAvailable()
	local courseMode = GAMESTATE:IsCourseMode()
	local sortOrder = GAMESTATE:GetSortOrder()
	return (not courseMode) and (sortOrder ~= 'SortOrder_ModeMenu')
end

function TextBannerAfterSet(self,param)
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")

	if Subtitle:GetText() == "" then 
		Title:y(0)
		Subtitle:visible(false)
	else
		Title:y(-5)
		Subtitle:visible(true)
		Subtitle:y(8)
	end
end

function CourseTextBannerAfterSet(self,param)
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")

	if Subtitle:GetText() == "" then 
		Title:y(0)
		Title:zoom(0.773)
		Subtitle:visible(false)
	else
		Title:y(-6)
		Title:zoom(0.6)
		Subtitle:visible(true)
		Subtitle:y(8)
	end
end

function GetScreenSelectMusicHelpText()
	local text = {}
	local ret = THEME:GetString("ScreenSelectMusic", "HelpTextNormal")

	if  SelectButtonAvailable() then
		-- Show the help text if it's available.  This should match ScreenSelectMusic::SelectMenuAvailable.
		if DifficultyChangingAvailable() or ModeMenuAvailable() then
			ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "SelectButtonAvailableHelpTextAppend" )
		end
	else
		if DifficultyChangingAvailable() then
			ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "DifficultyChangingAvailableHelpTextAppend" )
		end

		if ModeMenuAvailable() then
			ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "SortMenuAvailableHelpTextAppend" )
		end
	end

	if GAMESTATE:GetEnv("Workout") and IsHomeMode() then
		ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "WorkoutHelpTextAppend" )
	end

	return ret
end

--[ja] SMファイルで指定したパラメータの内容を読み取る
--[en] Read the contents of the parameters specified in the SM file.
function GetSMParameter(song,prm)
	local st=song:GetAllSteps()
	if #st<1 then
		return ""
	end
	local t
	t=st[1]:GetFilename()
	if not FILEMAN:DoesFileExist(t) then
		return ""
	end
	--[ja] 形式ではじく
	--[en] burst out in a formal manner
	local lt=string.lower(t)
	if not string.find(lt,".*%.sm") and not string.find(lt,".*%.ssc") then
		return ""
	end
	local f=RageFileUtil.CreateRageFile()
	f:Open(t,1)
	--[ja] 複数行を考慮していったん別変数に代入する
	--[en] Assign to a separate variable once to account for multiple lines
	local gl=""
	local pl=string.lower(prm)
	local l
	while true do
		if f then
			l=f:GetLine()
			local ll=string.lower(l)
			if string.find(ll,"#notes:.*") or f:AtEOF() then
				break
			--[ja] BOM考慮して .* を頭につける
			--[en] BOM considerations . * at the beginning
			elseif (string.find(ll,"^.*#"..pl..":.*") and (not string.find(ll,"^%/%/.*"))) or gl~="" then
				gl=gl..""..split("//",l)[1]
				if string.find(ll,".*;") then
					break
				end
			end
		end
	end
	local tmp={}
	if gl=="" then
		tmp={""}
	else
		tmp=split(":",gl)
		if tmp[2]==";" then
			tmp[1]=""
		else
			if #tmp>2 then
				tmp[1]=tmp[2]
				for i=3,#tmp do
					tmp[1]=tmp[1]..":"..split(";",tmp[i])[1]
				end
			else
				tmp[1]=split(";",tmp[2])[1]
			end
		end
	end
	f:Close()
	f:destroy()
	return tmp[1]
end

function HasLua(song,changes)
	local var = GetSMParameter(song,changes)
	local prm, cur
	local output = false
	if var ~= "" then
		prm = split(",",var)
		if prm ~= "" then
			for i=1,#prm do
				prm[i] = split("=",prm[i])
				if #prm[i] >= 2 then
					cur = prm[i][2]
					if cur ~= "" then
						if string.find(cur,".lua",0,true) then 
							output = true
						elseif string.find(cur,".",0,true) then else
							if string.find(cur,"-nosongbg-",0,true) or string.find(cur,"-random-",0,true)
								or string.find(cur,"songbackground",0,true) or cur == "" then else
								output = true
							end
						end
					end
				end
			end
		end
	end
	return output
end

function HasImage(song,changes)
	local var = GetSMParameter(song,changes)
	local prm, cur
	local output = false
	if var ~= "" then
		prm = split(",",var)
		if prm ~= "" then
			for i=1,#prm do
				prm[i] = split("=",prm[i])
				if #prm[i] >= 2 then
					cur = prm[i][2]
					if cur ~= "" then
						if string.find(cur,".jpg",0,true) or string.find(cur,".jpeg",0,true) or
							string.find(cur,".gif",0,true) or string.find(cur,".png",0,true) or
							string.find(cur,".bmp",0,true) then
							output = true
						end
					end
				end
			end
		end
	end
	return output
end

function HasVideo(song,changes)
	local var = GetSMParameter(song,changes)
	local prm, cur
	local output = false
	if var ~= "" then
		prm = split(",",var)
		if prm ~= "" then
			for i=1,#prm do
				prm[i] = split("=",prm[i])
				if #prm[i] >= 2 then
					cur = prm[i][2]
					if cur ~= "" then
						if string.find(cur,".ogv",0,true) or string.find(cur,".avi",0,true) or
							string.find(cur,".mov",0,true) or string.find(cur,".mpg",0,true) or
							string.find(cur,".mpeg",0,true) or string.find(cur,".wmv",0,true) or
							string.find(cur,".flv",0,true) or string.find(cur,".mp4",0,true) then
							output = true
						end
					end
				end
			end
		end
	end
	return output
end

function NeedsBPMfix(song)
	local var = GetSMParameter(song,"BPMS")
	local prm, cur
	local output = false
	if var ~= "" then
		prm = split(",",var)
		if prm ~= "" then
			for i=1,#prm do
				prm[i] = split("=",prm[i])
				if #prm[i] >= 2 then
					cur = prm[i][2]
					if cur ~= "" then
						if tonumber(cur) >= 109713 then
							output = true
						end
					end
				end
			end
		end
	end
	return output
end

--Extreme BPMs to warp desync check
function NeedsBPMfixCheck()
	local song = GAMESTATE:GetCurrentSong()
	return NeedsBPMfix(song)
end

--False LASTSECONDHINT fix check
function NeedsSecsFixCheck()
	local song = GAMESTATE:GetCurrentSong()
	local totalsecond = song:MusicLengthSeconds()
	local lastsecond = song:GetLastSecond()
	local difference = totalsecond - lastsecond
	return {totalsecond, lastsecond, difference}
end

function HasLuaCheck()
	local song = GAMESTATE:GetCurrentSong();
	return HasLua(song,"bgchanges") or HasLua(song,"fgchanges")
end

function HasVideoCheck()
	local song = GAMESTATE:GetCurrentSong();
	return HasVideo(song,"bgchanges") or HasVideo(song,"fgchanges")
end

function HasImageCheck()
	local song = GAMESTATE:GetCurrentSong();
	return HasImage(song,"bgchanges") or HasImage(song,"fgchanges")
end

function IsCourseSecret()
	local isSecret = false

	if GAMESTATE:IsCourseMode() then
		for i=1,#GAMESTATE:GetCurrentCourse():GetCourseEntries() do
			if GAMESTATE:GetCurrentCourse():GetCourseEntry(i-1):IsSecret() then
				isSecret = true
			end
		end
	end

	return isSecret
end

local allowednotes = {
	["TapNoteType_Tap"] = true,
	["TapNoteType_Lift"] = true,
	-- Support the heads of the subtypes.
	["TapNoteSubType_Hold"] = true,
	["TapNoteSubType_Roll"] = true,
}

function getStats(Steps)
    local chartint = 1
	local currentBeat = 0;
	local currentNotes = 0;
	local noteCounter = {0,0,0,0};
	local lastRegisteredBeat = 0;
	local hash = 0;

    if Steps then
        for k,v in pairs( GAMESTATE:GetCurrentSong():GetAllSteps() ) do
            if v == Steps then
				chartint = k
				hash = Steps:GetHash()
				break
			end
        end
		if hash > 0 then
			if LoadModule("Config.Exists.lua")(hash.."_","Cache/Steps/"..hash) then
				return split("_",LoadModule("Config.Load.lua")(hash.."_","Cache/Steps/"..hash))
			else
				for k,v in pairs( GAMESTATE:GetCurrentSong():GetNoteData(chartint) ) do
					if currentBeat < v[1] then
						lastRegisteredBeat = currentBeat
						currentBeat = v[1]
						if currentNotes ~= 0 then 
							noteCounter[currentNotes] = noteCounter[currentNotes] + 1
						end
						currentNotes = 0
					end
					if allowednotes[ v[3] ] then
						currentNotes = currentNotes + 1
					end
				end
				if lastRegisteredBeat < currentBeat then
					if currentNotes ~= 0 then
						noteCounter[currentNotes] = noteCounter[currentNotes] + 1
					end
				end
				LoadModule("Config.Save.lua")(hash.."_",table.concat(noteCounter, "_"),"Cache/Steps/"..hash)
			end
		end
    end
    return {noteCounter[1],noteCounter[2],noteCounter[3],noteCounter[4]}
end