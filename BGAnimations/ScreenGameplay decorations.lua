local t = Def.ActorFrame{}

if ShowStandardDecoration("StageDisplay") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StageDisplay"))() .. {
		InitCommand=function(self)
			self:name("StageDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

return Def.ActorFrame{
    LoadFallbackB(),
    t
}