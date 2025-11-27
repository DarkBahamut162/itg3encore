local userList = ""

return Def.ActorFrame{
	Def.Sprite {
		Texture = "ScreenNetRoom UserBox",
		InitCommand=function(self) self:x(-19):y(-38):zoom(2*WideScreenDiff()):halign(0):valign(0) end,
	},
	Def.BitmapText {
		File = "titlemenu",
		Text="Users:",
		InitCommand=function(self) self:zoom(1*WideScreenDiff()):halign(0) end,
	},
	Def.BitmapText {
		File = "_r bold 30px",
		Text="Loading...",
		InitCommand=function(self) self:x(-9):y(20):vertspacing(-10):zoom(1*WideScreenDiff()):halign(0):valign(0):maxwidth(200):maxheight(360) end,
		OnCommand=function(self) self:queuecommand("InitList") end,
		UsersUpdateMessageCommand=function(self) self:queuecommand("InitList") end,
		InitListCommand=function(self)
			local topScreen = SCREENMAN:GetTopScreen()
			if topScreen then
				local children = isEtterna("0.64") and NSMAN:GetLobbyUserList() or topScreen:GetChild("Users")
				if children then
					userList = ""
					if isEtterna("0.64") then
						for i = 1, #children do
							userList = addToOutput(userList,children[i],"\n")
						end
					else
						if #children == 0 then
							userList = addToOutput(userList,children:GetText(),"\n")
						else
							for child in ivalues(topScreen:GetChild("Users")) do
								userList = addToOutput(userList,child:GetText(),"\n")
							end
						end
					end
				end
			end

			self:settext(userList)
		end
	}
}