local t = Def.ActorFrame{
	InitCommand=function(self) self:runcommandsonleaves(function(child) child:ztest(true) end) end;
	LoadActor("_song frame");

	Def.Banner{
		InitCommand=function(self) self:x(-276):halign(0):scaletoclipped(128,40):diffusealpha(0.5):fadeleft(0.25):faderight(0.25) end;
		SetCommand=function(self, params)
			if params.Song then
				self:LoadFromSong( params.Song );
			end
		end;
	};
	LoadFont("_v 26px bold diffuse")..{
		--maxwidth,264
		InitCommand=function(self) self:x(-292):halign(0):zoom(0.6):shadowlength(1):wrapwidthpixels(264):maxheight(58) end;
		SetCommand=function(self, params)
			if params.Song then
				self:settext( params.Song:GetDisplayFullTitle() );
			end
		end;
	};
};

local c
local Scores = Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren(); end;
};

for i=1,4 do
	Scores[#Scores+1] = LoadFont("_v 26px bold black")..{
		Name="Name"..i;
		InitCommand=function(self) self:x(scale(i,1,4,-48,240)):y(-8):zoomx(0.875):zoomy(0.625) end;
	};
	Scores[#Scores+1] = LoadFont("_futurist numbers metallic")..{
		Name="Score"..i;
		InitCommand=function(self) self:x(scale(i,1,4,-48,240)):y(12):zoomx(0.5):zoomy(0.75) end;
	};
end

Scores.SetCommand=function(self,param)
	local profile = PROFILEMAN:GetMachineProfile();
	for name, child in pairs(c) do child:visible(false); end
	local sel = param.Song
	if not sel then return end

	for i, item in pairs(param.Entries) do
		if item then
			local hsl = profile:GetHighScoreList(sel, item);
			local hs = hsl and hsl:GetHighScores();

			assert(c["Name"..i])
			assert(c["Score"..i])

			c["Name"..i]:visible(true)
			c["Score"..i]:visible(true)
			if hs and #hs > 0 then
				c["Name"..i]:settext( hs[1]:GetName() );
				c["Score"..i]:settext( FormatPercentScore( hs[1]:GetPercentDP() ) );
			else
				c["Name"..i]:settext( "-----" );
				c["Score"..i]:settext( FormatPercentScore( 0 ) );
			end
		end
	end
end;

t[#t+1] = Scores

return t