local animate = canRender() and ThemePrefs.Get("AnimateSongTitle")
local TitleSongFade

if animate then
	if isOutFox() then
		TitleSongFade = LoadModule("Text.FadeSlide.lua")
	else
		TitleSongFade = LoadModuleSM("Text.FadeSlide.lua")
	end
else
	TitleSongFade = Def.ActorFrame{ Create = function(this) return Def.ActorFrame{} end }
end

local totalDelta = 0
local tmpDelta = 0
local c, ani
local P1,P2
local screen

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1.0/60 then
		tmpDelta = totalDelta
		if P1 and P2 then
			P1 = string.format("%03.0f",screen:GetTrueBPS(PLAYER_1)*60)
			P2 = string.format("%03.0f",screen:GetTrueBPS(PLAYER_2)*60)
			if P1 ~= P2 and not ani then
				ani = true
				c.BPMFrame:linear(0.125):zoomx(2):x(-SCREEN_CENTER_X)
			elseif P1 == P2 and ani then
				ani = false
				c.BPMFrame:linear(0.125):zoomx(1):x(0)
			end
		end
	end
end

return Def.ActorFrame{
	OnCommand = function(self)
		if GAMESTATE:GetNumPlayersEnabled() > 1 then
			screen = SCREENMAN:GetTopScreen()
			P1 = GAMESTATE:GetCurrentSteps(PLAYER_1)
			P2 = GAMESTATE:GetCurrentSteps(PLAYER_2)
			if P1:GetTimingData() ~= P2:GetTimingData() then
				self:SetUpdateFunction(Update)
			end
		end
	end,
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()):addy(-100) end,
		OnCommand=function(self) self:sleep(0.5):queuecommand("TweenOn") end,
		OffCommand=function(self) self:queuecommand("TweenOff") end,
		ShowGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOn") end,
		HideGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOff") end,
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end,
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end,
		Def.Sprite {
			Texture = "_base shade",
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+25*WideScreenDiff()):zoom(WideScreenDiff()):addy(-100) end,
		OnCommand=function(self) self:sleep(0.5):queuecommand("TweenOn") end,
		OffCommand=function(self) self:queuecommand("TweenOff") end,
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end,
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end,
		Def.SongMeterDisplay{
			InitCommand=function(self) self:SetStreamWidth(292) end,
			Stream=Def.Sprite {
				Texture = "meter stream",
			},
			Tip=Def.Sprite {
				Texture = "tip",
				OnCommand=function(self) self:zoom(0):sleep(1.8):zoom(1):diffuseshift():effectcolor1(color("1,1,1,1")):effectcolor2(color("1,1,1,0.5")):effectclock("beat"):effectperiod(4) end
			}
		}
	},
	Def.ActorFrame{
		OnCommand=function(self) self:visible(not isVS()) end,
		loadfile(THEME:GetPathG(Var "LoadingScreen", "BPMDisplay"))() .. {
			InitCommand=function(self)
				self:name("BPMDisplay")
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) c = self:GetChildren() end,
		OnCommand=function(self) self:addy(-100):sleep(0.5):queuecommand("TweenOn") end,
		OffCommand=function(self) self:queuecommand("TweenOff") end,
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end,
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end,
		Def.ActorFrame{
			Name="SongFrame",
			Def.Sprite {
				Texture = "_uplight top",
				InitCommand=function(self) self:CenterX():y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()):blend(Blend.Add) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#927f00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			},
			Def.Sprite {
				Texture = "_uplight top",
				InitCommand=function(self) self:CenterX():y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			},
			Def.Sprite {
				Texture = "width",
				InitCommand=function(self) self:x(SCREEN_CENTER_X-190*WideScreenDiff()):y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()):halign(1):zoomtowidth(3*WideScreenDiff()) end,
				OnCommand=function(self) self:sleep(1.5):linear(0.1):zoomtowidth(SCREEN_WIDTH/2-200*WideScreenDiff()) end
			},
			Def.Sprite {
				Texture = "width",
				InitCommand=function(self) self:x(SCREEN_CENTER_X+190*WideScreenDiff()):y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()):halign(0):zoomtowidth(3*WideScreenDiff()) end,
				OnCommand=function(self) self:sleep(1.5):linear(0.1):zoomtowidth(SCREEN_WIDTH/2-200*WideScreenDiff()) end
			},
			Def.Sprite {
				Texture = "left",
				InitCommand=function(self) self:x(SCREEN_CENTER_X-193*WideScreenDiff()):y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()):halign(1) end,
				OnCommand=function(self) self:sleep(1.5):linear(0.1):x(SCREEN_LEFT+16*WideScreenDiff()) end
			},
			Def.Sprite {
				Texture = "left",
				InitCommand=function(self) self:x(SCREEN_CENTER_X+193*WideScreenDiff()):y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()):halign(1):zoomx(-1*WideScreenDiff()) end,
				OnCommand=function(self) self:sleep(1.5):linear(0.1):x(SCREEN_RIGHT-16*WideScreenDiff()) end
			},
			Def.Sprite {
				Texture = "_base normal",
				InitCommand=function(self) self:CenterX():y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()) end
			},
			Def.Sprite {
				Texture = "_neons top",
				InitCommand=function(self) self:CenterX():y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()):blend(Blend.Add) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#927f00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			},
			Def.Sprite {
				Texture = "_neons top",
				InitCommand=function(self) self:CenterX():y(SCREEN_TOP+22*WideScreenDiff()):zoom(WideScreenDiff()) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			},
			Def.ActorFrame{
				TitleSongFade:Create()..{
					InitCommand=function(self) self:CenterX():y(SCREEN_TOP+24*WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
					OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoomy(0):hibernate(2):decelerate(0.3):zoomy(0.45*WideScreenDiff()) end,
				}
			},
			Def.BitmapText {
				File = "_r bold 30px",
				InitCommand=function(self) self:visible(not animate):CenterX():y(SCREEN_TOP+24*WideScreenDiff()):maxwidth(573):diffusebottomedge(color("#dedede")) end,
				OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoomy(0):hibernate(2):decelerate(0.3):zoomy(0.45*WideScreenDiff()):animate(0):playcommand("Update") end,
				CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end,
				UpdateCommand=function(self)
					local text = ""
					local song = GAMESTATE:GetCurrentSong()
					if song then text = song:GetDisplayFullTitle() end
					if animate then TitleSongFade:SetText( text ) end
					self:settext(text)
				end
			}
		},
		Def.ActorFrame{
			Name="BPMFrame",
			Def.Sprite {
				Texture = "_uplight bottom",
				InitCommand=function(self) self:x(SCREEN_CENTER_X-3*WideScreenDiff()):y(SCREEN_TOP+41*WideScreenDiff()):zoom(WideScreenDiff()):blend(Blend.Add):visible(not isVS()) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#927f00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			},
			Def.Sprite {
				Texture = "_uplight bottom",
				InitCommand=function(self) self:x(SCREEN_CENTER_X-3*WideScreenDiff()):y(SCREEN_TOP+41*WideScreenDiff()):zoom(WideScreenDiff()):visible(not isVS()) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			},
			Def.Sprite {
				Texture = "_base bpm",
				InitCommand=function(self) self:x(SCREEN_CENTER_X-3*WideScreenDiff()):y(SCREEN_TOP+58*WideScreenDiff()):zoom(WideScreenDiff()):visible(not isVS()) end
			},
			Def.Sprite {
				Texture = "_neons bottom",
				InitCommand=function(self) self:x(SCREEN_CENTER_X-3*WideScreenDiff()):y(SCREEN_TOP+60*WideScreenDiff()):zoom(WideScreenDiff()):blend(Blend.Add):visible(not isVS()) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#927f00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			},
			Def.Sprite {
				Texture = "_neons bottom",
				InitCommand=function(self) self:x(SCREEN_CENTER_X-3*WideScreenDiff()):y(SCREEN_TOP+60*WideScreenDiff()):zoom(WideScreenDiff()):visible(not isVS()) end,
				OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#fcff00")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
			}
		}
	},
	Def.ActorFrame{
		OnCommand=function(self) self:draworder(1):sleep(0.5):queuecommand("TweenOn") end,
		OffCommand=function(self) self:queuecommand("Hide") end,
		ShowGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOn") end,
		HideGameplayTopFrameMessageCommand=function(self) self:queuecommand("Hide") end,
		HideCommand=function(self)
			if AnyPlayerFullComboed() then self:sleep(1) end
			self:queuecommand('TweenOff')
		end,
		Def.ActorFrame{
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1) or isVS(),
			Name="Player1",
			OnCommand=function(self) self:x(SCREEN_CENTER_X-240*WideScreenDiff()):y(SCREEN_TOP+27*WideScreenDiff()):zoom(WideScreenDiff()):addx(-SCREEN_WIDTH/2) end,
			TweenOnCommand=function(self) self:sleep(1.5):decelerate(0.5):addx(SCREEN_WIDTH/2) end,
			TweenOffCommand=function(self) self:accelerate(0.8):addx(-SCREEN_WIDTH/2) end,
			Def.Sprite {
				Texture = "_difficulty icons",
				OnCommand=function(self) self:pause():playcommand("Update") end,
				UpdateCommand=function(self)
					local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(PLAYER_1) or GAMESTATE:GetCurrentSteps(PLAYER_1)
					if StepsOrTrail then
						self:visible(true):setstate(DifficultyToState(StepsOrTrail:GetDifficulty()))
					else
						self:visible(false)
					end
				end
			},
			Def.Sprite {
				Texture = "difficulty glow",
				InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):draworder(110) end,
				OnCommand=function(self) self:sleep(2.4):decelerate(0.5):diffusealpha(1):sleep(0.2):decelerate(0.8):diffusealpha(0):sleep(0) end,
				OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2) or isVS(),
			Name="Player2",
			OnCommand=function(self) self:x(SCREEN_CENTER_X+240*WideScreenDiff()):y(SCREEN_TOP+27*WideScreenDiff()):zoom(WideScreenDiff()):addx(SCREEN_WIDTH/2) end,
			TweenOnCommand=function(self) self:sleep(1.5):decelerate(0.5):addx(-SCREEN_WIDTH/2) end,
			TweenOffCommand=function(self) self:accelerate(0.8):addx(SCREEN_WIDTH/2) end,
			Def.Sprite {
				Texture = "_difficulty icons",
				OnCommand=function(self) self:pause():zoomx(-1):playcommand("Update") end,
				UpdateCommand=function(self)
					local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(PLAYER_2) or GAMESTATE:GetCurrentSteps(PLAYER_2)
					if StepsOrTrail then
						self:visible(true):setstate(DifficultyToState(StepsOrTrail:GetDifficulty()))
					else
						self:visible(false)
					end
				end
			},
			Def.Sprite {
				Texture = "difficulty glow",
				InitCommand=function(self) self:zoomx(-1):blend(Blend.Add):diffusealpha(0):draworder(110) end,
				OnCommand=function(self) self:sleep(2.4):decelerate(0.5):diffusealpha(1):sleep(0.2):decelerate(0.8):diffusealpha(0):sleep(0) end,
				OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end
			}
		}
	}
}