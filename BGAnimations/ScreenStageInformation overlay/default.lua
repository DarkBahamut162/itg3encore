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

local t = Def.ActorFrame{
	InitCommand=function(self)
		-- reset beginner stage
	end;

	Def.ActorFrame{
		Name="StageText";
		InitCommand=function(self) self:CenterX() end;
		Def.ActorFrame{
			Name="Main";
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+60) end;
			LoadActor(THEME:GetPathG("_gameplay","stage "..curStage))..{
				InitCommand=function(self) self:horizalign(center):cropright(1.3) end;
				OnCommand=function(self) self:sleep(.22):linear(1):cropright(-0.3) end;
			};
			LoadActor(THEME:GetPathG("_white","gameplay stage "..curStage))..{
				InitCommand=function(self) self:horizalign(center):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1) end;
				OnCommand=function(self) self:sleep(.22):linear(1):cropleft(1):cropright(-0.3) end;
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

	-- courses

	LoadActor("blueflare.png")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+12.5):blend(Blend.Add):draworder(115) end;
		OnCommand=function(self) self:zoomx(15):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4):linear(1):zoomtoheight(0):diffusealpha(.0) end;
	};
	LoadActor(THEME:GetPathS("","_ok"))..{
		OnCommand=function(self) self:play() end;
	};
};

return t;