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

return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+23*WideScreenDiff()):zoom(WideScreenDiff()):addy(-100) end,
		OnCommand=function(self) self:sleep(0.5):queuecommand("TweenOn") end,
		OffCommand=function(self) self:queuecommand("TweenOff") end,
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end,
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end,
		Def.SongMeterDisplay{
			InitCommand=function(self) self:SetStreamWidth(222) end,
			Stream=Def.Sprite {
				Texture = "meter stream"
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
		OnCommand=function(self) self:addy(-100):sleep(0.5):queuecommand("TweenOn") end,
		OffCommand=function(self) self:queuecommand("TweenOff") end,
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end,
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end,
		Def.Sprite {
			Texture = "width",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-190*WideScreenDiff()):y(SCREEN_TOP+20*WideScreenDiff()):zoom(WideScreenDiff()):halign(1):zoomtowidth(3*WideScreenDiff()) end,
			OnCommand=function(self) self:sleep(1.5):linear(0.1):zoomtowidth(SCREEN_WIDTH/2-200*WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = "width",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+190*WideScreenDiff()):y(SCREEN_TOP+20*WideScreenDiff()):zoom(WideScreenDiff()):halign(0):zoomtowidth(3*WideScreenDiff()) end,
			OnCommand=function(self) self:sleep(1.5):linear(0.1):zoomtowidth(SCREEN_WIDTH/2-200*WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = "left",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-193*WideScreenDiff()):y(SCREEN_TOP+20*WideScreenDiff()):zoom(WideScreenDiff()):halign(1) end,
			OnCommand=function(self) self:sleep(1.5):linear(0.1):x(SCREEN_LEFT+16*WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = "left",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+193*WideScreenDiff()):y(SCREEN_TOP+20*WideScreenDiff()):zoom(WideScreenDiff()):halign(1):zoomx(-1*WideScreenDiff()) end,
			OnCommand=function(self) self:sleep(1.5):linear(0.1):x(SCREEN_RIGHT-16*WideScreenDiff()) end
		},
		Def.ActorFrame{
			TitleSongFade:Create()..{
				InitCommand=function(self) self:CenterX():y(SCREEN_TOP+24*WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
				OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoomy(0):sleep(2):decelerate(0.3):zoomy(0.45*WideScreenDiff()) end,
			}
		},
		Def.BitmapText {
			File = "_r bold 30px",
			InitCommand=function(self) self:visible(not animate):CenterX():y(SCREEN_TOP+24*WideScreenDiff()):maxwidth(420):diffusebottomedge(color("#dedede")) end,
			OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoomy(0):sleep(2):decelerate(0.3):zoomy(0.45*WideScreenDiff()):animate(0):playcommand("Update") end,
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self)
				local text = ""
				local song = GAMESTATE:GetCurrentSong()
				if song then text = song:GetDisplayFullTitle() end
				if animate then TitleSongFade:SetText( text ) end
				self:settext(text)
			end
		},
		Def.Sprite {
			Texture = "_base normal",
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+19*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = "_base bpm",
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+59*WideScreenDiff()):zoom(WideScreenDiff()):visible(not isVS()) end
		},
		Def.Sprite {
			Texture = "_neons top",
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+20*WideScreenDiff()):zoom(WideScreenDiff()):blend(Blend.Add) end,
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#007892")):effectcolor2(color("#00EAFF")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
		},
		Def.Sprite {
			Texture = "_neons top",
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+20*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#82f5ff")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
		},
		Def.Sprite {
			Texture = "_neons bottom",
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+39*WideScreenDiff()):zoom(WideScreenDiff()):blend(Blend.Add):visible(not isVS()) end,
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#007892")):effectcolor2(color("#00EAFF")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
		},
		Def.Sprite {
			Texture = "_neons bottom",
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+39*WideScreenDiff()):zoom(WideScreenDiff()):visible(not isVS()) end,
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#82f5ff")):effectperiod(0.5):effect_hold_at_full(0.5):diffusealpha(0):linear(0.4):diffusealpha(1) end
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
			OnCommand=function(self) self:x(SCREEN_CENTER_X-230*WideScreenDiff()):y(SCREEN_TOP+27*WideScreenDiff()):zoom(WideScreenDiff()):addx(-SCREEN_WIDTH/2) end,
			TweenOnCommand=function(self) self:sleep(1.5):decelerate(0.5):addx(SCREEN_WIDTH/2) end,
			TweenOffCommand=function(self) self:accelerate(0.8):addx(-SCREEN_WIDTH/2) end,
			Def.Sprite {
				Texture = "_difficulty icons",
				InitCommand=function(self) self:pause():playcommand("Update") end,
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
			OnCommand=function(self) self:x(SCREEN_CENTER_X+230*WideScreenDiff()):y(SCREEN_TOP+27*WideScreenDiff()):zoom(WideScreenDiff()):addx(SCREEN_WIDTH/2) end,
			TweenOnCommand=function(self) self:sleep(1.5):decelerate(0.5):addx(-SCREEN_WIDTH/2) end,
			TweenOffCommand=function(self) self:accelerate(0.8):addx(SCREEN_WIDTH/2) end,
			Def.Sprite {
				Texture = "_difficulty icons",
				InitCommand=function(self) self:pause():zoomx(-1):playcommand("Update") end,
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