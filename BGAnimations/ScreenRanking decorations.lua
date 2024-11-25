local t = Def.ActorFrame{}

if ShowStandardDecoration("Header") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "Header"))() .. {
		InitCommand=function(self)
			self:name("Header")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

return Def.ActorFrame{
	t
}