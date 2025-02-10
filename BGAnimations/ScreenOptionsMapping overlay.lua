local lockmode = false
local backingout = true
local CurSel  = 1

local Buttons = {
	{"Button A", {145,-13,0.6} },
	{"Button B", {185,-50,0.6} },
	{"Button X", {105,-50,0.6} },
	{"Button Y", {145,-90,0.6} },
	{"Back", {-42,-52,0.4} },
	{"Guide", {0,0,0.4} },
	{"Start", {42,-52,0.4} },
	{"Axis 1 Press", {-148,-52,1} },
	{"Axis 2 Press", {72,34,1} },
	{"Left Bumper", {-148,-140,0.8} },
	{"Right Bumper", {148,-140,0.8} },
	{"Hat Up", {-76,0,0.6} },
	{"Hat Down", {-76,80,0.6} },
	{"Hat Left", {-118,38,0.6} },
	{"Hat Right", {-118/4,38,0.6} },
	{"Axis 1 x", {-148,-52,0.9,0} },
	{"Axis 1 y", {-148,-52,0.9,90} },
	{"Axis 2 x", {72,34,0.9,0} },
	{"Axis 2 y", {72,34,0.9,90} },
	{"Trigger Left", {-130,-180,0.8} },
	{"Trigger Right", {130,-180,0.8} }
}

local Mapping = {
	"a",
	"b",
	"x",
	"y",
	"back",
	"guide",
	"start",
	"leftstick",
	"rightstick",
	"leftshoulder",
	"rightshoulder",
	"dpup",
	"dpdown",
	"dpleft",
	"dpright",
	"leftx",
	"lefty",
	"rightx",
	"righty",
	"lefttrigger",
	"righttrigger"
}

local ButMap = {
	["b0"] = 0,
	["b1"] = 1,
	["b2"] = 2,
	["b3"] = 3,
	["b4"] = 4,
	["b5"] = 5,
	["b6"] = 6,
	["b7"] = 7,
	["b8"] = 8,
	["b9"] = 9,
	["b10"] = 10,
	["b11"] = 11,
	["b12"] = 12,
	["b13"] = 13,
	["b14"] = 14,
	["b15"] = 15,
	["b16"] = 16,
	["b17"] = 17,
	["b18"] = 18,
	["h0.0"] = 19,
	["h0.1"] = 20,
	["h0.2"] = 21,
	["h0.3"] = 22,
	["h0.4"] = 23,
	["h0.5"] = 24,
	["h0.6"] = 25,
	["h0.7"] = 26,
	["h0.8"] = 27,
	["h0.9"] = 28,
	["a0"] = 29,
	["a1"] = 30,
	["a2"] = 31,
	["a3"] = 32,
	["a4"] = 33,
	["a5"] = 34,
	["a6"] = 35,
	["a7"] = 36,
}

local function Move(offset, self)
	CurSel = CurSel + offset
	if CurSel > #Buttons then CurSel = 1 end
	if CurSel < 1 then CurSel = #Buttons end
	self:GetChild("CurBut"):settext(Buttons[CurSel][1]):xy( Buttons[CurSel][2][1], Buttons[CurSel][2][2]-40 )
	self:GetChild("SelectCircle"):xy( Buttons[CurSel][2][1], Buttons[CurSel][2][2] ):zoom( Buttons[CurSel][2][3] ):visible( CurSel < 16 or CurSel > 19 )
	self:GetChild("SelectSide"):xy( Buttons[CurSel][2][1], Buttons[CurSel][2][2] ):zoom( Buttons[CurSel][2][3] ):visible( CurSel >= 16 and CurSel <= 19 )
	:rotationz( Buttons[CurSel][2][4] and Buttons[CurSel][2][4] or 0 )
end


return Def.ActorFrame{
	InitCommand=function(self) self:zoom(math.min(2/3,WideScreenDiff())) end,
	Def.Sprite{
		Texture=THEME:GetPathG("","ControllerMockup"),
		OnCommand=function(self) self:zoom(1.4) end
	},
	Def.Sprite{
		Name="SelectCircle",
		Texture=THEME:GetPathG("","ControllerSelectionCircle"),
		OnCommand=function(self)
			-- First button it selects is A. move it to that.
			self:xy( Buttons[CurSel][2][1], Buttons[CurSel][2][2] ):zoom( Buttons[CurSel][2][3] )
		end
	},
	Def.Sprite{
		Name="SelectSide",
		Texture=THEME:GetPathG("","ControllerSelectionSide"),
		OnCommand=function(self)
			-- First button it selects is A. move it to that.
			self:xy( Buttons[CurSel][2][1], Buttons[CurSel][2][2] ):zoom( Buttons[CurSel][2][3] )
		end
	},
	Def.BitmapText{
		Text=Screen.String("Instruction"),
		Name="Controller",
		Font="Common Normal",
		OnCommand=function(self) self:y(-260) end
	},
	Def.BitmapText{
		Text=Buttons[CurSel][1], 
		Name="CurBut",
		Font="Common Normal",
		OnCommand=function(self)
			self:shadowlength(3)
			self:xy( Buttons[CurSel][2][1], Buttons[CurSel][2][2]-40 ):zoom( Buttons[CurSel][2][3] )
		end
	},
	StartCommand=function(self)
		if not lockmode then
			lockmode = true
			self:GetChild("CurBut"):settext( THEME:GetString("ScreenOptionsMapping","PressButton") )
		end
	end,
	MenuLeftCommand=function(self) if not lockmode then Move(-1,self) end end,
	MenuRightCommand=function(self) if not lockmode then Move(1,self) end end,
	MenuUpCommand=function(self) if not lockmode then Move(-1,self) end	end,
	MenuDownCommand=function(self) if not lockmode then Move(1,self) end end,
	OnCommand=function(self)
		self:Center()
		INPUTFILTER:ResetMapping()
		SCREENMAN:GetTopScreen():AddInputCallback(LoadModule("Lua.InputSystem.lua")(self))
	end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(LoadModule("Lua.InputSystem.lua")(self)) end,
	BackCommand=function(self)
		if lockmode then
			self:GetChild("CurBut"):settext(Buttons[CurSel][1])
			lockmode = false
		elseif backingout then
			backingout = false
			INPUTFILTER:SaveMapping()
			SCREENMAN:GetTopScreen():SetNextScreenName(SCREENMAN:GetTopScreen():GetPrevScreenName())
			self:sleep(1):queuecommand("Go")
		end
	end,
	GoCommand=function(self)
		if self.dID then
			INPUTFILTER:SaveMapping() -- Need to do it twice to fix mapping
			INPUTFILTER:OpenController(self.dID)
		end
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
	end,
	MappingButtonMessageCommand=function(self,Params)
		if lockmode then
			self.dID = Params.dID
			self:GetChild("Controller"):settext(Params.cName.."("..Params.cID..")")
			print(Params.cID.."("..Params.cName.."):"..Params.cBut)
			self:GetChild("CurBut"):settext(Buttons[CurSel][1])
			INPUTFILTER:MapButton(Params.cGUID, Params.cName, Params.cID, Mapping[CurSel]..":"..Params.cBut, ButMap[Params.cBut])
			lockmode = false
		end
	end
}