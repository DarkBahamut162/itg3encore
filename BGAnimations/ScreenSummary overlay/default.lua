local rounds = #Master
local roundText = rounds > 1 and "Rounds" or "Round"

local version = 0
if #P1 == #P2 then version = 2 elseif #Master == #P1 then version = 1 else version = 3 end

local entries = {}
local showOffset = ThemePrefs.Get("ShowOffset")
local tierToGrade = {
    ["Grade_Tier01"] = 1,
    ["Grade_Tier02"] = 2,
    ["Grade_Tier03"] = 3,
    ["Grade_Tier04"] = 4,
    ["Grade_Tier05"] = 5,
    ["Grade_Tier06"] = 6,
    ["Grade_Tier07"] = 7,
    ["Grade_Tier08"] = 8,
    ["Grade_Tier09"] = 9,
    ["Grade_Tier10"] = 10,
    ["Grade_Tier11"] = 11,
    ["Grade_Tier12"] = 12,
    ["Grade_Tier13"] = 13,
    ["Grade_Tier14"] = 14,
    ["Grade_Tier15"] = 15,
    ["Grade_Tier16"] = 16,
    ["Grade_Tier17"] = 17,
    ["Grade_Tier18"] = 18,
    ["Grade_Failed"] = 19
}
local gradeToTier = {
    [1]  = "Grade_Tier01",
    [2]  = "Grade_Tier02",
    [3]  = "Grade_Tier03",
    [4]  = "Grade_Tier04",
    [5]  = "Grade_Tier05",
    [6]  = "Grade_Tier06",
    [7]  = "Grade_Tier07",
    [8]  = "Grade_Tier08",
    [9]  = "Grade_Tier09",
    [10] = "Grade_Tier10",
    [11] = "Grade_Tier11",
    [12] = "Grade_Tier12",
    [13] = "Grade_Tier13",
    [14] = "Grade_Tier14",
    [15] = "Grade_Tier15",
    [16] = "Grade_Tier16",
    [17] = "Grade_Tier17",
    [18] = "Grade_Tier18",
    [19] = "Grade_Failed"
}
local summaryFA = {
	PLAYER_1 = false,
	PLAYER_2 = false
}
local showCalcDiff = ThemePrefs.Get("ShowCalcDiff")
local decimal = ThemePrefs.Get("ShowCalcDiffDecimals")
local counted = { [PLAYER_1] = 0,[PLAYER_2] = 0 }

for i=1,rounds do
	if ThemePrefs.Get("ShowSummarySummary") then
		if version <= 2 and not P1[i]["AutoPlayer"] then
			counted[PLAYER_1] = counted[PLAYER_1] + 1
			if not P1[rounds+1] then P1[rounds+1] = {} end
			P1[rounds+1]["AutoPlayer"] = false
			P1[rounds+1]["Meter"] = P1[rounds+1]["Meter"] and P1[rounds+1]["Meter"] + P1[i]["Meter"] or P1[i]["Meter"]
			if showCalcDiff then P1[rounds+1]["CalcedMeter"] = P1[rounds+1]["CalcedMeter"] and P1[rounds+1]["CalcedMeter"] + P1[i]["CalcedMeter"] or P1[i]["CalcedMeter"] end
			P1[rounds+1]["Score"] = P1[rounds+1]["Score"] and P1[rounds+1]["Score"] + P1[i]["Score"] or P1[i]["Score"]
			P1[rounds+1]["Grade"] = P1[rounds+1]["Grade"] and P1[rounds+1]["Grade"] + tierToGrade[P1[i]["Grade"]] or tierToGrade[P1[i]["Grade"]]
			if P1[i]["FA"] then
				if not summaryFA[PLAYER_1] then summaryFA[PLAYER_1] = true end
				P1[rounds+1]["ScoreFA"] = P1[rounds+1]["ScoreFA"] and P1[rounds+1]["ScoreFA"] + P1[i]["ScoreFA"] or P1[i]["ScoreFA"]
				P1[rounds+1]["TapNoteScore_W0"] = P1[rounds+1]["TapNoteScore_W0"] and P1[rounds+1]["TapNoteScore_W0"] + P1[i]["TapNoteScore_W0"] or P1[i]["TapNoteScore_W0"]
			else
				P1[rounds+1]["ScoreFA"] = P1[rounds+1]["ScoreFA"] and P1[rounds+1]["ScoreFA"] + P1[i]["Score"] or P1[i]["Score"]
			end
			P1[rounds+1]["TapNoteScore_W1"] = P1[rounds+1]["TapNoteScore_W1"] and P1[rounds+1]["TapNoteScore_W1"] + P1[i]["TapNoteScore_W1"] or P1[i]["TapNoteScore_W1"]
			P1[rounds+1]["TapNoteScore_W2"] = P1[rounds+1]["TapNoteScore_W2"] and P1[rounds+1]["TapNoteScore_W2"] + P1[i]["TapNoteScore_W2"] or P1[i]["TapNoteScore_W2"]
			P1[rounds+1]["TapNoteScore_W3"] = P1[rounds+1]["TapNoteScore_W3"] and P1[rounds+1]["TapNoteScore_W3"] + P1[i]["TapNoteScore_W3"] or P1[i]["TapNoteScore_W3"]
			P1[rounds+1]["TapNoteScore_W4"] = P1[rounds+1]["TapNoteScore_W4"] and P1[rounds+1]["TapNoteScore_W4"] + P1[i]["TapNoteScore_W4"] or P1[i]["TapNoteScore_W4"]
			P1[rounds+1]["TapNoteScore_W5"] = P1[rounds+1]["TapNoteScore_W5"] and P1[rounds+1]["TapNoteScore_W5"] + P1[i]["TapNoteScore_W5"] or P1[i]["TapNoteScore_W5"]
			P1[rounds+1]["TapNoteScore_Miss"] = P1[rounds+1]["TapNoteScore_Miss"] and P1[rounds+1]["TapNoteScore_Miss"] + P1[i]["TapNoteScore_Miss"] or P1[i]["TapNoteScore_Miss"]
			if showOffset then
				if P1[i]["FA"] then
					P1[rounds+1]["TapNoteScore_W0_Early"] = P1[rounds+1]["TapNoteScore_W0_Early"] and P1[rounds+1]["TapNoteScore_W0_Early"] + P1[i]["TapNoteScore_W0_Early"] or P1[i]["TapNoteScore_W0_Early"]
					P1[rounds+1]["TapNoteScore_W0_Late"] = P1[rounds+1]["TapNoteScore_W0_Late"] and P1[rounds+1]["TapNoteScore_W0_Late"] + P1[i]["TapNoteScore_W0_Late"] or P1[i]["TapNoteScore_W0_Late"]
				end
				P1[rounds+1]["TapNoteScore_W1_Early"] = P1[rounds+1]["TapNoteScore_W1_Early"] and P1[rounds+1]["TapNoteScore_W1_Early"] + P1[i]["TapNoteScore_W1_Early"] or P1[i]["TapNoteScore_W1_Early"]
				P1[rounds+1]["TapNoteScore_W1_Late"] = P1[rounds+1]["TapNoteScore_W1_Late"] and P1[rounds+1]["TapNoteScore_W1_Late"] + P1[i]["TapNoteScore_W1_Late"] or P1[i]["TapNoteScore_W1_Late"]
				P1[rounds+1]["TapNoteScore_W2_Early"] = P1[rounds+1]["TapNoteScore_W2_Early"] and P1[rounds+1]["TapNoteScore_W2_Early"] + P1[i]["TapNoteScore_W2_Early"] or P1[i]["TapNoteScore_W2_Early"]
				P1[rounds+1]["TapNoteScore_W2_Late"] = P1[rounds+1]["TapNoteScore_W2_Late"] and P1[rounds+1]["TapNoteScore_W2_Late"] + P1[i]["TapNoteScore_W2_Late"] or P1[i]["TapNoteScore_W2_Late"]
				P1[rounds+1]["TapNoteScore_W3_Early"] = P1[rounds+1]["TapNoteScore_W3_Early"] and P1[rounds+1]["TapNoteScore_W3_Early"] + P1[i]["TapNoteScore_W3_Early"] or P1[i]["TapNoteScore_W3_Early"]
				P1[rounds+1]["TapNoteScore_W3_Late"] = P1[rounds+1]["TapNoteScore_W3_Late"] and P1[rounds+1]["TapNoteScore_W3_Late"] + P1[i]["TapNoteScore_W3_Late"] or P1[i]["TapNoteScore_W3_Late"]
				P1[rounds+1]["TapNoteScore_W4_Early"] = P1[rounds+1]["TapNoteScore_W4_Early"] and P1[rounds+1]["TapNoteScore_W4_Early"] + P1[i]["TapNoteScore_W4_Early"] or P1[i]["TapNoteScore_W4_Early"]
				P1[rounds+1]["TapNoteScore_W4_Late"] = P1[rounds+1]["TapNoteScore_W4_Late"] and P1[rounds+1]["TapNoteScore_W4_Late"] + P1[i]["TapNoteScore_W4_Late"] or P1[i]["TapNoteScore_W4_Late"]
				P1[rounds+1]["TapNoteScore_W5_Early"] = P1[rounds+1]["TapNoteScore_W5_Early"] and P1[rounds+1]["TapNoteScore_W5_Early"] + P1[i]["TapNoteScore_W5_Early"] or P1[i]["TapNoteScore_W5_Early"]
				P1[rounds+1]["TapNoteScore_W5_Late"] = P1[rounds+1]["TapNoteScore_W5_Late"] and P1[rounds+1]["TapNoteScore_W5_Late"] + P1[i]["TapNoteScore_W5_Late"] or P1[i]["TapNoteScore_W5_Late"]
			end
		end
		if version >= 2 and not P2[i]["AutoPlayer"] then
			counted[PLAYER_2] = counted[PLAYER_2] + 1
			if not P2[rounds+1] then P2[rounds+1] = {} end
			P2[rounds+1]["AutoPlayer"] = false
			P2[rounds+1]["Meter"] = P2[rounds+1]["Meter"] and P2[rounds+1]["Meter"] + P2[i]["Meter"] or P2[i]["Meter"]
			if showCalcDiff then P2[rounds+1]["CalcedMeter"] = P2[rounds+1]["CalcedMeter"] and P2[rounds+1]["CalcedMeter"] + P2[i]["CalcedMeter"] or P2[i]["CalcedMeter"] end
			P2[rounds+1]["Score"] = P2[rounds+1]["Score"] and P2[rounds+1]["Score"] + P2[i]["Score"] or P2[i]["Score"]
			P2[rounds+1]["Grade"] = P2[rounds+1]["Grade"] and P2[rounds+1]["Grade"] + tierToGrade[P2[i]["Grade"]] or tierToGrade[P2[i]["Grade"]]
			if P2[i]["FA"] then
				if not summaryFA[PLAYER_2] then summaryFA[PLAYER_2] = true end
				P2[rounds+1]["ScoreFA"] = P2[rounds+1]["ScoreFA"] and P2[rounds+1]["ScoreFA"] + P2[i]["ScoreFA"] or P2[i]["ScoreFA"]
				P2[rounds+1]["TapNoteScore_W0"] = P2[rounds+1]["TapNoteScore_W0"] and P2[rounds+1]["TapNoteScore_W0"] + P2[i]["TapNoteScore_W0"] or P2[i]["TapNoteScore_W0"]
			else
				P2[rounds+1]["ScoreFA"] = P2[rounds+1]["ScoreFA"] and P2[rounds+1]["ScoreFA"] + P2[i]["Score"] or P2[i]["Score"]
			end
			P2[rounds+1]["TapNoteScore_W1"] = P2[rounds+1]["TapNoteScore_W1"] and P2[rounds+1]["TapNoteScore_W1"] + P2[i]["TapNoteScore_W1"] or P2[i]["TapNoteScore_W1"]
			P2[rounds+1]["TapNoteScore_W2"] = P2[rounds+1]["TapNoteScore_W2"] and P2[rounds+1]["TapNoteScore_W2"] + P2[i]["TapNoteScore_W2"] or P2[i]["TapNoteScore_W2"]
			P2[rounds+1]["TapNoteScore_W3"] = P2[rounds+1]["TapNoteScore_W3"] and P2[rounds+1]["TapNoteScore_W3"] + P2[i]["TapNoteScore_W3"] or P2[i]["TapNoteScore_W3"]
			P2[rounds+1]["TapNoteScore_W4"] = P2[rounds+1]["TapNoteScore_W4"] and P2[rounds+1]["TapNoteScore_W4"] + P2[i]["TapNoteScore_W4"] or P2[i]["TapNoteScore_W4"]
			P2[rounds+1]["TapNoteScore_W5"] = P2[rounds+1]["TapNoteScore_W5"] and P2[rounds+1]["TapNoteScore_W5"] + P2[i]["TapNoteScore_W5"] or P2[i]["TapNoteScore_W5"]
			P2[rounds+1]["TapNoteScore_Miss"] = P2[rounds+1]["TapNoteScore_Miss"] and P2[rounds+1]["TapNoteScore_Miss"] + P2[i]["TapNoteScore_Miss"] or P2[i]["TapNoteScore_Miss"]
			if showOffset then
				if P2[i]["FA"] then
					P2[rounds+1]["TapNoteScore_W0_Early"] = P2[rounds+1]["TapNoteScore_W0_Early"] and P2[rounds+1]["TapNoteScore_W0_Early"] + P2[i]["TapNoteScore_W0_Early"] or P2[i]["TapNoteScore_W0_Early"]
					P2[rounds+1]["TapNoteScore_W0_Late"] = P2[rounds+1]["TapNoteScore_W0_Late"] and P2[rounds+1]["TapNoteScore_W0_Late"] + P2[i]["TapNoteScore_W0_Late"] or P2[i]["TapNoteScore_W0_Late"]
				end
				P2[rounds+1]["TapNoteScore_W1_Early"] = P2[rounds+1]["TapNoteScore_W1_Early"] and P2[rounds+1]["TapNoteScore_W1_Early"] + P2[i]["TapNoteScore_W1_Early"] or P2[i]["TapNoteScore_W1_Early"]
				P2[rounds+1]["TapNoteScore_W1_Late"] = P2[rounds+1]["TapNoteScore_W1_Late"] and P2[rounds+1]["TapNoteScore_W1_Late"] + P2[i]["TapNoteScore_W1_Late"] or P2[i]["TapNoteScore_W1_Late"]
				P2[rounds+1]["TapNoteScore_W2_Early"] = P2[rounds+1]["TapNoteScore_W2_Early"] and P2[rounds+1]["TapNoteScore_W2_Early"] + P2[i]["TapNoteScore_W2_Early"] or P2[i]["TapNoteScore_W2_Early"]
				P2[rounds+1]["TapNoteScore_W2_Late"] = P2[rounds+1]["TapNoteScore_W2_Late"] and P2[rounds+1]["TapNoteScore_W2_Late"] + P2[i]["TapNoteScore_W2_Late"] or P2[i]["TapNoteScore_W2_Late"]
				P2[rounds+1]["TapNoteScore_W3_Early"] = P2[rounds+1]["TapNoteScore_W3_Early"] and P2[rounds+1]["TapNoteScore_W3_Early"] + P2[i]["TapNoteScore_W3_Early"] or P2[i]["TapNoteScore_W3_Early"]
				P2[rounds+1]["TapNoteScore_W3_Late"] = P2[rounds+1]["TapNoteScore_W3_Late"] and P2[rounds+1]["TapNoteScore_W3_Late"] + P2[i]["TapNoteScore_W3_Late"] or P2[i]["TapNoteScore_W3_Late"]
				P2[rounds+1]["TapNoteScore_W4_Early"] = P2[rounds+1]["TapNoteScore_W4_Early"] and P2[rounds+1]["TapNoteScore_W4_Early"] + P2[i]["TapNoteScore_W4_Early"] or P2[i]["TapNoteScore_W4_Early"]
				P2[rounds+1]["TapNoteScore_W4_Late"] = P2[rounds+1]["TapNoteScore_W4_Late"] and P2[rounds+1]["TapNoteScore_W4_Late"] + P2[i]["TapNoteScore_W4_Late"] or P2[i]["TapNoteScore_W4_Late"]
				P2[rounds+1]["TapNoteScore_W5_Early"] = P2[rounds+1]["TapNoteScore_W5_Early"] and P2[rounds+1]["TapNoteScore_W5_Early"] + P2[i]["TapNoteScore_W5_Early"] or P2[i]["TapNoteScore_W5_Early"]
				P2[rounds+1]["TapNoteScore_W5_Late"] = P2[rounds+1]["TapNoteScore_W5_Late"] and P2[rounds+1]["TapNoteScore_W5_Late"] + P2[i]["TapNoteScore_W5_Late"] or P2[i]["TapNoteScore_W5_Late"]
			end
		end
	end
	entries[#entries+1] = loadfile(THEME:GetPathB("ScreenSummary","overlay/Entry"))(version,i)..{
		InitCommand=function(self) self:Center() end
	}
end

if ThemePrefs.Get("ShowSummarySummary") then
	if rounds > 1 then
		entries[#entries+1] = Def.ActorFrame{}
		if version <= 2 and counted[PLAYER_1] > 1 then
			P1[rounds+1]["Difficulty"] = "Difficulty_Edit"
			P1[rounds+1]["Meter"] = math.round(P1[rounds+1]["Meter"]/counted[PLAYER_1])
			if showCalcDiff then P1[rounds+1]["CalcedMeter"] = math.round(P1[rounds+1]["CalcedMeter"]/counted[PLAYER_1],decimal) end
			P1[rounds+1]["Score"] = P1[rounds+1]["Score"]/counted[PLAYER_1]
			P1[rounds+1]["FA"] = summaryFA[PLAYER_1]
			if summaryFA[PLAYER_1] then P1[rounds+1]["ScoreFA"] = P1[rounds+1]["ScoreFA"]/counted[PLAYER_1] end
			P1[rounds+1]["Grade"] = gradeToTier[math.round(P1[rounds+1]["Grade"]/counted[PLAYER_1])]
		else
			P1[rounds+1] = nil
		end
		if version >= 2 and counted[PLAYER_2] > 1 then
			P2[rounds+1]["Difficulty"] = "Difficulty_Edit"
			P2[rounds+1]["Meter"] = math.round(P2[rounds+1]["Meter"]/counted[PLAYER_2])
			if showCalcDiff then P2[rounds+1]["CalcedMeter"] = math.round(P2[rounds+1]["CalcedMeter"]/counted[PLAYER_2],decimal) end
			P2[rounds+1]["Score"] = P2[rounds+1]["Score"]/counted[PLAYER_2]
			P2[rounds+1]["FA"] = summaryFA[PLAYER_2]
			if summaryFA[PLAYER_2] then
				P2[rounds+1]["ScoreFA"] = P2[rounds+1]["ScoreFA"]/counted[PLAYER_2]
			end
			P2[rounds+1]["Grade"] = gradeToTier[math.round(P2[rounds+1]["Grade"]/counted[PLAYER_2])]
		else
			P2[rounds+1] = nil
		end
		if counted[PLAYER_1] > 1 or counted[PLAYER_2] > 1 then
			entries[#entries+1] = loadfile(THEME:GetPathB("ScreenSummary","overlay/Entry"))(version,rounds+1)..{
				InitCommand=function(self) self:Center() end
			}
		end
	end
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
	BeginCommand=function() SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', (4/3 * (rounds + math.ceil(6/WideScreenDiff()) + ((ThemePrefs.Get("ShowSummarySummary") and rounds > 1) and 2 or 0)) )) end,
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
			InitCommand=function(self) self:x(SCREEN_CENTER_X+(87)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(right):zoomtowidth(174*WideScreenDiff()) end
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