local text = {}
local index = 1
local switch = THEME:GetMetric("HelpDisplay","TipSwitchTime")
local start = GetTimeSinceStart()

return isEtterna("0.65") and Def.BitmapText {
	File=THEME:GetPathF("HelpDisplay","text"),
	InitCommand=function(self)
		local s = THEME:GetString(Var "LoadingScreen","HelpText")
		text = split("::",s)
		self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5):maxwidth(269):queuecommand("Update")
	end,
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
	end,
	SetHelpTextCommand=function(self, params)
		text = split("::",params.Text)
		self:queuecommand("Update")
	end
	} or Def.HelpDisplay {
	File=THEME:GetPathF("HelpDisplay","text"),
	InitCommand=function(self)
		local s = THEME:GetString(Var "LoadingScreen","HelpText")
		self:SetSecsBetweenSwitches(switch)
		self:SetTipsColonSeparated(s)
		self:maxwidth(269)
	end,
	SetHelpTextCommand=function(self, params)
		self:SetTipsColonSeparated( params.Text )
	end
}