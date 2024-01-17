return function(file)
	if not FILEMAN:DoesFileExist(file) then return {} end

	local configfile = RageFileUtil.CreateRageFile()
	configfile:Open(file, 1)

	local configcontent = configfile:Read()

	configfile:Close()
	configfile:destroy()

	return configcontent
end