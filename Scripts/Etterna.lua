--Etterna is so terrible, is doesn't have the following things:

function IsUsingWideScreen()
	local curAspect = GetScreenAspectRatio()
	return curAspect > (16/10-.044)
end

if isEtterna() and not IniFile.StrToKeyVal then
	IniFile.StrToKeyVal = function( str )
		local key, value = str:match( "(.+)=(.*)" )
		if value == nil then value = "" return key,value end
		if tonumber(value) ~= nil then value = tonumber(value) return key,value end
		if value == "true" then value = true elseif value == "false" then value = false end
		return key, value
	end
end