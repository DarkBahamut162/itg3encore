local stageRemap = {
	Stage_1st	= 1, Stage_2nd	= 2, Stage_3rd	= 3,
	Stage_4th	= 4, Stage_5th	= 5, Stage_6th	= 6
}
local curStage = GAMESTATE:GetCurrentStage()
local songsPerPlay = PREFSMAN:GetPreference("SongsPerPlay")
if stageRemap[curStage] == songsPerPlay then
	curStage = 'Stage_Final'
end
if GAMESTATE:IsEventMode() then curStage = 'Stage_Event' end

curStage = ToEnumShortString(curStage)

-- Force noteskin to be applied here ~DarkBahamut162
if GAMESTATE:GetPlayMode() == "PlayMode_Oni" then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local noteskin = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):NoteSkin();
		GAMESTATE:ApplyGameCommand('mod,'..noteskin,pn);
	end
end

--Force turn off StatsDisplayPX if inside a course with secret songs
if getenv("StatsDisplayP1") or getenv("StatsDisplayP2") then
	if GAMESTATE:IsCourseMode() then
		if IsCourseSecret() then
			setenv("StatsDisplayP1",false);
			setenv("StatsDisplayP2",false);
		end
	end
end

--Force turn off ShowModsPX if turned on before but denied after
if getenv("ShowModsP1") or getenv("ShowModsP2") then
	if not GAMESTATE:IsCourseMode() then
		if not HasLuaCheck() then
			setenv("ShowModsP1",false);
			setenv("ShowModsP2",false);
		end
	end
end

local t = Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black) end;
	};
	LoadActor("top");
	LoadActor("bottom");
	LoadActor("highlight")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+5):y(SCREEN_CENTER_Y+60) end;
		OnCommand=function(self) self:diffusealpha(0):decelerate(0.2):diffusealpha(1) end;
	};

	Def.ActorFrame{
		Name="P1Frame";
		InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)) end;
		LoadActor("_left gradient")..{ InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+150):halign(0) end; };
		LoadActor("_p1")..{ InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+150):halign(0) end; };
		LoadFont("_r bold 30px")..{
			Text="Step Artist:";
			InitCommand=function(self) self:x(SCREEN_LEFT+5):y(SCREEN_CENTER_Y+172):zoom(0.6):halign(0):shadowlength(2) end;
			BeginCommand=function(self)
				local pm = GAMESTATE:GetPlayMode()
				local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
				self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and show)
			end;
		};
		LoadFont("_r bold 30px")..{
			Name="AuthorText";
			InitCommand=function(self) self:x(SCREEN_LEFT+100):y(SCREEN_CENTER_Y+172):shadowlength(2):halign(0):zoom(0.6) end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local text
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					if steps then
						text = steps:GetAuthorCredit()
					else
						text = ""
					end
				else
					text = ""
				end
				self:settext(text)
			end;
			OnCommand=function(self) self:playcommand("Set") end;
		};
		LoadFont("_r bold 30px")..{
			Name="PlayerName";
			InitCommand=function(self) self:x(SCREEN_LEFT+44):y(SCREEN_CENTER_Y+142):shadowlength(2):halign(0):zoom(0.8) end;
			SetCommand=function(self)
				self:settext( PROFILEMAN:GetPlayerName(PLAYER_1) )
			end;
			OnCommand=function(self) self:playcommand("Set") end;
		};
	};
	Def.ActorFrame{
		Name="P2Frame";
		InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2)) end;
		LoadActor("_right gradient")..{ InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+150):halign(1) end; };
		LoadActor("_p2")..{ InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+150):halign(1) end; };
		LoadFont("_r bold 30px")..{
			Text=":Step Artist";
			InitCommand=function(self) self:x(SCREEN_RIGHT-5):y(SCREEN_CENTER_Y+172):zoom(0.6):halign(1):shadowlength(2) end;
			BeginCommand=function(self)
				local pm = GAMESTATE:GetPlayMode()
				local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
				self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and show)
			end;
		};
		LoadFont("_r bold 30px")..{
			Name="AuthorText";
			InitCommand=function(self) self:x(SCREEN_RIGHT-100):y(SCREEN_CENTER_Y+172):shadowlength(2):halign(1):zoom(0.6) end;
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local text
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if steps then
						text = steps:GetAuthorCredit()
					else
						text = ""
					end
				else
					text = ""
				end
				self:settext(text)
			end;
			OnCommand=function(self) self:playcommand("Set") end;
		};
		LoadFont("_r bold 30px")..{
			Name="PlayerName";
			InitCommand=function(self) self:x(SCREEN_RIGHT-44):y(SCREEN_CENTER_Y+142):shadowlength(2):halign(1):zoom(0.8) end;
			SetCommand=function(self)
				self:settext( PROFILEMAN:GetPlayerName(PLAYER_2) )
			end;
			OnCommand=function(self) self:playcommand("Set") end;
		};
	};

	Def.ActorFrame{
		Name="StageText";
		Condition=not GAMESTATE:IsCourseMode() and not (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/Training1/'));
		InitCommand=function(self) self:CenterX() end;
		Def.ActorFrame{
			Name="Main";
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+60) end;
			LoadActor(THEME:GetPathG("_gameplay","stage "..curStage))..{
				InitCommand=function(self) self:horizalign(center):cropright(1.3) end;
				OnCommand=function(self) self:sleep(0.22):linear(1):cropright(-0.3) end;
			};
			LoadActor(THEME:GetPathG("_white","gameplay stage "..curStage))..{
				InitCommand=function(self) self:horizalign(center):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end;
				OnCommand=function(self) self:sleep(0.22):linear(1):cropleft(1):cropright(-0.3) end;
			};
		};
		Def.ActorFrame{
			Name="Reflect";
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+86) end;
			LoadActor(THEME:GetPathG("_gameplay","stage "..curStage))..{
				InitCommand=function(self) self:horizalign(center):rotationz(180):zoomx(-1):diffusealpha(0.6):fadetop(2):cropright(1.3) end;
				OnCommand=function(self) self:linear(1.225):cropright(-0.3) end;
			};
		};
	};

	-- tutorial
		Def.ActorFrame{
			Name="Tutorial";
			InitCommand=function(self) self:CenterX() end;
			Condition=not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/Training1/');
			LoadFont("_big blue glow")..{
				Text="Welcome to the::tutorial program";
				OnCommand=function(self) self:y(SCREEN_CENTER_Y-112):diffusealpha(0):zoom(4):sleep(0.0):linear(0.3):diffusealpha(1):zoom(1) end;
			};
		};

	-- courses
	Def.ActorFrame{
		Name="CourseText";
		Condition=GAMESTATE:IsCourseMode();
		InitCommand=function(self) self:CenterX() end;
		Def.ActorFrame{
			Name="Main";
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+60) end;
			LoadActor(THEME:GetPathG("_gameplay","course song 1"))..{
				InitCommand=function(self) self:horizalign(center):cropright(1.3) end;
				OnCommand=function(self) self:sleep(0.07):linear(1):cropright(-0.3) end;
			};
			LoadActor(THEME:GetPathG("_white","gameplay course song 1"))..{
				InitCommand=function(self) self:horizalign(center):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end;
				OnCommand=function(self) self:sleep(0.07):linear(1):cropleft(1):cropright(-0.3) end;
			};
		};
		Def.ActorFrame{
			Name="Reflect";
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+86) end;
			LoadActor(THEME:GetPathG("_gameplay","course song 1"))..{
				InitCommand=function(self) self:horizalign(center):rotationz(180):zoomx(-1):diffusealpha(0.6):fadetop(2):cropright(1.3) end;
				OnCommand=function(self) self:linear(1.225):cropright(-0.3) end;
			};
		};
	};

	LoadActor("blueflare")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+12.5):blend(Blend.Add):draworder(115) end;
		OnCommand=function(self) self:zoomx(15):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4):linear(1):zoomtoheight(0):diffusealpha(0.0) end;
	};
	LoadActor("shot")..{
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end;
		OnCommand=function(self) self:CenterY():zoomx(-2):zoomy(4):diffusealpha(1):CenterX():linear(0.9):diffusealpha(0):zoomy(0):x(SCREEN_CENTER_X-250) end;
	};
	LoadActor("shot")..{
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end;
		OnCommand=function(self) self:CenterY():zoomx(2):zoomy(4):diffusealpha(1):CenterX():linear(0.9):diffusealpha(0):zoomy(0):x(SCREEN_CENTER_X+250) end;
	};
};

return t;