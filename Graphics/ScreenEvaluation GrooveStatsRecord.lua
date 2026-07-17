local player = ...
assert(player,"[ScreenEvaluation IIDXClearRecord] requires player")

local text = {}
local index = 1
local switch = THEME:GetMetric("HelpDisplay","TipSwitchTime")
local start = GetTimeSinceStart()

local HelpDisplay = isEtterna("0.65") and Def.ActorFrame{
	Def.BitmapText {
		File=THEME:GetPathF("HelpDisplay","text"),
		InitCommand=function(self)
			self:shadowlength(0):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5)
			self:zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):vertspacing(-10):sleep(3):maxwidth(333)
			self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF"))
		end,
		["GrooveStatsRecord"..pname(player).."MessageCommand"]=function(self,params) text = split("::",params.Text) self:queuecommand("Update") end,
		UpdateCommand=function(self)
			if #text == 1 then
				self:settext(text[1])
			else
				local current = GetTimeSinceStart()
				if current-start >= switch then
					start = current
					if #text == index then index = 1 else index = index + 1 end
				end

				self:settext(text[index]):sleep(1/60):queuecommand("Update")
			end
		end
	}
} or Def.ActorFrame{
	Def.HelpDisplay {
		File=THEME:GetPathF("HelpDisplay", "text"),
		InitCommand=function(self)
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):vertspacing(-10):hibernate(3):maxwidth(333)
		end,
		["GrooveStatsRecord"..pname(player).."MessageCommand"]=function(self,params) self:SetTipsColonSeparated(params.Text) end,
		OnCommand=function(self) self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}

return HelpDisplay