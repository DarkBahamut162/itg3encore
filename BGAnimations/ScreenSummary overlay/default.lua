local rounds = #Master
local roundText = rounds > 1 and "Rounds" or "Round"

local version = 0
if #P1 == #P2 then version = 2 elseif #Master == #P1 then version = 1 else version = 3 end

local entries = {}
for i=1,rounds do
	entries[#entries+1] = loadfile(THEME:GetPathB("ScreenSummary","overlay/Entry"))(version,i)..{
		InitCommand=function(self) self:Center() end
	}
end

local borderLeft = SCREEN_CENTER_X-296*WideScreenDiff()
local borderLeftCenter = SCREEN_CENTER_X-110.5*WideScreenDiff()
local borderRightCenter = SCREEN_CENTER_X+110.5*WideScreenDiff()
local borderRight = SCREEN_CENTER_X+296*WideScreenDiff()
local summaryX = SCREEN_CENTER_X

if version == 1 then
	summaryX = SCREEN_CENTER_X-220*WideScreenDiff()
elseif version == 3 then
	summaryX = SCREEN_CENTER_X+220*WideScreenDiff()
end

return Def.ActorFrame{
	BeginCommand=function() SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', (4/3 * (rounds + math.ceil(6/WideScreenDiff())) )) end,
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenRanking","underlay/back frame"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X-1*WideScreenDiff()):CenterY():zoomx(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("horiz-line","long"),
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-34*WideScreenDiff()):zoomx(0.99*WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenRanking","underlay/mask"),
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+2*WideScreenDiff()):zwrite(true):zoomy(WideScreenDiff()):blend(Blend.NoEffect):vertalign(bottom) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP):valign(0):zoomto(SCREEN_WIDTH,78*WideScreenDiff()):zwrite(true):blend(Blend.NoEffect) end
	},
	Def.ActorScroller{
		SecondsPerItem=4/3,
		NumItemsToDraw=math.ceil(7/WideScreenDiff()),
		OnCommand=function(self) self:Center():addy(32):SetLoop(false):ScrollThroughAllItems():SetCurrentAndDestinationItem(math.floor(-3/WideScreenDiff())):SetDestinationItem(rounds+math.ceil(5/WideScreenDiff())) end,
		TransformFunction=function(self,offset,itemIndex,numItems) self:y(offset*64*WideScreenDiff()) end,
		children = entries
	},
	Def.ActorFrame{
		Condition=version==1,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/center "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-120*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/left "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-(120+17)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(right):zoomtowidth(SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/right "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-(120-14)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH) end
		},
	},
	Def.ActorFrame{
		Condition=version==2,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/right "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-(87+31)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(right):zoomtowidth(SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/center "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-(87+17)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):zoomx(-WideScreenDiff()):vertalign(top) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/center "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+(87+17)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/left "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+(87)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(right):zoomtowidth(174) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/right "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+(87+31)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH) end
		},
	},
	Def.ActorFrame{
		Condition=version==3,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/center "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+120*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):zoomx(-WideScreenDiff()):vertalign(top) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/left "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+(120+17)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenRanking","underlay/right "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+(120-14)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(right):zoomtowidth(SCREEN_WIDTH) end
		},
	},
	Def.ActorFrame{
		Def.BitmapText {
			File = "_z bold 19px",
			Text = "Summary",
			InitCommand=function(self) self:maxwidth(200):x(summaryX):y(SCREEN_TOP+24*WideScreenDiff()):zoom(0.8*WideScreenDiff()):diffusealpha(0) end,
			OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_z bold 19px",
			Text = "For "..rounds.." "..roundText,
			InitCommand=function(self) self:maxwidth(250):diffuse(PlayerColor(PLAYER_1)):x(summaryX):y(SCREEN_TOP+40*WideScreenDiff()):zoom(0.7*WideScreenDiff()):diffusealpha(0) end,
			OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_z bold 19px",
			Condition=version < 3,
			Text = P1[0],
			InitCommand=function(self) self:x(scale(0.5,0,1,version == 2 and borderLeft or borderRight,version == 2 and borderLeftCenter or borderLeftCenter)):y(SCREEN_TOP+56*WideScreenDiff()):zoom(0.7*WideScreenDiff()):diffusealpha(0):maxwidth(version == 2 and 250 or 600) end,
			OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_z bold 19px",
			Condition=version > 1,
			Text = P2[0],
			InitCommand=function(self) self:x(scale(0.5,0,1,version == 2 and borderRightCenter or borderLeft,version == 2 and borderRight or borderRightCenter)):y(SCREEN_TOP+56*WideScreenDiff()):zoom(0.7*WideScreenDiff()):diffusealpha(0):maxwidth(version == 2 and 250 or 600) end,
			OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
		}
	}
}