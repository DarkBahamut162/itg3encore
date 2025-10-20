local numPlayers = GAMESTATE:GetNumPlayersEnabled()
local player = numPlayers == 1 and {GAMESTATE:GetMasterPlayerNumber()} or GAMESTATE:GetEnabledPlayers()
local tChild

local t = Def.ActorFrame{
	InitCommand=function(self) tChild = self:GetChildren() self:y(-SCREEN_CENTER_Y) end,
	PlayerStateSetCommand= function(self,param)
		if numPlayers > 1 then
			tChild[pname(OtherPlayer[param.PlayerNumber])]:RemoveAllChildren()
		end
	end
}

for pn in ivalues(player) do
	local NMcheck,NMs = CheckNullMeasure(GAMESTATE:GetCurrentSteps(pn))
	t[#t+1] = Def.ActorFrame{
		Name=pname(pn),
		loadfile(THEME:GetPathG("NoteField","Board Front/ScreenFilter"))(pn),
		loadfile(THEME:GetPathG("NoteField","Board Front/danger"))(pn)..{ Condition=not isOni() and PREFSMAN:GetPreference("ShowDanger") },
		loadfile(THEME:GetPathG("NoteField","Board Front/dead"))(pn),
		loadfile(THEME:GetPathG("NoteField","Board Front/NullMeasure"))(pn,NMs)..{ Condition=NMcheck and not isOutFoxV043() }
	}
end

return t