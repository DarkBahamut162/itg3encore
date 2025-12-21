local groups = SONGMAN:GetSongGroupNames()
local ITG3ADDONS, ITG3UNLOCKS, REBIRTH, REBIRTHPLUS, REBIRTHTWO = false, false, false, false, false

for group in ivalues(groups) do
	if string.find(group,"In The Groove 3 Unlocks") then
		ITG3UNLOCKS = true
	elseif string.find(group,"In The Groove 3 +") then
		ITG3ADDONS = true
	elseif string.find(group,"In The Groove Rebirth 2") then
		REBIRTHTWO = true
	elseif string.find(group,"In The Groove Rebirth +") then
		REBIRTHPLUS = true
	elseif string.find(group,"In The Groove Rebirth") then
		REBIRTH = true
	end
end

local function sortArray(array)
	local check = {}
	local output = {}
	if array ~= "" then
		for _,v in ipairs(split("|",array)) do
			if not check[v] then
				output[#output+1] = v
				check[v] = true
			end
		end
	end
	return output
end

return Def.ActorFrame{
	OnCommand=function(self)
		if isOutFox(20200500) then
			GAMESTATE:UpdateDiscordGameMode(GAMESTATE:GetCurrentGame():GetName())
			GAMESTATE:UpdateDiscordScreenInfo("Title Menu","",1)
		end
	end,
	Def.Sprite {
		Texture = "_logobg_normal",
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture = "_logobg_normal",
		InitCommand=function(self) self:FullScreen():sleep(1/3):decelerate(1/30):zoomtowidth(SCREEN_WIDTH*1.02):zoomtoheight(SCREEN_HEIGHT*1.02):accelerate(1/30):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):decelerate(1/30):zoomtowidth(SCREEN_WIDTH*1.02):zoomtoheight(SCREEN_HEIGHT*1.02):accelerate(1/30):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT) end
	},
	Def.Sprite {
		Texture = "_splat",
		InitCommand=function(self) self:xy(SCREEN_CENTER_X+7*WideScreenSemiDiff(),SCREEN_CENTER_Y+9*WideScreenSemiDiff()):zoom(WideScreenSemiDiff()) end
	},
	Def.Sprite {
		Texture = "_light1",
		OnCommand=function(self) self:diffusealpha(0.2):horizalign(left):vertalign(top):y(SCREEN_TOP):x(-SCREEN_WIDTH*(320/640)):blend(Blend.Add):rotationz(-90):linear(7):rotationz(6):linear(7):rotationz(-90):queuecommand("On") end
	},
	Def.Sprite {
		Texture = "_light1",
		OnCommand=function(self) self:diffusealpha(0.2):horizalign(left):vertalign(top):y(SCREEN_HEIGHT*(540/480)):x(SCREEN_WIDTH*(770/640)):blend(Blend.Add):rotationx(180):rotationz(98):linear(7):rotationz(24):linear(7):rotationz(98):queuecommand("On") end
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = "itg3_logo",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+7*WideScreenSemiDiff()):y(SCREEN_CENTER_Y-11*WideScreenSemiDiff()):blend(Blend.Add):diffusealpha(0):sleep(0.183):diffusealpha(0.3):zoom(2*WideScreenSemiDiff()):accelerate(0.15):zoom(1.2*WideScreenSemiDiff()):decelerate(0.15):diffusealpha(0):zoom(1.5*WideScreenSemiDiff()):rotationz(3) end
		},
		Def.Sprite {
			Texture = "itg3_logo",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+7*WideScreenSemiDiff()):y(SCREEN_CENTER_Y-11*WideScreenSemiDiff()):diffusealpha(0):sleep(0.183):diffusealpha(0):zoom(2*WideScreenSemiDiff()):accelerate(0.15):diffusealpha(0.8):zoom(1*WideScreenSemiDiff()):decelerate(0.033):diffusealpha(1):rotationz(1):accelerate(0.033):rotationz(-2):decelerate(0.033):zoom(1.02*WideScreenSemiDiff()):rotationz(-1):accelerate(0.066):zoom(1*WideScreenSemiDiff()):rotationz(0) end
		},
		Def.Sprite {
			Texture = "itg3_I",
			OnCommand=function(self) self:x(SCREEN_CENTER_X-150*WideScreenSemiDiff()):y(SCREEN_CENTER_Y-5*WideScreenSemiDiff()):blend(Blend.Add):diffusealpha(0):zoom(WideScreenSemiDiff()):sleep(2.183):linear(0.233):diffusealpha(0.4):linear(0.233):diffusealpha(0):sleep(18.6):queuecommand("On") end
		},
		Def.Sprite {
			Texture = "itg3_T",
			OnCommand=function(self) self:x(SCREEN_CENTER_X-127*WideScreenSemiDiff()):y(SCREEN_CENTER_Y+52*WideScreenSemiDiff()):blend(Blend.Add):diffusealpha(0):zoom(WideScreenSemiDiff()):sleep(2.183):sleep(0.466):linear(0.233):diffusealpha(0.4):linear(0.233):diffusealpha(0):sleep(18.6):queuecommand("On") end
		},
		Def.Sprite {
			Texture = "itg3_G",
			OnCommand=function(self) self:x(SCREEN_CENTER_X-13*WideScreenSemiDiff()):y(SCREEN_CENTER_Y+101*WideScreenSemiDiff()):blend(Blend.Add):diffusealpha(0):zoom(WideScreenSemiDiff()):sleep(2.183):sleep(0.932):linear(0.233):diffusealpha(0.4):linear(0.233):diffusealpha(0):sleep(18.6):queuecommand("On") end
		},
		Def.Sprite {
			Texture = "itg3_3",
			OnCommand=function(self) self:x(SCREEN_CENTER_X+80*WideScreenSemiDiff()):y(SCREEN_CENTER_Y-13*WideScreenSemiDiff()):blend(Blend.Add):diffusealpha(0):zoom(1*WideScreenSemiDiff()):sleep(2.183):sleep(1.631):linear(0.383):diffusealpha(0.4):zoom(1.15*WideScreenSemiDiff()):linear(0.383):diffusealpha(0):zoom(1.3*WideScreenSemiDiff()):sleep(18.6):queuecommand("On") end
		},
		Def.Sprite {
			Texture = "itg3_3",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+80*WideScreenSemiDiff()):y(SCREEN_CENTER_Y-13*WideScreenSemiDiff()):blend(Blend.Add):diffusealpha(0):zoom(1*WideScreenSemiDiff()):sleep(0.416):diffusealpha(0.4):linear(0.333):diffusealpha(0):zoom(1.65*WideScreenSemiDiff()) end
		},
		Def.Sprite {
			Texture = "itg3_3",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+80*WideScreenSemiDiff()):y(SCREEN_CENTER_Y-13*WideScreenSemiDiff()):blend(Blend.Add):diffusealpha(0):zoom(1*WideScreenSemiDiff()):sleep(2.183):diffusealpha(0.4):linear(0.333):diffusealpha(0):zoom(1.65*WideScreenSemiDiff()) end
		}
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = "_frame",
			InitCommand=function(self) self:x(SCREEN_RIGHT+70*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*0*WideScreenDiff()):zoom(WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:shadowlength(3):horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):linear(0.5):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3ADDONS
		},
		Def.BitmapText {
			File = "stencil",
			InitCommand=function(self) self:settext("ITG3 ADDONS"):shadowlength(1):x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*0*WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):maxwidth(166):zoom(WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3ADDONS
		},
		Def.Sprite {
			Texture = "_frame",
			InitCommand=function(self) self:x(SCREEN_RIGHT+70*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*1*WideScreenDiff()):zoom(WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:shadowlength(3):horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):linear(0.5):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3UNLOCKS
		},
		Def.BitmapText {
			File = "stencil",
			InitCommand=function(self) self:settext("ITG3 UNLOCKS"):shadowlength(1):x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*1*WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):maxwidth(166):zoom(WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3UNLOCKS
		},
		Def.Sprite {
			Texture = "_frame",
			InitCommand=function(self) self:x(SCREEN_RIGHT+70*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*2*WideScreenDiff()):zoom(WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:shadowlength(3):horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):linear(0.5):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTH
		},
		Def.BitmapText {
			File = "stencil",
			InitCommand=function(self) self:settext("REBIRTH"):shadowlength(1):x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*2*WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):maxwidth(166):zoom(WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTH
		},
		Def.Sprite {
			Texture = "_frame",
			InitCommand=function(self) self:x(SCREEN_RIGHT+70*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*3*WideScreenDiff()):zoom(WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:shadowlength(3):horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):linear(0.5):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHPLUS
		},
		Def.BitmapText {
			File = "stencil",
			InitCommand=function(self) self:settext("REBIRTH +"):shadowlength(1):x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*3*WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):maxwidth(166):zoom(WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHPLUS
		},
		Def.Sprite {
			Texture = "_frame",
			InitCommand=function(self) self:x(SCREEN_RIGHT+70*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*4*WideScreenDiff()):zoom(WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:shadowlength(3):horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):linear(0.5):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHTWO
		},
		Def.BitmapText {
			File = "stencil",
			InitCommand=function(self) self:settext("REBIRTH 2"):shadowlength(1):x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+30+27*4*WideScreenDiff()):addy(IsHome() and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):maxwidth(166):zoom(WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHTWO
		}
	},
	Def.ActorFrame{
		OnCommand=function(self) self:visible(IsAprilFools() and not IsHome()) end,
		ScreenChangedMessageCommand=function(self) self:playcommand("On") end,
		Def.Sprite {
			Texture = "start_frame",
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+185*WideScreenSemiDiff()):diffusealpha(0):rotationz(90):zoom(1.5*WideScreenSemiDiff()):sleep(0.833):accelerate(0.15):rotationz(0):zoom(1*WideScreenSemiDiff()):diffusealpha(1) end
		},
		Def.Sprite {
			Texture = "press_start1a",
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+182*WideScreenSemiDiff()):diffusealpha(0):rotationz(90):zoom(1.5*WideScreenSemiDiff()):sleep(0.833):accelerate(0.15):rotationz(0):zoom(1*WideScreenSemiDiff()):diffusealpha(1) end
		},
		Def.Sprite {
			Texture = "press_start1b",
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+182*WideScreenSemiDiff()):zoom(1*WideScreenSemiDiff()):addy(999):sleep(1.316):addy(-999):diffuseshift():effectcolor1(1,1,1,0):effectcolor2(1,1,1,1):effectperiod(0.666) end
		}
	},
	Def.ActorFrame{
		OnCommand=function(self) self:xy(SCREEN_RIGHT,SCREEN_TOP):valign(0):halign(0):zoom(WideScreenSemiDiff()):rotationz(-480):addx(380*WideScreenSemiDiff()):sleep(0.8):linear(0.283):rotationz(0):addx(-380*WideScreenSemiDiff()) end,
		OffCommand=function(self) self:linear(0.283):rotationz(-270):addx(200*WideScreenSemiDiff()) end,
		Def.Sprite {
			Texture = "frame",
			InitCommand=function(self) self:x(-200+53*1.5):y(-2+34) end
		},
		loadfile(THEME:GetPathB("ScreenTitleAlt","background/icon"))()..{ InitCommand=function(self) self:x(5):y(-10) end }
	},
	Def.Sprite {
		Texture = "rx",
		OnCommand=function(self) self:shadowlength(2):zoom(0.6*WideScreenDiff()):x(SCREEN_LEFT+105*WideScreenDiff()):y(SCREEN_TOP+32*WideScreenDiff()):rotationz(480):addx(-380):sleep(0.8):linear(0.283):rotationz(0):addx(380) end,
	},
	Def.Sprite {
		Texture = "../_thanks/_bx",
		OnCommand=function(self) self:shadowlength(2):horizalign(center):zoom(0.6*WideScreenDiff()):x(SCREEN_LEFT+270*WideScreenDiff()):y(SCREEN_TOP+32*WideScreenDiff()):rotationz(480):addy(-380):sleep(0.8):linear(0.283):rotationz(0):addy(380) end,
	},
	Def.BitmapText {
		File = "_r bold 30px",
		InitCommand=function(self) self:x(SCREEN_LEFT+28*WideScreenDiff()):y(SCREEN_TOP+52*WideScreenDiff()):shadowlength(2):valign(0):halign(0):maxwidth(SCREEN_WIDTH/WideScreenDiff()):zoom(0.6*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Refresh") end,
		ScreenChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			local songs = SONGMAN:GetAllSongs()
			local songsSingle = 0
			local songsDouble = 0

			local groupsSingle = ""
			local groupsDouble = ""
			local groupsSingleCount = 0
			local groupsDoubleCount = 0

			local courses = SONGMAN:GetAllCourses(PREFSMAN:GetPreference("AutogenGroupCourses"))
			local coursesMarathonSingle = 0
			local coursesMarathonDouble = 0
			local coursesSurvivalSingle = 0
			local coursesSurvivalDouble = 0

			if (StepsTypeSingle() or StepsTypeDouble()) and (IsGame("dance") or isOutFoxV() or not isOutFox()) then
				local auto = nil
				local style = IsAutoStyle()
				local versus = false
				local double = false
				if style then
					if IsGame("dance") and ThemePrefs.Get("AutoStyleDance") then
						style = ThemePrefs.Get("AutoStyleDance")
					elseif IsGame("groove") and ThemePrefs.Get("AutoStyleGroove") then
						style = ThemePrefs.Get("AutoStyleGroove")
					elseif IsGame("solo") and ThemePrefs.Get("AutoStyleSolo") then
						style = ThemePrefs.Get("AutoStyleSolo")
					elseif IsGame("pump") and ThemePrefs.Get("AutoStylePump") then
						style = ThemePrefs.Get("AutoStylePump")
					elseif IsGame("smx") and ThemePrefs.Get("AutoStyleSmx") then
						style = ThemePrefs.Get("AutoStyleSmx")
					elseif IsGame("be-mu") and ThemePrefs.Get("AutoStyleBeMu") then
						style = ThemePrefs.Get("AutoStyleBeMu")
					elseif IsGame("beat") and ThemePrefs.Get("AutoStyleBeat") then
						style = ThemePrefs.Get("AutoStyleBeat")
					elseif IsGame("po-mu") and ThemePrefs.Get("AutoStylePoMu") then
						style = ThemePrefs.Get("AutoStylePoMu")
					elseif IsGame("popn") and ThemePrefs.Get("AutoStylePopn") then
						style = ThemePrefs.Get("AutoStylePopn")
					elseif IsGame("rechno") and ThemePrefs.Get("AutoStyleTechno") then
						style = ThemePrefs.Get("AutoStyleTechno")
					end
					for i,choice in ipairs(ChoiceSingle()) do if choice == style then auto = i end end
					for i,choice in ipairs(ChoiceVersus()) do if choice == style then auto = i versus = true end end
					for i,choice in ipairs(ChoiceDouble()) do if choice == style then auto = i double = true end end
				end
				local StepsTypeSingle = StepsTypeSingle()[auto or GetUserPrefN("StylePosition")]
				local StepsTypeDouble = StepsTypeDouble()[auto or GetUserPrefN("StylePosition")]
				if #songs > 0 then
					for i=1,#songs do
						if songs[i]:HasStepsType(StepsTypeSingle) then
							if not string.find(groupsSingle,songs[i]:GetGroupName()) then
								groupsSingle = addToOutput(groupsSingle,songs[i]:GetGroupName(),"|")
							end
							songsSingle = songsSingle + 1
						end
						if StepsTypeDouble then
							if songs[i]:HasStepsType(StepsTypeDouble) then
								if not string.find(groupsDouble,songs[i]:GetGroupName()) then
									groupsDouble = addToOutput(groupsDouble,songs[i]:GetGroupName(),"|")
								end
								songsDouble = songsDouble + 1
							end
						end
					end
				end
				if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
					if isOutFox() and ((not isOutFoxV() and IsGame("be-mu")) or (not isOutFoxV043() and IsGame("po-mu"))) then else
						if #courses > 0 then
							for i=1,#courses do
								if courses[i]:GetCourseType() == "CourseType_Nonstop" then
									if courses[i]:IsPlayableIn(StepsTypeSingle) then coursesMarathonSingle = coursesMarathonSingle + 1 end
									if StepsTypeDouble and songsDouble > 0 then
										if courses[i]:IsPlayableIn(StepsTypeDouble) then coursesMarathonDouble = coursesMarathonDouble + 1 end
									end
								end
								if courses[i]:GetCourseType() == "CourseType_Oni" or courses[i]:GetCourseType() == "CourseType_Survival" then
									if courses[i]:IsPlayableIn(StepsTypeSingle) then coursesSurvivalSingle = coursesSurvivalSingle + 1 end
									if StepsTypeDouble and songsDouble > 0 then
										if courses[i]:IsPlayableIn(StepsTypeDouble) then coursesSurvivalDouble = coursesSurvivalDouble + 1 end
									end
								end
							end
						end
					end
				end

				groupsSingle = sortArray(groupsSingle)
				groupsDouble = sortArray(groupsDouble)
				groupsSingleCount = #groupsSingle
				groupsDoubleCount = #groupsDouble

				local output = ""
				if groupsSingleCount == groupsDoubleCount then
					output = addToOutput(output,"Songs: "..songsSingle.." singles & "..songsDouble.." doubles in "..SONGMAN:GetNumSongGroups().." groups","\n")
				else
					output = addToOutput(output,"Songs: "..songsSingle.." singles ("..groupsSingleCount.." groups) & "..songsDouble.." doubles ("..groupsDoubleCount.." groups)","\n")
				end

				if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
					if isOutFox() and ((not isOutFoxV() and IsGame("be-mu")) or (not isOutFoxV043() and IsGame("po-mu"))) then
						output = addToOutput(output,"Courses: ? marathons & ? survivals","\n")
					else
						local temp = "Courses:"
						if coursesMarathonSingle == coursesMarathonDouble then
							temp = addToOutput(temp,coursesMarathonSingle.." marathons"," ")
						else
							temp = addToOutput(temp,coursesMarathonSingle.."s/"..coursesMarathonDouble.."d marathons"," ")
						end
						if coursesSurvivalSingle == coursesSurvivalDouble then
							temp = addToOutput(temp,coursesSurvivalSingle.." survivals"," & ")
						else
							temp = addToOutput(temp,coursesSurvivalSingle.."s/"..coursesSurvivalDouble.."d survivals"," & ")
						end
						output = addToOutput(output,temp,"\n")
					end
				end
				output = addToOutput(output,"Current Game Mode: "..GAMESTATE:GetCurrentGame():GetName(),"\n")
				if isTopScreen('ScreenTitleAlt') and (IsAutoPlayMode(true) and IsAutoStyle()) then output = addToOutput(output,IsAutoPlayMode(),"\n") end
				if isTopScreen('ScreenTitleAlt') and (IsAutoPlayMode(true) and IsAutoStyle()) or (isTopScreen('ScreenTitleMenuAlt') and IsAutoStyle()) then
					output = addToOutput(output,"Auto Style: "..StyleName()[auto or GetUserPrefN("StylePosition")],"\n")
					if versus then output = output.." (Versus)" elseif double then output = output.." (Double)" else output = output.." (Single)" end
					if ThemePrefs.Get("AllowBattle") then output = addToOutput(output,"Auto Battle: "..string.gsub(" "..ThemePrefs.Get("AutoBattle"), "%W%l", string.upper):sub(2),"\n") end
				else
					output = addToOutput(output,"Current Style: "..StyleName()[GetUserPrefN("StylePosition")],"\n")
				end
				self:settext(output):vertspacing(-10)
			else
				if GameModeEnabled() then
					self:settext("Information: The song/course counter currently only works in Dance Mode!\nSome other functionalities might also be broken!\nCurrent Game Mode: "..GAMESTATE:GetCurrentGame():GetName()):diffuse(Color.Yellow)
				else
					self:settext("WARNING: This Game Mode isn't supported here!\nErrors might occur!"):diffuse(Color.Red)
				end
			end
		end
	}
}