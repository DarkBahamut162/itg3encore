local player = ...

local optionslist = GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Song")
local sleep = math.max(1,tonumber(LoadFromCache(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player),"TrueFirstSecond"))-1.55)

return Def.ActorFrame{
	OnCommand=function(self) self:sleep(sleep):decelerate(0.5):diffusealpha(0) end,
	LoadFont("Common Normal")..{
		Text=optionslist:gsub(", ","\n"),
		InitCommand=function(self)
			local NoteFieldMiddle = (THEME:GetMetric("Player","ReceptorArrowsYStandard")+THEME:GetMetric("Player","ReceptorArrowsYReverse"))/2
			local mods = string.find(GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
			local reverse = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):UsingReverse()
			if mods then reverse = not reverse end
			local posY = reverse and THEME:GetMetric("Player","ReceptorArrowsYReverse") or THEME:GetMetric("Player","ReceptorArrowsYStandard")
			self:y(SCREEN_CENTER_Y+posY-NoteFieldMiddle):addy(reverse and -30 or 30):valign(reverse and 1 or 0):zoom(0.5):draworder(999):shadowlength(1)
		end
	}
}