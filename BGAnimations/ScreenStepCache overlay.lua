local checked = false
local updated = false
local cancel = false
local toBeCachedTotal = 0
local alreadyCachedTotal = 0
local unableToBeCachedTotal = 0
local cachedWrongVersionTotal = 0
local errorTotal = 0

local s = 10
local ss = 100
local ani = false

local cur = 0
local c, cs

local cacheStepTypes = {
	Dance = true,
	Pump = true,
	Smx = true,
	Bm = true,
	Pnm = true,
	Techno = true
}

local stepsToCache = {}
local types = ""
local totalTypes = {}
local cachedTypes = {}
local cachedTimes = {}

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end

	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuLeft" then
			if checked and not updated then
				cur = cur - 1
				if cur%2 == 0 then c.Cursor:queuecommand("Yes") else c.Cursor:queuecommand("No") end
				SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
			end
		elseif event.GameButton == "MenuRight" then
			if checked and not updated then
				cur = cur + 1
				if cur%2 == 0 then c.Cursor:queuecommand("Yes") else c.Cursor:queuecommand("No") end
				SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
			end
		elseif event.GameButton == "Back" then
			cancel = true
			SCREENMAN:GetTopScreen():Cancel()
		elseif event.GameButton == "Start" then
			if checked then
				if updated then
					SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
					SOUND:PlayOnce(THEME:GetPathS("Common", "Start"), true)
				else
					if cur%2 == 1 then
						SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
						SOUND:PlayOnce(THEME:GetPathS("Common", "Start"), true)
					else
						checked = false
						s,ss = 10,100
						cs.Seconds:playcommand("Update")
						cs.DeciSeconds:playcommand("Update")
						c.Cursor:diffusealpha(0)
						c.YES:diffusealpha(0)
						c.NO:diffusealpha(0)
						c.UpdateImminent:diffusealpha(1):sleep(ss/10):diffusealpha(0)
						c.Cache:sleep(ss/10):queuecommand("Updating")
					end
				end
			end
		end
	end
end

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() end,
	OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="Loaded",
		Text="",
		InitCommand=function(self) self:x(SCREEN_LEFT+25*WideScreenDiff()*WideScreenDiff()):y(isFinal() and SCREEN_BOTTOM-74*WideScreenDiff() or SCREEN_BOTTOM-66*WideScreenDiff()):shadowlength(2):horizalign(left):vertalign(bottom):vertspacing(-9):maxwidth(SCREEN_WIDTH/3*2/WideScreenDiff()):zoom(0.333*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(0.75) end,
	},
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="Cached",
		Text="",
		InitCommand=function(self) self:x(SCREEN_LEFT+25*WideScreenDiff()*WideScreenDiff()+SCREEN_WIDTH/3*1/WideScreenDiff()):y(isFinal() and SCREEN_BOTTOM-74*WideScreenDiff() or SCREEN_BOTTOM-66*WideScreenDiff()):shadowlength(2):horizalign(right):vertalign(bottom):vertspacing(-9):maxwidth(SCREEN_WIDTH/3*2/WideScreenDiff()):zoom(0.333*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(0.75) end,
	},
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="Checked",
		Text="",
		InitCommand=function(self) self:x(SCREEN_LEFT+25*WideScreenDiff()*WideScreenDiff()+SCREEN_WIDTH/6*1/WideScreenDiff()):y(isFinal() and SCREEN_BOTTOM-74*WideScreenDiff() or SCREEN_BOTTOM-66*WideScreenDiff()):shadowlength(2):vertalign(bottom):vertspacing(-9):maxwidth(SCREEN_WIDTH/3*2/WideScreenDiff()):zoom(0.333*WideScreenDiff()):diffusealpha(0) end,
	},
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="TBC",
		InitCommand=function(self) self:x(SCREEN_LEFT+25*WideScreenDiff()*WideScreenDiff()):y(isFinal() and SCREEN_BOTTOM-66*WideScreenDiff() or SCREEN_BOTTOM-58*WideScreenDiff()):shadowlength(2):horizalign(left):maxwidth(SCREEN_WIDTH/3*2/WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Check") end,
		CheckCommand=function(self)
			local songs = SONGMAN:GetAllSongs()
			for curSong=1,#songs do
				local steps = songs[curSong]:GetAllSteps()
				for curStep=1,#steps do
					if steps[curStep] then
						local stepType = split("_",steps[curStep]:GetStepsType())[2]
						if cacheStepTypes[stepType] then
							if not totalTypes[stepType] then types = addToOutput(types,stepType,",") end
							totalTypes[stepType] = totalTypes[stepType] and totalTypes[stepType] + 1 or 1
						end
					end
				end
				steps = nil
			end
			local output = ""
			local total = 0
			types = split(",",types)
			table.sort(types)
			for i=1,#types do
				total = total + totalTypes[types[i]]
				output = addToOutput(output,types[i].." "..totalTypes[types[i]],"\n")
			end
			totalTypes["TOTAL"] = total
			c.Loaded:settext(output.."\n\n".."TOTAL "..total)
			songs = nil
			self:decelerate(0.5):cropleft(0):cropright(0):settext("To be cached: "..total.." Steps")
		end
	},
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="IBC",
		InitCommand=function(self) self:x(SCREEN_LEFT+25*WideScreenDiff()*WideScreenDiff()):y(isFinal() and SCREEN_BOTTOM-50*WideScreenDiff() or SCREEN_BOTTOM-42*WideScreenDiff()):shadowlength(2):horizalign(left):maxwidth(SCREEN_WIDTH/3*2/WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Check") end,
		CheckCommand=function(self)
			if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache("/Cache/Steps/") end
			local files = FILEMAN:GetDirListing("/Cache/Steps/")
			self:decelerate(0.5):cropleft(0):cropright(0):settext("In the cache: "..#files.." files")
			files = nil
		end
	},
	Def.ActorFrame{
		Name="Timer",
		InitCommand=function(self) self:x(SCREEN_LEFT+86*WideScreenDiff()):y(SCREEN_TOP+35*WideScreenDiff()):zoom(WideScreenDiff()) cs = self:GetChildren() end,
		OnCommand=function(self) self:draworder(101):addy(-100):decelerate(0.8):addy(100) end,
		OffCommand=function(self) self:accelerate(0.7):addy(-200) end,
		Def.BitmapText {
			File = "_z numbers",
			Name="Seconds",
			Text=s..".",
			InitCommand=function(self) self:stoptweening():shadowlength(0):zoom(1.1):x(2):horizalign(right) end,
			OnCommand=function(self) self:sleep(0.5):queuecommand("Update") end,
			UpdateCommand=function(self)
				if s > 0 then
					s = s - 1
					if not cancel then
						if s <= 4 then
							if not ani then
								ani = true
								c.Timer:diffuseshift():effectperiod(0.5):effectcolor1(color("1,0,0,1")):effectcolor2(color("1,0,0,0"))
							end
							c.Timer:zoom(1.3*WideScreenDiff()):linear(0.2):zoom(1*WideScreenDiff())
							SOUND:PlayOnce(THEME:GetPathS('MenuTimer',"tick"))
						end
						self:settext(s.."."):sleep(1):queuecommand("Update")
					end
				else
					ani = false
					c.Timer:stoptweening():stopeffect()
				end
			end
		},
		Def.BitmapText {
			File = "_z numbers",
			Name="DeciSeconds",
			Text=ss%10,
			InitCommand=function(self) self:stoptweening():shadowlength(0):zoom(0.85):x(1):y(2):halign(0) end,
			OnCommand=function(self) self:sleep(0.5):queuecommand("Update") end,
			UpdateCommand=function(self)
				if s > 0 or ss > 0 then
					if not cancel then
						ss = ss - 1
						self:settext((ss%10)):sleep(0.1):queuecommand("Update")
					end
				end
			end
		}
	},
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="Cache",
		Text="The StepCache will be checked in 10 seconds.\nThis might take a little while...",
		InitCommand=function(self) self:Center():zoom(0.6*WideScreenDiff()):shadowlength(2):cropleft(0.5):cropright(0.5):maxwidth(SCREEN_WIDTH/0.7/WideScreenDiff()) end,
		OnCommand=function(self) self:decelerate(0.5):cropleft(0):cropright(0):sleep(s-0.1):queuecommand("Checking") end,
		CheckingCommand=function(self) self:settext("Checking..."):sleep(0.1):queuecommand("Check") end,
		UpdatingCommand=function(self) self:settext("Updating..."):sleep(0.1):queuecommand("Update") end,
		CheckCommand=function(self)
			local songs = SONGMAN:GetAllSongs()
			local currentCacheVersion = getCacheVersion()
			if not cancel then
				local start = GetTimeSinceStart()
				for curSong=1,#songs do
					local steps = songs[curSong]:GetAllSteps()
					for curStep=1,#steps do
						if steps[curStep] and not (not isEtterna() and steps[curStep]:IsAutogen()) then
							local stepType = split("_",steps[curStep]:GetStepsType())[2]
							if cacheStepTypes[stepType] then
								local filename = split("/",steps[curStep]:GetFilename())
								if #filename >= 4 then
									local cacheFile = getStepCacheFile(steps[curStep])
									if not FILEMAN:DoesFileExist(cacheFile) then
										stepsToCache[#stepsToCache+1] = steps[curStep]
										toBeCachedTotal = toBeCachedTotal + 1
									else
										local version = LoadModule("Config.Load.lua")("Version",cacheFile)
										if version == "0" then
											unableToBeCachedTotal = unableToBeCachedTotal + 1
										elseif not version or version ~= currentCacheVersion then
											stepsToCache[#stepsToCache+1] = steps[curStep]
											alreadyCachedTotal = alreadyCachedTotal + 1
											cachedWrongVersionTotal = cachedWrongVersionTotal + 1
										else
											alreadyCachedTotal = alreadyCachedTotal + 1
										end
									end
									cacheFile = nil
								else
									errorTotal = errorTotal + 1
								end
							end
						end
					end
					steps = nil
				end
				local checkDuration = GetTimeSinceStart()-start
				c.Checked:settext("CHECK TIME "..string.format("%0.3f",checkDuration).." s ("..string.format("%0.3f",checkDuration/totalTypes["TOTAL"]*1000 or 0).." ms)"):addy(-(#types+2)*10):diffusealpha(0.75)
				checked = true
				songs = nil
				if toBeCachedTotal == 0 and cachedWrongVersionTotal == 0 then updated = true end
				self:queuecommand("Checked")
			end
		end,
		CheckedCommand=function(self)
			local typ = ""
			local add = ""

			if toBeCachedTotal > 0 and cachedWrongVersionTotal == 0 then
				typ = "cache"
			elseif toBeCachedTotal == 0 and cachedWrongVersionTotal > 0 then
				typ = "update"
			elseif toBeCachedTotal > 0 and cachedWrongVersionTotal > 0 then
				typ = "cache and update"
			else
				updated = true
			end

			if not updated then
				add = "Would you like to\n"..typ.."\n the remaining steps?"
				c.Cursor:queuecommand("Yes"):diffusealpha(1)
				c.YES:diffusealpha(1)
				c.NO:diffusealpha(1)
				self:settext("There are "..toBeCachedTotal.." steps needing to be cached...\n"..
				"There are "..alreadyCachedTotal.." steps already cached...\n"..
				"There are "..cachedWrongVersionTotal.." steps on outdated versions...\n\n"..add.."\n\n\n\n\n")
			else
				c.Cursor:diffusealpha(1)
				c.OK:diffusealpha(1)
				self:settext("The StepCache is up-to-date!")
			end
		end,
		UpdateCommand=function(self)
			if not cancel then
				setenv("cacheing",true)
				for curStep=1,#stepsToCache do
					if stepsToCache[curStep] then
						local cacheTime = GetTimeSinceStart()
						local filePath = stepsToCache[curStep]:GetFilename()
						local quickSM = filePath:sub(-2):sub(1,1) == 's'	-- [S]M & S[S]C
						--local quickBMS = filePath:sub(-3):sub(2,2) == 'm'	-- B[M]S & B[M]E & B[M]L & P[M]S
						--local quickPMS = filePath:sub(-3) == 'pms'
						--if not isOutFox() or (quickSM and isOutFoxV()) then
						if not isOutFox() then
							if quickSM then cacheStepSM(nil,stepsToCache[curStep]) else cacheStepBMS(nil,stepsToCache[curStep]) end
						else cacheStep(nil,stepsToCache[curStep]) end
						local stepType = split("_",stepsToCache[curStep]:GetStepsType())[2]
						cachedTimes[stepType] = cachedTimes[stepType] and cachedTimes[stepType] + (GetTimeSinceStart()-cacheTime) or (GetTimeSinceStart()-cacheTime)
						cachedTypes[stepType] = cachedTypes[stepType] and cachedTypes[stepType] + 1 or 1
						cachedTypes["TOTAL"] = cachedTypes["TOTAL"] and cachedTypes["TOTAL"] + 1 or 1
					end
				end
				setenv("cacheing",false)
				local output = ""
				local total = 0
				for i=1,#types do
					total = cachedTimes[types[i]] and total + cachedTimes[types[i]] or total
					output = addToOutput(output,(cachedTypes[types[i]] or 0).." ("..string.format("%0.3f",cachedTimes[types[i]] or 0).." s)","\n")
				end
				c.Cached:settext(output.."\n\n"..cachedTypes["TOTAL"].." ("..string.format("%0.3f",total).." s)")
				stepsToCache = nil
				checked = true
				updated = true
				self:queuecommand("Updated")
			end
		end,
		UpdatedCommand=function(self)
			if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache("/Cache/Steps/") end
			c.Cursor:queuecommand("Ok"):diffusealpha(1)
			c.OK:diffusealpha(1)
			self:settext("The StepCache has been updated!")
		end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("ScreenPrompt","Cursor"),
		Name="Cursor",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
		YesCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3) end,
		NoCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3) end,
		OkCommand=function(self) self:CenterX() end,
	},
	Def.BitmapText {
		File = "_r bold 30px",
		Name="OK",
		Text="OK",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
	},
	Def.BitmapText {
		File = "_r bold 30px",
		Name="YES",
		Text="Yes",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
	},
	Def.BitmapText {
		File = "_r bold 30px",
		Name="NO",
		Text="No",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
	},
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="UpdateImminent",
		Text="Update imminent...",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(0.6*WideScreenDiff()):diffusealpha(0) end,
	},
}