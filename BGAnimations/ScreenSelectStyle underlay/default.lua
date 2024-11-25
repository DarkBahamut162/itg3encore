local c
local selectState = false
local styles = ChoiceSingle()
local currentStylePosition = GetUserPrefN("StylePosition")
local currentBattleMode = getenv("BattleMode")
local screenName = Var "LoadingScreen" or "ScreenSelectStyle" 
local enableUD = screenName == "ScreenSelectNumPlayers"
local output = enableUD and "Current Style: "..StyleName()[currentStylePosition].." | Battle Mode: "..string.gsub(" "..currentBattleMode, "%W%l", string.upper):sub(2) or "Current Style: "..StyleName()[currentStylePosition]

for player in ivalues(PlayerNumber) do
	SCREENMAN:set_input_redirected(player, false)
end

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end

	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuLeft" and selectState then
			if styles and #styles > 1 then
				if currentStylePosition == 1 then
					SetUserPref("StylePosition",#styles)
				else
					SetUserPref("StylePosition",currentStylePosition-1)
				end
				SCREENMAN:GetTopScreen():SetNextScreenName(screenName)
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			end
		elseif event.GameButton == "MenuRight" and selectState then
			if styles and #styles > 1 then
				if currentStylePosition == #styles then
					SetUserPref("StylePosition",1)
				else
					SetUserPref("StylePosition",currentStylePosition+1)
				end
				SCREENMAN:GetTopScreen():SetNextScreenName(screenName)
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			end
		elseif (event.GameButton == "MenuUp" or event.GameButton == "MenuDown") and selectState and enableUD then
			if currentBattleMode == "rave" then
				setenv("BattleMode","battle")
			else
				setenv("BattleMode","rave")
			end
			SCREENMAN:GetTopScreen():SetNextScreenName(screenName)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		elseif event.GameButton == "Select" and not selectState then
			for player in ivalues(PlayerNumber) do
				SCREENMAN:set_input_redirected(player, true)
			end
			SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "opened" ) )
			selectState = true
			c.Left:linear(0.125):diffusealpha(1)
			c.Right:linear(0.125):diffusealpha(1)
		end
	elseif event.type == "InputEventType_Release" and event.GameButton == "Select" and selectState then
		for player in ivalues(PlayerNumber) do
			SCREENMAN:set_input_redirected(player, false)
		end
		SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "closed" ) )
		selectState = false
		c.Left:linear(0.125):diffusealpha(0)
		c.Right:linear(0.125):diffusealpha(0)
	end
end

return Def.ActorFrame{
	BeginCommand = function(self)
		c = self:GetChildren()
		c.Left:addx((-c.Center:GetWidth()/4-8)*WideScreenDiff())
		c.Right:addx((c.Center:GetWidth()/4+8)*WideScreenDiff())
	end,
	OnCommand=function(self)
		if styles and #styles > 1 or enableUD then SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end
		if isOutFox() then GAMESTATE:UpdateDiscordScreenInfo("Selecting Style","",1) end
	end,
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))(),
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+100*WideScreenSemiDiff()):y(SCREEN_CENTER_Y+13*WideScreenSemiDiff()):z(-100):zoom(1.3*WideScreenDiff()) end,
		Def.Sprite {
			Texture = "char",
			InitCommand=function(self) self:zoom(0.5):glow(color("1,1,1,0")):diffusealpha(0):linear(0.3):glow(color("1,1,1,1")):sleep(0.001):diffusealpha(1):linear(0.3):glow(color("1,1,1,0")) end,
			MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
			MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
			GoOffCommand=function(self) self:sleep(0.2):linear(0.3):diffusealpha(0) end
		}
	},
	Def.Sprite {
		Texture = THEME:GetPathG("explanation","frame"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X+100*((WideScreenDiff()+WideScreenSemiDiff())/2)):y(SCREEN_CENTER_Y+130):zoom(WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:linear(0.5):diffusealpha(1.0) end,
		MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
		MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
		GoOffCommand=function(self) self:sleep(0.2):linear(0.3):diffusealpha(0) end
	},
	loadfile(THEME:GetPathB("_shared","underlay arrows"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/fore"))(),
	Def.BitmapText {
		File = "_v 26px bold shadow",
		Name="Center",
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-160*WideScreenDiff()):zoom(0.5*WideScreenDiff()):cropleft(0.5):cropright(0.5):settext(output) end,
		OnCommand=function(self) self:decelerate(0.5):cropleft(0):cropright(0) end,
		OffCommand=function(self) self:accelerate(0.5):cropleft(0.5):cropright(0.5) end
	},
	Def.BitmapText {
		File = "_v 26px bold shadow",
		Name="Left",
		Text="&MENULEFT;",
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-160*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(0) end,
		OffCommand=function(self) self:linear(0.125):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_v 26px bold shadow",
		Name="Right",
		Text="&MENURIGHT;",
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-160*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(0) end,
		OffCommand=function(self) self:linear(0.125):diffusealpha(0) end
	}
}