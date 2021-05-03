return Def.ActorFrame{
	OnCommand=function(self)
		-- custom trickery
	end;
	LoadActor(THEME:GetPathS("","_logo"))..{ OnCommand=cmd(play); };
	LoadActor(THEME:GetPathB("_fade in","normal"));
};