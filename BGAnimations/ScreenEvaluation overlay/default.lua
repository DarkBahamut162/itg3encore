local t = Def.ActorFrame{}

if ShowStandardDecoration("StyleIcon") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StyleIcon"))() .. {
		InitCommand=function(self)
			self:name("StyleIcon")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end
if ShowStandardDecoration("StageDisplay") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StageDisplay"))() .. {
		InitCommand=function(self)
			self:name("StageDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

local shiftHeld = { PLAYER_1 = false, PLAYER_2 = false }
local submitted = { [PLAYER_1] = false, [PLAYER_2] = false }
local message = { [PLAYER_1] = nil, [PLAYER_2] = nil }
local leaderboard = { [PLAYER_1] = getenv("SetScoreFA"..pname(PLAYER_1)) and 2 or 1, [PLAYER_2] = getenv("SetScoreFA"..pname(PLAYER_2)) and 2 or 1 }
--local additional = { [PLAYER_1] = nil, [PLAYER_2] = nil }
local KEY = { [PLAYER_1] = nil, [PLAYER_2] = nil }
--local GSH = { [PLAYER_1] = nil, [PLAYER_2] = nil }
--[[
if ThemePrefs.Get("EnableGrooveStats") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
		if not GAMESTATE:IsCourseMode() then
			if ThemePrefs.Get("EnableGrooveStats") then
				GSH[pn] = LoadFromCache(SongOrCourse,StepsOrTrail,"GrooveStatsHash")
			end
		end
	end
end
]]--
local InputHandler = function(event)
	--if ThemePrefs.Get("EnableGrooveStats") or isOutFoxOnline() then
	if isOutFoxOnline() then
		if string.find(event.DeviceInput.button,"shift") then
			local pn = string.find(event.DeviceInput.button,"left") and PLAYER_1 or PLAYER_2
			if GAMESTATE:IsHumanPlayer(pn) and ((GS and GS.IsConnected) or isOutFoxOnline()) then
				if event.type == "InputEventType_FirstPress" then
					if isOutFoxOnline() or (GS and GS[pn] and GS[pn].ApiKey ~= "") then
						if not shiftHeld[pn] then MESSAGEMAN:Broadcast("OnlineOpened"..pname(pn)) end
						shiftHeld[pn] = true
					else
						SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
					end
				elseif event.type == "InputEventType_Release" then
					if shiftHeld[pn] then MESSAGEMAN:Broadcast("OnlineClosed"..pname(pn)) end
					shiftHeld[pn] = false
				end
			end
		end
		if string.find(event.DeviceInput.button,"ctrl") then
			local pn = string.find(event.DeviceInput.button,"left") and PLAYER_1 or PLAYER_2
			if GAMESTATE:IsHumanPlayer(pn) and ((GS and GS.IsConnected) or isOutFoxOnline()) and shiftHeld[pn] then
				if event.type == "InputEventType_FirstPress" then
					if isOutFoxOnline() then
						--leaderboard[pn] = leaderboard[pn] < 2 and leaderboard[pn] + 1 or 1
					else
						leaderboard[pn] = leaderboard[pn] < 4 and leaderboard[pn] + 1 or 1
					end
					MESSAGEMAN:Broadcast("OnlineOpened"..pname(pn))
				end
			end
		end
	end
end
--[[
function CreateCommentString(player)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	local comment = ""

	local rate = GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate()
	if rate ~= 1 then comment = addToOutput(comment,("%gx Rate"):format(rate),", ") end

	local suffixes = {"w", "e", "g", "d", "wo", "m"}
	for i=2, 6 do
		local tns = i == 6 and "TapNoteScore_Miss" or "TapNoteScore_W"..i
		local number = pss:GetTapNoteScores(tns)
		if number ~= 0 then comment = addToOutput(comment,number..suffixes[i],", ") end
	end

	local timingWindowOption = "No "
	local tWOadd = ""

	local playeroptions = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
	local windows = {true,true,true,true,true}
	local windows_Short = {"Fan","Exc","Gre","Dec","WO"}
	local disabledWindows = playeroptions:GetDisabledTimingWindows()
	for w in ivalues(disabledWindows) do windows[tonumber(ToEnumShortString(w):sub(-1))] = false end
	for w,window in ipairs(windows) do
		if not window then tWOadd = addToOutput(tWOadd,windows_Short[w],"/") end
	end

	timingWindowOption = timingWindowOption..tWOadd

	if string.len(timingWindowOption) > 3 then comment = addToOutput(comment,timingWindowOption,", ") end

	local cmod = playeroptions:CMod()
	if cmod ~= nil then comment = addToOutput(comment,"C"..tostring(cmod),", ") end

	return comment
end

local function AutoSubmitRequestProcessor_SM(res)
	local hasRpg = false
	local showRpg = false
	local rpgname
	
	local shownotif = {PLAYER_1 = false, PLAYER_2 = false}
	local wrplr = 0
	
	if (res ~= nil) and res["status"] == "success" then
		local data = res["data"]

		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local playerStr = "player"..pn:sub(-1)

			if data and data[playerStr] then
				if GSH[pn] == data[playerStr]["chartHash"] then
					-- show notification based on result
					if data[playerStr]["result"] == "score-added" or data[playerStr]["result"] == "improved"
					or data[playerStr]["result"] == "score-not-improved"
					or data[playerStr]["result"] == "score-improved" then
						shownotif[pn] = true
						lua.ReportScriptError("GROOVESTATS RECORD NOT YET SUPPORTED")
						-- set qr panes to "already submitted"
					elseif not data[playerStr]["isRanked"] then
						-- set qr panes to "not ranked"
					end

					if data[playerStr]["rpg"] or data[playerStr]["itl"] then
						--additional[pn] = {}
						if data[playerStr]["rpg"] then
							lua.ReportScriptError("RPG NOT YET SUPPORTED")
						end

						if data[playerStr]["itl"] then
							lua.ReportScriptError("RPG NOT YET SUPPORTED")
						end
					else
						--additional[pn] = nil
					end
				end
			end
		end

		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			if GS[pn].ApiKey ~= "" then
				for pn in ivalues(GAMESTATE:GetHumanPlayers()) do MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submit Successful!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for Leaderboard\nPress "..(pn == PLAYER_1 and "Left" or "Right").." CTRL to switch Leaderboards"}) end
			end
		end
	else
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			if GS[pn].ApiKey ~= "" then
				for pn in ivalues(GAMESTATE:GetHumanPlayers()) do MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submit Failed!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for QR Code"}) end
			end
		end
	end
end

local function AutoSubmitRequestProcessor(res)
	if res.error or res.statusCode ~= 200 then
		local error = res.error and ToEnumShortString(res.error) or nil
		if error == "Timeout" then
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				if GS[pn].ApiKey ~= "" then
					for pn in ivalues(GAMESTATE:GetHumanPlayers()) do MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Time Out!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for QR Code"}) end
				end
			end
		elseif error or (res.statusCode ~= nil and res.statusCode ~= 200) then
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				if GS[pn].ApiKey ~= "" then
					for pn in ivalues(GAMESTATE:GetHumanPlayers()) do MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submit Failed!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for QR Code"}) end
				end
			end
		end
		return
	end

	local data = JsonDecode(res.body)

	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local playerStr = "player"..pn:sub(-1)

		if data and data[playerStr] then
			if GSH[pn] == data[playerStr]["chartHash"] then
				local personalRank = nil
				local showExScore = getenv("SetScoreFA"..pname(pn)) and data[playerStr]["exLeaderboard"]
				local hash = data[playerStr]["chartHash"]

				if data[playerStr]["key"] then
					GSCache[hash] = data[playerStr]["gsLeaderboard"]
					GSRanking[hash] = data[playerStr]["isRanked"]
					GSCaching[hash] = false
				end
				if data[playerStr]["exLeaderboard"] then EXCache[hash] = data[playerStr]["exLeaderboard"] end
				if data[playerStr]["rpg"] and data[playerStr]["rpg"]["rpgLeaderboard"] then RPGCache[hash] = data[playerStr]["rpg"]["rpgLeaderboard"] end
				if data[playerStr]["itl"] and data[playerStr]["itl"]["itlLeaderboard"] then ITLCache[hash] = data[playerStr]["itl"]["itlLeaderboard"] end

				-- Only display the overlay on the sides that are actually joined.
				if data[playerStr]["rpg"] or data[playerStr]["itl"] then
					if data[playerStr]["rpg"] then
						lua.ReportScriptError("RPG NOT YET SUPPORTED")
					end

					if data[playerStr]["itl"] then
						lua.ReportScriptError("RPG NOT YET SUPPORTED")
					end
				end

				if data[playerStr]["result"] == "score-added" or data[playerStr]["result"] == "improved" then
					lua.ReportScriptError("GROOVESTATS RECORD NOT YET SUPPORTED")
					--if personalRank == 1 then
					--	local worldRecordText = THEME:GetString("GrooveStats", "WorldRecord")
					--	if showExScore then worldRecordText = worldRecordText .. " (EX)" end
					--	--recordText:settext(worldRecordText)
					--else
					--	--recordText:settext(THEME:GetString("GrooveStats", "PersonalBest"))
					--end
				end
			end
		end

		if res["status"] == "success" then
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				if GS[pn].ApiKey ~= "" then
					for pn in ivalues(GAMESTATE:GetHumanPlayers()) do MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submit Successful!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for Leaderboard\nPress "..(pn == PLAYER_1 and "Left" or "Right").." CTRL to switch Leaderboards"}) end
				end
			end
		end
	end
end

local AutoSubmit = isITGmania() and RequestResponseActor()..{
	OnCommand=function(self)
		if not GS.IsConnected then return end
		if not IsServiceAllowed(GS.AutoSubmit) then
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Auto-Submitting Disabled!"})
			end
			return
		end
		local sendRequest = false
		local headers = {}
		local query = { maxLeaderboardResults=10 }
		local body = {}

		local rate = tonumber(string.format("%.0f", GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate() * 100))
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local _, valid = ValidForGrooveStats(pn,true)
			local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)

			if valid and not stats:GetFailed() and GS[pn].IsPadPlayer then
				local percentDP = stats:GetPercentDancePoints()
				local score = tonumber(("%.0f"):format(percentDP * 10000))
				local profileName = ""

				if PROFILEMAN:IsPersistentProfile(pn) and PROFILEMAN:GetProfile(pn) then profileName = PROFILEMAN:GetProfile(pn):GetDisplayName() end
				if GS[pn].ApiKey ~= "" and GSH[pn] ~= "" then
					local faplus = getenv("SetScoreFA"..pname(pn))
					local po = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")

					query["chartHashP"..pn:sub(-1)] = GSH[pn]
					headers["x-api-key-player-"..pn:sub(-1)] = GS[pn].ApiKey
					body["player"..pn:sub(-1)] = {
						rate=rate,
						score=score,
						judgmentCounts=GetJudgmentCounts(pn),
						rescoreCounts={
							["fantasticPlus"] = 0,
							["fantastic"] = 0,
							["excellent"] = 0,
							["great"] = 0,
							["decent"] = 0,
							["wayOff"] = 0
						},
						usedCmod=(GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):CMod() ~= nil),
						comment=CreateCommentString(pn),
					}
					sendRequest = true
					MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submitting..."})
				end
			else
				MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "GrooveStats Not Valid!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for reason"})
			end
		end

		if sendRequest then
			self:playcommand("MakeGrooveStatsRequest", {
				endpoint="?action=scoreSubmit&"..NETWORK:EncodeQueryParameters(query),
				method="POST",
				headers=headers,
				body=JsonEncode(body),
				timeout=30,
				callback=AutoSubmitRequestProcessor
			})
		end
	end
} or RequestResponseActor_SM("AutoSubmit", 10)..{
	OnCommand=function(self)
		if not GS.IsConnected then return end
		if not GS.Launcher then
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Auto-Submitting Disabled!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for QR Code"})
			end
			return
		elseif not IsServiceAllowed(GS.AutoSubmit) then
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Auto-Submitting Disabled!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for QR Code"})
			end
			return
		end
		local sendRequest = false
		local data = {
			action="groovestats/score-submit",
			maxLeaderboardResults=10,
		}

		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local _, valid = ValidForGrooveStats(pn,true)
			local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)

			if valid and not stats:GetFailed() and GS[pn].IsPadPlayer then
				local po = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
				local usedCmod = (GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):CMod() ~= nil)
				local judgmentCounts = GetJudgmentCounts(pn)
				local percentDP = stats:GetPercentDancePoints()
				local score = tonumber(("%.0f"):format(percentDP * 10000))
				local profileName = ""
				if PROFILEMAN:IsPersistentProfile(pn) and PROFILEMAN:GetProfile(pn) then profileName = PROFILEMAN:GetProfile(pn):GetDisplayName() end

				if GS[pn].ApiKey ~= "" and GSH[pn] ~= "" then
					data["player"..i] = {
						chartHash=GSH[pn],
						apiKey=GS[pn].ApiKey,
						rate=rate,
						score=score,
						comment=CreateCommentString(pn),
						profileName=profileName,
						usedCmod=usedCmod,
						judgmentCounts=judgmentCounts
					}
					sendRequest = true
					MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submitting..."})
				end
			else
				MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "GrooveStats Not Valid!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for reason"})
			end
		end

		if sendRequest then
			MESSAGEMAN:Broadcast("AutoSubmit", {
				data=data,
				callback=AutoSubmitRequestProcessor_SM
			})
		end
	end
}
]]

local ONLINE = Def.ActorFrame{}

if isOutFoxOnline() then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		ONLINE = Def.ActorFrame{
			Name="Online"..pname(pn),
			OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end,
			OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
			Def.ActorFrame{
				Name="Main"..pname(pn),
				InitCommand=function(self) self:x(SCREEN_CENTER_X-210*WideScreenDiff()):y(SCREEN_CENTER_Y-66*WideScreenDiff()):zoom(2/3*WideScreenDiff()):addx(-SCREEN_CENTER_X) end,
				["OnlineOpened"..pname(pn).."MessageCommand"]=function(self) self:stoptweening():stopeffect():decelerate(0.1):x(210*WideScreenDiff()) end,
				["OnlineClosed"..pname(pn).."MessageCommand"]=function(self) self:accelerate(0.1):addx(-SCREEN_CENTER_X) end,
				Def.ActorFrame{
					Name="Unsubmitted",
					Condition=GAMESTATE:IsHumanPlayer(pn),
					Def.Sprite { Texture="main" },
					--[[
					Def.ActorFrame{
						Name="QR",
						["OnlineOpened"..pname(pn).."MessageCommand"]=function(self) self:visible(not submitted[pn]) end,
						LoadActor( THEME:GetPathB("ScreenEvaluation", "overlay/QRCode") , {LoadActor(THEME:GetPathB("ScreenEvaluation", "overlay/GrooveStatsURL"), pn), 168, pn} )..{ InitCommand=function(self) self:xy(-84,-84) end },
						LoadActor("x")..{
							Name="X",
							InitCommand=function(self)
								local _, allChecksValid = ValidForGrooveStats(pn,true)
								self:visible(not allChecksValid)
							end
						}
					}
					]]
				},
				Def.BitmapText {
					File="Common Normal",
					Name="OnlineLeaderboard",
					InitCommand=function(self) self:zoom(0.75):vertspacing(-1):maxwidth(325):maxheight(325) end,
					["Submit"..pname(pn).."MessageCommand"]=function(self,param) self:visible(false) end,
					["OnlineOpened"..pname(pn).."MessageCommand"]=function(self) if submitted[pn] then self:playcommand("On") end self:visible(submitted[pn]) end,
					OnCommand=function(self)
						local output = ""
						local coloring = {}
						if ThemePrefs.Get("EnableGrooveStats") or isOutFoxOnline() then
							local scores

							if isOutFoxOnline() then
								local key
								if KEY[pn] then
									key = KEY[pn]
								else
									local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
									if not GAMESTATE:IsCourseMode() then key = StepsOrTrail:GetChartKey() end
								end
								if getenv("SetScoreFA"..pname(pn)) then scores = EXCache[key] else scores = OFCache[key] end
							else
								local key = GSH[pn]
								if leaderboard[pn] == 1 then
									scores = GSCache[key]
								elseif leaderboard[pn] == 2 then
									scores = EXCache[key]
								elseif leaderboard[pn] == 3 then
									scores = RPGCache[key]
								elseif leaderboard[pn] == 4 then
									scores = ITLCache[key]
								end
							end

							if scores then
								output = ""
								for i=1,#scores do
									local begin = string.len(''..output)
									output = addToOutput(output,"#"..scores[i]["rank"].." | "..string.format("%03.2f%%",scores[i]["score"]/100).." | "..GetMachineTag(scores[i]).." | x"..string.format("%1.1f",scores[i]["rate"]).." | "..scores[i]["date"],"\n")
									update = scores[i]["score"]/100
									if scores[i]["isFail"] or scores[i]["isRival"] or scores[i]["isSelf"] then
										coloring[#coloring+1] = {FIRST = begin, LAST = string.len(''..output)-begin, COLOR = scores[i]["isFail"] and color("#FF0000") or scores[i]["isRival"] and color("#AA00AA") or scores[i]["isSelf"] and color("#00FF00") or color("#FFFFFF")}
									end
								end
								if output == "" then output = "NO SCORES" end
							else
								if isOutFoxOnline() then
									--leaderboard[pn] = leaderboard[pn] < 2 and leaderboard[pn] + 1 or 1
								else
									leaderboard[pn] = leaderboard[pn] < 4 and leaderboard[pn] + 1 or 1
									self:queuecommand("On")
									self:GetParent():GetChild("Leaderboard"):GetChild("Text"):queuecommand("On")
								end
							end
						end
						if false then
							local splits = split("\n",output)
							for i=#splits,9 do
								output = addToOutput(output,"#"..(i+1).." | ??.??% | ???? | x?.? | ????-??-?? ??:??:??","\n")
							end
						end
						self:settext(output):xy(-325*0.375,-325*0.375):valign(0):halign(0):ClearAttributes()
						for i,pair in pairs(coloring) do
							self:AddAttribute(pair.FIRST, {
								Length = math.max(pair.LAST, 0),
								Diffuse = pair.COLOR,
							})
						end
					end
				},
				Def.ActorFrame{
					Name="Leaderboard",
					InitCommand=function(self) self:addy(170) end,
					["Submit"..pname(pn).."MessageCommand"]=function(self,param)
						if not shiftHeld[pn] then
							self:stoptweening():decelerate(0.1):x((SCREEN_CENTER_X*2-210*WideScreenDiff())):sleep(3):accelerate(0.1):x(0)
							self:GetChild("Text"):settext(param.Message and param.Message or "")
						end
					end,
					["OnlineOpened"..pname(pn).."MessageCommand"]=function(self) self:stoptweening():stopeffect():decelerate(0.1):x(0) end,
					Def.Sprite { Texture="explanation" },
					Def.BitmapText {
						File="Common Normal",
						Name="Text",
						InitCommand=function(self) self:zoom(0.5):vertspacing(-1):maxwidth(500):maxheight(100) end,
						["OnlineOpened"..pname(pn).."MessageCommand"]=function(self) self:playcommand("On") end,
						OnCommand=function(self)
							local output = ""
							if ThemePrefs.Get("EnableGrooveStats") or isOutFoxOnline() then
								if submitted[pn] then
									if isOutFoxOnline() then
										if KEY[pn] then
											local key = KEY[pn]
											local text = leaderboard[pn] == 1 and "OutFox Online (ITG)" or "OutFox Online (FA+)"
											if message[pn] == "" then message[pn] = "Score Submitted" end
											if message[pn] then text = text.."\n"..message[pn] end
											self:settext(text)
										end
									else
										local key = GSH[pn]
										if leaderboard[pn] == 1 and GSCache[key] then
											self:settext("GrooveStats")
										elseif leaderboard[pn] == 2 and EXCache[key] then
											self:settext("GrooveStats EX")
										elseif leaderboard[pn] == 3 and RPGCache[key] then
											self:settext("Stamina RPG")
										elseif leaderboard[pn] == 4 and ITLCache[key] then
											self:settext("International Timing League")
										end
									end
								else
									output = ""
									if isOutFoxOnline() then
										self:settext(message[pn] or ""):visible(true)
										--if output == "" then self:GetParent():GetParent():GetChild("Unsubmitted"):GetChild("QR"):visible(false) end
									else
										--[[
										local valid, allChecksValid = ValidForGrooveStats(pn,true)
										if not allChecksValid then
											for i,error in pairs(valid) do
												if not error then
													output = addToOutput(output,THEME:GetString("ScreenEvaluation","QRInvalidScore"..i),"\n")
												end
											end
										end
										if output ~= "" then self:settext("QR Disabled!\n"..output):visible(true) end
										if output == "" then self:GetParent():GetParent():GetChild("Unsubmitted"):GetChild("QR"):visible(false) end
										]]
									end
								end
							end
						end
					}
				},
				MessageOFNetworkResponseMessageCommand=function(self,params)
					if params.PlayerNumber == pn then
						if params.Name == "ScoreSave" then
							submitted[pn] = params and params.Status == "success" or false
							message[pn] = params.Message

							local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
							local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
							if not GAMESTATE:IsCourseMode() then
								local key = StepsOrTrail:GetChartKey()
								KEY[pn] = key
								if submitted[pn] then
									if OFCaching[key] or OFCache[key] then OFCache[key] = nil end
									if EXCaching[key] or EXCache[key] then EXCache[key] = nil end
								end
								if not OFCache[key] or (getenv("SetScoreFA"..pname(pn)) and not EXCache[key]) then
									NETMAN:FuncHighScoresForChart{
										ChartKey = key,
										Timing = getenv("SetScoreFA"..pname(pn)) and "FAplus" or "ITG",
										Rate = GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate(),
										PlayerNumber = pn,
										OnResponse = function(data)
											local DATA = data.response.scores
											local newDATA = {}
											for i,score in ipairs(data.response.scores) do
												if i > 10 then break end
												newDATA[i] = {}
												newDATA[i]["rank"] = i
												newDATA[i]["score"] = score.score*10000
												newDATA[i]["name"] = score.username
												newDATA[i]["rate"] = score.rate
												newDATA[i]["date"] = score.date:gsub("T"," ")
											end
											if getenv("SetScoreFA"..pname(pn)) then
												EXCache[key]=newDATA
												EXCaching[key] = false
											else
												OFCache[key]=newDATA
												OFCaching[key] = false
											end
											for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
												MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submit Successful!\nHold "..(pn == PLAYER_1 and "Left" or "Right").." Shift for Leaderboard"})
											end
											submitted[pn] = true
										end,
										OnFail = function(data)
											MESSAGEMAN:Broadcast("Submit"..pname(pn),{Message = "Submit Failed!"})
											--lua.ReportScriptError(rin_inspect(data))
										end
									}
								else
									submitted[pn] = true
								end
							end
						end
					end
				end
			}
		}
	end
end

--if ThemePrefs.Get("EnableGrooveStats") or isOutFoxOnline() then
if isOutFoxOnline() then
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("","_coins"))(),
		t,

		ONLINE,
		--AutoSubmit
	}
else
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("","_coins"))(),
		t
	}
end