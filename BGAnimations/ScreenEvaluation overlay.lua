local t = Def.ActorFrame{}

if ShowStandardDecoration("StyleIcon") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StyleIcon"))() .. {
		InitCommand=function(self)
			self:name("StyleIcon")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end
if ShowStandardDecoration("StageDisplay") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StageDisplay"))() .. {
		InitCommand=function(self)
			self:name("StageDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

return Def.ActorFrame{
	loadfile(THEME:GetPathB("","_coins"))(),
	t
}