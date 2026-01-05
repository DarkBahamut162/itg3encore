local player = ...
if not GAMESTATE:IsHumanPlayer(player) then return Def.ActorFrame{} end
local style = GAMESTATE:GetCurrentStyle()
local NumColumns = style:ColumnsPerPlayer()
local width = GetTrueWidth(player)
local widthFixed = {
	["Key2"] = 28,
	["Key4"] = 28,
	["Key6"] = 28,
	["Blue"] = 28,
	["Yellow"] = 28,
	["Left Blue"] = 28,
	["Right Blue"] = 28,
	["Left Yellow"] = 28,
	["Right Yellow"] = 28,
	["Key1"] = 36,
	["Key3"] = 36,
	["Key5"] = 36,
	["Key7"] = 36,
	["Green"] = 36,
	["Left Green"] = 36,
	["Right Green"] = 36,
	["Red"] = 36,
	["Left Red"] = 36,
	["Right Red"] = 36,
	["White"] = 36,
	["Left White"] = 36,
	["Right White"] = 36,
	["foot"] = 40,
	["Foot"] = 40,
	["scratch"] = 60,
}
local columns = getenv("ShowColumns"..pname(player)) or 0
local bits = NumberToBits(columns,isOpenDDR() and 6 or 7)
local checkJudgments = {}
local judgments = {
	"TapNoteScore_Miss",
	"TapNoteScore_W5",
	"TapNoteScore_W4",
	"TapNoteScore_W3",
	"TapNoteScore_W2",
	"TapNoteScore_W1"
}

if isOpenDDR() then table.remove(judgments,2) end

for j=2,#bits do
	if bits[#bits-j+1] then
		checkJudgments[judgments[j-1]] = true
	end
end

function range(start, stop, step)
	if start == nil then return end
	if not stop then
		stop = start
		start = 1
	end

	step = step or 1

	if step > 0 and start > stop then step = -1 * step end

	local t = {}
	for i = start, stop, step do t[#t+1] = i end
	return t
end

function GetColumnMapping(player)
	local po = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Preferred')

	local shuffle = po:Shuffle() or po:SoftShuffle() or po:SuperShuffle()
	if isITGmania(20230317) then shuffle = shuffle or po:HyperShuffle() end
	local notes_inserted = (po:Wide() or po:Skippy() or po:Quick() or po:Echo() or po:BMRize() or po:Stomp() or po:Big())
	local notes_removed = (po:Little()  or po:NoHolds() or po:NoStretch() or po:NoHands() or po:NoJumps() or po:NoFakes() or po:NoLifts() or po:NoQuads() or po:NoRolls())

	if shuffle or notes_inserted or notes_removed then return nil end

	local flip = po:Flip() > 0
	local invert = po:Invert() > 0
	local left = po:Left()
	local right = po:Right()
	local mirror = po:Mirror()
	local backwards = po:Backwards()
	local udmirror = isITGmania(20240307) and po:UDMirror() or false
	local lrmirror = isITGmania(20240307) and po:LRMirror() or false

	if flip and invert then return nil end

	local has_turn = flip or invert or left or right or mirror or backwards or udmirror or lrmirror
	local style = GAMESTATE:GetCurrentStyle()
	local num_columns = style:ColumnsPerPlayer()
	local column_mapping
	local swapCount = 0
	local multi = 0

	if not has_turn then
		return range(num_columns)
	else
		if IsGame("dance") or IsGame("groove") or IsGame("solo") then
			if num_columns == 4 or num_columns == 8 then
				multi = 4
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2], column_mapping[1], column_mapping[4], column_mapping[3]} end
				if left then column_mapping = {column_mapping[2], column_mapping[4], column_mapping[1], column_mapping[3]} end
				if right then column_mapping = {column_mapping[3], column_mapping[1], column_mapping[4], column_mapping[2]} end
				if mirror then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if udmirror then column_mapping = {column_mapping[1], column_mapping[3], column_mapping[2], column_mapping[4]} end
				if lrmirror then column_mapping = {column_mapping[4], column_mapping[2], column_mapping[3], column_mapping[1]} end
			elseif num_columns == 6 or num_columns == 12 then
				multi = 6
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[3],column_mapping[2],column_mapping[1],column_mapping[6],column_mapping[5],column_mapping[4]} end
				if left and num_columns == 6 then column_mapping = {column_mapping[3],column_mapping[2],column_mapping[6],column_mapping[4],column_mapping[5],column_mapping[1]} end
				if right and num_columns == 6 then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[1],column_mapping[4],column_mapping[2],column_mapping[3]} end
				if mirror then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if udmirror and num_columns == 6 then column_mapping = {column_mapping[1],column_mapping[2],column_mapping[4],column_mapping[3],column_mapping[5],column_mapping[6]} end
				if lrmirror and num_columns == 6 then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[3],column_mapping[4],column_mapping[2],column_mapping[1]} end
			end
			if num_columns > 6 then
				for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
				if flip then swapCount = swapCount + 1 end
				if mirror then swapCount = swapCount + 1 end
				if backwards then swapCount = swapCount + 1 end
				if lrmirror then swapCount = swapCount + 1 end
				if swapCount % 2 == 1 then
					for i=1,multi do
						column_mapping[i] = column_mapping[i] + multi
						column_mapping[i+multi] = column_mapping[i+4] - multi
					end
				end
			end
		elseif IsGame("pump") then
			if num_columns == 5 or num_columns == 10 then
				multi = 5
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2],column_mapping[1],column_mapping[3],column_mapping[5],column_mapping[4]} end
				if left and not isDouble() then column_mapping = {column_mapping[2],column_mapping[4],column_mapping[3],column_mapping[5],column_mapping[1]} end
				if left and isDouble() then column_mapping = {column_mapping[4],column_mapping[5],column_mapping[3],column_mapping[1],column_mapping[2]} end
				if right and not isDouble() then column_mapping = {column_mapping[4],column_mapping[5],column_mapping[3],column_mapping[1],column_mapping[2]} end
				if mirror then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[4],column_mapping[5],column_mapping[3],column_mapping[1],column_mapping[2]} end
				if udmirror then column_mapping = {column_mapping[2],column_mapping[1],column_mapping[3],column_mapping[5],column_mapping[4]} end
				if lrmirror then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if num_columns == 10 then
					for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
					if flip then swapCount = swapCount + 1 end
					if mirror then swapCount = swapCount + 1 end
					if backwards then swapCount = swapCount + 1 end
					if lrmirror then swapCount = swapCount + 1 end
					if swapCount % 2 == 1 then
						for i=1,multi do
							column_mapping[i] = column_mapping[i] + multi
							column_mapping[i+multi] = column_mapping[i+4] - multi
						end
					end
				end
			elseif num_columns == 6 then
				multi = 6
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[1],column_mapping[2],column_mapping[3],column_mapping[4],column_mapping[5],column_mapping[6]} end
				if left then column_mapping = {column_mapping[3],column_mapping[1],column_mapping[2],column_mapping[4],column_mapping[5],column_mapping[6]} end
				if right then column_mapping = {column_mapping[1],column_mapping[3],column_mapping[1],column_mapping[4],column_mapping[5],column_mapping[6]} end
				if mirror then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[6],column_mapping[4],column_mapping[5],column_mapping[2],column_mapping[3],column_mapping[1]} end
				if udmirror then column_mapping = {column_mapping[1],column_mapping[3],column_mapping[2],column_mapping[5],column_mapping[4],column_mapping[6]} end
				if lrmirror then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
			end
		elseif IsGame("smx") then
			if num_columns == 5 or num_columns == 10 then
				multi = 5
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2],column_mapping[1],column_mapping[3],column_mapping[5],column_mapping[4]} end
				if mirror then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if num_columns == 10 then
					for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
					if flip then swapCount = swapCount + 1 end
					if mirror then swapCount = swapCount + 1 end
					if backwards then swapCount = swapCount + 1 end
					if lrmirror then swapCount = swapCount + 1 end
					if swapCount % 2 == 1 then
						for i=1,multi do
							column_mapping[i] = column_mapping[i] + multi
							column_mapping[i+multi] = column_mapping[i+4] - multi
						end
					end
				end
			elseif num_columns == 6 then
				multi = 6
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if mirror then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
			end
		elseif IsGame("techno") then
			if num_columns == 4 or (num_columns == 8 and isDouble()) then
				multi = 4
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2], column_mapping[1], column_mapping[4], column_mapping[3]} end
				if mirror then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
			elseif num_columns == 5 or num_columns == 10 then
				multi = 5
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2],column_mapping[1],column_mapping[3],column_mapping[5],column_mapping[4]} end
				if mirror then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
			elseif (num_columns == 8 and not isDouble()) or num_columns == 16 then
				multi = 8
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5]} end
				if mirror then column_mapping = {column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
			elseif num_columns == 9 or num_columns == 18 then
				multi = 9
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[5], column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6]} end
				if mirror then column_mapping = {column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
			end
			if isDouble() then
				for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
				if flip then swapCount = swapCount + 1 end
				if mirror then swapCount = swapCount + 1 end
				if backwards then swapCount = swapCount + 1 end
				if swapCount % 2 == 1 then
					for i=1,multi do
						column_mapping[i] = column_mapping[i] + multi
						column_mapping[i+multi] = column_mapping[i+4] - multi
					end
				end
			end
		elseif IsGame("beat") or IsGame("be-mu") then
			if num_columns == 6 or num_columns == 12 then
				multi = 6
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[6], column_mapping[5], column_mapping[4]} end
				if mirror or (backwards and isDouble()) then column_mapping = {column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards and not isDouble() then column_mapping = {column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[6]} end
			elseif num_columns == 7 or num_columns == 14 then
				multi = 7
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1] } end
				if invert then column_mapping = {column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[4], column_mapping[7], column_mapping[6], column_mapping[5] } end
				if mirror then column_mapping = {column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1] } end
				if backwards then column_mapping = {column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1] } end
			elseif num_columns == 8 or num_columns == 16 then
				multi = 8
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1] } end
				if invert then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5] } end
				if mirror or (backwards and isDouble()) then column_mapping = {column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1] } end
				if backwards and not isDouble() then column_mapping = {column_mapping[1], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2] } end
			end
			if isDouble() then
				for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
				if flip then swapCount = swapCount + 1 end
				if mirror then swapCount = swapCount + 1 end
				if backwards then swapCount = swapCount + 1 end
				if lrmirror then swapCount = swapCount + 1 end
				if swapCount % 2 == 1 then
					for i=1,multi do
						column_mapping[i] = column_mapping[i] + multi
						column_mapping[i+multi] = column_mapping[i+4] - multi
					end
				end
			end
		elseif IsGame("popn") or IsGame("po-mu") then
			if num_columns == 3 then
				multi = 3
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[3], column_mapping[2], column_mapping[1]} end
				if mirror then column_mapping = {column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[3], column_mapping[2], column_mapping[1]} end
			elseif num_columns == 4 then
				multi = 4
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2], column_mapping[1], column_mapping[4], column_mapping[3]} end
				if mirror then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
			elseif num_columns == 5 then
				multi = 5
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2], column_mapping[1], column_mapping[3], column_mapping[5], column_mapping[4]} end
				if mirror then column_mapping = {column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
			elseif num_columns == 7 then
				multi = 7
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[4], column_mapping[7], column_mapping[6], column_mapping[5]} end
				if mirror then column_mapping = {column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
			elseif num_columns == 9 or num_columns == 18 then
				multi = 9
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[5], column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6]} end
				if mirror then column_mapping = {column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if backwards then column_mapping = {column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
			end
			if isDouble() then
				for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
				if flip then swapCount = swapCount + 1 end
				if mirror then swapCount = swapCount + 1 end
				if backwards then swapCount = swapCount + 1 end
				if lrmirror then swapCount = swapCount + 1 end
				if swapCount % 2 == 1 then
					for i=1,multi do
						column_mapping[i] = column_mapping[i] + multi
						column_mapping[i+multi] = column_mapping[i+4] - multi
					end
				end
			end
		else
			return nil
		end
	end

	return column_mapping
end

function GetColumnMappingITG(player)
	local po = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Preferred')

	local shuffle = po:Shuffle() or po:SoftShuffle() or po:SuperShuffle()
	if isITGmania(20230317) then shuffle = shuffle or po:HyperShuffle() end
	local notes_inserted = (po:Wide() or po:Skippy() or po:Quick() or po:Echo() or po:BMRize() or po:Stomp() or po:Big())
	local notes_removed = (po:Little()  or po:NoHolds() or po:NoStretch() or po:NoHands() or po:NoJumps() or po:NoFakes() or po:NoLifts() or po:NoQuads() or po:NoRolls())

	if shuffle or notes_inserted or notes_removed then return nil end

	local flip = po:Flip() > 0
	local invert = po:Invert() > 0

	if flip and invert then return nil end

	local has_turn = flip or invert
	local style = GAMESTATE:GetCurrentStyle()
	local num_columns = style:ColumnsPerPlayer()
	local column_mapping
	local swapCount = 0
	local multi = 0

	if not has_turn then
		return range(num_columns)
	else
		if IsGame("dance") or IsGame("groove") or IsGame("solo") then
			if num_columns == 4 or num_columns == 8 then
				multi = 4
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2], column_mapping[1], column_mapping[4], column_mapping[3]} end
			elseif num_columns == 6 or num_columns == 12 then
				multi = 6
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[3],column_mapping[2],column_mapping[1],column_mapping[6],column_mapping[5],column_mapping[4]} end
			end
			if num_columns > 6 then
				for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
				if swapCount % 2 == 1 then
					for i=1,multi do
						column_mapping[i] = column_mapping[i] + multi
						column_mapping[i+multi] = column_mapping[i+4] - multi
					end
				end
			end
		elseif IsGame("pump") then
			if num_columns == 5 or num_columns == 10 then
				multi = 5
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2],column_mapping[1],column_mapping[3],column_mapping[5],column_mapping[4]} end
				if num_columns == 10 then
					for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
					if flip then swapCount = swapCount + 1 end
					if swapCount % 2 == 1 then
						for i=1,multi do
							column_mapping[i] = column_mapping[i] + multi
							column_mapping[i+multi] = column_mapping[i+4] - multi
						end
					end
				end
			elseif num_columns == 6 then
				multi = 6
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[1],column_mapping[2],column_mapping[3],column_mapping[4],column_mapping[5],column_mapping[6]} end
			end
		elseif IsGame("smx") then
			if num_columns == 5 or num_columns == 10 then
				multi = 5
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2],column_mapping[1],column_mapping[3],column_mapping[5],column_mapping[4]} end
				if num_columns == 10 then
					for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
					if flip then swapCount = swapCount + 1 end
					if swapCount % 2 == 1 then
						for i=1,multi do
							column_mapping[i] = column_mapping[i] + multi
							column_mapping[i+multi] = column_mapping[i+4] - multi
						end
					end
				end
			elseif num_columns == 6 then
				multi = 6
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[6],column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
			end
		elseif IsGame("techno") then
			if num_columns == 4 or (num_columns == 8 and isDouble()) then
				multi = 4
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2], column_mapping[1], column_mapping[4], column_mapping[3]} end
			elseif num_columns == 5 or num_columns == 10 then
				multi = 5
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[5],column_mapping[4],column_mapping[3],column_mapping[2],column_mapping[1]} end
				if invert then column_mapping = {column_mapping[2],column_mapping[1],column_mapping[3],column_mapping[5],column_mapping[4]} end
			elseif (num_columns == 8 and not isDouble()) or num_columns == 16 then
				multi = 8
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5]} end
			elseif num_columns == 9 or num_columns == 18 then
				multi = 9
				column_mapping = range(multi)
				if flip then column_mapping = {column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6], column_mapping[5], column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1]} end
				if invert then column_mapping = {column_mapping[4], column_mapping[3], column_mapping[2], column_mapping[1], column_mapping[5], column_mapping[9], column_mapping[8], column_mapping[7], column_mapping[6]} end
			end
			if isDouble() then
				for i=1,multi do column_mapping[multi+i] = column_mapping[i] + multi end
				if flip then swapCount = swapCount + 1 end
				if swapCount % 2 == 1 then
					for i=1,multi do
						column_mapping[i] = column_mapping[i] + multi
						column_mapping[i+multi] = column_mapping[i+4] - multi
					end
				end
			end
		else
			return nil
		end
	end

	return column_mapping
end

local NoteFieldMiddle = (THEME:GetMetric("Player","ReceptorArrowsYStandard")+THEME:GetMetric("Player","ReceptorArrowsYReverse"))/2
local mods = string.find(GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
local reverse = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):UsingReverse()
if mods then reverse = not reverse end
local posY = reverse and THEME:GetMetric("Player","ReceptorArrowsYReverse") or THEME:GetMetric("Player","ReceptorArrowsYStandard")

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny

local totalDelta = 0
local tmpDelta = 0
local checking = true
local first = true
local c
local noteData = {}
local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSong() or GAMESTATE:GetCurrentSong()
local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSteps() or GAMESTATE:GetCurrentSteps(player)
trueFirst = tonumber(LoadFromCache(SongOrCourse,StepsOrTrail,"TrueFirstBeat"))
local GCM = GetColumnMapping(player)
local GCM_ITG = GetColumnMappingITG(player)

function setCol()
	noteData = {}
	local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSong() or GAMESTATE:GetCurrentSong()
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSteps() or GAMESTATE:GetCurrentSteps(player)
	trueFirst = tonumber(LoadFromCache(SongOrCourse,StepsOrTrail,"TrueFirstBeat"))
	local timingData = StepsOrTrail:GetTimingData()
	local chartint = 1

	if isOutFox(20200400) then
		if not isOutFoxV043() then
			for i,current in pairs( SongOrCourse:GetAllSteps() ) do
				if current == StepsOrTrail then
					chartint = i
					break
				end
			end
		end
		noteData = isOutFoxV043() and StepsOrTrail:GetNoteData(trueFirst,trueFirst) or SongOrCourse:GetNoteData(chartint,trueFirst,trueFirst)
	else
		local filePath = StepsOrTrail:GetFilename():lower()
		if filePath:sub(-2):sub(1,1) == 's' or filePath:sub(-3):sub(1,1) == 'd' then
			local firstRow = LoadFromCache(SongOrCourse,StepsOrTrail,"FirstRow")
			local check = {
				["L"] = true,
				["1"] = true,
				["2"] = true,
				["4"] = true,
			}
			for i=1, string.len(firstRow) do
				if check[firstRow:sub(i,i)] then
					noteData[#noteData+1] = {"",i}
					break
				end
			end
		else
			local firstRow = split("_",LoadFromCache(SongOrCourse,StepsOrTrail,"FirstRow"))
			local notes = NumColumns
			if IsGame("be-mu") or IsGame("beat") then 
				if isDouble() then
					local add = ((notes == 14 and player == PLAYER_2) or notes < 14) and 0 or 1
					local half = notes / 2
					for note in ivalues(firstRow) do
						if note == "11" or note == "51" then noteData[#noteData+1] = {"",1+add} end
						if note == "12" or note == "52" then noteData[#noteData+1] = {"",2+add} end
						if note == "13" or note == "53" then noteData[#noteData+1] = {"",3+add} end
						if note == "14" or note == "54" then noteData[#noteData+1] = {"",4+add} end
						if note == "15" or note == "55" then noteData[#noteData+1] = {"",5+add} end
						if note == "16" or note == "56" then noteData[#noteData+1] = {"",1+(7*(1-add))} end
						if note == "17" or note == "57" then noteData[#noteData+1] = {"",6+add} end
						if note == "18" or note == "58" then noteData[#noteData+1] = {"",6+add} end
						if note == "19" or note == "59" then noteData[#noteData+1] = {"",7+add} end
						if note == "21" or note == "61" then noteData[#noteData+1] = {"",half+1} end
						if note == "22" or note == "62" then noteData[#noteData+1] = {"",half+2} end
						if note == "23" or note == "63" then noteData[#noteData+1] = {"",half+3} end
						if note == "24" or note == "64" then noteData[#noteData+1] = {"",half+4} end
						if note == "25" or note == "65" then noteData[#noteData+1] = {"",half+5} end
						if note == "26" or note == "66" then noteData[#noteData+1] = {"",half+8} end
						if note == "27" or note == "67" then noteData[#noteData+1] = {"",half} end
						if note == "28" or note == "68" then noteData[#noteData+1] = {"",half+6} end
						if note == "29" or note == "69" then noteData[#noteData+1] = {"",half+7} end
					end
				else
					local add = ((notes == 7 and player == PLAYER_2) or notes < 7) and 0 or 1
					for note in ivalues(firstRow) do
						if note == "11" or note == "51" then noteData[#noteData+1] = {"",1+add} end
						if note == "12" or note == "52" then noteData[#noteData+1] = {"",2+add} end
						if note == "13" or note == "53" then noteData[#noteData+1] = {"",3+add} end
						if note == "14" or note == "54" then noteData[#noteData+1] = {"",4+add} end
						if note == "15" or note == "55" then noteData[#noteData+1] = {"",5+add} end
						if note == "16" or note == "56" then noteData[#noteData+1] = {"",1+(7*(1-add))} end
						if note == "17" or note == "57" then noteData[#noteData+1] = {"",6+add} end
						if note == "18" or note == "58" then noteData[#noteData+1] = {"",6+add} end
						if note == "19" or note == "59" then noteData[#noteData+1] = {"",7+add} end
					end
				end
			else
				local add = notes-9
				for note in ivalues(firstRow) do
					if note == "11" or note == "51" then noteData[#noteData+1] = {"",1+add} end
					if note == "12" or note == "52" then noteData[#noteData+1] = {"",2+add} end
					if note == "13" or note == "53" then noteData[#noteData+1] = {"",3+add} end
					if note == "14" or note == "54" then noteData[#noteData+1] = {"",4+add} end
					if note == "15" or note == "55" then noteData[#noteData+1] = {"",5+add} end
					if note == "22" or note == "62" then noteData[#noteData+1] = {"",6+add} end
					if note == "23" or note == "63" then noteData[#noteData+1] = {"",7+add} end
					if note == "24" or note == "64" then noteData[#noteData+1] = {"",8+add} end
					if note == "25" or note == "65" then noteData[#noteData+1] = {"",9+add} end
				end
			end
		end
	end

	local style = GAMESTATE:GetCurrentStyle()
	local num_columns = style:ColumnsPerPlayer()
	if IsGame("dance") or IsGame("groove") or IsGame("solo") or IsGame("pump") or IsGame("techno") or IsGame("beat") or IsGame("be-mu") or IsGame("popn") or IsGame("po-mu") then
		for i,note in ipairs( noteData ) do
			noteData[i][2] = GCM[noteData[i][2]]
		end
		if isITGmania() then
			for i,note in ipairs( noteData ) do
				noteData[i][2] = GCM_ITG[noteData[i][2]]
			end
		end
	end
end

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1/60 and checking then
		tmpDelta = totalDelta
		local YoffsetBeat = ArrowEffects.GetYOffset(GAMESTATE:GetPlayerState(player),1,trueFirst)/64
		local currentBeat = GAMESTATE:GetSongPosition():GetSongBeatVisible()
		if YoffsetBeat < 6 and first then
			for note in ivalues( noteData ) do
				if first then c["Column"..note[2]]:accelerate(0.1):diffuse(0,0,0,0) end
			end
			if first then first = false end
		elseif YoffsetBeat < 0 then
			checking = false
		elseif YoffsetBeat >= 6 then
			for _,note in ipairs( noteData ) do
				if not first then c["Column"..note[2]]:decelerate(0.1):diffuse(Color("White")) end
			end
			if not first then first = true end
		end
    end
end

if columns > 0 then
	local t = Def.ActorFrame{
		InitCommand=function(self) c = self:GetChildren() end,
		CurrentSongChangedMessageCommand=function(self)
			if bits[#bits] then
				checking,first = true,true
				setCol()
				for _,note in pairs( noteData ) do c["Column"..note[2]]:diffuse(Color("White")) end
			end
		end,
		OnCommand=function(self)
			if bits[#bits] then
				setCol()
				for _,note in pairs( noteData ) do c["Column"..note[2]]:diffuse(Color("White")) end
				self:SetUpdateFunction(Update)
			end
		end
	}

	for ColumnIndex = 1, NumColumns do
		local player = PLAYER_1
		local info = style:GetColumnInfo(player, ColumnIndex)

		t[#t+1] = Def.Quad{
			Name="Column"..(isITGmania() and GCM_ITG[ColumnIndex] or ColumnIndex),
			InitCommand=function(self)
				self:diffuse(0,0,0,0)
					:x(info.XOffset)
					:y(SCREEN_CENTER_Y+(posY-NoteFieldMiddle)/currentMini):valign(0)
					:setsize(widthFixed[info.Name] and widthFixed[info.Name] or width/NumColumns, (SCREEN_HEIGHT-math.abs(posY-NoteFieldMiddle))/currentMini)
					:fadebottom(0.333):fadetop(0.333)
				if reverse then self:rotationz(180) end
			end,
			JudgmentMessageCommand = function(self, params)
				if params.Player ~= player then return end
				if not params.TapNoteScore then return end
				if GAMESTATE:GetCurrentGame():CountNotesSeparately() then
					if params.FirstTrack ~= ColumnIndex - 1 then return end
					if params.Player == player and params.Notes then
						local tnt = ToEnumShortString(params.Notes[ColumnIndex]:GetTapNoteType())
						if "Column"..ColumnIndex == self:GetName() then
							if tnt == "Tap" or tnt == "HoldHead" or tnt == "LongNoteHead" or tnt == "Lift" then
								if checkJudgments[params.TapNoteScore] then
									self:stoptweening():diffuse(TapNoteScoreToColor(params.TapNoteScore)):accelerate(0.165):diffuse(0,0,0,0)
								end
							end
						end
					end
				else
					if params.Player == player and params.Notes then
						for i,col in pairs(params.Notes) do
							local tnt = ToEnumShortString(col:GetTapNoteType())
							if "Column"..i == self:GetName() then
								if tnt == "Tap" or tnt == "HoldHead" or tnt == "LongNoteHead" or tnt == "Lift" then
									if checkJudgments[params.TapNoteScore] then
										self:stoptweening():diffuse(TapNoteScoreToColor(params.TapNoteScore)):accelerate(0.165):diffuse(0,0,0,0)
									end
								end
							end
						end
					end
				end
			end
		}
	end

	return t
else
	return Def.ActorFrame{}
end