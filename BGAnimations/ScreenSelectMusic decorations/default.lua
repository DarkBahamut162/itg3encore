local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFile("BannerReflection","BannerReflection");
t[#t+1] = StandardDecorationFromFile("Triangle","Triangle");

-- stepsdisplay
local function StepsDisplay(pn)
	local function set(self, player) self:SetFromGameState(player); end

	local t = Def.StepsDisplay {
		InitCommand=function(self) self:player(pn):Load("StepsDisplay",GAMESTATE:GetPlayerState(pn)) end;
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			self:visible(song ~= nil)
		end;
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn); end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn); end;
	end

	return t;
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "StepsDisplay" .. PlayerNumberToString(pn);
	t[#t+1] = StepsDisplay(pn) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end


t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathG('ScreenSelectMusic','BannerFrame'));
	StandardDecorationFromFile("ArtistDisplay","ArtistDisplay");
	StandardDecorationFromFile("BPMDisplay","BPMDisplay");
	StandardDecorationFromFileOptional("SongTime","SongTime");
	StandardDecorationFromFileOptional("StepsDisplayList","StepsDisplayList");
	StandardDecorationFromFileOptional("CourseContentsList","CourseContentsList");
};

return t;