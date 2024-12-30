local function GetList()
	local l = {}
	for i=1,7 do
		local stats
		stats = STATSMAN:GetPlayedStageStats(i)

		if not stats then
			break
		end

		l[#l+1] = stats
	end
	return l
end

local statList = GetList()

local as = Def.ActorScroller {
	SecondsPerItem = 1,
	NumItemsToDraw = 10,
	TransformFunction = function( self, offset, itemIndex, numItems)
		self:diffusealpha(1-offset)
	end,
	OnCommand=function(self)
		self:SetLoop(true)
		self:SetPauseCountdownSeconds(-3)
		self:SetSecondsPauseBetweenItems(2)
		self:ScrollThroughAllItems()
	end
}

for i=1,#statList do
	local j = #statList - (i-1)
	as[#as+1] = Def.ActorFrame {
		Def.Sprite {
			InitCommand=function(self) self:scaletoclipped((isFinal() and 170 or 174)*WideScreenDiff(),(isFinal() and 64 or 68)*WideScreenDiff()):ztest(true):cropright(1.3):faderight(0.1):sleep(3):linear(0.7):cropright(-0.3) end,
			OnCommand=function(self)
				local path = statList[j]:GetPlayedSongs()[1]:GetBannerPath() or THEME:GetPathG("Common","fallback banner")
				self:LoadBanner(path)
			end,
			OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
		}
	}
end

return Def.ActorFrame { as }
