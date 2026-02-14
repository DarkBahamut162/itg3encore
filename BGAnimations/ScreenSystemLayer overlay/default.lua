local showData = {
	[PLAYER_1] = false,
	[PLAYER_2] = false
}

local function CreditsText(pn)
	local text = Def.BitmapText {
		File = THEME:GetPathF(Var "LoadingScreen", "credits"),
		InitCommand=function(self)
			self:name("Credits"..PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end,
		UpdateTextCommand=function(self)
			local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn)
			if str == "" then str = "PLAYER "..(pn == PLAYER_1 and "1" or "2") end
			local data = nil
			if showData[pn] and PROFILEMAN:IsPersistentProfile(pn) then data = GetData(pn) self:settext("LV"..data["LV"].." | EXP "..data["EXP"].."\n"..str):vertspacing(-8) else self:settext(str) end
		end,
		EnablePlayerStatsMessageCommand=function(self,param)
			if param.PLAYER and self:GetName() == "Credits"..pname(param.PLAYER) then
				if not showData[pn] and PROFILEMAN:IsPersistentProfile(pn) then showData[pn] = true end
				self:queuecommand("UpdateText")
			end
		end,
		DisablePlayerStatsMessageCommand=function(self,param)
			if param.PLAYER and self:GetName() == "Credits"..pname(param.PLAYER) then
				if showData[pn] and PROFILEMAN:IsPersistentProfile(pn) then showData[pn] = false end
				self:queuecommand("UpdateText")
			end
		end,
		UpdateVisibleCommand=function(self)
			local screen = SCREENMAN:GetTopScreen()
			local bShow = true
			if screen then
				local sClass = screen:GetName()
				bShow = THEME:GetMetric(sClass,"ShowCreditDisplay")
			end

			self:visible(bShow)
		end
	}
	return text
end

local t = Def.ActorFrame{}

t[#t+1] = loadfile(THEME:GetPathB("ScreenSystemLayer",isEtterna() and "error" or "aux"))()
t[#t+1] = Def.ActorFrame{
	CreditsText(PLAYER_1),
	CreditsText(PLAYER_2)
}
t[#t+1] = Def.ActorFrame{
	Def.Quad{
		Name="BG",
		InitCommand=function(self) self:zoomtowidth(SCREEN_WIDTH):zoomtoheight(30):horizalign(left):vertalign(top):y(SCREEN_TOP):diffuse(color("0,0,0,0")) end,
		OnCommand=function(self) self:finishtweening():diffusealpha(0.85) end,
		OffCommand=function(self,param) self:sleep(param.TIME):linear(0.5):diffusealpha(0) end
	},
	Def.BitmapText{
		Font="Common Normal",
		Name="Text",
		InitCommand=function(self) self:maxwidth((SCREEN_WIDTH-20)*1.75):horizalign(left):vertalign(top):y(SCREEN_TOP+10):x(SCREEN_LEFT+10):shadowlength(1):diffusealpha(0) end,
		OnCommand=function(self) self:finishtweening():diffusealpha(1):zoom(0.5) end,
		OffCommand=function(self,param) self:sleep(param.TIME):linear(0.5):diffusealpha(0) end
	},
	SystemMessageMessageCommand=function(self,params)
		self:GetChild("Text"):settext(params.Message)
		local _,lines = string.gsub(params.Message,"\n","")
		local _,count = string.gsub(params.Message,".","")
		self:GetChild("BG"):zoomtoheight(10+(lines+1)*18)
		self:playcommand("On")
		if params.NoAnimate then self:finishtweening() end
		self:playcommand("Off",{TIME=count*0.1})
	end,
	HideSystemMessageMessageCommand=function(self) self:finishtweening() end
}

return t