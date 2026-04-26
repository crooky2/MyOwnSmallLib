local TweenService = game:GetService("TweenService")

local cam = {}


local debug = false
local function dbg(value, fctn, wrn)
    if not debug then return end

    if wrn then
        if fctn then warn ("[".. fctn.. "] ") end
        warn(value)
    else
        if fctn then print ("[".. fctn.. "] ") end
        print(value)
    end
end



local camGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui) camGui.Name = "moslib_GamGui"

local shutCameraFolder = Instance.new("Folder", camGui) shutCameraFolder.Name = "ShutCamera" 
local function newShutFrame(name, position)
    local frame = Instance.new("Frame", shutCameraFolder)
    frame.Name = name
    frame.Position = position
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.Visible = false
    return frame 
end
shutFrame1 = newShutFrame("ShutFrame1", UDim2.new(-0.5,0,0,0))
shutFrame2 = newShutFrame("ShutFrame2", UDim2.new(1,0,0,0))





function cam.shutCamera(toogle: boolean, duration: number, tweenTime: number)

	if not shutFrame1 or not shutFrame2 then
		dbg("Shut frames not initialized", "shutCamera", true)
		return false
	end

	if not toogle then
		dbg("No toogle provided, defaulting to false", "shutCamera")
		toogle = false
	end

	if not duration then
		dbg("No duration provided, defaulting to 1 second", "shutCamera")
		duration = 1
	end

	if not tweenTime then
		dbg("No tweenTime provided, defaulting to 0.5 seconds", "shutCamera")
		tweenTime = 0.5
	end

	shutFrame1.Visible = true
	shutFrame2.Visible = true

	local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	TweenService:Create(shutFrame1, tweenInfo, { Position = UDim2.new(0, 0, 0, 0) }):Play()
	TweenService:Create(shutFrame2, tweenInfo, { Position = UDim2.new(0.5, 0, 0, 0) }):Play()

	task.delay(duration, function()
		local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

		TweenService:Create(shutFrame1, tweenInfo, { Position = UDim2.new(-0.5, 0, 0, 0) }):Play()
		TweenService:Create(shutFrame2, tweenInfo, { Position = UDim2.new(1, 0, 0, 0) }):Play()

		task.wait(tweenTime + 0.1)
		shutFrame1.Visible = false
		shutFrame2.Visible = false
		return true
	end)
end

return cam
