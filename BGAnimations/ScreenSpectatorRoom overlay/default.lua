local function InputHandler(event)
	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "Back" or event.GameButton == "Select" then
			local topScreen = SCREENMAN:GetTopScreen()
			if topScreen then
				topScreen:SetNextScreenName("ScreenOnlineLobbies")
				MESSAGEMAN:Broadcast("LeaveLobby")
				topScreen:StartTransitioningScreen("SM_GoToNextScreen")
				SCREENMAN:PlayCancelSound()
			end
		end
	end
end
local isPlaying = false
local index = -1
local collectiveIndex = -1

return Def.ActorFrame{
	InitCommand=function(self) self:Center() end,
	OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	Def.ActorFrame{
		Name="List",
		InitCommand=function(self) self:xy(-SCREEN_CENTER_X,-SCREEN_CENTER_Y) end,
		OnlineLobbyStateMessageCommand=function(self,params)
			for i=1,9 do
				self:GetChild("Slots"):GetChild("Slot"..i):settext("")
				self:GetChild("Slots"):GetChild("Position"..i):visible(false)
			end
			local inGameplay = 0
			local isReady = 0
			for i,player in ipairs(params and params.players or {}) do
				if string.find(player.screenName,"ScreenGameplay") or string.find(player.screenName,"ScreenEvaluation") then inGameplay = inGameplay + 1 end
				if player.ready == true then isReady = isReady + 1 end
				if params.songInfo and params.songInfo.courseMode then
					if player.songPath == params.songInfo.songPath then
						if player.index and collectiveIndex < player.index then
							collectiveIndex = player.index
						end
					end
				end
			end
			local playing = (#(params.players or {}) == isReady or playing) and inGameplay == isReady and inGameplay+isReady > 0
			if playing and params.songInfo.courseMode then
				isPlaying = index == collectiveIndex
				index = collectiveIndex
			end
			if playing and not isPlaying then
				isPlaying = playing
				local SongOrCourse = params.songInfo.courseMode and SONGMAN:FindCourse(params.songInfo.songPath) or SONGMAN:FindSong(params.songInfo.songPath)
				
				local group = params.songInfo.songPath:split("/")[1] or ""
				local groupBanner = ""
				local songBanner = ""
				if #(params.players or {}) == isReady and inGameplay == isReady then
					if params.songInfo.courseMode then
						groupBanner = SongOrCourse:GetBannerPath()
						if SongOrCourse:AllSongsAreFixed() then
							SOUND:StopMusic()
							songBanner = SongOrCourse:GetCourseEntry(collectiveIndex):GetSong():GetBannerPath()
							SOUND:PlayMusicPart(SongOrCourse:GetCourseEntry(collectiveIndex):GetSong():GetMusicPath(),0,-1,0,0,false,false)
						end
					else
						groupBanner = SONGMAN:GetSongGroupBannerPath(group)
						songBanner = SongOrCourse:GetBannerPath()
						SOUND:PlayMusicPart(SongOrCourse:GetMusicPath(),0,-1,0,0,false,false)
					end
				end

				if not groupBanner or groupBanner == "" then groupBanner = THEME:GetPathG("Common","fallback banner") end
				if not songBanner or songBanner == "" then songBanner = THEME:GetPathG("Common","fallback banner") end

				self:GetChild("Group"):visible(true)
				self:GetChild("Song"):visible(true)
				self:GetChild("Group"):GetChild("Banner"):LoadBackground(groupBanner)
				self:GetChild("Song"):GetChild("Banner"):LoadBackground(songBanner)
				self:GetChild("Group"):GetChild("Name"):settext(params.songInfo.courseMode and SongOrCourse:GetDisplayFullTitle() or group)
				self:GetChild("Song"):GetChild("Name"):settext(params.songInfo.courseMode and SongOrCourse:GetCourseEntry(collectiveIndex):GetSong():GetDisplayFullTitle() or SongOrCourse:GetDisplayFullTitle())
			elseif not playing then
				self:GetChild("Group"):visible(false)
				self:GetChild("Song"):visible(false)
				isPlaying = playing
				SOUND:StopMusic()
				index = -1
				collectiveIndex = -1
			end
			for i,player in ipairs(params and params.players or {}) do
				if i <= 9 then
					self:GetChild("Slots"):GetChild("Position"..i):visible(true)
					local profile = player.profileName or player.name or player.playerId or ("Player "..i)
					local add = "(is in "..player.screenName..")"
					local coloring = {}
					local begin = 0
					local playerColor = color("#FFFFFF")
					if string.find(player.screenName,"ScreenGameplay") then add = player.ready and "&START;" or "&SELECT;" end
					if playing then
						add = ""

						begin = string.len(profile..add)+1
						add = addToOutput(add,player.judgments["fantasticPlus"],"|")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+1-begin, COLOR = TapNoteScoreToColor("TapNoteScore_W1")}
						begin = string.len(profile..add)+2
						add = addToOutput(add,player.judgments["fantastic"],"|")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+1-begin, COLOR = color("#C0C0C0")}
						begin = string.len(profile..add)+2
						add = addToOutput(add,player.judgments["excellent"],"|")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+1-begin, COLOR = TapNoteScoreToColor("TapNoteScore_W2")}
						begin = string.len(profile..add)+2
						add = addToOutput(add,player.judgments["great"],"|")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+1-begin, COLOR = TapNoteScoreToColor("TapNoteScore_W3")}
						begin = string.len(profile..add)+2
						add = addToOutput(add,player.judgments["decent"],"|")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+1-begin, COLOR = TapNoteScoreToColor("TapNoteScore_W4")}
						begin = string.len(profile..add)+2
						add = addToOutput(add,player.judgments["wayOff"],"|")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+1-begin, COLOR = TapNoteScoreToColor("TapNoteScore_W5")}
						begin = string.len(profile..add)+2
						add = addToOutput(add,player.judgments["miss"],"|")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+1-begin, COLOR = TapNoteScoreToColor("TapNoteScore_Miss")}
						if tonumber(player.judgments["totalHolds"]) > 0 or tonumber(player.judgments["totalRolls"]) > 0 then
							add = addToOutput(add,player.judgments["holdsHeld"]," | H ")
							add = addToOutput(add,player.judgments["totalHolds"],"/")
						end
						if tonumber(player.judgments["totalRolls"]) > 0 then
							add = addToOutput(add,player.judgments["rollsHeld"]," | R ")
							add = addToOutput(add,player.judgments["totalRolls"],"/")
						end
						if tonumber(player.judgments["totalMines"]) > 0 then
							add = addToOutput(add,player.judgments["minesHit"]," | M ")
							add = addToOutput(add,player.judgments["totalMines"],"/")
						end
						begin = string.len(profile..add)+3
						add = addToOutput(add,string.format("%5.2f",player.exScore or 0)," | ")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+2-begin, COLOR = color("#C0C0C0")}
						begin = string.len(profile..add)+4
						add = addToOutput(add,string.format("%5.2f",player.score or 0),"% | ")
						coloring[#coloring+1] = {FIRST = begin, LAST = string.len(profile..add)+2-begin, COLOR = TapNoteScoreToColor("TapNoteScore_W1")}
						add = addToOutput(add,"","%")
						if player.songPath~=params.songInfo.songPath then
							playerColor = color("#FF0000")
						elseif player.difficulty~=params.songInfo.difficulty then
							playerColor = color("#FFFF00")
						end
					end
					self:GetChild("Slots"):GetChild("Slot"..i):settext(profile.." "..add):ClearAttributes()
					for pair in ivalues(coloring) do
						self:GetChild("Slots"):GetChild("Slot"..i):diffuse(playerColor):AddAttribute(pair.FIRST,{Length=pair.LAST,Diffuse=pair.COLOR})
					end
					self:GetChild("Slots"):GetChild("Position"..i):settext(i..".")
				else
					--lua.ReportScriptError(rin_inspect(player))
				end
			end
		end,
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenOptions","page/service page"),
			InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end,
			SearchOnMessageCommand=function(self) self:visible(true) end,
			SearchOffMessageCommand=function(self) self:visible(false) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenOptions","overlay/_frame"),
			InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end
		},
		Def.ActorFrame{
			Name="Slots",
			Def.BitmapText {
				Name="Position1",
				File = "_v 26px bold white",
				Text="1.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y-119*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position2",
				File = "_v 26px bold white",
				Text="2.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y-91*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position3",
				File = "_v 26px bold white",
				Text="3.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y-63*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position4",
				File = "_v 26px bold white",
				Text="4.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y-35*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position5",
				File = "_v 26px bold white",
				Text="5.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y-7*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position6",
				File = "_v 26px bold white",
				Text="6.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y+21*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position7",
				File = "_v 26px bold white",
				Text="7.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y+49*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position8",
				File = "_v 26px bold white",
				Text="8.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y+77*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Position9",
				File = "_v 26px bold white",
				Text="9.",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-277*WideScreenDiff(),SCREEN_CENTER_Y+105*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(18):halign(1):shadowlength(0):visible(false) end
			},
			Def.BitmapText {
				Name="Slot1",
				File = "_v 26px bold white",
				Text="Waiting for response...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-119*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot2",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-91*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot3",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-63*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot4",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-35*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot5",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-7*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot6",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+21*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot7",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+49*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot8",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+77*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			},
			Def.BitmapText {
				Name="Slot9",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+105*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(565):halign(0):shadowlength(0) end
			}
		},
		Def.ActorFrame{
			Name="Group",
			InitCommand=function(self) self:visible(false) end,
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenEvaluation","underlay/evaluation banner mask"),
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-200,SCREEN_CENTER_Y+170):zoom(0.75):zbuffer(true):blend(Blend.NoEffect):zwrite(true):ztest(false) end,
			},
			Def.Sprite {
				Name = "Banner",
				InitCommand=function(self)
					self:xy(SCREEN_CENTER_X-200,SCREEN_CENTER_Y+170):scaletoclipped((isFinal() and 170 or 174)*0.75,(isFinal() and 64 or 68)*0.75):ztest(true):zbuffer(true):zwrite(false)
				end,
			},
			Def.Sprite {
				Texture = THEME:GetPathG("ScreenEvaluation","_BannerFrame"..(isFinal() and "Final" or "Normal")),
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-200,SCREEN_CENTER_Y+170):zoom(0.75):ztest(false) end,
			},
			Def.BitmapText {
				Name = "Name",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-200,SCREEN_CENTER_Y+137):maxwidth(360):zoom(0.5):shadowlength(0) end
			}
		},
		Def.ActorFrame{
			Name="Song",
			InitCommand=function(self) self:visible(false) end,
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenEvaluation","underlay/evaluation banner mask"),
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+200,SCREEN_CENTER_Y+170):zoom(0.75):zbuffer(true):blend(Blend.NoEffect):zwrite(true):ztest(false) end,
			},
			Def.Sprite {
				Name = "Banner",
				InitCommand=function(self)
					self:xy(SCREEN_CENTER_X+200,SCREEN_CENTER_Y+170):scaletoclipped((isFinal() and 170 or 174)*0.75,(isFinal() and 64 or 68)*0.75):ztest(true):zbuffer(true):zwrite(false)
				end,
			},
			Def.Sprite {
				Texture = THEME:GetPathG("ScreenEvaluation","_BannerFrame"..(isFinal() and "Final" or "Normal")),
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+200,SCREEN_CENTER_Y+170):zoom(0.75):ztest(false) end,
			},
			Def.BitmapText {
				Name = "Name",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+200,SCREEN_CENTER_Y+137):maxwidth(360):zoom(0.5):shadowlength(0) end
			}
		}
	}
}