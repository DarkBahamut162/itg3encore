if isOutFoxV(20231017) and not PREFSMAN:GetPreference("GimmickMode") then
	PREFSMAN:SetPreference("GimmickMode", 1)
	GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
end

if isOutFoxV() and PREFSMAN:PreferenceExists("KeySoundMode") then
	local KeySoundMode = PREFSMAN:GetPreference("KeySoundMode")
	if KeySoundMode ~= "Auto" then PREFSMAN:SetPreference("KeySoundMode", "Auto") end
end

if isOldStepMania() and not VersionDateCheck(20160000) then
	local IgnoredDialogs = PREFSMAN:GetPreference("IgnoredDialogs")
	if not string.find(IgnoredDialogs,"LUA_ERROR") then
		IgnoredDialogs = addToOutput(IgnoredDialogs,"LUA_ERROR",",")
		PREFSMAN:SetPreference("IgnoredDialogs", IgnoredDialogs)
		GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
	end
end

if isOldStepMania() or isStepMania(20250000) or (isITGmania() and not VersionDateCheck(20240507)) or (not isEtterna("0.71")) then
	local IgnoredDialogs = PREFSMAN:GetPreference("IgnoredDialogs")
	if not string.find(IgnoredDialogs,"FRAME_DIMENSIONS_WARNING") then
		IgnoredDialogs = addToOutput(IgnoredDialogs,"FRAME_DIMENSIONS_WARNING",",")
		PREFSMAN:SetPreference("IgnoredDialogs", IgnoredDialogs)
		GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
	end
end

if isOutFox(20220900) and not isOutFox(20230400) then
	if "glad" == string.lower(split(',',PREFSMAN:GetPreference('VideoRenderers'))[1]) then
		SCREENMAN:SystemMessage("Please switch your VideoRenderer!\nGLAD is bugged in this version of OutFox!")
	end
end

if isITGmania() then
	if string.find(PREFSMAN:GetPreference("HttpAllowHosts"),"api.github.com") and CheckVersion=="????????" then
		NETWORK:HttpRequest{
			url="https://api.github.com/repos/DarkBahamut162/itg3encore/commits/master",
			headers=headers,
			connectTimeout=3,
			transferTimeout=10,
			onResponse=function(response)
				local json = JsonDecode(response.body)
				local date = json.commit.author.date
				local TZ = split(" ",json.commit.verification.payload)
				for value in ivalues(TZ) do
					if value:sub(1,1) == "+" or value:sub(1,1) == "-" then TimeZone = value:sub(1,5) break end
				end

				CheckVersion = date:gsub('[-:Z]+',''):gsub('[T]+',' ')
			end
		}
	end
end

return Def.ActorFrame{
	Def.Sprite {
		Texture="roxor video",
		Condition=not isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture="bga",
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture="particle",
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen():blend(Blend.Add) end
	},
	Def.Sprite {
		Texture="roxor logo",
		Condition=isFinal(),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):zoomtowidth(SCREEN_WIDTH/5*4):zoomtoheight(SCREEN_HEIGHT/2) end
	}
}