return function(list,file)
    local configcontent = ""
	
    for key,val in pairs( list ) do
		configcontent = configcontent..key.."="..val.."\n"
	end

    local configfile = RageFileUtil.CreateRageFile()
	if configfile:Open(file, 2) then
		configfile:Write(configcontent)
		configfile:Close()
	end

	configfile:destroy()
end