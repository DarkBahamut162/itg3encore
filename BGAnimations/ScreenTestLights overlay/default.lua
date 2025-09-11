local totalDelta = 0
local tmpDelta = 0

local cabinet = ""
local controller = ""
local check = ""

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1.0/60 then
		tmpDelta = totalDelta
		local text = split("\n",SCREENMAN:GetTopScreen():GetChild("Text"):GetText())
		if #text >= 2 then
			if cabinet ~= text[#text-2] then
				cabinet = text[#text-2]
				check = split(" ",cabinet)
				MESSAGEMAN:Broadcast("CabinetReset")
				if check[#check] == "-----" then else
					MESSAGEMAN:Broadcast(check[#check])
				end
			end
			if controller ~= text[#text-1] then
				controller = text[#text-1]
				check = split(" ",controller)
				MESSAGEMAN:Broadcast("GameButtonReset")
				if check[#check] == "-----" then else
					MESSAGEMAN:Broadcast(check[#check]..check[#check-2])
				end
			end
		end
	end
end

return Def.ActorFrame{
	Def.ActorFrame{
		OnCommand=function(self) self:SetUpdateFunction(Update) end,
		Condition=true,
		Def.Sprite {
			Texture = "cab",
			InitCommand=function(self) self:x(SCREEN_LEFT+140):y(SCREEN_CENTER_Y-20) end,
			OnCommand=function(self) self:blend(Blend.Add) end
		},

		Def.Sprite {
			Texture = "floor",
			InitCommand=function(self) self:x(SCREEN_RIGHT-280):y(SCREEN_CENTER_Y-40) end
		},
		Def.Sprite {
			Texture = "floor",
			InitCommand=function(self) self:x(SCREEN_RIGHT-140):y(SCREEN_CENTER_Y-40) end
		},

		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+40):y(SCREEN_CENTER_Y-212):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeUpLeftMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+40):y(SCREEN_CENTER_Y-138):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeLrLeftMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+241):y(SCREEN_CENTER_Y-212):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeUpRightMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+241):y(SCREEN_CENTER_Y-138):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeLrRightMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "but",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+97):y(SCREEN_CENTER_Y+19.5) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			ButtonsLeftMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "but",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+182):y(SCREEN_CENTER_Y+19.5) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			ButtonsRightMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "neo",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+70):y(SCREEN_CENTER_Y+88) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			BassLeftMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "neo",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+211):y(SCREEN_CENTER_Y+88) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			BassRightMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-322):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			LeftP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0):zoomx(-1):x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			RightP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-280):y(SCREEN_CENTER_Y-89):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			UpP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0):zoomy(-1):x(SCREEN_RIGHT-280):y(SCREEN_CENTER_Y-5):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			DownP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-182):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			LeftP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0):zoomx(-1):x(SCREEN_RIGHT-98):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			RightP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-140):y(SCREEN_CENTER_Y-89):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			UpP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0):zoomy(-1):x(SCREEN_RIGHT-140):y(SCREEN_CENTER_Y-5):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			DownP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		}
	},

	Def.ActorFrame{
		Condition=false,
		Def.Sprite {
			Texture = "ddrcab",
			InitCommand=function(self) self:x(SCREEN_LEFT+140):y(SCREEN_CENTER_Y-18) end,
			OnCommand=function(self) self:blend(Blend.Add) end
		},

		Def.Sprite {
			Texture = "u_floor",
			InitCommand=function(self) self:x(SCREEN_RIGHT-280):y(SCREEN_CENTER_Y-40) end
		},
		Def.Sprite {
			Texture = "u_floor",
			InitCommand=function(self) self:x(SCREEN_RIGHT-140):y(SCREEN_CENTER_Y-40) end
		},

		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+55):y(SCREEN_CENTER_Y-193):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeUpLeftMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+55):y(SCREEN_CENTER_Y-138):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeLrLeftMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+226):y(SCREEN_CENTER_Y-193):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeUpRightMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "hal",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+226):y(SCREEN_CENTER_Y-138):blend(Blend.Add) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.15):diffusealpha(0) end,
			MarqueeLrRightMessageCommand=function(self) self:finishtweening():accelerate(.085):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "u_but",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+111):y(SCREEN_CENTER_Y+3.75) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			ButtonsLeftMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_but",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+171):y(SCREEN_CENTER_Y+3.75) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			ButtonsRightMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "u_neo",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+76):y(SCREEN_CENTER_Y+105) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			BassLeftMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_neo",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_LEFT+204):y(SCREEN_CENTER_Y+105) end,
			CabinetResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			BassRightMessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "u_b",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-322):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			LeftP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_b",
			InitCommand=function(self) self:diffusealpha(0):zoomx(-1):x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			RightP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_r",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-280):y(SCREEN_CENTER_Y-89):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			UpP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_r",
			InitCommand=function(self) self:diffusealpha(0):zoomy(-1):x(SCREEN_RIGHT-280):y(SCREEN_CENTER_Y-5):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			DownP1MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},

		Def.Sprite {
			Texture = "u_b",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-182):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			LeftP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_b",
			InitCommand=function(self) self:diffusealpha(0):zoomx(-1):x(SCREEN_RIGHT-98):y(SCREEN_CENTER_Y-47):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			RightP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_r",
			InitCommand=function(self) self:diffusealpha(0):x(SCREEN_RIGHT-140):y(SCREEN_CENTER_Y-89):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			UpP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		},
		Def.Sprite {
			Texture = "u_r",
			InitCommand=function(self) self:diffusealpha(0):zoomy(-1):x(SCREEN_RIGHT-140):y(SCREEN_CENTER_Y-5):blend(Blend.Add) end,
			GameButtonResetMessageCommand=function(self) self:finishtweening():decelerate(.02):diffusealpha(0) end,
			DownP2MessageCommand=function(self) self:stoptweening():accelerate(.03):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening() end
		}
	}
}