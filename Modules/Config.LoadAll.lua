return function(file)
	local Container = {}
	local configfile = RageFileUtil.CreateRageFile()
	local configcontent = ""

	if configfile:Open(file, 1) then
		configcontent = configfile:Read()
		configfile:Close()
	end
	configfile:destroy()

	for line in string.gmatch(configcontent.."\n", "(.-)\n") do
		for KeyVal, Val in string.gmatch(line, "(.-)=(.+)") do
			Container[KeyVal] = Val
		end
	end

	return Container
end