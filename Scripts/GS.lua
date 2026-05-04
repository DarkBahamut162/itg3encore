GS = {}
GSCaching = {}
OFCaching = {}
EXCaching = {}
GSRanking = {}
OFCache = {}
GSCache = {}
EXCache = {}
RPGCache = {}
ITLCache = {}

function RequestResponseActor_SM(name, timeout)
    local timeout = clamp(timeout, 1.0, 59.0)
    local path_prefix = "/Save/GrooveStats/"

    return Def.Actor{
        InitCommand=function(self)
            self.request_id = nil
            self.request_time = nil
            self.callback = nil
			self.tocache = {}
        end,
        WaitCommand=function(self)
            local Reset = function(self)
                self.request_id = nil
                self.request_time = nil
                self.callback = nil
				self.tocache = {}
            end
            if self.request_id ~= nil then
                local now = GetTimeSinceStart()
                local f = RageFileUtil.CreateRageFile()
                if f:Open(path_prefix.."responses/"..self.request_id..".json", 1) then
                    local json_str = f:Read()
					local data = {}
					if #json_str ~= 0 then
						data = json.decode(json_str)
					end
                    self.callback(data)
                    f:Close()
					if self.tocache ~= {} then
						for cache in ivalues(self.tocache) do
							GSCaching[cache] = false
						end
					end
                    Reset(self)
                elseif now - self.request_time > timeout then
                    self.callback(nil)
					GS.IsConnected = false
					if self.tocache ~= {} then
						for cache in ivalues(self.tocache) do
							GSCaching[cache] = false
						end
					end
                    Reset(self)
                end
                f:destroy()
            end
            if self.request_id ~= nil then
                self:sleep(0.5):queuecommand('Wait')
            end
        end,
        [name .. "MessageCommand"]=function(self, params)
            if not GS.Launcher and params.data["action"] ~= "ping" then return end
            local id = nil
            if params.data["action"] == "ping" then
                id = "ping"
            else
                id = CRYPTMAN:GenerateRandomUUID()
				if self.tocache ~= {} then
					for cache in ivalues(self.tocache) do
						GSCaching[cache] = false
					end
				end
				self.tocache = params.tocache or {}
            end

            local f = RageFileUtil:CreateRageFile()
            if f:Open(path_prefix .. "requests/".. id .. ".json", 2) then
                f:Write(json.encode(params.data))
                f:Close()

				self:stoptweening()
                self.request_id = id
                self.request_time = GetTimeSinceStart()
                self.callback = params.callback
                self:sleep(0.5):queuecommand('Wait')
            end
            f:destroy()
        end
    }
end

function RequestResponseActor()
	local url_prefix = "https://apiservice.groovestats.com/api/"

	return Def.ActorFrame{
		InitCommand=function(self)
			self.request_time = -1
			self.timeout = -1
			self.request_handler = nil
			self.leaving_screen = false
			self.tocache = {}
		end,
		CancelCommand=function(self)
			self.leaving_screen = true
			if self.request_handler then
				self.request_handler:Cancel()
				self.request_handler = nil
				if self.tocache ~= {} then
					for cache in ivalues(self.tocache) do
						GSCaching[cache] = false
					end
				end
			end
		end,
		OffCommand=function(self)
			self.leaving_screen = true
			if self.request_handler then
				self.request_handler:Cancel()
				self.request_handler = nil
				if self.tocache ~= {} then
					for cache in ivalues(self.tocache) do
						GSCaching[cache] = false
					end
				end
			end
		end,
		MakeGrooveStatsRequestCommand=function(self, params)
			self:stoptweening()
			if not params then
				Warn("No params specified for MakeGrooveStatsRequestCommand.")
				return
			end

			if self.request_handler then
				self.request_handler:Cancel()
				self.request_handler = nil
			end

			local timeout = params.timeout or 60
			local endpoint = params.endpoint or ""
			local method = params.method
			local body = params.body
			local headers = params.headers
			local tocache = params.tocache

			self.timeout = timeout
			if self.tocache ~= {} then
				for cache in ivalues(self.tocache) do
					GSCaching[cache] = false
				end
			end
			self.tocache = tocache

			self.request_handler = NETWORK:HttpRequest{
				url=url_prefix..endpoint,
				method=method,
				body=body,
				headers=headers,
				connectTimeout=timeout,
				transferTimeout=timeout,
				onResponse=function(response)
					self.request_handler = nil
					if response.statusCode then
						local body = nil
						local code = response.statusCode
						if code == 200 then
							body = JsonDecode(response.body)
						end
						if (code >= 400 and code < 499 and code ~= 429) or (code == 200 and body and body.error and #body.error) then
							GS.IsConnected = false
						end
					end

					if self.leaving_screen then return end
					
					if params.callback then
						if not response.error or ToEnumShortString(response.error) ~= "Cancelled" then
							params.callback(response)
						end
					end
				end,
			}
			self.request_time = GetTimeSinceStart()
			self:queuecommand("GrooveStatsRequestLoop")
		end,
		GrooveStatsRequestLoopCommand=function(self)
			local now = GetTimeSinceStart()
			local remaining_time = self.timeout - (now - self.request_time)
			if self.request_handler then
				self:sleep(0.5):queuecommand("GrooveStatsRequestLoop")
			end
		end
	}
end

function NewSessionRequestProcessor_SM(res)
	GS.IsConnected = false
	GS.GetScores = false
	GS.Leaderboard = false
	GS.AutoSubmit = false
	GS.Status = nil

	if res == nil then
		GS.Status = "Timed Out"
		MESSAGEMAN:Broadcast("GrooveStatsUpdate")
		return
	elseif res["status"] ~= "success" then
		local text = "Error"
		if res["status"] == "fail" then
			text = "Failed to Load"
		elseif res["status"] == "disabled" then
			text = "Disabled"
		end
		GS.Status = text
		MESSAGEMAN:Broadcast("GrooveStatsUpdate")
		return
	end

	local data = res["data"]
	if data == nil then
		GS.Status = "No Data"
		MESSAGEMAN:Broadcast("GrooveStatsUpdate")
		return
	end

	local services = data["servicesAllowed"]
	if services ~= nil then
		if services["playerScores"] ~= nil then if services["playerScores"] then GS.GetScores = true else GS.GetScores = false end end
		if services["playerLeaderboards"] ~= nil then if services["playerLeaderboards"] then GS.Leaderboard = true else GS.Leaderboard = false end end
		if services["scoreSubmit"] ~= nil then if services["scoreSubmit"] then GS.AutoSubmit = true else GS.AutoSubmit = false end end
	end
	if GS.GetScores or GS.Leaderboard or GS.AutoSubmit then GS.IsConnected = true end
	MESSAGEMAN:Broadcast("GrooveStatsUpdate")
end

function NewSessionRequestProcessor(res)
	GS.IsConnected = false
	GS.GetScores = false
	GS.Leaderboard = false
	GS.AutoSubmit = false
	GS.Status = nil

	if res.error or res.statusCode ~= 200 then
		local error = res.error and ToEnumShortString(res.error) or nil
		local text = "Error"
		if error == "Timeout" then
			text = "Timed Out"
		elseif error or (res.statusCode ~= nil and res.statusCode ~= 200) then
			if error == "Blocked" then
				text = "Access to GrooveStats Host Blocked"
			elseif error == "CannotConnect" then
				text = "Machine Offline"
			elseif error == "Timeout" then
				text = "Request Timed Out"
			else
				text = "Failed to Load"
			end
		end
		GS.Status = text
		MESSAGEMAN:Broadcast("GrooveStatsUpdate")
		return
	end

	local data = JsonDecode(res.body)
	if data == nil then
		GS.Status = "No Data"
		MESSAGEMAN:Broadcast("GrooveStatsUpdate")
		return
	end

	local services = data["servicesAllowed"]
	if services ~= nil then
		if services["playerScores"] ~= nil then if services["playerScores"] then GS.GetScores = true else GS.GetScores = false end end
		if services["playerLeaderboards"] ~= nil then if services["playerLeaderboards"] then GS.Leaderboard = true else GS.Leaderboard = false end end
		if services["scoreSubmit"] ~= nil then if services["scoreSubmit"] then GS.AutoSubmit = true else GS.AutoSubmit = false end end
	end

	if GS.GetScores or GS.Leaderboard or GS.AutoSubmit then GS.IsConnected = true end
	MESSAGEMAN:Broadcast("GrooveStatsUpdate")
end


local ProfileSlot = {
    [PLAYER_1] = "ProfileSlot_Player1",
    [PLAYER_2] = "ProfileSlot_Player2"
}

function LoadGrooveStatsIni(player)
	if not player then return end
	if not ProfileSlot[player] then return end
	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	if not dir or #dir == 0 then return end
	local path = dir .. "GrooveStats.ini"
    if not GS[player] then GS[player] = {} end

	if not FILEMAN:DoesFileExist(path) then
        GS[player].ApiKey = ""
        GS[player].Username = ""
        GS[player].IsPadPlayer = false
		IniFile.WriteFile(path, {
			["GrooveStats"]={
				["ApiKey"]="",
				["Username"]="",
				["IsPadPlayer"]=0,
			}
		})
	else
		local contents = IniFile.ReadFile(path)
		for k,v in pairs(contents["GrooveStats"]) do
			if k == "ApiKey" then
				if string.len(v) ~= 64 then
					GS[player].ApiKey = ""
				else
					GS[player].ApiKey = v
				end
			elseif k == "Username" then
				GS[player].Username = v
			elseif k == "IsPadPlayer" then
				if v == 1 then
					GS[player].IsPadPlayer = true
				else
					GS[player].IsPadPlayer = false
				end
			end
		end

		IniFile.WriteFile(path, {
			["GrooveStats"]={
				["ApiKey"]=GS[player].ApiKey,
				["Username"]=GS[player].Username,
				["IsPadPlayer"]=GS[player].IsPadPlayer and "1" or "0",
			}
		})
	end
end

function SaveGrooveStatsIni(player)
	if not player then return end
	if not ProfileSlot[player] then return end

	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	if not dir or #dir == 0 then return "" end

	local path = dir .. "GrooveStats.ini"

	IniFile.WriteFile(path, {
		["GrooveStats"]={
			["ApiKey"]=GS[player].ApiKey,
			["Username"]=GS[player].Username,
			["IsPadPlayer"]=GS[player].IsPadPlayer and "1" or "0",
		}
	})
end

function IsServiceAllowed(condition)
	return (condition and
		ThemePrefs.Get("EnableGrooveStats") and
		GS.IsConnected and
		(GAMESTATE:GetCurrentGame():GetName() == "dance" or GAMESTATE:GetCurrentGame():GetName() == "pump") and
		(GS[PLAYER_1].ApiKey ~= "" or GS[PLAYER_2].ApiKey ~= ""))
end

function ValidForGrooveStats(player,checkAUTO)
	local valid = {}

	valid[1] = IsGame("dance") or IsGame("pump")
	valid[2] = GAMESTATE:GetCurrentStyle():GetName() ~= "solo"
	valid[3] = not GAMESTATE:IsCourseMode()
	valid[4] = PREFSMAN:GetPreference("TimingWindowScale") <= 1
	valid[5] = PREFSMAN:GetPreference("LifeDifficultyScale") <= 1

	local ExpectedTWA = 0.0015
	local ExpectedWindows = {
		0.021500 + ExpectedTWA,  -- Fantastics
		0.043000 + ExpectedTWA,  -- Excellents
		0.102000 + ExpectedTWA,  -- Greats
		0.135000 + ExpectedTWA,  -- Decents
		0.180000 + ExpectedTWA,  -- Way Offs
		0.320000 + ExpectedTWA,  -- Holds
		0.070000 + ExpectedTWA,  -- Mines
		0.350000 + ExpectedTWA,  -- Rolls
	}
	local TimingWindows = { "W1", "W2", "W3", "W4", "W5", "Hold", "Mine", "Roll" }
	local ExpectedLife = {
         0.008,  -- Fantastics
		 0.008,  -- Excellents
		 0.004,  -- Greats
		 0.000,  -- Decents
		-0.050,  -- Way Offs
		-0.100,  -- Miss
		-0.080,  -- Let Go
		 0.008,  -- Held
		-0.050,  -- Hit Mine
	}
	local ExpectedScoreWeight = {
		 5,  -- Fantastics
		 4,  -- Excellents
		 2,  -- Greats
		 0,  -- Decents
		-6,  -- Way Offs
		-12,  -- Miss
		 0,  -- Let Go
		 5,  -- Held
		-6,  -- Hit Mine
	}
	local LifeWindows = { "W1", "W2", "W3", "W4", "W5", "Miss", "LetGo", "Held", "HitMine" }

	--Wrong Max/RegenComboAfterMiss Value
	-- TODO ETTERNA
	valid[6] = (PREFSMAN:GetPreference("RegenComboAfterMiss") == 5 and PREFSMAN:GetPreference("MaxRegenComboAfterMiss") == 10)

	local FloatEquals = function(a, b) return math.abs(a-b) < 0.0001 end

	--Wrong Lifebar Initial Value
	valid[7] = FloatEquals(THEME:GetMetric("LifeMeterBar", "InitialValue"), 0.5)
	--Wrong HarshHotLifePenalty
	-- TODO ETTERNA
	valid[8] = PREFSMAN:GetPreference("HarshHotLifePenalty")

	local TWA = isEtterna("0.55") and 0 or PREFSMAN:GetPreference("TimingWindowAdd")
	local check = false
    for i, window in ipairs(TimingWindows) do
		--Wrong TimingWindowSeconds
		check = FloatEquals(PREFSMAN:GetPreference("TimingWindowSeconds"..window) + TWA, ExpectedWindows[i])
        valid[9] = valid[9] ~= nil and (valid[9] and check) or check
    end

    for i, window in ipairs(LifeWindows) do
		--Wrong LifePercentChange
		check = FloatEquals(THEME:GetMetric("LifeMeterBar", "LifePercentChange"..window), ExpectedLife[i])
        valid[10] = valid[10] ~= nil and (valid[10] and check) or check
		--Wrong PercentScoreWeight
		check = THEME:GetMetric("ScoreKeeperNormal", "PercentScoreWeight"..window) == ExpectedScoreWeight[i]
        valid[11] = valid[11] ~= nil and (valid[10] and check) or check
    end

	local rate = GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate() * 100
	valid[12] = 100 <= rate and rate <= 300

	local po = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
	valid[13] = not ( po:Little()  or po:NoHolds() or po:NoStretch() or po:NoHands() or po:NoJumps() or po:NoFakes() or po:NoLifts() or po:NoQuads() or po:NoRolls() )
	valid[14] = not ( po:Wide() or po:Skippy() or po:Quick() or po:Echo() or po:BMRize() or po:Stomp() or po:Big() )

	local failType = isITGmania(20250313) and GAMESTATE:GetPlayerFailType(player) or po:FailSetting()
	valid[15] = (failType == "FailType_Immediate" or failType == "FailType_ImmediateContinue")
	valid[16] = not checkAUTO and true or getenv("EvalCombo"..pname(player))

	local minTNSToScoreNores = ToEnumShortString(isITGmania(20230618) and PREFSMAN:GetPreference("MinTNSToScoreNotes") or po:MinTNSToHideNotes())
    valid[17] = minTNSToScoreNores ~= "W1" and minTNSToScoreNores ~= "W2"

	local allChecksValid = true
	for _, passed_check in ipairs(valid) do
		if not passed_check then allChecksValid = false break end
	end

	return valid, allChecksValid
end

function GetMachineTag(entry)
	if not entry then return end
	if entry["machineTag"] then
		return entry["machineTag"]:sub(1,4):upper()
	end
	if entry["name"] then
		return entry["name"]:sub(1,4):upper()
	end

	return "????"
end

function GetJudgmentCounts(player)
	local faplus = getenv("SetScoreFA"..pname(player))
	local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	local po = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)

	return {
		["fantasticPlus"] = faplus and (getenv("W0"..pname(player)) or 0) or 0,
		["fantastic"] = faplus and (getenv("W1"..pname(player)) or 0) or stats:GetTapNoteScores("TapNoteScore_W1"),
		["excellent"] = stats:GetTapNoteScores("TapNoteScore_W2"),
		["great"] = stats:GetTapNoteScores("TapNoteScore_W3"),
		["decent"] = stats:GetTapNoteScores("TapNoteScore_W4"),
		["wayOff"] = stats:GetTapNoteScores("TapNoteScore_W5"),
		["miss"] = stats:GetTapNoteScores("TapNoteScore_Miss"),
		["totalSteps"] = StepsOrTrail:GetRadarValues(player):GetValue( "RadarCategory_TapsAndHolds" ),
		["holdsHeld"] = stats:GetRadarActual():GetValue("RadarCategory_Holds"),
		["totalHolds"] = StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_Holds" ),
		["minesHit"] = po:NoMines() and 0 or StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_Mines")-stats:GetRadarActual():GetValue("RadarCategory_Mines"),
		["totalMines"] = po:NoMines() and 0 or StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_Mines"),
		["rollsHeld"] = stats:GetRadarActual():GetValue("RadarCategory_Rolls"),
		["totalRolls"] = StepsOrTrail:GetRadarValues(player):GetValue( "RadarCategory_Rolls")
	}
end

function CalculateExScore(player)
	local ex_counts = GetJudgmentCounts(player)
	local ExWeights = {
		["fantasticPlus"]	= 3.5,
		["fantastic"]		= 3,
		["excellent"]		= 2,
		["great"]			= 1,
		["decent"]			= 0,
		["wayOff"]			= 0,
		["miss"]			= 0,
		["LetGo"]			= 0,
		["holdsHeld"]		= 1,
		["rollsHeld"]		= 1,
		["minesHit"]		= -1
	}
	local total_possible = ex_counts["totalSteps"] * ExWeights["fantasticPlus"] + ex_counts["totalHolds"] * ExWeights["holdsHeld"] + ex_counts["totalRolls"] * ExWeights["rollsHeld"]
	local total_points = 0

	local po = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
	if po:NoMines() then
		local totalMines = ex_counts["totalMines"]
		total_points = total_points + totalMines * ExWeights["minesHit"]
	end

	local keys = { "fantasticPlus", "fantastic", "excellent", "great", "decent", "wayOff", "miss", "holdsHeld", "rollsHeld", "minesHit" }
	for key in ivalues(keys) do
		local value = ex_counts[key]
		if value ~= nil then total_points = total_points + value * ExWeights[key] end
	end

	return math.max(0, math.floor(total_points/total_possible * 10000) / 100), total_points, total_possible
end