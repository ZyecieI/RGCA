
local TargetID = 1133242788 -- Target UserID
local TargetDisplay = 'SnakeDarling' -- Target Display Name
local useDisplay = false -- Set to 'true' if you want to use the display name above the head. Keep it to 'false' if you want to keep the actual name of his roblox account.
local AltAccName = 'Jaco_m' -- \\ Name of your alt account in the server // friends account in the server. Has to be the exact roblox name.



-- \\ Do not touch unless you know what you're doing

local Players = game:GetService("Players")
local Char = Players[AltAccName].Character
local Apps = Players:GetCharacterAppearanceAsync(TargetID)
local PlayerName = Players:GetNameFromUserIdAsync(TargetID)

local mt = getrawmetatable(game)
local oldkick = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(Self, ...)
    local Method = getnamecallmethod()
    if tostring(string.lower(Method)) == 'kick' and not checkcaller() then
        wait(math.huge)
        return
    end
    return oldkick(Self, ...)
end)
setreadonly(mt, true)

local randomstr = game:GetService('HttpService'):GenerateGUID(false)
randomstr = string.gsub(randomstr, '-', '')


local function reload()
    Char.Parent = nil
    task.wait(0.5)
    Char.Parent = workspace
end

local function supSUSHI()

    local hairstand = Instance.new('Part', Char)
    hairstand.Name = randomstr
    hairstand.Transparency = 1
    hairstand.Color = Color3.new(16, 16, 16)
    hairstand.Position = Char['Head'].Position + Vector3.new(-0.05, 0.4, 0)
    hairstand.CanCollide = false


    for i,v in next, Char:GetDescendants() do
        if v:IsA('Accessory') or v:IsA('Shirt') or v:IsA('Pants') or v:IsA('BodyColors') then
            v:Destroy()
        end
    end

    for i,v in next, Apps:GetChildren() do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
            v.Parent = Char
        elseif string.match(string.lower(v.Name), 'hair') then
            v.Parent = Char
            for i1,v1 in ipairs(v:GetChildren()) do
                if v1:IsA('Part') then
                    v1.CFrame = Char[randomstr].CFrame
                    local Weld0 = Instance.new('WeldConstraint')
                    Weld0.Part0 = v1
                    Weld0.Part1 = Char['Head']
                    Weld0.Parent = Char
                end
            end
        end
    end
    reload()

    for i,v in pairs(Char:GetDescendants()) do
        if v:IsA('BillboardGui') and v.Parent.Name == 'Head' then
            v['plrName'].Text = PlayerName
        end
    end

    local checkTab = coroutine.wrap(function()
        while task.wait() do
            pcall(function()
                for i,v in pairs(Players.LocalPlayer.PlayerGui.PlayerList.PlayerListFrame.List:GetChildren()) do
                    if string.match(string.lower(v.Name), string.lower(AltAccName)) then
                        if v.DisplayNameLabel.Text ~= TargetDisplay or v.UsernameLabel.Text ~= '('..PlayerName..')' then
                            v.DisplayNameLabel.Text = TargetDisplay
                            v.UsernameLabel.Text = '('..PlayerName..')'
                        end
                    end
                end
                for i,v in pairs(Char:GetDescendants()) do
                    if v:IsA('BillboardGui') and v.Parent.Name == 'Head' then
                        if useDisplay == false then
                            v['plrName'].Text = PlayerName
                        else
                            v['plrName'].Text = TargetDisplay
                        end
                    end
                end
            end)
        end
    end)

    checkTab()

end


supSUSHI()