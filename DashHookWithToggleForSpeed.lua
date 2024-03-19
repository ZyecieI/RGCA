
for _, v in next, getgc(true) do
			if type(v) == "function" and getfenv(v).script == game.Workspace:WaitForChild(LCP.Name).ClientControl then
				local Constants = getconstants(v)
				if Constants[1] == "UserInputType" and Constants[2] == "Enum" and Constants[3] == "MouseButton1" then
					local Dash  = LCP.Character:WaitForChild("HumanoidRootPart"):WaitForChild("Dash")
					local Distance = (Dash.Position - LCP.Character:WaitForChild("HumanoidRootPart").Position)
					local Direction = Distance.Unit
					Dash.P = Settings.DashModifications.DashSpeed
					Dash.Position = LCP.Character:WaitForChild("HumanoidRootPart").Position + Direction * Settings.DashModifications.DashDistance
				end
			end
		end
	end
end
