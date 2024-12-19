return function(key,file)	
	if not FILEMAN:DoesFileExist(file) then return false end

	local configfile = RageFileUtil.CreateRageFile()
	local configcontent = ""

	if configfile:Open(file, 1) then
		configcontent = configfile:Read()
		configfile:Close()
	end

	configfile:destroy()

	if configcontent == "" then return false end
	if string.find(configcontent,key..'=') then return true end
	return false
end