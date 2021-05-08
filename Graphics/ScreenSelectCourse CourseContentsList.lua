return Def.CourseContentsList {
	MaxSongs = 4;
    NumItemsToDraw = 8; -- xxx: Doesn't scroll anymore.
	ShowCommand=function(self) self:linear(0.3):zoomy(1) end;
	HideCommand=function(self) self:linear(0.3):zoomy(0) end;
	SetCommand=function(self)
		self:SetFromGameState();
		self:PositionItems();
		self:SetTransformFromHeight(44);
		self:SetCurrentAndDestinationItem(0);
		self:SetLoop(false);
		self:SetMask(270,0);
	end;
	CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
	CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end;

	Display = Def.ActorFrame { 
		--InitCommand=function(self) self:setsize(270,44) end;

		LoadFont("_r bold 30px") .. {
			InitCommand=function(self) self:x(-145):zoom(0.8):shadowlength(0):halign(1) end;
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				self:diffuse( DifficultyToColor(params.Difficulty) );
				self:finishtweening():zoomy(0):sleep(0.125*params.Number):linear(0.125):zoomy(1.1):linear(0.05):zoomx(1.1):decelerate(0.1):zoom(1) end;
			end;
		};

		Def.TextBanner{
			InitCommand=function(self) self:Load("CourseTextBanner"):zoom(0.75):halign(0):SetFromString("", "", "", "", "", "") end;
			SetSongCommand=function(self, params)
				if params.Song then
					self:SetFromSong( params.Song );
				else
					self:SetFromString( "??????????", "??????????", "", "", "", "" );
				end
				self:finishtweening():zoomy(0):sleep(0.125*params.Number):linear(0.125):zoomy(1.1):linear(0.05):zoomx(1.1):decelerate(0.1):zoom(1) end;
			end;
		};

		Def.Quad{
			InitCommand=function(self) self:x(64):y(24):ztest(true):zoomto(512,2):diffusealpha(0.45):blend(Blend.Add):fadeleft(0.25):faderight(0.25) end;
		};
	};
};