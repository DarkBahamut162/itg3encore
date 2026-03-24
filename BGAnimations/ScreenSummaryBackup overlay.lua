local cur = 0

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end

	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuLeft" then
			cur = cur - 1
			if cur%2 == 0 then c.Cursor:queuecommand("Yes") else c.Cursor:queuecommand("No") end
			SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
		elseif event.GameButton == "MenuRight" then
			cur = cur + 1
			if cur%2 == 0 then c.Cursor:queuecommand("Yes") else c.Cursor:queuecommand("No") end
			SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
		elseif event.GameButton == "Back" then
			cancel = true
			SCREENMAN:GetTopScreen():Cancel()
		elseif event.GameButton == "Start" then
			if cur%2 == 1 then
				if isOutFoxOnline() then
					SCREENMAN:GetTopScreen():SetNextScreenName("ScreenOutFoxOnlineLogin")
				end
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
				SummaryBackupClear()
				SummaryAdjust = 0
				Master = {}
				P1 = {}
				P2 = {}
				SOUND:PlayOnce(THEME:GetPathS("Common","Start"),true)
			else
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
				SOUND:PlayOnce(THEME:GetPathS("Common","Start"),true)
			end
		end
	end
end

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() end,
	OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="Cache",
		Text="The previous session hasn't concluded!\nDo you wanna continue this session or start a new one?\n\nThe previous session has "..SummaryAdjust..(SummaryAdjust == 1 and " song" or " songs"),
		InitCommand=function(self) self:Center():zoom(0.6*WideScreenDiff()):shadowlength(2):cropright(1):maxwidth(SCREEN_WIDTH/0.7/WideScreenDiff()) end,
		OnCommand=function(self) self:decelerate(1):cropright(0) end,
		OffCommand=function(self) self:cropright(1) end,
	},
	Def.Sprite {
		Texture = THEME:GetPathG("ScreenPrompt","Cursor"),
		Name="Cursor",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):queuecommand("Yes") end,
		YesCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3) end,
		NoCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3) end
	},
	Def.BitmapText {
		File = "_r bold 30px",
		Name="YES",
		Text="Load",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()) end,
	},
	Def.BitmapText {
		File = "_r bold 30px",
		Name="NO",
		Text="Reset",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()) end,
	}
}