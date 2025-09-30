local function InputHandler(event)
	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "Back" or event.GameButton == "Start" then
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			SOUND:PlayOnce(THEME:GetPathS("Common", "Start"), true)
		end
	end
end

return Def.ActorFrame{
	OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback( InputHandler ) end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback( InputHandler ) end,
	Def.Sprite {
		Texture = "test",
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:diffusealpha(0):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.15):diffusealpha(0) end
	}
}