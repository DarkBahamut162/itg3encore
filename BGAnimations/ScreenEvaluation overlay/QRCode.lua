local qrencode = loadfile(THEME:GetPathB("ScreenEvaluation", "overlay/qrencode.lua"))()
local url, size, player = unpack(...)
if not GAMESTATE:IsHumanPlayer(player) or not isGrooveStats(player) then return Def.ActorFrame{} end

url =  url or ""
size = size or 150

local verts = {}
local ok, tab_or_message = qrencode.qrcode( url )

for c, column in ipairs(tab_or_message) do
	for m, module in ipairs(column) do
		local clr = (module > 0) and Color.Black or Color.White
		table.insert( verts, {{m-1, c-1, 0}, clr } )
		table.insert( verts, {{m,   c-1, 0}, clr } )
		table.insert( verts, {{m,   c,   0}, clr } )
		table.insert( verts, {{m-1, c,   0}, clr } )
	end
end

local pixel_size = size/#tab_or_message
local qr = Def.ActorFrame{}

qr[#qr+1] = Def.Quad{
	InitCommand=function(self)
		self:zoom(size + pixel_size * 2)
		self:addx(size/2):addy(size/2)
	end
}

qr[#qr+1] = Def.ActorMultiVertex{
	Name="QRCodeData",
	InitCommand=function(self)
		self:SetDrawState({Mode="DrawMode_Quads"})
		self:SetVertices(verts)
		self:zoom(pixel_size)
	end,
	HideCommand=function(self)
		for vert in ivalues(verts) do
			vert[2] = color("0.1,0.1,0.1")
		end
		self:SetVertices(verts)
	end
}

return qr