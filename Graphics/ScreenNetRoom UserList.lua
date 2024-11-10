local userList = ""

return Def.ActorFrame{
	LoadActor("ScreenNetRoom UserBox")..{
		InitCommand=function(self) self:x(-19):y(-38):zoom(2*WideScreenDiff()):halign(0):valign(0) end,
	},
	LoadFont("titlemenu")..{
		Text="Users:",
		InitCommand=function(self) self:zoom(1*WideScreenDiff()):halign(0) end,
	},
	LoadFont("_r bold 30px")..{
		Text="Loading...",
		InitCommand=function(self) self:x(-9):y(20):vertspacing(-10):zoom(1*WideScreenDiff()):halign(0):valign(0):maxwidth(200):maxheight(360) end,
		OnCommand=function(self) self:queuecommand("InitList") end,
		UsersUpdateMessageCommand=function(self) self:queuecommand("InitList") end,
		InitListCommand=function(self)
			local topScreen = SCREENMAN:GetTopScreen()
			if topScreen then
				local children = topScreen:GetChild("Users")
				if children then
					userList = ""
					if #children == 0 then
						userList = addToOutput(userList,children:GetText(),"\n")
					else
						for child in ivalues(topScreen:GetChild("Users")) do
							userList = addToOutput(userList,child:GetText(),"\n")
						end
					end
				end
			end

			self:settext(userList)
		end
	}
}