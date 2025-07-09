local pn = ...
local player = nil
local pnFlare = getenv("Flare"..pname(pn))
local old = getenv("FlareType"..pname(pn)) == 1
local float = pnFlare == 11
local level = pnFlare == 11 and 10 or pnFlare
local life = 10000
local lifeTotal = {10000,10000,10000,10000,10000,10000,10000,10000,10000,10000}

local function GetLifeSub(lv)
	if old then
		return {
			TapNoteScore_W2 = flareOld[lv][1],
			TapNoteScore_W3 = flareOld[lv][2],
			TapNoteScore_W4 = flareOld[lv][3],
			TapNoteScore_W5 = flareOld[lv][4],
			TapNoteScore_Miss = flareOld[lv][4],
			TapNoteScore_HitMine = flareOld[lv][4],
			HoldNoteScore_LetGo = flareOld[lv][4],
		}
	end
    return {
        TapNoteScore_W2 = flareNew[lv][1],
        TapNoteScore_W3 = flareNew[lv][2],
        TapNoteScore_W4 = flareNew[lv][3],
        TapNoteScore_W5 = flareNew[lv][4],
        TapNoteScore_Miss = flareNew[lv][4],
        TapNoteScore_HitMine = flareNew[lv][4],
        HoldNoteScore_LetGo = flareNew[lv][4],
    }
end

local lifeSub = GetLifeSub(level)
local lifeSubTotal = {
	GetLifeSub(1),
	GetLifeSub(2),
	GetLifeSub(3),
	GetLifeSub(4),
	GetLifeSub(5),
	GetLifeSub(6),
	GetLifeSub(7),
	GetLifeSub(8),
	GetLifeSub(9),
	GetLifeSub(10),
}
local lifeCount = {
	TapNoteScore_W2 = 0,
	TapNoteScore_W3 = 0,
	TapNoteScore_W4 = 0,
	TapNoteScore_W5 = 0,
	TapNoteScore_Miss = 0,
	TapNoteScore_HitMine = 0,
	HoldNoteScore_LetGo = 0,
}
local floatDisplay = {
	{0,"10000|10000|10000|10000|10000|10000|10000|10000|10000|10000"}
}
local lastFloat = "10000|10000|10000|10000|10000|10000|10000|10000|10000|10000"

return Def.ActorFrame{
    OnCommand=function(self)
		self:draworder(1):sleep(0.5):queuecommand("TweenOn")
		player = SCREENMAN:GetTopScreen():GetChild('Player'..pname(pn))
        self:SetUpdateFunction(function(self)
			if player and level then player:SetLife(0.0001*life) end
        end)
		MESSAGEMAN:Broadcast("ChangeBorder",{
			Player = pn,
			Level = level,
			Color = flareColor[level],
			Name = 'FLARE '..flareName[level]
		})
    end,
	OffCommand=function(self)
		self:queuecommand("Hide")
		if float then
			local output = ""
			for i = 1, level do output=addToOutput(output,lifeTotal[i],"|") end
			setenv("FlareDisplay"..pname(pn),floatDisplay)
		end
	end,
	Def.BitmapText {
		File = "_z 36px black",
		OnCommand=function(self)
			local xPN = pn == PLAYER_1 and SCREEN_LEFT+(isFinal() and WideScaleFixed(20*WideScreenDiff(),35*WideScreenDiff()) or 20*WideScreenDiff()) or SCREEN_RIGHT-(isFinal() and WideScaleFixed(20*WideScreenDiff(),35*WideScreenDiff()) or 20*WideScreenDiff())
			self:visible(not getenv("HideLifeP1")):diffusealpha(IsGame("pump") and 0 or 1):zoom(0.5*WideScreenDiff()):x(xPN):y(SCREEN_CENTER_Y-120*WideScreenDiff()):addx(pn == PLAYER_1 and -100 or 100):sleep(0.5):decelerate(0.8):addx(pn == PLAYER_1 and 100 or -100)
		end,
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.4):addx(pn == PLAYER_1 and -100 or 100) end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == pn then
				if param.Level == 0 then
					self:diffusealpha(0)
				elseif param.Level == 10 then
					self:rainbow()
				else
					self:stopeffect():diffuse(color(param.Color))
				end
				self:settext(flareName[param.Level])
			end
		end
	},
	ShowGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOn") end,
	HideGameplayTopFrameMessageCommand=function(self) self:queuecommand("Hide") end,
	HideCommand=function(self)
		if AnyPlayerFullComboed() then self:sleep(1) end
		self:queuecommand('TweenOff')
	end,
	JudgmentMessageCommand=function(self, params)
		if params.Player == params.Player and not string.find(params.TapNoteScore,"Checkpoint") and not string.find(params.TapNoteScore,"None") and params.TapNoteScore ~= "TapNoteScore_" then
			if pn == params.Player then
				if level and level < 1 then return end
				local noteScore = params.HoldNoteScore or params.TapNoteScore
				local sub = (lifeSub[noteScore] or 0) + ((level == nil and life >= 10000 and lifeSub[noteScore] > 0) and 1000 or 0)
				if player then
					if lifeCount[noteScore] then lifeCount[noteScore] = lifeCount[noteScore] + 1 end
					life = life-sub
					if float and life <= 0 and level and level > 1 then
						local sumSub = 0
						if level > 1 then
							while level > 1 do
								level = level-1
								SOUND:PlayOnce(THEME:GetPathS("ScreenOptions", "toggle off"), true)
								MESSAGEMAN:Broadcast("ChangeBorder",{
									Player = pn,
									Level = level,
									Color = flareColor[level],
									Name = 'FLARE '..flareName[level]
								})
								if level < 1 then break end
								lifeSub = GetLifeSub(level)
								sumSub = lifeCount.TapNoteScore_W2*lifeSub.TapNoteScore_W2
									+lifeCount.TapNoteScore_W3*lifeSub.TapNoteScore_W3
									+lifeCount.TapNoteScore_W4*lifeSub.TapNoteScore_W4
									+lifeCount.TapNoteScore_W5*lifeSub.TapNoteScore_W5
									+lifeCount.TapNoteScore_Miss*lifeSub.TapNoteScore_Miss
									+lifeCount.TapNoteScore_HitMine*lifeSub.TapNoteScore_HitMine
									+lifeCount.HoldNoteScore_LetGo*lifeSub.HoldNoteScore_LetGo
								if sumSub < 10000 then break end
							end
						end
						if level < 1 then
							life = -1
							STATSMAN:GetCurStageStats():GetPlayerStageStats(player):FailPlayer()
						else
							life = 10000 - sumSub
						end
					end
					if life <= 0 then
						player:SetLife(0)
					elseif life == 0 then
						player:SetLife(0.0001)
					else
						player:SetLife(0.0001 * life)
					end
					local output = ""
					for i = 1, level do
						local sumSub = lifeCount.TapNoteScore_W2*lifeSubTotal[i].TapNoteScore_W2
							+lifeCount.TapNoteScore_W3*lifeSubTotal[i].TapNoteScore_W3
							+lifeCount.TapNoteScore_W4*lifeSubTotal[i].TapNoteScore_W4
							+lifeCount.TapNoteScore_W5*lifeSubTotal[i].TapNoteScore_W5
							+lifeCount.TapNoteScore_Miss*lifeSubTotal[i].TapNoteScore_Miss
							+lifeCount.TapNoteScore_HitMine*lifeSubTotal[i].TapNoteScore_HitMine
							+lifeCount.HoldNoteScore_LetGo*lifeSubTotal[i].HoldNoteScore_LetGo
						lifeTotal[i]=10000-sumSub
						output=addToOutput(output,lifeTotal[i],"|")
					end

					if lastFloat ~= output then
						lastFloat = output
						floatDisplay[#floatDisplay+1]={isEtterna() and GAMESTATE:GetSongPosition():GetMusicSecondsVisible() or STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetAliveSeconds(),output}
					end
				end
			end
		end
	end
}