game:GetService("Players").LocalPlayer.PlayerFolder.CanAct:GetPropertyChangedSignal("Value"):Connect(function()

game:GetService("Players").LocalPlayer.PlayerFolder.CanAct.Value = true

end)

game.StarterGui:SetCore("SendNotification", {Title = "Working.", Text = "Success, Anti-Delay Loaded.", Duration = 4,})