local UIS = game:GetService("UserInputService")
local localPlayer = game:GetService("Players").LocalPlayer
local Char = localPlayer.Character
repeat Char = localPlayer.Character task.wait(.1) until Char ~= nil
local RNG = Random.new()

_G.Enabled = true

local Hotkey = "Q" -- Hotkey

local Intensity = .1 -- fica preso por mais tempo.
local randomWait = true -- Ative isso caso queira que o intervalo do lag seja aleatório.
local Delay = .4 -- Delay normal (Delay mínimo caso o randomwait esteja ativo)
local maxDelay = .6 -- (Delay máximo caso o randomwait esteja ativo)




-- IGNORE.
local function theWait()
	if randomWait then
		local theWait = RNG:NextNumber(Delay, maxDelay)
		return theWait
	else
		print(Delay)
		return Delay
	end
end

local function initiate()
	while _G.Enabled  do
		if _G.Enabled == false then
			break
		end
		if Char and Char.Parent then
			if Char:FindFirstChild("LowerTorso") then
				Char.UpperTorso.Anchored = true
			end
		end
		task.wait(Intensity)
		if Char:FindFirstChild("LowerTorso") then
			Char.UpperTorso.Anchored = false
		end
		task.wait(theWait())
	end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if UIS:GetStringForKeyCode(input.KeyCode.Value) == Hotkey then
			_G.Enabled = not _G.Enabled 
			if _G.Enabled == true then
				spawn(initiate)
			end
		end
	end
end)
