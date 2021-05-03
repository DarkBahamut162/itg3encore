function PlayerColor( pn )
	if pn == PLAYER_1 then return color("#FFDE00") end	-- oranged yellow
	if pn == PLAYER_2 then return color("#14FF00") end	-- green
	return color("1,1,1,1")
end

function DiffusePlayerColor( pn )
	if pn == PLAYER_1 then return color("#FFDE00") end	-- oranged yellow
	if pn == PLAYER_2 then return color("#14FF00") end	-- green
	return color("1,1,1,1")
end

function CustomDifficultyToColor( dc )
	if dc == "Beginner"		then return color("#D05CF6") end
	if dc == "Easy"			then return color("#09FF10") end
	if dc == "Medium"		then return color("#F3F312") end
	if dc == "Hard"			then return color("#EA3548") end
	if dc == "Challenge"	then return color("#16AFF3") end
	if dc == "Edit"			then return color("#F7F7F7") end
	return color("1,1,1,1")
end

function ContrastingDifficultyColor( dc )
	if dc == "Beginner"		then return color("#E2ABF5") end
	if dc == "Easy"			then return color("#B2FFB5") end
	if dc == "Medium"		then return color("#F2F2AA") end
	if dc == "Hard"			then return color("#EBA4AB") end
	if dc == "Challenge"	then return color("#AADCF2") end
	if dc == "Edit"			then return color("#F7F7F7") end
	return color("1,1,1,1")
end

function DifficultyToColor( dc )
	if dc == 'Difficulty_Beginner'	then return CustomDifficultyToColor("Beginner") end
	if dc == 'Difficulty_Easy'		then return CustomDifficultyToColor("Easy") end
	if dc == 'Difficulty_Medium'	then return CustomDifficultyToColor("Medium") end
	if dc == 'Difficulty_Hard'		then return CustomDifficultyToColor("Hard") end
	if dc == 'Difficulty_Expert'	then return CustomDifficultyToColor("Expert") end
	if dc == 'Difficulty_Edit'		then return CustomDifficultyToColor("Edit") end
	return color("1,1,1,1")
end
