local t = Def.ActorFrame{
	LoadActor(GetSongFrame()),
	Def.ActorFrame{
		Name="RaveNames",
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+58*WideScreenDiff()):visible(isRave()) end,
		OnCommand=function(self) self:addy(-100):sleep(0.5):decelerate(0.8):addy(100) end,
		OffCommand=function(self) self:accelerate(0.8):addy(-100) end,
		LoadFont("_v 26px bold black")..{
			InitCommand=function(self) self:x(-254*WideScreenDiff()):zoom(0.55*WideScreenDiff()):shadowlength(0):maxwidth(160) end,
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_1) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
				elseif isRave() then
					self:settext("CPU")
				end
			end
		},
		LoadFont("_v 26px bold black")..{
			InitCommand=function(self) self:x(254*WideScreenDiff()):zoom(0.55*WideScreenDiff()):shadowlength(0):maxwidth(160) end,
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_2) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
				elseif isRave() then
					self:settext("CPU")
				end
			end
		}
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,1")) end,
		OnCommand=function(self) self:linear(0.3):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="ScreenStageHoldovers",
		InitCommand=function(self) self:visible(not GAMESTATE:IsDemonstration() and not GAMESTATE:IsCourseMode()) end,
		LoadActor(THEME:GetPathB("ScreenStageInformation","in/bottom/bar"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+136*WideScreenDiff()):zoomy(WideScreenDiff()):zoomtowidth(SCREEN_WIDTH):faderight(0.8):fadeleft(0.8) end,
			OnCommand=function(self) self:sleep(2.25):cropright(0):linear(0.6):cropleft(1) end
		},
		Def.ActorFrame{
			Name="InfoP1",
			InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)) end,
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_left gradient"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_p1"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadFont("_r bold 30px")..{
				Text="Step Artist:",
				InitCommand=function(self) self:x(SCREEN_LEFT+5*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):zoom(0.6*WideScreenDiff()):halign(0):shadowlength(2*WideScreenDiff()) end,
				BeginCommand=function(self)
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and isRegular() or isRave())
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadFont("_r bold 30px")..{
				Name="AuthorText",
				InitCommand=function(self) self:x(SCREEN_LEFT+100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(0):zoom(0.6*WideScreenDiff()) end,
				BeginCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local text = ""
					if song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then text = steps:GetAuthorCredit() end
					end
					self:settext(text)
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadFont("_r bold 30px")..{
				Name="PlayerName",
				InitCommand=function(self) self:x(SCREEN_LEFT+44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(0):zoom(0.8*WideScreenDiff()) end,
				BeginCommand=function(self)
					if GAMESTATE:IsHumanPlayer(PLAYER_1) then
						self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
					elseif isRave() then
						self:settext("CPU")
					end
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="InfoP2",
			InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2)) end,
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_right gradient"))..{
				InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_p2"))..{
				InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadFont("_r bold 30px")..{
				Text=":Step Artist",
				InitCommand=function(self) self:x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):zoom(0.6*WideScreenDiff()):halign(1):shadowlength(2*WideScreenDiff()) end,
				BeginCommand=function(self)
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and isRegular() or isRave())
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadFont("_r bold 30px")..{
				Name="AuthorText",
				InitCommand=function(self) self:x(SCREEN_RIGHT-100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(1):zoom(0.6*WideScreenDiff()) end,
				BeginCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local text = ""
					if song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then text = steps:GetAuthorCredit() end
					end
					self:settext(text)
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			LoadFont("_r bold 30px")..{
				Name="PlayerName",
				InitCommand=function(self) self:x(SCREEN_RIGHT-44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(1):zoom(0.8*WideScreenDiff()) end,
				BeginCommand=function(self)
					if GAMESTATE:IsHumanPlayer(PLAYER_2) then
						self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
					elseif isRave() then
						self:settext("CPU")
					end
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			}
		}
	},
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+127*WideScreenDiff()):maxwidth(SCREEN_WIDTH/8*7/WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(1) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text = ""
			if song then text = song:GetDisplayFullTitle() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end
	},
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+147*WideScreenDiff()):maxwidth(SCREEN_WIDTH/8*6.8/WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoom(0.4*WideScreenDiff()):diffusealpha(1) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text = ""
			if song then text = song:GetDisplayArtist() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="DemonstrationFrame",
		BeginCommand=function(self) self:visible(GAMESTATE:IsDemonstration() and not isTopScreen('ScreenJukebox')) end,
		LoadActor("_metallic streak")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+43*WideScreenDiff()):zoomtowidth(SCREEN_WIDTH) end,
			OnCommand=function(self) self:diffusealpha(0.9):fadeleft(1):faderight(1) end
		},
		LoadFont("_z 36px black")..{
			Text="DEMO",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+43*WideScreenDiff()):zoom(0.7*WideScreenDiff()) end,
			OnCommand=function(self) self:pulse():effectmagnitude(1.0,0.95,0):effectclock('beat'):effectperiod(1) end
		},
		LoadActor("demonstration gradient")..{
			InitCommand=function(self) self:FullScreen():diffusealpha(0.8) end
		}
	},
	LoadActor(THEME:GetPathB("","_coins"))..{ InitCommand=function(self) self:visible(not GAMESTATE:IsDemonstration()) end }
}

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("DeltaSeconds", pn)..{ Condition=isOni() and not isLifeline(pn) or isSurvival(pn) }
	t[#t+1] = LoadActor("FCSplash", pn)
	t[#t+1] = LoadActor("Score", pn)..{ Condition=isRegular() or isNonstop() or isLifeline(pn) }
end

return t