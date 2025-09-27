local c = { [PLAYER_1] = nil, [PLAYER_2] = nil }
local tChild
local t = Def.ActorFrame{
	InitCommand = function(self) tChild = self:GetChildren() end,
	LoadFallbackB()
}
local view = { [PLAYER_1] = 0, [PLAYER_2] = 0 }
local judges = { [PLAYER_1] = isOpenDDR() and 4 or 5, [PLAYER_2] = isOpenDDR() and 4 or 5 }
if getenv("SetScoreFA"..pname(PLAYER_1)) then judges[PLAYER_1]=judges[PLAYER_1]+1 end
if getenv("SetScoreFA"..pname(PLAYER_2)) then judges[PLAYER_2]=judges[PLAYER_2]+1 end
local enableOffsets = ThemePrefs.Get("ShowOffset")
local offsetInfo = getenv("OffsetTable")

local timing = GetTimingDifficulty()
local timingChange = { 1.50,1.33,1.16,1.00,0.84,0.66,0.50,0.33,0.20 }
local W0 = 0.0135*timingChange[timing]
local W1 = (isOpenDDR() and 0.0167 or PREFSMAN:GetPreference("TimingWindowSecondsW1"))*timingChange[timing]
local W2 = (isOpenDDR() and 0.0333 or PREFSMAN:GetPreference("TimingWindowSecondsW2"))*timingChange[timing]
local W3 = (isOpenDDR() and 0.0920 or PREFSMAN:GetPreference("TimingWindowSecondsW3"))*timingChange[timing]
local W4 = (isOpenDDR() and 0.1420 or PREFSMAN:GetPreference("TimingWindowSecondsW4"))*timingChange[timing]
local W5 = (isOpenDDR() and 0.0000 or PREFSMAN:GetPreference("TimingWindowSecondsW5"))*timingChange[timing]
local Wadd = (isOpenDDR() or isEtterna()) and 0.0000 or PREFSMAN:GetPreference("TimingWindowAdd")

if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		local t2 = Def.ActorFrame{
			Def.Sprite {
				Texture = THEME:GetPathG("_difficulty icons",isFinal() and "final" or "normal"),
				InitCommand=function(self) self:zoomy(0.8):animate(0):zoomx((pn==PLAYER_2) and -0.8 or 0.8):playcommand("Update") end,
				UpdateCommand=function(self)
					local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
					if StepsOrTrail then self:setstate(DifficultyToState(StepsOrTrail:GetDifficulty())) end
				end
			},
			Def.Sprite {
				Condition=getenv("Flare"..pname(pn)) > 0 and not GAMESTATE:IsCourseMode(),
				Texture = THEME:GetPathB("ScreenGameplay","overlay/_border"),
				InitCommand=function(self) self:zoomy(0.4):zoomx((pn==PLAYER_2) and -0.4 or 0.4):playcommand("ChangeBorder")  end,
				ChangeBorderCommand=function(self)
					local level = getenv("Flare"..pname(pn))
					if level == 0 then
						self:diffusealpha(0)
					elseif level == 11 then
						local float = getenv("FlareDisplay"..pname(pn))
						if type(float[#float][2]) ~= 'table' then
							level = #split("|",float[#float][2])
						else
							level = #float[#float][2]
						end
						if level == 1 and tonumber(float[#float][2][1]) < 0 then
							self:diffusealpha(0)
						else
							if flareColor[level] == "rainbow" then self:rainbow() else self:stopeffect():diffuse(color(flareColor[level])) end
						end
					end
				end
			},
			Def.BitmapText {
				Condition=getenv("Flare"..pname(pn)) > 0 and not GAMESTATE:IsCourseMode(),
				File = "_v 26px bold black",
				InitCommand=function(self) self:zoom(0.33*WideScreenDiff()):addy(-11*WideScreenDiff()):playcommand("ChangeBorder") end,
				ChangeBorderMessageCommand=function(self)
					local level = getenv("Flare"..pname(pn))
					if level == 0 then
						self:diffusealpha(0)
					elseif level == 11 then
						local float = getenv("FlareDisplay"..pname(pn))
						if type(float[#float][2]) ~= 'table' then
							level = #split("|",float[#float][2])
						else
							level = #float[#float][2]
						end
						if level == 1 and tonumber(float[#float][2][1]) < 0 then
							self:diffusealpha(0)
						else
							self:settext("FLARE "..flareName[level])
						end
					end
				end
			},
			Def.StepsDisplay {
				InitCommand=function(self) self:Load("StepsDisplayEvaluation",pn):SetFromGameState(pn) end,
				UpdateNetEvalStatsMessageCommand=function(self,param)
					if GAMESTATE:IsPlayerEnabled(pn) or isVS() then self:SetFromSteps(param.Steps) end
				end
			}
		}
		t[#t+1] = t2 .. {
			InitCommand=function(self)
				self:name("StepsDisplay"..pname(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "MachineRecord"))(pn) .. {
			InitCommand=function(self)
				self:player(pn):name("MachineRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"))(pn)..{
			InitCommand=function(self)
				self:player(pn):name("PersonalRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "AutoPlayer"))(pn) .. {
			InitCommand=function(self)
				self:player(pn):name("AutoPlayer" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		if PROFILEMAN:IsPersistentProfile(pn) then
			t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "PacemakerRecord"))(pn)..{
				InitCommand=function(self)
					self:player(pn):name("PacemakerRecord" .. PlayerNumberToString(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

local function TotalPossibleStepSeconds()
	local fSecs = 0
	local s = STATSMAN:GetPlayedStageStats(1)
	local played = isITGmania() and #s:GetPlayedSongs() or #s:GetPossibleSongs()
	for a = 1, played do
		fSecs = fSecs + s:GetPossibleSongs()[a]:GetStepsSeconds()
	end

    local songoptions = GAMESTATE:GetSongOptionsObject("ModsLevel_Song")
    if not songoptions then return fSecs end

    return fSecs / songoptions:MusicRate()
end

local function CalcMinusStepSeconds(pn)
	if isEtterna() then return 0 end
	local fSecs = 0

	if GAMESTATE:IsCourseMode() then
		local trail = GAMESTATE:GetCurrentTrail(pn):GetTrailEntry(1)
		if trail then
			local song = trail:GetSong()
			if song then
				fSecs = fSecs + song:GetFirstSecond()
			end
		end
	else
		fSecs = fSecs + GAMESTATE:GetCurrentSong():GetFirstSecond()
	end

    local songoptions = GAMESTATE:GetSongOptionsObject("ModsLevel_Song")
    if not songoptions then return fSecs end

    return fSecs / songoptions:MusicRate()
end

local function GetVertices(flare,level)
	local graphH = 68
	local graphW = 192
    local vertices = {}
	local max = flare[#flare][1]

    for i=1, #flare - 1 do
		local curX = flare[i][1]
		local nextX = flare[i+1][1]
		local curY = flare[i][2][level] or 0
		local nextY = flare[i+1][2][level] or 0
		if string.find(curY,"-") then curY = 0 end
		if string.find(nextY,"-") then nextY = 0 end
        local col = color(flareColor[level] == "rainbow" and "#ffffff" or flareColor[level])
        vertices[#vertices+1] = { {math.min(1,curX/max)*graphW, (curY/10000)*graphH, 0}, col }
        vertices[#vertices+1] = { {math.min(1,curX/max)*graphW, 0, 0}, col }
        vertices[#vertices+1] = { {math.min(1,nextX/max)*graphW, 0, 0}, col }
        vertices[#vertices+1] = { {math.min(1,nextX/max)*graphW, (nextY/10000)*graphH, 0}, col }
    end
    return vertices
end

local function GetVerticesOutFox(lives,pn)
	local graphH = 68
	local graphW = 192
    local vertices = {}
	local max = #lives

    for i=1, #lives - 1 do
		local curX = i
		local nextX = i+1
		local curY = lives[i] or 0
		local nextY = lives[i+1] or 0
        vertices[#vertices+1] = { {math.min(1,curX/max)*graphW, curY*graphH, 0}, PlayerColor(pn) }
        vertices[#vertices+1] = { {math.min(1,curX/max)*graphW, 0, 0}, PlayerColorSemi(pn) }
        vertices[#vertices+1] = { {math.min(1,nextX/max)*graphW, 0, 0}, PlayerColorSemi(pn) }
        vertices[#vertices+1] = { {math.min(1,nextX/max)*graphW, nextY*graphH, 0}, PlayerColor(pn) }
    end
    return vertices
end

local function GetVerticesOffsetDot(offset,pn)
	local graphH = 68/2
	local graphW = 192
    local vertices = {}
	local max = TotalPossibleStepSeconds()
	local JudgeScale = isOutFoxV(20230624) and GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
	local jugd = getenv("SetScoreFA"..pname(pn)) and {{W0*JudgeScale+Wadd,color("#7BE8FF")},{W1*JudgeScale+Wadd,color("#FFFFFF")}} or {{W1*JudgeScale+Wadd,color("#7BE8FF")}}
	jugd[#jugd+1]={W2*JudgeScale+Wadd,color("#FFA959")}
	jugd[#jugd+1]={W3*JudgeScale+Wadd,color("#67FF19")}
	jugd[#jugd+1]={W4*JudgeScale+Wadd,color("#D366FF")}
	if not isOpenDDR() then jugd[#jugd+1]={W5*JudgeScale+Wadd,color("#FF7149")} end
	local maxjudg = math.round(jugd[judges[pn]][1],3)

	vertices[#vertices+1] = { {math.min(1,0)*graphW, (-1-0.01)*graphH, 0}, color("#000080") }
	vertices[#vertices+1] = { {math.min(1,0)*graphW, (-1+0.01)*graphH, 0}, color("#800000") }
	vertices[#vertices+1] = { {math.min(1,max)*graphW, (-1+0.01)*graphH, 0}, color("#800000") }
	vertices[#vertices+1] = { {math.min(1,max)*graphW, (-1-0.01)*graphH, 0}, color("#000080") }

    local lines = isOutFox(20201100)

    for off=1, #offset do
		local curX = offset[off][1]-CalcMinusStepSeconds(pn)
		local nextX = offset[off][1]-CalcMinusStepSeconds(pn)
		local curY = offset[off][2]
		local nextY = offset[off][2]
		for j=1, judges[pn] do
			if offset[off][2] == "Miss" then
				if lines then
					vertices[#vertices+1] = { {math.min(1,curX/max)*graphW, -2*graphH, 0}, color("#FF080880") }
					vertices[#vertices+1] = { {math.min(1,curX/max)*graphW, 0, 0}, color("#FF080880") }
					break
				else
					vertices[#vertices+1] = { {math.min(1,(curX/max-0.0015))*graphW, -2*graphH, 0}, color("#FF080880") }
					vertices[#vertices+1] = { {math.min(1,(curX/max-0.0015))*graphW, 0, 0}, color("#FF080880") }
					vertices[#vertices+1] = { {math.min(1,(curX/max+0.0015))*graphW, 0, 0}, color("#FF080880") }
					vertices[#vertices+1] = { {math.min(1,(curX/max+0.0015))*graphW, -2*graphH, 0}, color("#FF080880") }
					break
				end
			else
				if math.abs(offset[off][2]) <= jugd[j][1] then
					curY = curY / maxjudg - 1
					nextY = nextY / maxjudg - 1

					if lines then
						vertices[#vertices+1] = { {math.min(1,curX/max)*graphW, (curY-0.01)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,nextX/max)*graphW, (nextY+0.01)*graphH, 0}, jugd[j][2] }
						break
					else
						vertices[#vertices+1] = { {math.min(1,curX/max-0.0015)*graphW, (curY-0.01)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,curX/max-0.0015)*graphW, (curY+0.01)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,nextX/max+0.0015)*graphW, (nextY+0.01)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,nextX/max+0.0015)*graphW, (nextY-0.01)*graphH, 0}, jugd[j][2] }
						break
					end
				end
			end
		end
    end
    return vertices
end

local function GetVerticesOffsetLine(data,pn)
	local graphH = 68
	local graphW = 192/2
    local vertices = {}
	local max = 0
	local JudgeScale = isOutFoxV(20230624) and GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
	local jugd = getenv("SetScoreFA"..pname(pn)) and {{W0*JudgeScale+Wadd,color("#7BE8FF")},{W1*JudgeScale+Wadd,color("#FFFFFF")}} or {{W1*JudgeScale+Wadd,color("#7BE8FF")}}
	jugd[#jugd+1]={W2*JudgeScale+Wadd,color("#FFA959")}
	jugd[#jugd+1]={W3*JudgeScale+Wadd,color("#67FF19")}
	jugd[#jugd+1]={W4*JudgeScale+Wadd,color("#D366FF")}
	if not isOpenDDR() then jugd[#jugd+1]={W5*JudgeScale+Wadd,color("#FF7149")} end
	local maxjudg = math.round(jugd[judges[pn]][1],3)
    local lines = isOutFox(20201100)

	vertices[#vertices+1] = { {math.min(1,0-0.01)*graphW+graphW, -(1)*graphH, 0}, color("#000080") }
	vertices[#vertices+1] = { {math.min(1,0-0.01)*graphW+graphW, (0)*graphH, 0}, color("#000080") }
	vertices[#vertices+1] = { {math.min(1,0+0.01)*graphW+graphW, (0)*graphH, 0}, color("#800000") }
	vertices[#vertices+1] = { {math.min(1,0+0.01)*graphW+graphW, -(1)*graphH, 0}, color("#800000") }

	local offset = {}
	for t in ivalues(data) do
		if t[2] and type(t[2]) == "number" then
			t[2]=math.round(t[2],3)
			offset[t[2]] = offset[t[2]] and offset[t[2]] + 1 or 1
		end
	end
	for check = -maxjudg,maxjudg+0.001,0.001 do
		check=math.round(check,3)
		if offset[check] then max=math.max(max,offset[check]) end
	end
	for i = -maxjudg,maxjudg+0.001,0.001 do
		i=math.round(i,3)
		if offset[i] then
			for j=1, judges[pn] do
				if math.abs(i) <= jugd[j][1] then
					if lines then
						vertices[#vertices+1] = { {math.min(1,i/maxjudg)*graphW+graphW, -(offset[i]/max)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,i/maxjudg)*graphW+graphW, (0)*graphH, 0}, jugd[j][2] }
						break
					else
						vertices[#vertices+1] = { {math.min(1,i/maxjudg)*graphW+graphW, -(offset[i]/max)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,i/maxjudg-0.01)*graphW+graphW, (0)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,i/maxjudg+0.01)*graphW+graphW, (0)*graphH, 0}, jugd[j][2] }
						vertices[#vertices+1] = { {math.min(1,i/maxjudg)*graphW+graphW, -(offset[i]/max)*graphH, 0}, jugd[j][2] }
						break
					end
				end
			end
		end
    end
    return vertices
end

local function SwitchView(pn)
	local check = view[pn] % 3
	c[pn]["Graph"..pname(pn)]:diffusealpha(check == 0 and 1 or 0)
	c[pn]["Dot"..pname(pn)]:diffusealpha(check == 1 and 1 or 0)
	c[pn]["Line"..pname(pn)]:diffusealpha(check == 2 and 1 or 0)
	tChild["StageAward"..pname(pn)]:diffusealpha(check == 0 and 1 or 0)
	tChild["PeakComboAward"..pname(pn)]:diffusealpha(check == 0 and 1 or 0)
end

local checkUpdate = false

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end
	if not GAMESTATE:IsHumanPlayer(event.PlayerNumber) then return false end
	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuLeft" or event.GameButton == "MenuRight" then
			if event.GameButton == "MenuLeft" then
				view[event.PlayerNumber] = view[event.PlayerNumber] - 1
			elseif event.GameButton == "MenuRight" then
				view[event.PlayerNumber] = view[event.PlayerNumber] + 1
			end
			SwitchView(event.PlayerNumber)
		elseif event.GameButton == "MenuUp" or event.GameButton == "MenuDown" then
			if event.GameButton == "MenuUp" and judges[event.PlayerNumber] < (isOpenDDR() and 4 or 5) then
				judges[event.PlayerNumber] = judges[event.PlayerNumber] + 1
				checkUpdate = true
			elseif event.GameButton == "MenuDown" and judges[event.PlayerNumber] > 1 then
				judges[event.PlayerNumber] = judges[event.PlayerNumber] - 1
				checkUpdate = true
			end
			if checkUpdate then
				c[event.PlayerNumber]["Dot"..pname(event.PlayerNumber)]:playcommand("Draw")
				c[event.PlayerNumber]["Line"..pname(event.PlayerNumber)]:playcommand("Draw")
				checkUpdate = false
			end
		end
	end
end

local function GraphDisplay(pn)
	local length = TotalPossibleStepSeconds()
	local lastMarvelousSecond = getenv("LastFantastic"..pname(pn)) - CalcMinusStepSeconds(pn)
	local lastPerfectSecond = getenv("LastPerfect"..pname(pn)) - CalcMinusStepSeconds(pn)
	local lastGreatSecond = getenv("LastGreat"..pname(pn)) - CalcMinusStepSeconds(pn)

	local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	local combo = PSS:GetComboList()
	local trueLast = #combo > 0 and combo[1]["StartSecond"]+combo[1]["SizeSeconds"] or 0
	local maxLast = lastGreatSecond ~= 0 and lastGreatSecond or lastPerfectSecond ~= 0 and lastPerfectSecond or lastMarvelousSecond
	local fix = trueLast < maxLast and trueLast/maxLast or 1
	local lastGreatSecond = lastGreatSecond * fix
	local lastPerfectSecond = lastPerfectSecond * fix
	local lastMarvelousSecond = lastMarvelousSecond * fix

	local display = Def.ActorFrame{
		InitCommand=function(self) c[pn] = self:GetChildren() end,
		OnCommand=function() if enableOffsets and not isVS() then SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end end,
		OffCommand=function() if enableOffsets and not isVS() then SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end end,
	}
	local float = getenv("FlareDisplay"..pname(pn))
	local last = 1
	local flareLevel = getenv("Flare"..pname(pn))

	if flareLevel == 11 and not GAMESTATE:IsCourseMode() then
		if type(float[#float][2]) ~= 'table' then
			last = #split("|",float[#float][2])
		else
			last = #float[#float][2]
		end
		float[#float][1] = length
		local flareDisplay = Def.ActorFrame{ Name="Graph"..pname(pn) }
		for flare=last,10 do
			for i=1,#float do
				if type(float[i][2]) ~= 'table' then
					float[i][2] = split("|",float[i][2])
				end
			end
			flareDisplay[#flareDisplay+1] = Def.ActorMultiVertex{
				InitCommand=function(self)
					local vertices = GetVertices(float,flare)
					self:SetDrawState({Mode = 'DrawMode_Quads'})
					self:SetVertices(1, vertices)
					self:SetNumVertices(#vertices)
					self:rotationx(180)
					self:x(-96):y(34)
					if flare == 10 then self:rainbow() end
				end
			}
		end
		display[#display+1] = flareDisplay
	else
		if isOutFox() and isMGD(pn) then
			local lives = PSS:GetLifeRecord(length, 192)
			local mod = GetLives(pn)/100
			for i=1,#lives do lives[i]=lives[i]*mod end
			display[#display+1] = Def.ActorMultiVertex{
				Name="Graph"..pname(pn),
				InitCommand=function(self)
					local vertices = GetVerticesOutFox(lives,pn)
					self:SetDrawState({Mode = 'DrawMode_Quads'})
					self:SetVertices(1, vertices)
					self:SetNumVertices(#vertices)
					self:rotationx(180)
					self:x(-96):y(34)
				end
			}
		else
			display[#display+1] = Def.ActorFrame{
				Name="Graph"..pname(pn),
				Def.GraphDisplay {
					InitCommand=function(self) self:Load("GraphDisplay"..pname(pn)) end,
					BeginCommand=function(self)
						local ss = SCREENMAN:GetTopScreen():GetStageStats()
						self:Set( ss, ss:GetPlayerStageStats(pn) ):player( pn )
						if not isOutFox() and isMGD(pn) then
							local lives = GetLives(pn)/100
							self:zoomy(lives):addy(66*(1-lives)/2)
						end
						if not isOutFox() and isVS() then self:MaskDest() end
					end
				},
				Def.ActorFrame {
					Condition=not isSurvival(pn) and flareLevel == 0,
					Def.Sprite {
						Texture = THEME:GetPathB("ScreenEvaluation","underlay/FGC "..pname(pn)),
						Condition=not isVS() and getenv("EvalCombo"..pname(pn)) and not (isOni() and not isLifeline(pn)),
						InitCommand=function(self)
							self:croptop(0.78) if not (PSS:FullComboOfScore('TapNoteScore_W3') and PlayerFullComboed(pn)) then self:cropright(1-(lastGreatSecond/length)) end
						end
					},
					Def.Sprite {
						Texture = THEME:GetPathB("ScreenEvaluation","underlay/FEC "..pname(pn)),
						Condition=not isVS() and getenv("EvalCombo"..pname(pn)) and not (isOni() and not isLifeline(pn)),
						InitCommand=function(self)
							self:croptop(0.78) if not (PSS:FullComboOfScore('TapNoteScore_W2') and PlayerFullComboed(pn)) then self:cropright(1-(lastPerfectSecond/length)) end
						end
					},
					Def.Sprite {
						Texture = THEME:GetPathB("ScreenEvaluation","underlay/FFC "..pname(pn)),
						Condition=not isVS() and getenv("EvalCombo"..pname(pn)) and not (isOni() and not isLifeline(pn)),
						InitCommand=function(self)
							self:croptop(0.78) if not (PSS:FullComboOfScore('TapNoteScore_W1') and PlayerFullComboed(pn)) then self:cropright(1-(lastMarvelousSecond/length)) end
						end
					}
				}
			}
		end
	end
	if enableOffsets and offsetInfo and offsetInfo[pn] then
		display[#display+1] = Def.ActorMultiVertex{
			Name="Dot"..pname(pn),
			InitCommand=function(self) self:diffusealpha(0):playcommand("Draw") end,
			DrawCommand=function(self)
				local vertices = GetVerticesOffsetDot(offsetInfo[pn],pn)
                self:SetDrawState(isOutFox(20201100) and {Mode = 'DrawMode_Lines'} or {Mode = 'DrawMode_Quads'})
				self:SetVertices(1, vertices)
				self:SetNumVertices(#vertices)
				self:x(-96):y(34)
			end
		}
		display[#display+1] = Def.ActorMultiVertex{
			Name="Line"..pname(pn),
			InitCommand=function(self) self:diffusealpha(0):playcommand("Draw") end,
			DrawCommand=function(self)
				local vertices = GetVerticesOffsetLine(offsetInfo[pn],pn)
                self:SetDrawState(isOutFox(20201100) and {Mode = 'DrawMode_Lines'} or {Mode = 'DrawMode_Quads'})
				self:SetVertices(1, vertices)
				self:SetNumVertices(#vertices)
				self:x(-96):y(34)
			end
		}
	end

	if flareLevel > 0 and not GAMESTATE:IsCourseMode() then
		if PSS:GetFailed() then last = 0 end
		if last == 1 and tonumber(float[#float][2][1]) < 0 then last = 0 end

		if flareLevel > 0 and last > 0 then
			if (isEtterna() and not STATSMAN:GetCurStageStats():Failed() or (not PSS:GetFailed() and PSS:GetAliveSeconds() > length)) and not
			((GAMESTATE:GetPlayerState(pn):GetPlayerController() == 'PlayerController_Autoplay') or
			(GAMESTATE:GetPlayerState(pn):GetPlayerController() == 'PlayerController_Cpu')) then
				local Song = GAMESTATE:GetCurrentSong()
				local Steps = GAMESTATE:GetCurrentSteps(pn)
				if UpdateFlare(Song,Steps,last,pn) then SaveFlare(pn) end
			end
		end
	end

	return Def.ActorFrame {
		Def.ActorFrame {
			Condition=not isOutFox() and isVS(),
			Def.Quad{
				OnCommand=function(self) self:valign(0):zoomto(194,SCREEN_WIDTH):MaskSource(false):y(34) end
			},
			Def.Quad{
				OnCommand=function(self) self:valign(1):zoomto(194,SCREEN_WIDTH):MaskSource(false):y(-34) end
			}
		},
		display
	}
end

if ShowStandardDecoration("GraphDisplay") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = GraphDisplay(pn) .. {
				InitCommand=function(self)
					self:name("GraphDisplay"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

local function ComboGraph( pn )
	return Def.ActorFrame {
		Def.ComboGraph {
			InitCommand=function(self) self:Load("ComboGraph"..pname(pn)) end,
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) ):player( pn )
			end
		}
	}
end

if ShowStandardDecoration("ComboGraph") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = ComboGraph(pn) .. {
				InitCommand=function(self)
					self:name("ComboGraph"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

local function StageAward( pn )
	return loadfile(THEME:GetPathG("ScreenEvaluation", "StageAward"))(pn)..{
		InitCommand=function(self) self:player(pn):name("StageAward"..pname(pn)) end
	}
end

if ShowStandardDecoration("StageAward") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StageAward(pn) .. {
				InitCommand=function(self)
					self:name("StageAward"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

local function PeakComboAward( pn )
	return loadfile( THEME:GetPathG(Var "LoadingScreen", "PeakComboAward"))(pn) .. {
		InitCommand=function(self) self:player(pn):name("PeakComboAward"..pname(pn)) end
	}
end

if ShowStandardDecoration("PeakComboAward") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = PeakComboAward(pn) .. {
				InitCommand=function(self)
					self:name("PeakComboAward"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

return t