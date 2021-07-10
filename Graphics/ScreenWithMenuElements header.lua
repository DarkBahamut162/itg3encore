lua.ReportScriptError( ("Hello %s"):format(Var "LoadingScreen") )
local t = Def.ActorFrame{
	LoadActor( THEME:GetPathG("_dynamic","headers"), Var "LoadingScreen" )..{
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,30) end,
		OnCommand=function(self) self:zoom(1.3) end
	},

	Def.BitmapText{
		Font="_z bold gray 36px",
		Text=THEME:GetString( Var "LoadingScreen" , "HeaderText" ),
		InitCommand=function(self)
			self:xy(SCREEN_RIGHT-20,28):shadowlength(2):halign(1):zoom(0.5):cropright(1.3):faderight(0.1)
		end,
		OnCommand=function(self)
			self:sleep(0.2):linear(0.8):cropright(-0.3)
		end
	}
}

return t