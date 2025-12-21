function MemoryCheck()
	if isEtterna("0.55") then return false else return GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() end
end

local preload = GAMESTATE:GetCoinMode()=='CoinMode_Home' and IsAutoStyle() or (IsAutoPlayMode(true) and IsAutoStyle())
SetAllowLateJoin(false)

return Def.ActorFrame{
	OffCommand=function()
		local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
		SetCategory(category)
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			if ThemePrefs.Get("ExperimentalProfileLevel") then LoadData(pn) MESSAGEMAN:Broadcast("EnablePlayerStats",{PLAYER=pn}) end
			LoadFlare(pn)
		end
		InitRotationOptions()
		InitPlayerOptions()
	end,
	Def.Quad{
		InitCommand=function(self)
			if preload then
				self:Center():diffuse(color("0,0,0,1")):valign(0):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):linear(0.5):y(SCREEN_CENTER_Y+60*0.68*WideScreenDiff())
			else
				self:CenterX():y(SCREEN_CENTER_Y+60*0.68*WideScreenDiff()):valign(0):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT)
			end
		end
	},
	Def.Quad{
		InitCommand=function(self)
			if preload then
				self:Center():diffuse(color("0,0,0,1")):valign(1):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):linear(0.5):y(SCREEN_CENTER_Y-60*0.68*WideScreenDiff())
			else
				self:CenterX():y(SCREEN_CENTER_Y-60*0.68*WideScreenDiff()):valign(1):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT)
			end
		end
	},
	loadfile(THEME:GetPathB("_statsout","style"))(),
	Def.ActorFrame{
		Condition=MemoryCheck(),
		Def.Sprite {
			Texture = THEME:GetPathG("","profile "..(isFinal() and "final" or "normal")),
			InitCommand=function(self)
				if preload then
					self:Center():zoomx(SCREEN_WIDTH):zoomy(0):linear(0.5):zoomy(0.68*WideScreenDiff())
				else
					self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff())
				end
			end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Text="LOADING USB PROFILES...",
			InitCommand=function(self)
				if preload then
					self:Center():zoom(0.7*WideScreenDiff()):cropright(1.3):faderight(0.1):sleep(0.25):linear(0.7):cropright(-0.3)
				else
					self:Center():zoom(0.7*WideScreenDiff())
				end
			end
		},
		Def.ActorFrame{
			Condition=preload,
			Def.Sprite {
				Texture = THEME:GetPathG("","redflare"),
				InitCommand=function(self) self:draworder(115):blend(Blend.Add):Center():zoomx(15*WideScreenDiff()):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4/WideScreenDiff()) end,
				OnCommand=function(self) self:decelerate(0.9):zoomtoheight(0):diffusealpha(0.5) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("","redflare"),
				InitCommand=function(self) self:draworder(115):blend(Blend.Add):Center():zoomx(15*WideScreenDiff()):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4/WideScreenDiff()) end,
				OnCommand=function(self) self:decelerate(0.9):zoomtoheight(0):diffusealpha(0.5) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("","_flare"),
				InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+10*WideScreenDiff()):CenterY():zoom(1.7*WideScreenDiff()) end,
				OnCommand=function(self) self:linear(1.6):rotationz(460):zoom(0) end
			}
		}
	},
	Def.ActorFrame{
		Condition=not MemoryCheck(),
		Def.Sprite {
			Texture = THEME:GetPathG("","lolhi "..(isFinal() and "final" or "normal")),
			InitCommand=function(self)
				if preload then
					self:Center():zoomx(SCREEN_WIDTH):zoomy(0):linear(0.5):zoomy(0.68*WideScreenDiff())
				else
					self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff())
				end
			end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Text="LOADING...",
			InitCommand=function(self)
				if preload then
					self:Center():zoom(0.7*WideScreenDiff()):cropright(1.3):faderight(0.1):sleep(0.25):linear(0.7):cropright(-0.3)
				else
					self:Center():zoom(0.7*WideScreenDiff())
				end
			end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("","_disk "..(isFinal() and "final" or "normal")),
			InitCommand=function(self)
				if preload then
					self:x(SCREEN_CENTER_X-120*WideScreenDiff()):CenterY():zoom(WideScreenDiff()):rotationz(-460):linear(1.6):rotationz(0):linear(0.5):zoom(0):rotationz(360)
				else
					self:x(SCREEN_CENTER_X-120*WideScreenDiff()):CenterY():zoom(WideScreenDiff()):linear(0.5):zoom(0):rotationz(360)
				end
			end
		},
		Def.ActorFrame{
			Condition=preload,
			Def.Sprite {
				Texture = THEME:GetPathG("","blueflare"),
				InitCommand=function(self) self:draworder(115):blend(Blend.Add):Center():zoomx(15*WideScreenDiff()):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4/WideScreenDiff()) end,
				OnCommand=function(self) self:decelerate(0.9):zoomtoheight(0):diffusealpha(0.5) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("","_flare"),
				InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X-120*WideScreenDiff()):CenterY():zoom(0.5*WideScreenDiff()) end,
				OnCommand=function(self) self:linear(1.6):rotationz(460):zoom(0) end
			}
		}
	},
	Def.Actor{
		BeginCommand=function(self)
			if preload then self:sleep(1.6) end
			if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1.5) else self:sleep(0.5) end
			self:queuecommand("Load")
		end,
		LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end
	}
}