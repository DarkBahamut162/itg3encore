local function LoadAI()
	if not FILEMAN:DoesFileExist("Data/AI.ini") then return {} end

	local configfile = RageFileUtil.CreateRageFile()
	configfile:Open("Data/AI.ini", 1)

	local configcontent = configfile:Read()

	configfile:Close()
	configfile:destroy()
	
	return configcontent
end

local file = split("\n",LoadAI():gsub("%\r", ""))
local AIini,AIiniOLD = {},{}
local AIiniDefault = {
	["Skill0"] = {
		["WeightMiss"] = 8,
		["WeightW5"] = 8,
		["WeightW4"] = 8,
		["WeightW3"] = 30,
		["WeightW2"] = 30,
		["WeightW1"] = 30,
		["WeightProW5"] = 0,
		["WeightProW4"] = 0,
		["WeightProW3"] = 0,
		["WeightProW2"] = 0,
		["WeightProW1"] = 0,
	},
	["Skill1"] = {
		["WeightMiss"] = 5,
		["WeightW5"] = 5,
		["WeightW4"] = 5,
		["WeightW3"] = 25,
		["WeightW2"] = 30,
		["WeightW1"] = 40,
		["WeightProW5"] = 0,
		["WeightProW4"] = 0,
		["WeightProW3"] = 0,
		["WeightProW2"] = 0,
		["WeightProW1"] = 0,
	},
	["Skill2"] = {
		["WeightMiss"] = 3,
		["WeightW5"] = 3,
		["WeightW4"] = 3,
		["WeightW3"] = 20,
		["WeightW2"] = 30,
		["WeightW1"] = 40,
		["WeightProW5"] = 0,
		["WeightProW4"] = 0,
		["WeightProW3"] = 0,
		["WeightProW2"] = 0,
		["WeightProW1"] = 0,
	},
	["Skill3"] = {
		["WeightMiss"] = 2,
		["WeightW5"] = 2,
		["WeightW4"] = 2,
		["WeightW3"] = 15,
		["WeightW2"] = 30,
		["WeightW1"] = 45,
		["WeightProW5"] = 0,
		["WeightProW4"] = 0,
		["WeightProW3"] = 0,
		["WeightProW2"] = 0,
		["WeightProW1"] = 0,
	},
	["Skill4"] = {
		["WeightMiss"] = 1,
		["WeightW5"] = 1,
		["WeightW4"] = 1,
		["WeightW3"] = 10,
		["WeightW2"] = 30,
		["WeightW1"] = 50,
		["WeightProW5"] = 0,
		["WeightProW4"] = 0,
		["WeightProW3"] = 0,
		["WeightProW2"] = 0,
		["WeightProW1"] = 0,
	},
	["Skill5"] = {
		["WeightMiss"] = 2,
		["WeightW5"] = 3,
		["WeightW4"] = 5,
		["WeightW3"] = 5,
		["WeightW2"] = 30,
		["WeightW1"] = 55,
		["WeightProW5"] = 0,
		["WeightProW4"] = 0,
		["WeightProW3"] = 0,
		["WeightProW2"] = 0,
		["WeightProW1"] = 0,
	},
	["Skill6"] = {
		["WeightMiss"] = 2,
		["WeightW5"] = 3,
		["WeightW4"] = 5,
		["WeightW3"] = 5,
		["WeightW2"] = 30,
		["WeightW1"] = 55,
		["WeightProW5"] = 0,
		["WeightProW4"] = 0,
		["WeightProW3"] = 0,
		["WeightProW2"] = 0,
		["WeightProW1"] = 0,
	}
}
local range = {
	["Skill0"] = "0-6",
	["Skill1"] = "7-12",
	["Skill2"] = "13-17",
	["Skill3"] = "18-23",
	["Skill4"] = "24-29",
	["Skill5"] = "30-34",
	["Skill6"] = "35+"
}
local SkillsDefault = { "Skill0","Skill1","Skill2","Skill3","Skill4","Skill5","Skill6" }
local WeightsDefault = { "WeightMiss","WeightW5","WeightW4","WeightW3","WeightW2","WeightW1","WeightProW5","WeightProW4","WeightProW3","WeightProW2","WeightProW1" }
local currentSkillName = ""
local totalSkills = 0
local totalWeights
local totalList
local selectHeld = false
local totalSkillNames = {}
local totalWeightNames = {}

for line = 1, #file do
	if string.find(file[line],"%[") then
		currentSkillName = file[line]:match("%[(.*)%]")
		totalSkills = totalSkills + 1
		totalWeights = 0
		totalSkillNames[totalSkills] = currentSkillName
		AIini[currentSkillName] = {}
		AIiniOLD[currentSkillName] = {}
	elseif string.len(file[line]) > 0 then
		totalWeights = totalWeights + 1
		local splitted = split("=",file[line])
		totalWeightNames[totalWeights] = splitted[1]
		AIini[currentSkillName][splitted[1]] = splitted[2]
		AIiniOLD[currentSkillName][splitted[1]] = splitted[2]
	end
end

totalList = totalWeights + 3
local skill,weight,default,prompt
local currentSkill = 1
local currentList = 1
local editing = false
local checking = false
local value = 0
local cur = 0

local function getScore(weight)
	local weights = {
		["WeightMiss"] = -12,
		["WeightW5"] = -6,
		["WeightW4"] = 0,
		["WeightW3"] = 2,
		["WeightW2"] = 4,
		["WeightW1"] = 5
	}
	return weights[weight] or 0
end

local function CalcPercent(array)
	local max = 0
	local total = 0
	for i = 1, #totalWeightNames do
		total = total + (tonumber(array[SkillsDefault[currentSkill]][WeightsDefault[i]]) * getScore(WeightsDefault[i]))
		max = max + (tonumber(array[SkillsDefault[currentSkill]][WeightsDefault[i]]) * getScore("WeightW1"))
	end
	return math.max(0,math.round(total/max*100,3))
end

local function CheckChanges()
    for skills,weights in pairs( AIini ) do
		for weight,value in pairs( weights ) do
			if tonumber(value) ~= tonumber(AIiniOLD[skills][weight]) then return true end
		end
	end
	return false
end

local function SaveAI()
	local configfile = RageFileUtil.CreateRageFile()
	local output = ""
	for i1 = 1, #totalSkillNames do
		output = addToOutput(output,"["..totalSkillNames[i1].."]","\n")
		for i2 = 1, #totalWeightNames do
			output = addToOutput(output,totalWeightNames[i2].."="..AIini[totalSkillNames[i1]][totalWeightNames[i2]],"\n")
		end
	end
	configfile:Open("Data/AI.ini", 2)
	configfile:Write(output)
	configfile:Close()
	configfile:destroy()
end


local numbers = {
	["DeviceButton_1"] = true,
	["DeviceButton_2"] = true,
	["DeviceButton_3"] = true,
	["DeviceButton_4"] = true,
	["DeviceButton_5"] = true,
	["DeviceButton_6"] = true,
	["DeviceButton_7"] = true,
	["DeviceButton_8"] = true,
	["DeviceButton_9"] = true
}

local InputHandler = function(event)
	if (not event.PlayerNumber or not event.button) and not editing then return false end
	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuLeft" then
			if selectHeld and not editing then -- changing skills
				if currentSkill - 1 < 1 then currentSkill = totalSkills else currentSkill = currentSkill - 1 end
				weight.Percent:playcommand("Update")
				weight.WeightMiss:playcommand("Update")
				weight.WeightW5:playcommand("Update")
				weight.WeightW4:playcommand("Update")
				weight.WeightW3:playcommand("Update")
				weight.WeightW2:playcommand("Update")
				weight.WeightW1:playcommand("Update")
				if totalWeights>6 then
					weight.WeightProW5:playcommand("Update")
					weight.WeightProW4:playcommand("Update")
					weight.WeightProW3:playcommand("Update")
					weight.WeightProW2:playcommand("Update")
					weight.WeightProW1:playcommand("Update")
					default.WeightProW5:playcommand("Update")
					default.WeightProW4:playcommand("Update")
					default.WeightProW3:playcommand("Update")
					default.WeightProW2:playcommand("Update")
					default.WeightProW1:playcommand("Update")
				end
				default.Percent:playcommand("Update")
				default.WeightMiss:playcommand("Update")
				default.WeightW5:playcommand("Update")
				default.WeightW4:playcommand("Update")
				default.WeightW3:playcommand("Update")
				default.WeightW2:playcommand("Update")
				default.WeightW1:playcommand("Update")
				skill.Current:playcommand("Update")
				skill.Name:playcommand("Update")
				SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "left" ) )
			elseif checking then -- changing prompt options
				cur = cur - 1
				if cur%2 == 0 then prompt.Cursor:queuecommand("Yes") else prompt.Cursor:queuecommand("No") end
				SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
			end
		elseif event.GameButton == "MenuRight" then
			if selectHeld and not editing then -- changing skills
				if currentSkill + 1 > totalSkills then currentSkill = 1 else currentSkill = currentSkill + 1 end
				weight.Percent:playcommand("Update")
				weight.WeightMiss:playcommand("Update")
				weight.WeightW5:playcommand("Update")
				weight.WeightW4:playcommand("Update")
				weight.WeightW3:playcommand("Update")
				weight.WeightW2:playcommand("Update")
				weight.WeightW1:playcommand("Update")
				if totalWeights>6 then
					weight.WeightProW5:playcommand("Update")
					weight.WeightProW4:playcommand("Update")
					weight.WeightProW3:playcommand("Update")
					weight.WeightProW2:playcommand("Update")
					weight.WeightProW1:playcommand("Update")
					default.WeightProW5:playcommand("Update")
					default.WeightProW4:playcommand("Update")
					default.WeightProW3:playcommand("Update")
					default.WeightProW2:playcommand("Update")
					default.WeightProW1:playcommand("Update")
				end
				default.Percent:playcommand("Update")
				default.WeightMiss:playcommand("Update")
				default.WeightW5:playcommand("Update")
				default.WeightW4:playcommand("Update")
				default.WeightW3:playcommand("Update")
				default.WeightW2:playcommand("Update")
				default.WeightW1:playcommand("Update")
				skill.Current:playcommand("Update")
				skill.Name:playcommand("Update")
				SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "right" ) )
			elseif checking then -- changing prompt options
				cur = cur + 1
				if cur%2 == 0 then prompt.Cursor:queuecommand("Yes") else prompt.Cursor:queuecommand("No") end
				SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
			end
		elseif event.GameButton == "MenuUp" then
			if not editing and not checking then -- changing currently selected weight
				if currentList - 1 < 1 then currentList = totalList else currentList = currentList - 1 end
				if currentList <= totalWeights then weight.Current:y((currentList-1)*16*WideScreenDiff()) else weight.Current:y(currentList*16*WideScreenDiff()) end
				SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "left" ) )
			end
		elseif event.GameButton == "MenuDown" then
			if not editing and not checking then -- changing currently selected weight
				if currentList + 1 > totalList then currentList = 1 else currentList = currentList + 1 end
				if currentList <= totalWeights then weight.Current:y((currentList-1)*16*WideScreenDiff()) else weight.Current:y(currentList*16*WideScreenDiff()) end
				SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "right" ) )
			end
		elseif event.GameButton == "Select" and not selectHeld then -- skill change switch
				SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "opened" ) )
				skill.Left:linear(0.125):diffusealpha(1)
				skill.Right:linear(0.125):diffusealpha(1)
				selectHeld = true
		elseif event.GameButton == "Back" then
			if not editing then 
				if CheckChanges() then -- changes detected | ask player to discard
					if not checking then
						SOUND:PlayOnce( THEME:GetPathS( 'MemoryCardManager', "error" ) )
						prompt.BG:diffusealpha(0.5)
						if cur%2 == 0 then prompt.Cursor:queuecommand("Yes") else prompt.Cursor:queuecommand("No") end
						prompt.Cursor:diffusealpha(1)
						prompt.Warning:diffusealpha(1)
						prompt.YES:diffusealpha(1)
						prompt.NO:diffusealpha(1)
						checking = true
					end
				else -- exit screen
					SCREENMAN:GetTopScreen():Cancel()
				end
			elseif editing then -- exit value changer
				prompt.BG:playcommand("BGOff")
				prompt.Text:linear(0.125):diffusealpha(0)
				prompt.Value:linear(0.125):diffusealpha(0)
				SOUND:PlayOnce(THEME:GetPathS("", "_prompt"), true)
			end
		elseif event.GameButton == "Start" then
			if not editing and not checking then -- setup value changer
				if currentList <= totalWeights then
					prompt.BG:playcommand("BGOn")
					prompt.Text:playcommand("Set"):linear(0.125):diffusealpha(1)
					prompt.Value:playcommand("Set"):playcommand("Update"):linear(0.125):diffusealpha(1)
					SOUND:PlayOnce(THEME:GetPathS("Common", "Start"), true)
				elseif currentList < totalWeights + 3 then
					if currentList == totalWeights + 1 then -- reset current skill
						AIini[SkillsDefault[currentSkill]] = DeepCopy(AIiniDefault[SkillsDefault[currentSkill]])
					elseif currentList == totalWeights + 2 then -- reset all skills
						AIini = DeepCopy(AIiniDefault)
						AIiniOLD = DeepCopy(AIini)
					end
					weight.Percent:playcommand("Update")
					weight.WeightMiss:playcommand("Update")
					weight.WeightW5:playcommand("Update")
					weight.WeightW4:playcommand("Update")
					weight.WeightW3:playcommand("Update")
					weight.WeightW2:playcommand("Update")
					weight.WeightW1:playcommand("Update")
					if totalWeights>6 then
						weight.WeightProW5:playcommand("Update")
						weight.WeightProW4:playcommand("Update")
						weight.WeightProW3:playcommand("Update")
						weight.WeightProW2:playcommand("Update")
						weight.WeightProW1:playcommand("Update")
					end
					SOUND:PlayOnce(THEME:GetPathS("ScreenPlayerOptions", "cancel all"), true)
				elseif currentList == totalWeights + 3 then -- save ai
					SaveAI()
					AIiniOLD = DeepCopy(AIini)
					SOUND:PlayOnce(THEME:GetPathS("", "_save"), true)
				end
			elseif editing and not checking then -- change value
				if currentList <= totalWeights then
					AIini[SkillsDefault[currentSkill]][WeightsDefault[currentList]] = tonumber(value)
					prompt.BG:playcommand("BGOff")
					prompt.Text:linear(0.125):diffusealpha(0)
					prompt.Value:linear(0.125):diffusealpha(0)
					weight.Percent:playcommand("Update")
					weight.WeightMiss:playcommand("Update")
					weight.WeightW5:playcommand("Update")
					weight.WeightW4:playcommand("Update")
					weight.WeightW3:playcommand("Update")
					weight.WeightW2:playcommand("Update")
					weight.WeightW1:playcommand("Update")
					if totalWeights>6 then
						weight.WeightProW5:playcommand("Update")
						weight.WeightProW4:playcommand("Update")
						weight.WeightProW3:playcommand("Update")
						weight.WeightProW2:playcommand("Update")
						weight.WeightProW1:playcommand("Update")
					end
					SOUND:PlayOnce(THEME:GetPathS("Common", "Start"), true)
				end
			elseif checking then
				if cur%2 == 0 then -- "YES" option selected
					SCREENMAN:GetTopScreen():Cancel()
				elseif checking and cur%2 == 1 then -- "NO" option selected
					SOUND:PlayOnce(THEME:GetPathS("Common", "Start"), true)
					prompt.BG:diffusealpha(0)
					prompt.Cursor:diffusealpha(0)
					prompt.Warning:diffusealpha(0)
					prompt.YES:diffusealpha(0)
					prompt.NO:diffusealpha(0)
					if cur%2 == 0 then prompt.Cursor:queuecommand("Yes") else prompt.Cursor:queuecommand("No") end
					checking = false
				end
			end
		elseif event.DeviceInput.button == "DeviceButton_0" then
			if value == "0" then -- value is already 0
				SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
			else -- add number to value
				value = value.."0"
				prompt.Value:playcommand("Update")
				SOUND:PlayOnce( THEME:GetPathS( 'ScreenOptions', "change" ) )
			end
		elseif numbers[event.DeviceInput.button] then -- add number to value
			if value == "0" then value = event.DeviceInput.button:sub(-1) else value = value..event.DeviceInput.button:sub(-1) end
			prompt.Value:playcommand("Update")
			SOUND:PlayOnce( THEME:GetPathS( 'ScreenOptions', "change" ) )
		elseif event.DeviceInput.button == "DeviceButton_backspace" then
			if value ~= "0" then -- erase latest number from value
				value = value:sub(1, -2)
				if value == "" then value = "0" end
				prompt.Value:playcommand("Update")
				SOUND:PlayOnce( THEME:GetPathS( 'ScreenOptions', "change" ) )
			else -- value is already 0
				SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
			end
		end
	elseif event.type == "InputEventType_Repeat" and event.DeviceInput.button == "DeviceButton_backspace" then
		if value ~= "0" then -- erase latest number from value
			value = value:sub(1, -2)
			if value == "" then value = "0" end
			prompt.Value:playcommand("Update")
			SOUND:PlayOnce( THEME:GetPathS( 'ScreenOptions', "change" ) )
		else -- value is already 0
			SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
		end
	elseif event.type == "InputEventType_Release" then
		if event.GameButton == "Select" and selectHeld then -- skill change switch
			skill.Left:linear(0.125):diffusealpha(0)
			skill.Right:linear(0.125):diffusealpha(0)
			SOUND:PlayOnce( THEME:GetPathS( 'OptionsList', "closed" ) )
			selectHeld = false
		end
	end
end

local function GetWeightPercent(array,skill)
	local total = 0

    for i,v in pairs( array[SkillsDefault[currentSkill]] ) do
		total = total + array[SkillsDefault[currentSkill]][i]
	end

	return total == 0 and 0 or math.round(array[SkillsDefault[currentSkill]][skill]/total*100,3)
end

return Def.ActorFrame{
	InitCommand=function(self) self:y(SCREEN_CENTER_Y-SCREEN_CENTER_Y*WideScreenDiff()) end,
	OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end,
	Def.ActorFrame{
		Name="Skill",
		InitCommand=function(self) self:x(SCREEN_LEFT+86*WideScreenDiff()):y(SCREEN_TOP+80*WideScreenDiff()) skill = self:GetChildren() end,
		LoadFont("_z bold 36px")..{
			Name="Current",
			InitCommand=function(self) self:shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left):diffusebottomedge(color("0.5,0.5,0.5")) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("Current Skill ("..currentSkill.."/"..totalSkills..")") end
		},
		LoadFont("_z bold 36px")..{
			Name="Default",
			Text="Default Values",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-86*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left):diffusebottomedge(color("0.75,0.75,0.75")) end
		},
		LoadFont("_z bold 36px")..{
			Name="Name",
			InitCommand=function(self) self:shadowlength(1):zoom(1/3*WideScreenDiff()):y(6*WideScreenDiff()):valign(0):halign(0):diffusebottomedge(color("1,1,0")):vertspacing(-16) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext(SkillsDefault[currentSkill].."\n(Used on Difficulty "..range[SkillsDefault[currentSkill]]..")") end
		},
		LoadFont("_v 26px bold shadow") .. {
			Name="Left",
			Text="&MENULEFT;",
			InitCommand=function(self) self:x(-6*WideScreenDiff()):y(16*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(0) end
		},
		LoadFont("_v 26px bold shadow") .. {
			Name="Right",
			Text="&MENURIGHT;",
			InitCommand=function(self) self:x(85*WideScreenDiff()):y(16*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		Name="Weight",
		InitCommand=function(self) self:x(SCREEN_LEFT+86*WideScreenDiff()):y(SCREEN_TOP+160*WideScreenDiff()) weight = self:GetChildren() end,
		Def.Quad{
			Name="Current",
			InitCommand=function(self) self:CenterX():zoomto(SCREEN_WIDTH,16*WideScreenDiff()):diffuseshift():effectcolor1(color("#bed0ff80")):effectcolor2(color("#76767640")):effectoffset(0):effectclock("timerglobal"):faderight(0.5) end
		},
		LoadFont("_z bold 36px")..{
			Name="Percent",
			InitCommand=function(self) self:y(16*-1*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left):diffusebottomedge(color("1,0,0")) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("Score: "..CalcPercent(AIini).."%") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightMiss",
			InitCommand=function(self) self:y(16*0*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("Miss: "..AIini[SkillsDefault[currentSkill]]["WeightMiss"].." ("..GetWeightPercent(AIini,"WeightMiss").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW5",
			InitCommand=function(self) self:y(16*1*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W5: "..AIini[SkillsDefault[currentSkill]]["WeightW5"].." ("..GetWeightPercent(AIini,"WeightW5").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW4",
			InitCommand=function(self) self:y(16*2*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W4: "..AIini[SkillsDefault[currentSkill]]["WeightW4"].." ("..GetWeightPercent(AIini,"WeightW4").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW3",
			InitCommand=function(self) self:y(16*3*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W3: "..AIini[SkillsDefault[currentSkill]]["WeightW3"].." ("..GetWeightPercent(AIini,"WeightW3").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW2",
			InitCommand=function(self) self:y(16*4*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W2: "..AIini[SkillsDefault[currentSkill]]["WeightW2"].." ("..GetWeightPercent(AIini,"WeightW2").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW1",
			InitCommand=function(self) self:y(16*5*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W1: "..AIini[SkillsDefault[currentSkill]]["WeightW1"].." ("..GetWeightPercent(AIini,"WeightW1").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW5",
			InitCommand=function(self) self:y(16*6*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW5: "..AIini[SkillsDefault[currentSkill]]["WeightProW5"].." ("..GetWeightPercent(AIini,"WeightProW5").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW4",
			InitCommand=function(self) self:y(16*7*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW4: "..AIini[SkillsDefault[currentSkill]]["WeightProW4"].." ("..GetWeightPercent(AIini,"WeightProW4").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW3",
			InitCommand=function(self) self:y(16*8*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW3: "..AIini[SkillsDefault[currentSkill]]["WeightProW3"].." ("..GetWeightPercent(AIini,"WeightProW3").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW2",
			InitCommand=function(self) self:y(16*9*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW2: "..AIini[SkillsDefault[currentSkill]]["WeightProW2"].." ("..GetWeightPercent(AIini,"WeightProW2").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW1",
			InitCommand=function(self) self:y(16*10*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW1: "..AIini[SkillsDefault[currentSkill]]["WeightProW1"].." ("..GetWeightPercent(AIini,"WeightProW1").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="ResetCurrent",
			Text="Reset Current Skill",
			OnCommand=function(self) self:y(16*(#totalWeightNames+1)*WideScreenDiff()):diffusebottomedge(color("0,0,1")):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end
		},
		LoadFont("_z bold 36px")..{
			Name="ResetAll",
			Text="Reset All Skills",
			OnCommand=function(self) self:y(16*(#totalWeightNames+2)*WideScreenDiff()):diffusebottomedge(color("0,0,0.5")):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end
		},
		LoadFont("_z bold 36px")..{
			Name="SaveAI",
			Text="Save AI",
			OnCommand=function(self) self:y(16*(#totalWeightNames+3)*WideScreenDiff()):diffusebottomedge(color("0,0.5,0")):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end
		}
	},
	Def.ActorFrame{
		Name="Default",
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+160*WideScreenDiff()) default = self:GetChildren() end,
		LoadFont("_z bold 36px")..{
			Name="Percent",
			InitCommand=function(self) self:y(16*-1*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left):diffusebottomedge(color("1,0,0")) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("Score: "..CalcPercent(AIiniDefault).."%") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightMiss",
			InitCommand=function(self) self:y(16*0*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("Miss: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightMiss"].." ("..GetWeightPercent(AIiniDefault,"WeightMiss").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW5",
			InitCommand=function(self) self:y(16*1*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W5: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightW5"].." ("..GetWeightPercent(AIiniDefault,"WeightW5").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW4",
			InitCommand=function(self) self:y(16*2*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W4: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightW4"].." ("..GetWeightPercent(AIiniDefault,"WeightW4").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW3",
			InitCommand=function(self) self:y(16*3*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W3: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightW3"].." ("..GetWeightPercent(AIiniDefault,"WeightW3").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW2",
			InitCommand=function(self) self:y(16*4*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W2: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightW2"].." ("..GetWeightPercent(AIiniDefault,"WeightW2").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Name="WeightW1",
			InitCommand=function(self) self:y(16*5*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("W1: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightW1"].." ("..GetWeightPercent(AIiniDefault,"WeightW1").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW5",
			InitCommand=function(self) self:y(16*6*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW5: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightProW5"].." ("..GetWeightPercent(AIiniDefault,"WeightProW5").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW4",
			InitCommand=function(self) self:y(16*7*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW4: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightProW4"].." ("..GetWeightPercent(AIiniDefault,"WeightProW4").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW3",
			InitCommand=function(self) self:y(16*8*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW3: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightProW3"].." ("..GetWeightPercent(AIiniDefault,"WeightProW3").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW2",
			InitCommand=function(self) self:y(16*9*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW2: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightProW2"].." ("..GetWeightPercent(AIiniDefault,"WeightProW2").."%)") end
		},
		LoadFont("_z bold 36px")..{
			Condition=totalWeights>6,
			Name="WeightProW1",
			InitCommand=function(self) self:y(16*10*WideScreenDiff()):shadowlength(1):zoom(1/3*WideScreenDiff()):horizalign(left) end,
			OnCommand=function(self) self:playcommand("Update") end,
			UpdateCommand=function(self) self:settext("ProW1: "..AIiniDefault[SkillsDefault[currentSkill]]["WeightProW1"].." ("..GetWeightPercent(AIiniDefault,"WeightProW1").."%)") end
		}
	},
	Def.ActorFrame{
		Name="Prompt",
		InitCommand=function(self) self:y(-SCREEN_CENTER_Y+SCREEN_CENTER_Y*WideScreenDiff()) prompt = self:GetChildren() end,
		Def.Quad{
			Name="BG",
			InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0")):diffusealpha(0) end,
			BGOnCommand=function(self) self:FullScreen():diffuse(color("0,0,0")):diffusealpha(0.5) editing = true end,
			BGOffCommand=function(self) self:FullScreen():diffuse(color("0,0,0")):diffusealpha(0) editing = false end
		},
		LoadFont("_z 36px shadowx")..{
			Name="Text",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-SCREEN_CENTER_Y/3):zoom(0.6*WideScreenDiff()):diffusealpha(0) end,
			SetCommand=function(self) self:settext("Current Value to Change: "..WeightsDefault[currentList]) end
		},
		LoadFont("_r bold 30px")..{
			Name="Value",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):diffusealpha(0) end,
			SetCommand=function(self) value = tostring(AIini[SkillsDefault[currentSkill]][WeightsDefault[currentList]]) end,
			UpdateCommand=function(self) self:settext(value and value or "0") end
		},
		LoadActor(THEME:GetPathG("ScreenPrompt","Cursor"))..{
			Name="Cursor",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
			YesCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3) end,
			NoCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3) end
		},
		LoadFont("_z 36px shadowx")..{
			Name="Warning",
			Text="Changes have been identified!\nDo you want to discard the changes?",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-SCREEN_CENTER_Y/3):zoom(0.6*WideScreenDiff()):diffusealpha(0) end
		},
		LoadFont("_r bold 30px")..{
			Name="YES",
			Text="Yes",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
		},
		LoadFont("_r bold 30px")..{
			Name="NO",
			Text="No",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
		}
	}
}