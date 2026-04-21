function PlayerColor( pn )
	local colors = {
		[PLAYER_1] = color("#FFDE00"),
		[PLAYER_2] = color("#14FF00")
	}
	return colors[pn] or color("1,1,1,1")
end

function PlayerColorSemi( pn )
	local colors = {
		[PLAYER_1] = color("#FFDE0080"),
		[PLAYER_2] = color("#14FF0080")
	}
	return colors[pn] or color("1,1,1,0.5")
end

function CustomDifficultyToColor( dc )
	local colors = {
		["Beginner"]	= color("#D05CF6"),
		["Easy"]		= color("#09FF10"),
		["Medium"]		= color("#F3F312"),
		["Hard"]		= color("#EA3548"),
		["Challenge"]	= color("#16AFF3"),
		["Edit"]		= color("#F7F7F7"),

		["Freestyle"]	= color("#09FF10"),
		["HalfDouble"]	= color("#F3F312"),
		["Crazy"]		= color("#EA3548"),
		["Nightmare"]	= color("#16AFF3")
	}
	return colors[dc] or color("1,1,1,1")
end

function CustomIIDXDifficultyToColor( dc )
	local colors = {
		["Beginner"]	= color("#09FF10"),
		["Easy"]		= color("#28C8F8"),
		["Medium"]		= color("#F38212"),
		["Hard"]		= color("#EA3548"),
		["Challenge"]	= color("#161616"),
		["Edit"]		= color("#AFAFAF"),

		["Freestyle"]	= color("#28C8F8"),
		["HalfDouble"]	= color("#F3F312"),
		["Crazy"]		= color("#EA3548"),
		["Nightmare"]	= color("#161616")
	}
	return colors[dc] or isGamePlay() and color("#AFAFAF") or color("1,1,1,1")
end

function ContrastingDifficultyColor( dc )
	local colors = {
		["Beginner"]	= color("#E2ABF5"),
		["Easy"]		= color("#B2FFB5"),
		["Medium"]		= color("#F2F2AA"),
		["Hard"]		= color("#EBA4AB"),
		["Challenge"]	= color("#AADCF2"),
		["Edit"]		= color("#F7F7F7"),

		["Freestyle"]	= color("#B2FFB5"),
		["HalfDouble"]	= color("#F2F2AA"),
		["Crazy"]		= color("#EBA4AB"),
		["Nightmare"]	= color("#AADCF2")
	}
	return colors[dc] or color("1,1,1,1")
end

function DifficultyToColor( dc )
	if not string.find(dc, "_") then dc = "Difficulty_"..dc end
	local colors = {
		["Difficulty_Beginner"]	= CustomDifficultyToColor("Beginner"),
		["Difficulty_Easy"]		= CustomDifficultyToColor("Easy"),
		["Difficulty_Medium"]		= CustomDifficultyToColor("Medium"),
		["Difficulty_Hard"]		= CustomDifficultyToColor("Hard"),
		["Difficulty_Challenge"]	= CustomDifficultyToColor("Challenge"),
		["Difficulty_Edit"]		= CustomDifficultyToColor("Edit"),

		["Difficulty_Freestyle"]	= CustomDifficultyToColor("Freestyle"),
		["Difficulty_HalfDouble"]	= CustomDifficultyToColor("HalfDouble"),
		["Difficulty_Crazy"]		= CustomDifficultyToColor("Crazy"),
		["Difficulty_Nightmare"]	= CustomDifficultyToColor("Nightmare")
	}
	return colors[dc] or color("1,1,1,1")
end

function TapNoteScoreToColor( tns )
	local colors = {
		["TapNoteScore_W1"]		= color("#7BE8FF"),
		["TapNoteScore_W2"]		= color("#FFA959"),
		["TapNoteScore_W3"]		= color("#67FF19"),
		["TapNoteScore_W4"]		= color("#D366FF"),
		["TapNoteScore_W5"]		= color("#FF7149"),
		["TapNoteScore_Miss"]	= color("#FF0808")
	}
	return colors[tns] or color("1,1,1,1")
end

function JudgmentCircle(radius,percents)
    local numPoints = 360
    local angleIncrement = (2 * math.pi) / numPoints
	local vertices = {}

	local colors = {color("#7BE8FF"),color("#FFA959"),color("#67FF19"),color("#D366FF"),color("#FF7149"),color("#FF0808"),color("#404040")}
	local colorsFA = {color("#7BE8FF"),color("#F7F7F7"),color("#FFA959"),color("#67FF19"),color("#D366FF"),color("#FF7149"),color("#FF0808"),color("#404040")}
	local currentPoint = 0
	local currentPercent = percents[1]
	local position = 1
	local prevX = 0
	local prevY = 0

	for i = 0, numPoints do
		local angle = i * angleIncrement
		local pointX = radius * math.cos(angle)
		local pointY = radius * math.sin(angle)
		currentPoint = i / 3.6
		if currentPoint >= currentPercent then
			while currentPoint >= currentPercent do
				position = position + 1
				currentPercent = currentPercent + (percents[position] or 100)
			end
		end

		vertices[#vertices+1] = { {0, 0, 0}, #percents == 7 and colorsFA[position] or colors[position] }
		vertices[#vertices+1] = { {prevX, prevY, 0}, #percents == 7 and colorsFA[position] or colors[position] }
		vertices[#vertices+1] = { {pointX, pointY, 0}, #percents == 7 and colorsFA[position] or colors[position] }

		prevX = pointX
		prevY = pointY
	end

	return vertices
end