local Player = ...
if not Player then error("[ScreenNameEntryTraditional Wheel] If it had to done per player in StepMania 3.95, it has to be done per-player here.") end

local machineProfile = PROFILEMAN:GetMachineProfile()
local wheelItemFont = "_r bold 30px"
local wheelItemFocus = function(self) self:diffuseshift():effectcolor1(color("1,1,0,1")):effectcolor2(color("0,1,1,1")) end

local function MakeHighScoreWheelItem(index)
	return Def.ActorFrame{
		Name=string.format("WheelItem%i",index),
		Def.ActorFrame{
			UpdateWheelItemMessageCommand=function(self,param)
				if param.Index == index and param.Player == Player then
					local hs = param.HighScore

					if hs then
						local scoreName = hs:GetName()
						if string.len(scoreName)<1 then scoreName = THEME:GetMetric("HighScore","EmptyName") end
						self:GetChild("Name"):settext(scoreName)
						self:GetChild("Score"):settext(FormatPercentScore(hs:GetPercentDP()))
						local dateText = tostring(hs:GetDate())
						dateText = string.gsub(string.sub(dateText,1,10),"-","/")
						self:GetChild("Date"):settext(dateText)
					else
						self:GetChild("Name"):settext("????")
						self:GetChild("Score"):settext(FormatPercentScore(0))
						self:GetChild("Date"):settext("----/--/--")
					end

					if param.Focus == index then
						self:GetChild("Rank"):queuecommand("Focus")
						self:GetChild("Name"):queuecommand("Focus")
						self:GetChild("Score"):queuecommand("Focus")
						self:GetChild("Date"):queuecommand("Focus")
					else
						self:GetChild("Rank"):stopeffect()
						self:GetChild("Name"):stopeffect()
						self:GetChild("Score"):stopeffect()
						self:GetChild("Date"):stopeffect()
					end
				end
			end,
			Def.BitmapText {
				File = wheelItemFont,
				Name="Rank",
				Text=index+1,
				InitCommand=function(self) self:x(-158):shadowlength(2) end,
				FocusCommand=wheelItemFocus,
			},
			Def.BitmapText {
				File = wheelItemFont,
				Name="Name",
				InitCommand=function(self) self:x(-89):maxwidth(110):shadowlength(2) end,
				FocusCommand=wheelItemFocus,
			},
			Def.BitmapText {
				File = wheelItemFont,
				Name="Score",
				InitCommand=function(self) self:x(87):halign(1):maxwidth(120):shadowlength(2) end,
				FocusCommand=wheelItemFocus,
			},
			Def.BitmapText {
				File = wheelItemFont,
				Name="Date",
				InitCommand=function(self) self:x(132):maxwidth(80):shadowlength(2) end,
				FocusCommand=wheelItemFocus,
			}
		}
	}
end

return Def.ActorFrame{
	InitCommand=function(self) self:fov(15) end,
	Def.ActorScroller{
		SecondsPerItem=0.2,
		NumItemsToDraw=10.5,
		TransformFunction=function(self,offset,itemIndex,numItems)
			local degrees=18*offset
			local radians=degrees*math.pi/180
			self:rotationx(degrees):y(math.sin(radians)*90):z(math.cos(radians)*90)
		end,
		OffCommand=function(self) self:stoptweening() end,
		ChangeDisplayedFeatMessageCommand=function(self,param)
			if param.Player == Player then
				self:SetCurrentAndDestinationItem(15):PositionItems()

				local itemToFocus = -1
				local scrollerFocus = 3
				local playedSS,playerSS,myPercentDP,myScore

				if GAMESTATE:IsCourseMode() then
					playedSS = STATSMAN:GetPlayedStageStats(1)
					playerSS = playedSS:GetPlayerStageStats(Player)
					myPercentDP = playerSS:GetPercentDancePoints()
					myScore = playerSS:GetScore()

					local hsl = machineProfile:GetHighScoreListIfExists(GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(Player))
					if hsl then
						local highScores = hsl:GetHighScores()
						for i=1,10 do
							local hs = highScores[i]
							if hs then
								if hs:IsFillInMarker() then
									local hsName = hs:GetName()
									if string.find(hsName,PlayerNumberToString(Player)) then
										if hs:GetPercentDP() == myPercentDP and hs:GetScore() == myScore then itemToFocus = i-1 end
									end
								end
							end
						end
						scrollerFocus = math.max(itemToFocus,3)
						for i=0,9 do MESSAGEMAN:Broadcast("UpdateWheelItem",{Player=param.Player,Index=i,HighScore=highScores[i+1],Focus=itemToFocus}) end
					end
				else
					local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
					playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
					playerSS = playedSS:GetPlayerStageStats(Player)
					local songs = playedSS:GetPlayedSongs()
					local steps = playerSS:GetPlayedSteps()
					local hsl = machineProfile:GetHighScoreListIfExists(songs[1],steps[1])
					myPercentDP = playerSS:GetPercentDancePoints()
					myScore = playerSS:GetScore()

					if hsl then
						local highScores = hsl:GetHighScores()
						for i=1,10 do
							local hs = highScores[i]
							if hs then
								if hs:IsFillInMarker() then
									local hsName = hs:GetName()
									if string.find(hsName,PlayerNumberToString(Player)) then
										if hs:GetPercentDP() == myPercentDP and hs:GetScore() == myScore then itemToFocus = i-1 end
									end
								end
							end
						end
						scrollerFocus = math.max(itemToFocus,3)
						for i=0,9 do MESSAGEMAN:Broadcast("UpdateWheelItem",{Player=param.Player,Index=i,HighScore=highScores[i+1],Focus=itemToFocus}) end
					end
				end

				self:SetDestinationItem(scrollerFocus):PositionItems()
			end
		end,
		MakeHighScoreWheelItem(0),
		MakeHighScoreWheelItem(1),
		MakeHighScoreWheelItem(2),
		MakeHighScoreWheelItem(3),
		MakeHighScoreWheelItem(4),
		MakeHighScoreWheelItem(5),
		MakeHighScoreWheelItem(6),
		MakeHighScoreWheelItem(7),
		MakeHighScoreWheelItem(8),
		MakeHighScoreWheelItem(9)
	}
}