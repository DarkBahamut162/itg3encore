local player = ...
assert(player,"[Graphics/_pane icons] player required")
function avatarCheck()
	if hasAvatar(player) then
		return getAvatar(player)
	elseif hasSLAvatar(player) then
		return getSLAvatar(player)
	else
		return THEME:GetPathG("UserProfile","generic icon")
	end
end
local avatar = avatarCheck()

return Def.ActorFrame{
	InitCommand=function(self) self:y(ThemePrefs.Get("ShowStepCounter") and 3 or -1):visible(IsUsingWideScreen() and (hasAvatar(player) or hasSLAvatar(player))) end,
	OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH):decelerate(0.75):addx(player == PLAYER_2 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	ForceUpdateMessageCommand=function(self) self:visible(IsUsingWideScreen() and (hasAvatar(player) or hasSLAvatar(player))) end,
	Def.Sprite{
		InitCommand=function(self) self:xy(player == PLAYER_1 and -96 or 96,110):Load(avatar):setsize(58,58) end,
		ForceUpdateMessageCommand=function(self)
			if hasAvatar(player) then
				avatar = getAvatar(player)
			elseif hasSLAvatar(player) then
				avatar = getSLAvatar(player)
			else
				avatar = THEME:GetPathG("UserProfile","generic icon")
			end
			self:Load(avatar):setsize(58,58)
		end
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = "border "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:xy(player == PLAYER_1 and -96 or 96,110):shadowlength(1):zoom(0.8) end
		}
	}
}