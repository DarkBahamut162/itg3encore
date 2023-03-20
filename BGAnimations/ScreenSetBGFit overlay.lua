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

actors[#actors+1] = BGFitInputActor(fit_choices, LoseFocus, GainFocus)

return Def.ActorFrame(actors)
