local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end
	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "Back" or event.GameButton == "Select" or event.GameButton == "Start" then
			SCREENMAN:GetTopScreen():Cancel()
        end
	end
end

return Def.ActorFrame{
	Def.BitmapText {
		File = "_z 36px shadowx",
		InitCommand=function(self) self:Center():zoom(0.6*WideScreenDiff()):shadowlength(2):maxwidth(SCREEN_WIDTH/0.7/WideScreenDiff()) end,
		OnCommand=function(self)
            SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
            local valid, allChecksValid = ValidForGrooveStats()
            local output = ""
            if not allChecksValid then
                for i,error in pairs(valid) do
                    if not error then
                        output = addToOutput(output,THEME:GetString("ScreenEvaluation","QRInvalidScore"..i),"\n")
                    end
                end
                self:settext("GrooveStats\nIssues Detected!\n\n"..output):diffuse(color("#FF0000"))
            else
                self:settext("GrooveStats\nNo Issues Detected!"):diffuse(color("#00FF00"))
            end
        end,
		OffCommand=function(self)
            SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler)
        end
	}
}