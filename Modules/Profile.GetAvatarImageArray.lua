return function()
    local result = {}
    local dir = "/Appearance/Avatars/"

    for name in ivalues(FILEMAN:GetDirListing(dir, false, false)) do
        if name ~= "Put here Avatars with your Profile Name" then
            result[#result+1] = {name, dir..name}
        end
    end

    return result
end