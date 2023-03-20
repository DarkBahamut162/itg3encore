return Def.BitmapText {
	Text="Move Joystick Axis or Midi Input",
	Font="Common Normal",
	OnCommand=function(self) self:Center():zoom(WideScreenDiff()) end,
	AnalogInputMessageCommand=function(self,Params)
		if Params.Value > 0.01 or Params.Value < -0.01 then
			self:settext("Device: "..Params.Device.."\nButton"..Params.Button.."\nValue:"..Params.Value)
		else
			self:settext("Move Joystick Axis or Midi Input")
		end
	end
}