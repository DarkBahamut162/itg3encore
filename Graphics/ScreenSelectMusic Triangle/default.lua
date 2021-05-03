local t = Def.ActorFrame{
	LoadActor("glow")..{
		InitCommand=cmd(diffusealpha,0;);
		OnCommand=cmd(sleep,0.1;linear,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("#00FFFF");effectcolor2,color("#0000CC");effectclock,"beat");
		OffCommand=cmd(stoptweening;decelerate,0.3;diffusealpha,0);
		CurrentSongChangedMessageCommand=cmd(stoptweening;linear,0.15;x,10;decelerate,0.3;x,0);
	};
	LoadActor("wheel cursor normal")..{
		InitCommand=cmd(diffusealpha,0;);
		OnCommand=cmd(sleep,0.1;linear,0.3;diffusealpha,1);
		OffCommand=cmd(stoptweening;decelerate,0.3;diffusealpha,0);
		CurrentSongChangedMessageCommand=cmd(stoptweening;linear,0.15;x,10;decelerate,0.3;x,0);
	};
	LoadActor("outline")..{
		InitCommand=cmd(diffusealpha,0;blend,Blend.Add);
		OffCommand=cmd(stoptweening;decelerate,0.3;diffusealpha,0);
		-- original version
		RefreshCommand=cmd(stoptweening;linear,.1;diffusealpha,0;sleep,.2;diffusealpha,1;cropright,-0.3;cropleft,1.1;fadeleft,.05;faderight,.05;diffusealpha,1;linear,0.72;cropright,1;cropleft,-0.3;);
		CurrentSongChangedMessageCommand=cmd(diffusealpha,0;stoptweening;playcommand,"Refresh");

		-- freem's version
		--[[
		NextSongMessageCommand=cmd(diffusealpha,0;stoptweening;playcommand,"GoRight");
		PreviousSongMessageCommand=cmd(diffusealpha,0;stoptweening;playcommand,"GoLeft");
		GoLeftCommand=cmd(stoptweening;linear,.1;diffusealpha,0;sleep,.2;diffusealpha,1;cropright,-0.3;cropleft,1.1;fadeleft,.05;faderight,.05;diffusealpha,1;linear,0.72;cropright,1;cropleft,-0.3;);
		GoRightCommand=cmd(stoptweening;linear,.1;diffusealpha,0;sleep,.2;diffusealpha,1;cropleft,-0.3;cropright,1.1;faderight,.05;fadeleft,.05;diffusealpha,1;linear,0.72;cropleft,1;cropright,-0.3;);
		--]]
	};
};

return t;