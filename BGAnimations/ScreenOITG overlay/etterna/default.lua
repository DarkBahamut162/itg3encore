return Def.ActorFrame{
	InitCommand=function(self) self:fov(70) end,
	Def.Sprite {
		Texture = THEME:GetPathB("","_thanks/_etterna/text"),
		OnCommand=function(self) self:x(120):zoomto(440,83) end
	},
	Def.BitmapText {
		File = "_v profile",
		Text="Powered by",
		InitCommand=function(self) self:x(-101):y(-69):halign(0):shadowlength(2) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end
	},
	Def.BitmapText {
		File = "_v 26px bold shadow",
		Text="https://projectoutfox.com/",
		InitCommand=function(self) self:x(23):y(69):shadowlength(2):zoom(0.75) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end
	}
}