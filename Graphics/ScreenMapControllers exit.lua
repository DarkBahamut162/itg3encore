local totalLines = 0
local currentLine = 0
local threshold = 0

return Def.ActorFrame{
	InitCommand=function(self) self:y(-77*WideScreenDiff()) end,
	OnCommand=function(self)
		local scroller = SCREENMAN:GetTopScreen():GetChild("LineScroller")
		totalLines = #scroller:GetChild("Line") + 1
		threshold = totalLines - 7
		self:ztest(false):diffusealpha(0)
	end,
	MapControllersFocusChangedMessageCommand=function(self, params)
		if currentLine ~= params.bmt:GetParent().ItemIndex then
			if currentLine < threshold and params.bmt:GetParent().ItemIndex >= threshold then
				self:stoptweening():accelerate(0.1):diffusealpha(1)
			elseif currentLine >= threshold and params.bmt:GetParent().ItemIndex < threshold then
				self:stoptweening():decelerate(0.1):diffusealpha(0)
			end
			currentLine = params.bmt:GetParent().ItemIndex
		end
	end,
	Def.Sprite {
		Texture = THEME:GetPathG("ScreenOptions","more/moreexit"),
		Text="Exit",
		InitCommand=function(self) self:CenterX():y(-10*WideScreenDiff()):zoom(WideScreenDiff()):croptop(0.57):cropbottom(0.1):diffuse(color("0.5,0.5,0.5,1")) end,
		OnCommand=function(self) self:diffusealpha(0):decelerate(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():accelerate(0.3):diffusealpha(0):queuecommand("Hide") end,
		HideCommand=function(self) self:visible(false) end,
		GainFocusCommand=function(self) self:linear(0.2):diffuse(color("1,1,1,1")) end,
		LoseFocusCommand=function(self) self:stoptweening():linear(0.2):diffuse(color("0.5,0.5,0.5,1")) end
	},
	Def.ActorFrame{
		Name="Triangles",
		InitCommand=function(self) self:CenterX():y(6*WideScreenDiff()):zoom(WideScreenDiff()) end,
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenOptions","more/_triangle "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:zoom(0.5):blend(Blend.Add):x(-38*WideScreenSemiDiff()):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(1):effectoffset(0):effectclock("beat") end,
			GainFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(-90) end,
			LoseFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenOptions","more/_triangle "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:zoom(0.5):blend(Blend.Add):x(38*WideScreenSemiDiff()):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(1):effectoffset(0):effectclock("beat") end,
			GainFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(90) end,
			LoseFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(0) end
		}
	}
}