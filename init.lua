--[[
--------------------------------------------------------------------------------
-- @author Zachary Hart
-- @copyright 2019
-- @license GPL-3.0
--------------------------------------------------------------------------------

    :::       :::     :::     :::     ::: :::::::::: :::::::::      :::      ::::::::  :::    ::: 
   :+:       :+:   :+: :+:   :+:     :+: :+:        :+:    :+:   :+: :+:   :+:    :+: :+:    :+:  
  +:+       +:+  +:+   +:+  +:+     +:+ +:+        +:+    +:+  +:+   +:+  +:+        +:+    +:+   
 +#+  +:+  +#+ +#++:++#++: +#+     +:+ +#++:++#   +#+    +:+ +#++:++#++: +#++:++#++ +#++:++#++    
+#+ +#+#+ +#+ +#+     +#+  +#+   +#+  +#+        +#+    +#+ +#+     +#+        +#+ +#+    +#+     
#+#+# #+#+#  #+#     #+#   #+#+#+#   #+#        #+#    #+# #+#     #+# #+#    #+# #+#    #+#      
###   ###   ###     ###     ###     ########## #########  ###     ###  ########  ###    ###       

--]]

local modules = (...) and (...):gsub('%.init$', '') .. ".modules." or ""

local wavedash = {
	_LICENSE = "Wavedash is provided under the GPL-3.0 license. See LICENSE.",
	_URL = "https://github.com/zthart/wavedash",
	_VERSION = "0.1.0",
	_DESCRIPTION = "A basic Wavefront .obj parser, useful for basic 3D games and concept pieces"
}

local files = {
	"object",
	"vertex",
	"face"
}

for _, file in ipairs(files) do
	wavedash[file] = require(modules..file)
end

return wavedash

