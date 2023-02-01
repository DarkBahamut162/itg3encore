return Def.ActorFrame{
	LoadActor("OptionsList cursor normal") .. {
		Condition=not isFinal(),
		OnCommand=function(self) self:finishtweening():blend(Blend.Add):diffusealpha(0):zoomx(0.4) end,
		OptionsListOpenedMessageCommand=function(self) self:finishtweening():linear(0.2):diffusealpha(1):zoomx(1) end,
		OptionsListClosedMessageCommand=function(self) self:finishtweening():linear(0.2):diffusealpha(0):zoomx(0.4) end
	},
	LoadActor("OptionsList cursor final P1") .. {
		Condition=isFinal(),
		OnCommand=function(self) self:finishtweening():blend(Blend.Add):diffusealpha(0):zoomx(0.4) end,
		OptionsListOpenedMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.2):diffusealpha(1):zoomx(1.5)
			end
		end,
		OptionsListClosedMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.2):diffusealpha(0):zoomx(0.4)
			end
		end
	},
	LoadActor("OptionsList cursor final P2") .. {
		Condition=isFinal(),
		OnCommand=function(self) self:finishtweening():blend(Blend.Add):diffusealpha(0):zoomx(0.4) end,
		OptionsListOpenedMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.2):diffusealpha(1):zoomx(1.5)
			end
		end,
		OptionsListClosedMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.2):diffusealpha(0):zoomx(0.4)
			end
		end
	},
	LoadActor("_p1 left cursor") .. {
		OnCommand=function(self) self:finishtweening():addx(-75):zoom(0.6):diffusealpha(0) end,
		OptionsListOpenedMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():diffusealpha(0)
			end
		end,
		OptionsListLeftMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListStartMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPopMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPushMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListResetMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end
	},
	LoadActor("_p1 right cursor") .. {
		OnCommand=function(self) self:finishtweening():addx(75):zoom(0.6):diffusealpha(0) end,
		OptionsListOpenedMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():diffusealpha(0)
			end
		end,
		OptionsListRightMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListStartMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPopMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPushMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListResetMessageCommand=function(self,params)
			if params.Player == PLAYER_1 then
				self:finishtweening():diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end
	},
	LoadActor("_p2 left cursor") .. {
		OnCommand=function(self) self:finishtweening():addx(-75):zoom(0.6):diffusealpha(0) end,
		OptionsListOpenedMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():diffusealpha(0)
			end
		end,
		OptionsListLeftMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListStartMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPopMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPushMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListResetMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end
	},
	LoadActor("_p2 right cursor") .. {
		OnCommand=function(self) self:finishtweening():addx(75):zoom(0.6):diffusealpha(0) end,
		OptionsListOpenedMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():diffusealpha(0)
			end
		end,
		OptionsListRightMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListStartMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPopMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListPushMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():linear(0.1):diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end,
		OptionsListResetMessageCommand=function(self,params)
			if params.Player == PLAYER_2 then
				self:finishtweening():diffusealpha(1):linear(0.1):diffusealpha(0)
			end
		end
	}
}