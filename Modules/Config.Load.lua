return function(key,file,Cat)	
	if not FILEMAN:DoesFileExist(file) then return false end

	local configcontent = ""

	local configfile = RageFileUtil.CreateRageFile()
	if configfile:Open(file, 1) then
		configcontent = configfile:Read()
		configfile:Close()
	end

	configfile:destroy()

	if configcontent == "" then return false end
	if Cat == nil then
		local index = string.find(configcontent,key..'=')
		if index then
			local quick_output = configcontent:sub(index+(string.len(key..'=')),-1)
			quick_output = quick_output:sub(1,string.find(quick_output,'\n')-1)
			if quick_output == "true" then return true end
			if quick_output == "false" then return false end
			return quick_output
		end
	else
		local Caty = true

		for line in string.gmatch(configcontent.."\n", "(.-)\n") do	
			for Con in string.gmatch(line, "%[(.-)%]") do
				if Con == Cat or Cat == nil then Caty = true else Caty = false end
			end	
			for KeyVal, Val in string.gmatch(line, "(.-)=(.+)") do
				if key == KeyVal and Caty then
					if Val == "true" then return true end
					if Val == "false" then return false end
					return Val 
				end
			end	
		end
	end

	return false
end