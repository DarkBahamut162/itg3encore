local player = ...
if not GAMESTATE:IsHumanPlayer(player) then return Def.ActorFrame{} end
local update = false
local time = 0

local NoteFieldMiddle = (THEME:GetMetric("Player","ReceptorArrowsYStandard")+THEME:GetMetric("Player","ReceptorArrowsYReverse"))/2
local mods = string.find(GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
local reverse = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):UsingReverse()
if mods then reverse = not reverse end
local posY = reverse and THEME:GetMetric("Player","ReceptorArrowsYReverse") or THEME:GetMetric("Player","ReceptorArrowsYStandard")

local actualPos = SCREEN_CENTER_Y+posY-NoteFieldMiddle
local playField = SCREEN_HEIGHT-actualPos
if playField < SCREEN_HEIGHT/2 then playField = actualPos end
local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
--local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
--currentMini = currentMini * currentTiny
playField = playField / currentMini

local mode = ""
local speed = 1
local forced = 0
local diff = (IsGame("beat") or IsGame("be-mu")) and 30 or 60
local multi = (IsGame("beat") or IsGame("be-mu")) and 2 or 1

local function Update(self)
	if (GetTimeSinceStart() - time) >= 1/60 then
		update = true
		time = GetTimeSinceStart()
	else
		update = false
	end
	if update then
		local bpm = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(player) * diff)
		self:GetChild("GreenNumber"..pname(player)):settext(math.floor(playField/(bpm*speed)*1000))
	end
end

local function setSpeed()
	local playeroptions = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current")
	local absoluteBPM = GAMESTATE:GetCurrentSteps(player):GetTimingData():GetActualBPM()
	if mode == "x" then
		speed = playeroptions:XMod()
	elseif mode == "C" then
		speed = playeroptions:CMod()
		forced = speed
	elseif mode == "m" then
		local max = tonumber(THEME:GetMetric('Player', 'MModHighCap'))
		speed = playeroptions:MMod()
		if max > 0 and absoluteBPM[2] > max then
			speed = speed / max
		else
			speed = speed / absoluteBPM[2]
		end
	elseif mode == "a" or mode == "ca" or mode == "av" then
		local baseAvg = (absoluteBPM[1] + absoluteBPM[2]) * 0.5
		if mode == "a" then
			speed = playeroptions:AMod()
		elseif mode == "ca" then
			speed = playeroptions:CAMod()
		elseif mode == "av" then
			speed = playeroptions:AVMod()
		end
		speed = speed / baseAvg
	end
end

local StepsOrTrail1 = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
local StepsOrTrail2 = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(OtherPlayer[player]) or GAMESTATE:GetCurrentSteps(OtherPlayer[player])
local align = 0.5
local move = isFinal() and WideScaleFixed(20*WideScreenDiff(),35*WideScreenDiff()) or 20*WideScreenDiff()
local maxwidth = move*4
local add = 0

if (isVS() or StepsOrTrail1==StepsOrTrail2) or (isDouble() or getenv("Rotation"..pname(player)) == 5) then
	move = player == PLAYER_1 and SCREEN_LEFT+move or SCREEN_RIGHT-move
	add = 5*WideScreenDiff()
else
	move = SCREEN_CENTER_X+(player == PLAYER_1 and -5 or 5)
	align = player == PLAYER_1 and 1 or 0
end

local XMS = IsGame("beat") or IsGame("be-mu") or IsGame("popn") or IsGame("po-mu")

if XMS then move = THEME:GetMetric(Var "LoadingScreen","Player"..pname(player).."OnePlayerOneSideX") end

return Def.ActorFrame{
	CodeMessageCommand = function(self, params)
		if params.Name == 'SpeedUp' or params.Name == 'SpeedDown' then
			setSpeed()

			local absoluteBPM = GAMESTATE:GetCurrentSteps(player):GetTimingData():GetActualBPM()
			self:GetChild("Min"..pname(player)):settext(math.floor(playField/(forced > 0 and forced or absoluteBPM[1]*speed)*multi*1000))
			local bpm = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(player) * diff)
			self:GetChild("GreenNumber"..pname(player)):settext(math.floor(playField/(forced > 0 and forced or bpm*speed)*1000))
			self:GetChild("Max"..pname(player)):settext(math.floor(playField/(forced > 0 and forced or absoluteBPM[2]*speed)*multi*1000))
		end
	end,
	OnCommand=function(self)
		for pn in ivalues({player}) do
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Song")
			if playeroptions:MMod() then mode = "m" break end
			if isOutFox(20210200) then if playeroptions:AMod() then mode = "a" break end end
			if isOutFox(20220300) then if playeroptions:CAMod() then mode = "ca" break end end
			if isOutFox(20220900) then if playeroptions:AVMod() then mode = "av" break end end
			if playeroptions:XMod() then mode = "x" end
			if playeroptions:CMod() then mode = "c" end
		end
		setSpeed()
		local absoluteBPM = GAMESTATE:GetCurrentSteps(player):GetTimingData():GetActualBPM()
		if absoluteBPM[1] ~= absoluteBPM[2] then
			self:GetChild("Min"..pname(player)):settext(math.floor(playField/(forced > 0 and forced or absoluteBPM[1]*speed)*multi*1000))
			self:GetChild("Max"..pname(player)):settext(math.floor(playField/(forced > 0 and forced or absoluteBPM[2]*speed)*multi*1000))
		else
			self:GetChild("Min"..pname(player)):visible(false)
			self:GetChild("Max"..pname(player)):visible(false)
		end
		if isGamePlay() then self:SetUpdateFunction(Update) end
		self:visible(isGamePlay())
		if not XMS then
			self:y(SCREEN_TOP+91*WideScreenDiff()-162.5+add):accelerate(0.5):y(SCREEN_TOP+91*WideScreenDiff()-100+add):decelerate(0.8):y(SCREEN_TOP+91*WideScreenDiff()+add)
		else
			self:y(SCREEN_TOP+41*WideScreenDiff())
		end
	end,
	OffCommand=function(self) stopping = true if not IsGame("pump") then if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100):decelerate(0.8):addy(-100) end end,
	Def.BitmapText {
		File = "_r bold numbers",
		Name="Min"..pname(player),
		Text="000",
		InitCommand=function(self)
			self:visible(getenv("GreenNumber"..pname(player))):diffuse(PlayerColor(player)):x(move):zoom(0.4*WideScreenDiff()):diffuse(color("#00ff00")):shadowlength(1):addx(XMS and -maxwidth*0.4*WideScreenDiff() or 0):y(XMS and 0 or -10):halign(align):maxwidth(maxwidth)
		end,
	},
	Def.BitmapText {
		File = "_r bold numbers",
		Name="GreenNumber"..pname(player),
		Text="000",
		InitCommand=function(self)
			self:visible(getenv("GreenNumber"..pname(player))):diffuse(PlayerColor(player)):x(move):zoom(0.5*WideScreenDiff()):diffuse(color("#00ff00")):shadowlength(1):halign(align):maxwidth(maxwidth)
		end,
	},
	Def.BitmapText {
		File = "_r bold numbers",
		Name="Max"..pname(player),
		Text="000",
		InitCommand=function(self)
			self:visible(getenv("GreenNumber"..pname(player))):diffuse(PlayerColor(player)):x(move):zoom(0.4*WideScreenDiff()):diffuse(color("#00ff00")):shadowlength(1):addx(XMS and maxwidth*0.4*WideScreenDiff() or 0):y(XMS and 0 or 10):halign(align):maxwidth(maxwidth)
		end,
	}
}