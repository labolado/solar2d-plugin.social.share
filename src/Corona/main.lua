local platform = system.getInfo("platform")

local txt
local source
local function logOnScreen(...)
	local args = {...}
	for i=1, #args do
	    args[i] = tostring(args[i])
	end
	local text = table.concat(args, " ")
	if txt == nil then
		txt = display.newText(text, display.contentCenterX, 50, native.systemFont, 10)
	else
		txt.text = text
		txt.isVisible = true
	end
	txt:setFillColor(1, 0, 1, 1)
	-- _D(...)
	if source then
		timer.cancel(source)
	end
	source = timer.performWithDelay(4000, function()
		-- txt:removeSelf()
		txt.isVisible = false
	end)
end

local function write( path, data, baseDir )

    path = system.pathForFile( path, baseDir or system.DocumentsDirectory )

    local file = io.open( path, "wb" )

    if file then
        file:write( data )
        io.close( file )
        file = nil
    end

end

local view = display.newText("HelloWorld", display.contentCenterX, display.contentCenterY, native.systemFont, 20)
view:setFillColor(1, 0, 0, 1)

timer.performWithDelay(1000, function()
    display.save(view, {filename="view.png", baseDir=system.DocumentsDirectory, captureOffscreenArea=true})
    local share = require("plugin.social.share")
    print(share)
    logOnScreen(share)
    share.init()
    share.popUp({
        imageName = "view.png", -- name of png in system.DocumentsDirectory
        message = "HellowWorld!",
        url = "http://www.baidu.com",
        origin = { x=0, y=0 } --  If iPad: the point the share popup emerges from.
    })
end)
