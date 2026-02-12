local animate = canRender() and ThemePrefs.Get("AnimateSongTitle")
local TitleSongFade

if animate then
	TitleSongFade = LoadModule("Text.FadeSlide.lua")
else
	TitleSongFade = Def.ActorFrame{ Create = function(this) return Def.ActorFrame{} end }
end

return Def.ActorFrame{
    Def.Sprite {
		Texture = THEME:GetPathB("ScreenGameplay","overlay/_iidx_title"),
		InitCommand=function(self) self:CenterX():y(SCREEN_HEIGHT-83):zoom(WideScreenDiff()) end
	},
	Def.ActorFrame{
        Def.ActorFrame{
            TitleSongFade:Create(428)..{
                InitCommand=function(self) self:CenterX():y(SCREEN_HEIGHT-83):zoom(0.5*WideScreenDiff()) end,
                OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoomy(0.45*WideScreenDiff()) end,
            }
        },
        Def.BitmapText {
            File = "_r bold 30px",
            InitCommand=function(self) self:visible(not animate):CenterX():y(SCREEN_HEIGHT-83):maxwidth(428):diffusebottomedge(color("#dedede")) end,
            OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoomy(0.45*WideScreenDiff()):animate(0):playcommand("Update") end,
            CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end,
            UpdateCommand=function(self)
                local text = ""
                local SongOrSteps = checkBMS() and GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()) or GAMESTATE:GetCurrentSong()
                if SongOrSteps then text = checkBMS() and GetBMSTitle(SongOrSteps) or SongOrSteps:GetDisplayFullTitle() end
                local course = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or nil
                if course then text = course:GetDisplayFullTitle() .. " - " .. text end
                if animate then TitleSongFade:SetText( text ) end
                self:settext(text)
            end
        }
	}
}