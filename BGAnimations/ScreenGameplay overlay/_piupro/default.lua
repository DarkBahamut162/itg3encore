local showDanger = PREFSMAN:GetPreference("ShowDanger")

local function SingleLifeMeter()
	return GAMESTATE:GetNumPlayersEnabled() == 1 and isDouble() or isVS()
end

local MaxGauntletLivesToShow = SingleLifeMeter() and 60 or 30

local function LifeMeterTotalWidth()
	local PermissibleOverlap = 20
	local MaxSize = math.min(784, SCREEN_WIDTH)

	return scale(MaxSize, 640, 784, 640+PermissibleOverlap, 784)
end

local GauntletLivesWidthSingle = 33

local function LifeMeterWidth()
	if SingleLifeMeter() then
		return (LifeMeterTotalWidth())-90-90
	else
		local width = (LifeMeterTotalWidth()/2)-90-5

		if isMGD(GAMESTATE:GetMasterPlayerNumber()) and not SingleLifeMeter() then width = width - GauntletLivesWidthSingle end

		return width
	end
end

local Player = {}

for pn in ivalues(PlayerNumber) do Player[pn] = pn end

if SingleLifeMeter() and GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then
	Player[PLAYER_1] = PLAYER_2
	Player[PLAYER_2] = PLAYER_1
end

local IsDisplayedPlayer = {}

if IsRoutine() then
	for pn in ivalues(PlayerNumber) do IsDisplayedPlayer[pn] = false end
	IsDisplayedPlayer[GAMESTATE:GetMasterPlayerNumber()] = true
else
	for pn in ivalues(PlayerNumber) do IsDisplayedPlayer[pn] = GAMESTATE:IsPlayerEnabled(pn) end
end

local LifeMeterX = (SCREEN_WIDTH - LifeMeterTotalWidth())/2

local MeterX = {
	[PLAYER_1] = SCREEN_LEFT+LifeMeterX+89,
	[PLAYER_2] = SCREEN_RIGHT-LifeMeterX-89
}

local function LoadLifeMeterFramePart(f)
	return LoadActor( THEME:GetPathG("_frame", "1D"),
		{ 121/784, 80/784, 48/784, 106/784, 74/784, 106/784, 48/784, 80/784, 121/784 },
		Def.Sprite { Texture = f }
	) .. {
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+32):playcommand("SetSize", { Width=LifeMeterTotalWidth() }) end
	}
end

local function ProgressMeterWidth(source)
	local width = 0

	for idx=3,7 do
		width = width + source:GetChild(idx):GetZoomedWidth()
	end

	return width - 6*2
end

local TopFrame = Def.ActorFrame {
	OnCommand = function(self) self:addy(-100):sleep(1.0):decelerate(0.4):addy(100) end,
	LoadLifeMeterFramePart("top frame 1") .. {
		Name="Dummy",
		InitCommand=function(self) self:visible(false) end
	},
	Def.SongMeterDisplay {
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+6) end,
		Stream = Def.Sprite { Texture = "progress bar" },
		Tip = Def.Sprite { Texture = "progress tip", InitCommand=function(self) self:halign(0) end },
		BeginCommand=function(self)
			local Dummy = self:GetParent():GetChild("Dummy")
			local Width = ProgressMeterWidth(Dummy)
			self:SetStreamWidth(Width)
		end
	},
	Def.Quad{ InitCommand=function(self) self:diffusealpha(0):clearzbuffer(true) end }
}

TopFrame[#TopFrame+1] = LoadLifeMeterFramePart("meter mask") .. {
	InitCommand=function(self) self:RunCommandsRecursively(function(self) self:blend("BlendMode_NoEffect"):zwrite(true):zbias(5) end) end
}
TopFrame[#TopFrame+1] = LoadLifeMeterFramePart("meter under")

local function Quantize( f, fRoundInterval ) return math.floor( (f + fRoundInterval/2)/fRoundInterval ) * fRoundInterval end

local function MakeLifeMeterLives(pn, frame)
	local f = Def.ActorFrame {
		Def.Sprite { Texture = frame, InitCommand=function(self) self:zoomx(pn == PLAYER_1 and 1 or -1) end }
	}

	f[#f+1] = Def.BitmapText {
		File = "_v 26px bold shadow",
		Name = "LivesLeft",
		InitCommand=function(self) self:zoom(1/3):shadowlength(0):x(0) end,
		BeginCommand=function(self) self:playcommand("Update") end,
		LifeChangedMessageCommand=function(self,param)
			if param.Player == pn then
				self:settext(param.LivesLeft)
			end
		end,
		UpdateCommand=function(self)
			local meter = SCREENMAN:GetTopScreen():GetLifeMeter(pn)
			if meter then self:settext(meter:GetLivesLeft()) end
		end
	}

	return f
end


local function MakeLifeMeter(side)
	local c
	local pn = Player[side]
	if not IsDisplayedPlayer[pn] then return Def.Actor{} end

	local fDisplayWidth = DISPLAY:GetDisplayWidth()
	local fScreenWidth = SCREEN_WIDTH
	local LifeMeterAdjustRatio = fScreenWidth/fDisplayWidth
	local fAdjusted = math.floor( 1/LifeMeterAdjustRatio + 0.5 )

	if fAdjusted > 0.001 then LifeMeterAdjustRatio = LifeMeterAdjustRatio*fAdjusted end

	local TicksWidth = LifeMeterWidth()
	TicksWidth = TicksWidth/LifeMeterAdjustRatio
	local MeterWidth = LifeMeterWidth()
	local HexFullPercent = MeterWidth/1024
	local WidthPerSegment

	local function SetWidthPerSegment(width)
		assert(c)
		WidthPerSegment = width
		c.Tick:SetDistanceBetweenTicks(WidthPerSegment)
	end

	local function SetNumberOfSegments(NumberOfSegments)
		assert(c)

		WidthPerSegment = TicksWidth / NumberOfSegments
		c.Tick:SetDistanceBetweenTicks(WidthPerSegment)
	end

	local meter
	local function Update(self)
		local original_life = meter and meter:GetLife() or STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetCurrentLife()
		local life
		if meter then
			if meter.GetTotalLives then
				local max_lives = meter:GetTotalLives()
				local cur_lives = meter:GetLivesLeft()

				max_lives = math.min(max_lives, MaxGauntletLivesToShow)
				cur_lives = math.min(cur_lives, MaxGauntletLivesToShow)
				original_life = cur_lives / max_lives
			end
		else
			if original_life == 0 then original_life = 0.5 end 
		end

		life = original_life

		if c.TweenHelper:GetTweenTimeLeft() ~= 0 then life = c.TweenHelper:getaux() end

		local fBeat = GAMESTATE:GetSongPosition():GetSongBeatVisible()
		local fBeatFract = fBeat % 1

		if c.Grad:GetTweenTimeLeft() == 0 then
			local fSectionWidth = WidthPerSegment*LifeMeterAdjustRatio
			local fSeparatorWidth = 2*LifeMeterAdjustRatio
			local fPulseSections = 3

			if not isMGD(pn) then
				local ExtraMeterWidth = ((fSectionWidth+fSeparatorWidth)*fPulseSections)
				local ExtraMeterPercent = ExtraMeterWidth / MeterWidth
				if life >= 0.5 then life = scale(life, 0.5, 1.0, 0.5, 1+ExtraMeterPercent) end
			end

			local fPos = life
			fPos = fPos * MeterWidth
			fPos = Quantize(fPos, fSectionWidth)
			fPos = fPos - fSeparatorWidth
			fPos = fPos / MeterWidth

			local fPulseDistance = (fPulseSections * fSectionWidth)
			fPulseDistance = fPulseDistance / MeterWidth

			local fTipPos = math.min(life, 1.0) * MeterWidth
			fTipPos = Quantize(fTipPos, fSectionWidth)
			fTipPos = fTipPos - fSeparatorWidth/2

			local fFlip = (side == PLAYER_1 and 1 or -1 )
			c.Tip:x( MeterX[side] + (fTipPos * fFlip) )
			c.Tip:visible( fTipPos >= 0.01 )
			local fVisible = scale( life, 0.95, 1.00, 1, 0 )
			c.Tip:basealpha(fVisible)

			if not isMGD(pn) and not isVS() then
				local fPulse = scale( fBeatFract, 0.0, 0.25, 0, fPulseDistance )
				fPulse = clamp( fPulse, 0, fPulseDistance )
				if c.TweenHelper:GetTweenTimeLeft() ~= 0 then fPulse = fPulseDistance end
				fPos = fPos - fPulse
			end

			c.HexMask:cropleft( fPos )
			c.Grad:cropright( 1-fPos )
			
			local FadePos = c.HexTweenHelper:GetSecsIntoEffect() / 4
			FadePos = scale( FadePos, 0, 1, -0.65, 1 )
			c.Hex:fadeleft(0.2)
			c.Hex:faderight(0.2)
			c.Hex:cropleft(FadePos)
			c.Hex:cropright(1-(FadePos+0.65))
		end

		if showDanger and not isVS() then
			local DangerAlpha = scale( original_life, 0.1, 0.25, 0.8, 0 )
			c.Danger:stoptweening()
			local OldDangerAlpha = c.Danger:GetDiffuseAlpha()
			c.Danger:linear(math.abs(OldDangerAlpha - DangerAlpha) * 1)
			c.Danger:diffusealpha(DangerAlpha)
		end

		local fFillVisible = scale( original_life, 0.80, 0.90, 0, 1 )
		c.Filled:diffusealpha(fFillVisible)
		c.FilledHex:diffusealpha(fFillVisible)

		local fFilledHexCrop = scale( original_life, 0.80, 1.00, 0.15, -0.25 )
		c.FilledHex:cropright( fFilledHexCrop )
		c.FilledHex:cropleft( fFilledHexCrop )
	end

	local f = Def.ActorFrame {
		Def.Quad { Name = "HexMask" },
		Def.Sprite { Texture = "meter tip", Name = "Tip" },
		Def.Sprite { Texture = "meter grad", Name = "Grad", OnCommand=function(self) if not meter then self:diffuse(PlayerColor(pn)) end end },
		Def.Sprite { Texture = "meter danger", Condition = showDanger , Name = "Danger" },
		Def.Sprite { Texture = "meter honeycomb", Name = "Hex" },
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_piupro/life meter ticks"))(TicksWidth) .. { Name = "Tick" },
		Def.Sprite { Texture = "meter filled color", Name = "Filled" },
		Def.Sprite { Texture = "meter honeycomb", Name = "FilledHex" },
		Def.Sprite { Texture = "meter danger", Name = "Dead" },
		Def.Actor { Name = "TweenHelper" },
		Def.Actor { Name = "HexTweenHelper" }
	}

	if isMGD(pn) then
		if SingleLifeMeter() then
			f[#f+1] = MakeLifeMeterLives(pn, "lives frame double") .. {
				OnCommand=function(self) self:x(MeterX[side]+MeterWidth/2):y(6) end
			}
		else
			local X = MeterX[PLAYER_1]+MeterWidth-18+GauntletLivesWidthSingle
			if pn == PLAYER_2 then X = SCREEN_WIDTH - X end
			f[#f+1] = MakeLifeMeterLives(pn, "lives frame single") .. {
				OnCommand=function(self) self:x(X):y(6) end
			}
		end
	end

	f.InitCommand = function(self)
		self:SetUpdateFunction( Update )
		self:y(SCREEN_TOP+21)
		c = self:GetChildren()
		c.Tick = c.Tick.sprite

		local f=function(self) self:zoomx(side == PLAYER_1 and 1 or -1):ztest(true):halign(0):x(MeterX[side]) end

		f(c.Grad)
		if showDanger and not isVS() then f(c.Danger) end
		f(c.Tick)
		f(c.Filled)
		f(c.FilledHex)
		f(c.Hex)
		f(c.HexMask)
		f(c.Dead)
	end
	f.BeginCommand=function(self)
		self:visible(IsDisplayedPlayer[pn])
		if not IsDisplayedPlayer[pn] then return end

		meter = SCREENMAN:GetTopScreen():GetLifeMeter(pn)
		if meter and meter.GetTotalLives then
			local lives = meter:GetTotalLives()
			lives = math.min(lives, MaxGauntletLivesToShow)
			SetNumberOfSegments(lives)
		else
			SetWidthPerSegment(10)
		end
		c.Tick:SetDistanceBetweenTicks(WidthPerSegment)
		c.Tick:SetTextureFiltering(false)
		c.Tick:SetWidth( MeterWidth )

		c.Grad:SetWidth( MeterWidth )
		c.Grad:diffusealpha(1)

		if showDanger then
			c.Danger:SetWidth( MeterWidth )
			c.Danger:diffuse(color("#C0C0C0"))
			c.Danger:diffusealpha(0)
		end

		c.Dead:SetWidth( MeterWidth )
		c.Dead:diffuse(color("#909090"))
		c.Dead:diffusealpha(0)

		c.HexMask:diffuse(color("#FF00FF"))
		c.HexMask:blend("BlendMode_NoEffect"):zwrite(true):zbias(-1)
		c.HexMask:setsize(MeterWidth, 32)

		c.Hex:zbias(-2)
		c.Hex:setsize(MeterWidth, 32)
		c.Hex:SetCustomImageRect( 0, 0, HexFullPercent, 1 )
		c.Hex:diffusealpha( 0.4 )

		c.Filled:visible(false)
		c.FilledHex:visible(false)
		c.Filled:setsize(MeterWidth, 32)
		c.Filled:SetCustomImageRect( 0, 0, HexFullPercent, 1 )
		c.FilledHex:setsize(MeterWidth, 32)
		c.FilledHex:SetCustomImageRect( 0, 0, HexFullPercent, 1 )
		c.FilledHex:fadeleft(0.25)
		c.FilledHex:faderight(0.25)

		c.Tip:ztest(true)
		c.Tip:zoomx(LifeMeterAdjustRatio)

		local fSnappedX = math.floor( c.Tick:GetX()/LifeMeterAdjustRatio )*LifeMeterAdjustRatio
		local fXAdjust = fSnappedX - c.Tick:GetX()
		self:addx( fXAdjust )
	end
	f.OnCommand=function(self)
		c.Tick:finishtweening():diffusealpha(1):fadeleft(0.25):cropleft(1):sleep(2.0):linear(0.3):cropleft(-0.25):linear(0.2):diffusealpha(0.4)
		c.TweenHelper:aux(0.0)
		c.TweenHelper:sleep(2.0)
		c.TweenHelper:decelerate(0.3)
		c.TweenHelper:aux(meter and meter:GetLife() or STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetCurrentLife())
		c.HexTweenHelper:effectperiod(4)
	end

	f.PlayerFailedMessageCommand=function(self, params)
		if params.PlayerNumber ~= pn then return end

		c.Dead:finishtweening():diffusealpha(1):faderight(0.25):cropright(1):decelerate(0.3):cropright(-0.25)
	end

	return f
end

for side in ivalues(PlayerNumber) do
	TopFrame[#TopFrame+1] = MakeLifeMeter(side)
end

for side in ivalues(PlayerNumber) do
	local Bubble

	if SingleLifeMeter() then
		Bubble = {
			Outer = 60,
			Inner = 60
		}
	else
		Bubble = {
			Outer = 60,
			Inner = 17
		}
	end

	local LifeMeterCenter = LifeMeterTotalWidth()/2
	local BubblePadding = 15*2

	local function LoadBubblePart(part)
		return LoadActor( THEME:GetPathG("_frame", "1D"),
			{ 15/348, 318/348, 15/348 },
			Def.Sprite { Texture = part }
		)
	end

	local pn = Player[side]
	local fFlip = (side == PLAYER_1 and 1 or -1 )
	local PlayerFrame = Def.ActorFrame {
		LoadBubblePart("difficulty bubble border") .. { Name="BubbleBorder" },
		LoadBubblePart("difficulty bubble color") .. { Name="BubbleColor" },
		InitCommand=function(self) self:x(SCREEN_CENTER_X-LifeMeterTotalWidth()/2*fFlip):y(SCREEN_TOP+44) end,
		BeginCommand=function(self)
			local BubbleLeft = Bubble.Outer
			local BubbleRight

			if SingleLifeMeter() then
				BubbleRight = LifeMeterTotalWidth() - Bubble.Inner
			else
				BubbleRight = LifeMeterCenter - Bubble.Inner
			end
			local BubbleCenter = (BubbleRight - BubbleLeft) / 2
			local BubbleWidth = (BubbleRight-BubbleLeft) + BubblePadding

			self:visible(IsDisplayedPlayer[pn])
			if not IsDisplayedPlayer[pn] then return end

			local c = self:GetChildren()

			for child in ivalues({ c.BubbleBorder, c.BubbleColor }) do
				child:playcommand( "SetSize", { Width=BubbleWidth } )
				child:x((BubbleCenter + Bubble.Outer) * fFlip)
			end

			local Selection = GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
			local DifficultyColor = CustomDifficultyToColor(ToEnumShortString(Selection:GetDifficulty()))
			c.BubbleColor:RunCommandsRecursively( function(self) self:diffuse(DifficultyColor) end )

			local DifficultyColor = {DifficultyColor[1], DifficultyColor[1], DifficultyColor[2], DifficultyColor[4]}

			for x=1,3 do DifficultyColor[x] = 1 - ((1-DifficultyColor[x]) * 0.25) end

			c.BubbleBorder:RunCommandsRecursively( function(self) self:diffuse(DifficultyColor) end )
		end
	}
	TopFrame[#TopFrame+1] = PlayerFrame
end

TopFrame[#TopFrame+1] = LoadLifeMeterFramePart("top frame 1") .. { OnCommand = function(self) self:hide_if(not SingleLifeMeter()) end }
TopFrame[#TopFrame+1] = LoadLifeMeterFramePart("top frame 2") .. { OnCommand = function(self) self:hide_if(SingleLifeMeter()) end }
TopFrame[#TopFrame+1] = Def.BitmapText {
	File = "_v 26px bold shadow",
	InitCommand=function(self) self:zoom(0.4):maxwidth(832):settext("TITLE"):CenterX():y(6):shadowlength(0):playcommand("Title") end,
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Title") end,
	TitleCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
		local text = ""

		if song then text = song:GetDisplayFullTitle() end
		if course then text = course:GetDisplayFullTitle() .. " - " .. text end

		self:settext( text )
	end
}

local function MakeStageCreditIcons(pn)
	local Icon = Def.Sprite { Texture = "stage credit icon", InitCommand=function(self) self:pause() end }
	local Total

	if GAMESTATE:IsCourseMode() then
		Total = GAMESTATE:GetCurrentCourse():GetEstimatedNumStages()
	else
		Total = PREFSMAN:GetPreference("SongsPerPlay")
	end

	local Width = scale(Total, 3, 5, 20, 28)

	if Total == 2 then Width = 15 end

	local t = Def.ActorFrame{}

	for i = 1,Total do
		local function Lit()
			if not GAMESTATE:IsPlayerEnabled(pn) then return false end
			local IconsToLight
			if GAMESTATE:IsCourseMode() then
				IconsToLight = GAMESTATE:GetLoadingCourseSongIndex() + 1
			else
				local StagesLeft = GAMESTATE:GetNumStagesLeft(pn)+1
				IconsToLight = scale(StagesLeft, 1, Total, Total, 1)
			end

			return i <= IconsToLight
		end

		t[#t+1] = Icon .. {
			InitCommand=function(self) self:x(scale(i, 1, Total, -Width/2, Width/2)) end,
			BeginCommand=function(self) self:setstate(Lit() and 0 or 1) end,
			ChangeCourseSongOutMessageCommand=function(self) self:playcommand("Refresh") end,
			OnCommand=function(self) self:diffusealpha(0):zoom(0):sleep(1.7+0.1*(i-1)):linear(0.3):zoom(1):diffusealpha(1) end,
			RefreshCommand=function(self) self:setstate(Lit() and 0 or 1) end
		}
	end
	return t
end

TopFrame[#TopFrame+1] = MakeStageCreditIcons(PLAYER_1) .. { InitCommand=function(self) self:x(SCREEN_LEFT+LifeMeterX+82):y(SCREEN_TOP+34) end }
TopFrame[#TopFrame+1] = MakeStageCreditIcons(PLAYER_2) .. { InitCommand=function(self) self:x(SCREEN_RIGHT-LifeMeterX-82):y(SCREEN_TOP+34):zoomx(-1) end }

for side in ivalues(PlayerNumber) do
	local pn = Player[side]
	local fFlip = (side == PLAYER_1 and 1 or -1 )
	local PlayerFrame = Def.ActorFrame{
		Def.Sprite {
			Texture = side == PLAYER_1 and "difficulty color p1" or "difficulty color p2",
			Name="Color",
			InitCommand=function(self) self:x(66 * fFlip):y(17) end
		},
		Def.Sprite {
			Texture = side == PLAYER_1 and "difficulty frame p1" or "difficulty frame p2",
			InitCommand=function(self) self:x(66 * fFlip):y(17) end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			Name="Meter",
			InitCommand=function(self) self:zoom(0.5):x(68 * fFlip):y(17):shadowlength(1) end
		},
		InitCommand=function(self) self:x(SCREEN_CENTER_X-LifeMeterTotalWidth()*fFlip/2):y(SCREEN_TOP) end,
		BeginCommand=function(self)
			local c = self:GetChildren()
			local Selection = GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
			local DifficultyColor

			if IsDisplayedPlayer[pn] then
				DifficultyColor = CustomDifficultyToColor(ToEnumShortString(Selection:GetDifficulty()))
			else
				DifficultyColor = color("#404040")
			end

			c.Color:diffuse(DifficultyColor)
			if Selection then c.Meter:settext(Selection:GetMeter()) end
			c.Meter:visible(IsDisplayedPlayer[pn])
		end
	}

	TopFrame[#TopFrame+1] = PlayerFrame
end

local Overlay = Def.ActorFrame { TopFrame }

if Var "LoadingScreen" ~= "ScreenDemonstration" then
	local LastCoins = 0
	local CreditsString = THEME:GetString("ScreenSystemLayer", "CreditsCredits")
	CreditsText = Def.BitmapText {
		File = "_v 26px bold white",
		InitCommand=function(self) self:shadowlength(1):visible(GAMESTATE:GetCoinMode() == "CoinMode_Pay"):CenterX():y(SCREEN_BOTTOM-10):zoom(0.5):playcommand("Update") end,
		CoinInsertedMessageCommand=function(self) self:playcommand("Update") end,
		UpdateCommand=function(self)
			local Coins = GAMESTATE:GetCoins()

			if Coins == 0 then self:settext( "" ) return end
			if LastCoins == 0 then self:addy(30):smooth(0.3):addy(-30) end

			LastCoins = Coins
			local CoinsPerCredit = PREFSMAN:GetPreference("CoinsPerCredit")
			local Credits = math.floor(Coins / CoinsPerCredit)
			local RemainingCoins = Coins % CoinsPerCredit
			local s = CreditsString .. ": "

			if Credits > 0 or CoinsPerCredit == 1 then s = s .. tostring(Credits) end
			if CoinsPerCredit > 1 then s = s .. "  " .. tostring(RemainingCoins) .. "/" .. tostring(CoinsPerCredit) end

			self:settext( s )
		end
	}

	Overlay[#Overlay+1] = CreditsText
end

return Overlay