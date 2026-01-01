local DanceStage = getenv("SelectDanceStage") or "OFF"
local function CharaAnimRate(self)
	local SPos = GAMESTATE:GetSongPosition()
	local mRate = GAMESTATE:GetSongOptionsObject("ModsLevel_Current"):MusicRate()
	local bpm = round(GAMESTATE:GetSongBPS() * 60 * mRate, 3)
	local spdRate = 1

	if getenv("CharacterSync") == "BPM Sync" then
		if bpm <= 130 then
			spdRate = (0.004*bpm)+0.4
		elseif bpm >= 250 then
			spdRate = ((1/750)*bpm)+(2/3)
		elseif bpm >= 400 then
			spdRate = 1.2
		end
	end

	if _VERSION ~= 5.3 and HasVideo() and VideoStage() then
		if not SPos:GetFreeze() and not SPos:GetDelay() then
			spdRate = spdRate
		else
			spdRate = 0.1
		end
	end
		
	self:SetUpdateRate(spdRate)
end

local t = Def.ActorFrame{}

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	if not GAMESTATE:IsDemonstration() then
		if getenv("SelectCharacter"..pn) == "Random" then
			GAMESTATE:SetCharacter(pn,getenv("CharaRandom"..pn))
		else
			GAMESTATE:SetCharacter(pn,getenv("SelectCharacter"..pn))
		end
	else
		local DemoChara = GetAllCharacterNames()
		table.remove(DemoChara,IndexKey(DemoChara,"Random"))
		table.remove(DemoChara,IndexKey(DemoChara,"None"))
		GAMESTATE:SetCharacter(pn,DemoChara[math.random(#DemoChara)])
	end
end

if GAMESTATE:IsDemonstration() then
	Listed = {
		GAMESTATE:GetCharacter(PLAYER_1):GetDisplayName(),
		GAMESTATE:GetCharacter(PLAYER_2):GetDisplayName()
	}
else
	Listed = {
		GAMESTATE:GetCharacter(PLAYER_1):GetDisplayName(),
		GAMESTATE:GetCharacter(PLAYER_2):GetDisplayName(),
		getenv("Mate1"),
		getenv("Mate2"),
		getenv("Mate3"),
		getenv("Mate4"),
		getenv("Mate5"),
		getenv("Mate6")
	}
end

if not BothPlayersEnabled() then table.remove(Listed,2) end

for i=1,#Listed do
	for i=1,#Listed do
		if Listed[i] == "None" then table.remove(Listed,IndexKey(Listed,"None")) end
		if Listed[i] == "Random" then
			local CharaRandom = GetAllCharacterNames()
			table.remove(CharaRandom,IndexKey(CharaRandom,"Random"))
			table.remove(CharaRandom,IndexKey(CharaRandom,"None"))
			Listed[i]=CharaRandom[math.random(#CharaRandom)]
		end
	end
end

function CharacterInfoo(Chara,Read)
	local CharaCfg = "/Characters/"..Chara.."/character.ini";
	local Info = Config.Load(Read,CharaCfg)
	return Info
end

function NewChara(Chara)
	if CharacterInfoo("Size",Chara) ~= nil then
		return true
	else
		return false
	end
end

Gender = {}
Size = {}

for i=1,#Listed do
	Gender[i]=CharacterInfoo(Listed[i],"Genre")
	Size[i]=CharacterInfoo(Listed[i],"Size")
end

if #Listed > 0 then
	t[#t+1] = loadfile("/Characters/DanceRepo/DRoutines.lua")()

	if #Listed == 1 then
		PositionX={0}
		PositionZ={0}
	elseif #Listed == 2 then
		PositionX={7,-7}
		PositionZ={0,0}
	elseif #Listed == 3 and BothPlayersEnabled() then
		PositionX={10,-10,0}
		PositionZ={-2,-2,6}
	elseif #Listed == 3 and not BothPlayersEnabled() then
		PositionX={0,10,-10}
		PositionZ={-2,6,6}
	elseif #Listed == 4 then
		PositionX={7,-7,15,-15}
		PositionZ={-2,-2,9,9}
	elseif #Listed == 5 then
		PositionX={8,-8,17,0,-17}
		PositionZ={-2,-2,9,9,9}
	elseif #Listed == 6 then
		PositionX={16,-16,22,10,-10,-22}
		PositionZ={-4,-4,7,7,7,7}
	elseif #Listed == 7 then
		PositionX={8,-8,23,16,0,-16,-23}
		PositionZ={-4,-4,5,15,10,15,5}
	elseif #Listed == 8 then
		PositionX={7,-7,23,18,12,-12,-18,-23}
		PositionZ={-4,-4,-14,4,14,14,4,-14}
	end

	function GetMotionLength()
		local index = IndexKey(MotionsLenght, Motion)
		local success, result = pcall(function() return MotionsLenght[index + 1] end)
		if success then
			return result
		else
			return 0
		end
	end

	local SongLength = GAMESTATE:GetCurrentSong():MusicLengthSeconds()
	local MotionLength = GetMotionLength()
	if MotionLength ~= nil and (MotionLength-2) > SongLength then
		Delta = MotionLength - SongLength
		Position=(math.random(0,Delta))
	else
		Position = 0
	end

	function DSInfo(Read)
		local StageIni = "/DanceStages/"..DanceStage.."/Stage.ini"
		local Info = Config.Load(Read,StageIni)
		if FILEMAN:DoesFileExist(StageIni) and Info~=nil then
			local Info = Config.Load(Read,StageIni)
			return Info
		else
			return "No"
		end
	end

	for i=1,#Listed do
		if tonumber(CharacterInfoo(Listed[i],"Size")) <= 0.5 then
			ShadowModel = "Model_Small.txt"
		elseif tonumber(CharacterInfoo(Listed[i],"Size")) == 0 then
			ShadowModel = "None.txt"
		else
			ShadowModel = "Model.txt"
		end
	end

	for i,pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
		t[#t + 1] =	Def.ActorFrame {
			OnCommand = function(self) self:queuecommand('Animate') end,
			AnimateCommand = function(self) self:SetUpdateFunction(CharaAnimRate) end,
			Def.Model {
				Meshes="/Characters/"..Listed[i].."/model.txt",
				Materials="/Characters/"..Listed[i].."/model.txt",
				Bones="/Characters/DanceRepo/"..Gender[i].."/"..Gender[i].." "..Motion..".txt",
				OnCommand=function(self)
					self:cullmode("CullMode_None"):zoom(Size[i]):x(PositionX[i]):z(PositionZ[i]):position(Position)
					if not GAMESTATE:IsDemonstration() then self:diffuse(color(DSInfo(getenv("SNEnv")) or "#ffffff")) end
				end
			}
		}

		if DSInfo("Mirrored")=="No" and getenv("CharaShadow") == "ON" then
			t[#t+1] = Def.ActorFrame {
				OnCommand = function(self) self:queuecommand('Animate') end,
				AnimateCommand = function(self) self:SetUpdateFunction(CharaAnimRate) end,
				Def.Model {
					Meshes="/Characters/DanceRepo/Shadow/"..ShadowModel,
					Materials="/Characters/DanceRepo/Shadow/Model.txt",
					Bones="/Characters/DanceRepo/Shadow/Dance/"..Gender[i].." "..Motion..".txt",
					OnCommand=function(self)
						self:cullmode("CullMode_None"):zoom(Size[i]):x(PositionX[i]):z(PositionZ[i]):position(Position)
					end
				}
			}
		end
	end
end

return t