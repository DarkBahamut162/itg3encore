return Def.ActorFrame{
	OnCommand=function(self)
		-- custom trickery
	end;
	LoadActor(THEME:GetPathS("","_logo"))..{ OnCommand=function(self) self:play() end; };
	LoadActor(THEME:GetPathB("_fade in","normal"));
};