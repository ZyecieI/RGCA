game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(descendant)
if descendant:IsA("BodyPosition") then
wait()
descendant:Destroy()
end
end)
