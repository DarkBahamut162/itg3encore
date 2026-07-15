return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _Custom NormalPart"..(isFinal() and "Final" or "Normal")
	},
	LoadFont("Common Normal") .. {
		Name="Text",
		InitCommand=function(self) self:x(96):zoom(0.6):halign(1):maxwidth(WideScaleFixed(SCREEN_WIDTH/2.1,SCREEN_WIDTH/1.85)/WideScreenDiff_(16/10)):shadowlength(2) end,
		SetMessageCommand=function(self,params)
			if params.Label then self:settext(params.Label) elseif params.Text then self:settext(params.Text) end
		end
	}
}