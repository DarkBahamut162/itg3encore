return function(key,value,file)
    local configcontent = ""
    local configfile = RageFileUtil.CreateRageFile()
    if configfile:Open(file, 1) then
        configcontent = configfile:Read()
		configfile:Close()
    end

	if configcontent ~= "" and string.find(configcontent,key..'=') then
		local exchange = configcontent:sub(string.find(configcontent,key..'='),-1)
		exchange = exchange:sub(1,string.find(exchange,'\n')-1)
		configcontent = configcontent:gsub(exchange, key.."="..value)
	else
		configcontent = configcontent..key.."="..value.."\n"
	end

	if configfile:Open(file, 2) then
		configfile:Write(configcontent)
		configfile:Close()
	end

	configfile:destroy()
end