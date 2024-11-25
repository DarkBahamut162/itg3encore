local credits = {}
local creditsDiffuse = {
	[  1] = color("#00E4FF"),
	[  2] = color("#00E4FF"),
	[  5] = color("#76B1D5"),
	[ 12] = color("#76B1D5"),
	[ 17] = color("#76B1D5"),
	[ 26] = color("#76B1D5"),
	[ 33] = color("#76B1D5"),
	[ 40] = color("#76B1D5"),
	[ 67] = color("#76B1D5"),
	[ 72] = color("#76B1D5"),
	[ 76] = color("#FF0000"),
	[ 84] = color("#3C00FF"),
	[ 95] = color("#00C300"),
	[105] = color("#76B1D5"),
	[118] = color("#76B1D5"),
	[164] = color("#76B1D5"),
	[171] = color("#ffa800"),
	[174] = color("#ffa800"),
	[175] = color("#ddf3ff"),
	[182] = color("#ffa800"),
	[183] = color("#ddf3ff"),
	[188] = color("#ffa800"),
	[189] = color("#ddf3ff"),
	[194] = color("#ffa800"),
	[195] = color("#ddf3ff"),
	[200] = color("#ffa800"),
	[201] = color("#ddf3ff"),
	[206] = color("#ffa800"),
	[207] = color("#ddf3ff")
}

credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="In The Groove 3", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Open Groove Team", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Theme Graphics/Coding", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Dominick Renzetti", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Felipe Valladares", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="A.J. Kung", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jason Bolt", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Original UI Concept", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ryan McKanna", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="John Schlemmer", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Song/Course Graphics", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Dominick Renzetti", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="N. Colley", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="M.J. Quigley", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ryan McKanna", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Matt Puls", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Heather Dority", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Audio", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Kyle Ward", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="John Mendenhall", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Scott Brown", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Renard Queenston", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Programming", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Glenn Maynard", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Chris Danford", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Mark Cannon", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Pat McIlroy", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Step Artists", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Donnie D'Amato", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Matthew Emirzian", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Dalton Runberg", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Dominick Renzetti", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jordan Frederick", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Mike Calfin", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ryan Konkul", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Kyle Ward", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Chris Foy", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ryan McKanna", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Matt Puls", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jonas Casarino", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Christopher Emirzian", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="A.J. Kung", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="G. PolloxxX", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Max Leonardo Cerna", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Joseph DeGarmo", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Alex Sofikitis", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="N. Colley", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="J. Nordli", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Derek Bauer", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Brandon Bauer", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="M.J. Quigley", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Eric Holniker", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Courses", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Barry Knapp-Tabbernor", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Gabriel Marchan", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Producer", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.Sprite {
	Texture = THEME:GetPathB("","_thanks/_br"),
	OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end
}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="PressX", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="KholdFuzion", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="AJ 197", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Infamouspat", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="vdl", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="vyhd", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="OpenGroove", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="r0dent", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Edgar131", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="GRIM.657", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Hellacious", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Kalek", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Lightning", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="NX-306", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="xjen0vax", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Honorary members", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="sherl0k", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="bacon", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="neoMAXCML", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="SonGohanX", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Rubbinnexx", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Kung", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Midiman", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Test Locations", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Divertonicos Kripton - Bogota", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Lightning's basement - PA", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Infamous360's house - SC", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Great Wolf L. - Ontario, Canada", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Pittsburgh Mills - PA", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="North Park Club House - PA", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Game Zone - KS", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Players - MD", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Corner Pocket - PA", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Funland - Trocadero Centre, UK", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Test Team", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="G. PolloxxX", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Lil Lion", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Matt Vandermeulen", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jeff 'Jeffrey' Odendahl", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Carlos 'Wanny' Ortega", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="John 'GooFWeaR' Uhlman", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="AJ Kelly", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Steve 'Nevets933' Bauer", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Derek 'Whicker' Bauer", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Scott 'Scooter' Smiesko", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Max Racaud", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Josh Laughery", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ryan Jackson", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Andrzej Poetek", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Eric Holniker", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Tyler Thompson", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Janel Yeager", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ryan Lower", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Joseph Sherman", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Kevin 'PF3K' Lin", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Michael Porter", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Brian 'Red' Kurtz", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Valentina O'Donnell", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Bryan Wills", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Brandon Stokes", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Brian Rudowski", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ryan Campbell", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jarad Kaplan", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Phil Eberhardt", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Chelsie Ehasz", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Adam Landes", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Patrick Richards", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Ian Hunsberger", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Carly Chiavaroli", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Huamid 'Moon' Alnuaimi", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Sonia Leng", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Garrett Shourds", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Bradley Shank", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jorrie Marie", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jordan Miller", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Damien Diehl", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jason 'TheGreat' Gilleece", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Justin 'Pags' Pagano", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Hardware Support", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Mark Cannon", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Pat McIlroy", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Andrzej Poetek", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Jason Bolt", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Special Thanks to:", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.Sprite {
	Texture = THEME:GetPathB("","_thanks/_bx"),
	OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end
}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Boxorroxors", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="www.boxorroxors.net", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = loadfile(THEME:GetPathB("","_thanks/_sci/perfect"))()..{OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="SCI Recordings!", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="www.scirecordings.com", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.Sprite {
	Texture = THEME:GetPathB("","_thanks/_itgf"),
	OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end
}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="ITGfreak/Rhythmatic.net", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="www.rhythmatic.net", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.Sprite {
	Texture = THEME:GetPathB("","_thanks/_gs"),
	OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end
}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="GrooveStats", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="www.groovestats.com", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.Sprite {
	Texture = THEME:GetPathB("","_thanks/_n3k"),
	OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end
}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="Naota3k", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="www.naota3k.com", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.Sprite {
	Texture = THEME:GetPathB("","_thanks/_rx"),
	OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end
}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="RoXoR", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.BitmapText { File = "_v credit", Text="www.roxorgames.com", OnCommand=function(self) self:horizalign(left):shadowlength(1.25) end}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}
credits[#credits+1] = Def.ActorFrame{}

for i=0,math.ceil((SCREEN_HEIGHT-SCREEN_HEIGHT*WideScreenDiff())/24) do
	credits[#credits+1] = Def.ActorFrame{}
end

return Def.ActorScroller{
	SecondsPerItem=73.75/#credits,
	NumItemsToDraw=23/WideScreenDiff(),
	OnCommand=function(self) self:SetLoop(false):ScrollThroughAllItems():SetCurrentAndDestinationItem(-43/WideScreenSemiDiff()):SetDestinationItem(#credits):horizalign(left):shadowlength(1.25) end,
	TransformFunction=function(self,offset,itemIndex,numItems)
		self:y(offset*24*WideScreenDiff()):zoom(0.7*WideScreenDiff())
		if creditsDiffuse[itemIndex] then self:diffuse(creditsDiffuse[itemIndex]) end
	end,
	children = credits
}