local fit_choices = {}
local actors = {}
local width_per_choice = _screen.w / #BackgroundFitMode
local xstart = width_per_choice / 2
local mini_screen_w = _screen.w * .1
local mini_screen_h = _screen.h * .1

function BGFitNormalExampleText(w, h)
	return Def.BitmapText{
		Name = "example_label",
		Font = "Common Normal",
		Text = w .. ":" .. h .. " " .. THEME:GetString("ScreenSetBGFit", "BG"),
		InitCommand=function(self) self:y(mini_screen_h * .5 + 9):zoom(.375) end,
		OnCommand=function (self) self:shadowlength(1) end
	}
end

for i, mode in ipairs(BackgroundFitMode) do
	actors[#actors+1] = Def.ActorFrame{
		Name = mode,
		InitCommand=function(self)
			fit_choices[i] = self
			self:xy(xstart + ((i-1) * width_per_choice), _screen.cy)
		end,
		Def.BitmapText{
			Name= "mode_label",
			Font= "Common Normal",
			Text= THEME:GetString("ScreenSetBGFit", ToEnumShortString(mode)),
			InitCommand= function(self) self:y(mini_screen_h * -2.5):zoom(.75*WideScreenDiff()) end,
			OnCommand= function (self) self:diffusebottomedge(color("0.875,0.875,0.875")):shadowlength(1) end
		},
		BGFitChoiceExample{
			exname = "16_12_example.png",
			x = 0,
			y = mini_screen_h * -1.5,
			mini_screen_w = mini_screen_w,
			mini_screen_h = mini_screen_h,
			example_function = bg_fit_functions[mode],
			example_label = BGFitNormalExampleText(16, 12),
			sbg_color = color("0,0,0,1"),
			soutline_color = color("#39b54a")
		},
		BGFitChoiceExample{
			exname = "16_10_example.png",
			x = 0,
			y = 0,
			mini_screen_w = mini_screen_w,
			mini_screen_h = mini_screen_h,
			example_function = bg_fit_functions[mode],
			example_label = BGFitNormalExampleText(16, 10),
			sbg_color = color("0,0,0,1"),
			soutline_color = color("#39b54a")
		},
		BGFitChoiceExample{
			exname = "16_9_example.png",
			x = 0,
			y = mini_screen_h * 1.5,
			mini_screen_w = mini_screen_w,
			mini_screen_h = mini_screen_h,
			example_function = bg_fit_functions[mode],
			example_label = BGFitNormalExampleText(16, 9),
			sbg_color = color("0,0,0,1"),
			soutline_color = color("#39b54a")
		},
	}
end

local function LoseFocus(self) self:stoptweening():smooth(.125):zoom(1) end
local function GainFocus(self) self:stoptweening():smooth(.125):zoom(1.25) end
local function BGFitInputActor(choices, lose_focus, gain_focus)
	local curr_choice= BackgroundFitMode:Reverse()[PREFSMAN:GetPreference("BackgroundFitMode")] + 1 -- reverse is 0-indexed
	local left_buttons= {MenuLeft= true, MenuUp= true}
	local right_buttons= {MenuRight= true, MenuDown= true}
	local saw_press= false
	if not lose_focus then
		lua.ReportScriptError("BGFitInputActor not given a lose_focus function.")
		lose_focus= function() end
	end
	if not gain_focus then
		lua.ReportScriptError("BGFitInputActor not given a gain_focus function.")
		gain_focus= function() end
	end
	local function check_choice_and_change_focus(focus_func)
		if choices[curr_choice] then
			focus_func(choices[curr_choice])
		else
			lua.ReportScriptError("BGFitInputActor not given a choice actor for the " .. BackgroundFitMode[curr_choice] .. " mode.")
		end
	end
	local function input(event)
		if event.type == "InputEventType_Release" then return false end
		if event.type == "InputEventType_Repeat" and not saw_press then
			return false
		end
		if not event.GameButton then return false end
		saw_press= true
		if left_buttons[event.GameButton] or right_buttons[event.GameButton] then
			check_choice_and_change_focus(lose_focus)
			if left_buttons[event.GameButton] then
				curr_choice= math.max(curr_choice - 1, 1)
			else
				curr_choice= math.min(curr_choice + 1, #choices)
			end
			check_choice_and_change_focus(gain_focus)
			PREFSMAN:SetPreference("BackgroundFitMode", BackgroundFitMode[curr_choice])
			SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster", "change"), true)
		elseif event.GameButton == "Start" or event.GameButton == "Back" then
			SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster", "start"), true)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		end
		return false
	end
	return Def.ActorFrame{
		Name= "input_init",
		OnCommand= function(self)
			local screen= SCREENMAN:GetTopScreen()
			screen:AddInputCallback(input)
			choices[curr_choice]:stoptweening()
			choices[curr_choice]:linear(.25)
			choices[curr_choice]:zoom(1.25)
		end
	}
end

actors[#actors+1] = BGFitInputActor(fit_choices, LoseFocus, GainFocus)

return Def.ActorFrame(actors)
