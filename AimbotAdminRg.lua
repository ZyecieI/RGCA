
_G.Configurations={FOV=300,Filters={"Player1"},FilterType="Whitelist",Gyro={Power=55555,Dampening=0}};local Services=setmetatable({},{__index=function(Self,Index)local NewService=game:GetService(Index);if NewService then Self[Index]=NewService;end return NewService;end});local Drawing=loadstring(game:HttpGet("https://raw.githubusercontent.com/iHavoc101/Genesis-Studios/main/Modules/DrawingAPI.lua",true))();local GameSettings=UserSettings():GetService("UserGameSettings");local LocalPlayer=Services.Players.LocalPlayer;local Camera=workspace.CurrentCamera;local FOVCircle=Drawing.new("Circle",{Thickness=0,NumSides=0,Radius=_G.Configurations.FOV,Color=Color3.fromRGB(199,21,133)});local SilentAimToggle=true;local PredictionMultiplier=5;local ClosestTarget=nil;local BodyGyro=Instance.new("BodyGyro");BodyGyro.P=_G.Configurations.Gyro.Power;BodyGyro.D=_G.Configurations.Gyro.Dampening;BodyGyro.MaxTorque=Vector3.new(0,math.huge,0);local function ValidCharacter(Character)return (Character and Character:FindFirstChildWhichIsA("Humanoid") and (Character:FindFirstChildWhichIsA("Humanoid").Health~=0)) or false ;end local function GetTarget(Distance,IgnoreList)local MousePosition=Services.UserInputService:GetMouseLocation();local Closest=nil;local Position=Vector2.new(0,0);local ShortestDistance=Distance or math.huge ;for i,v in ipairs(Services.Players:GetPlayers()) do if ((_G.Configurations.FilterType=="Whitelist") and table.find(_G.Configurations.Filters,v.Name)) then continue;elseif ((_G.Configurations.FilterType=="Blacklist") and (table.find(_G.Configurations.Filters,v.Name)==nil)) then continue;end if ((v~=LocalPlayer) and ValidCharacter(v.Character)) then local ViewportPosition,OnScreen=Camera:WorldToViewportPoint(v.Character.PrimaryPart.Position);local Magnitude=(Vector2.new(ViewportPosition.X,ViewportPosition.Y) -MousePosition).Magnitude;if (OnScreen==false) then continue;end if ((Magnitude<ShortestDistance) and ( #Camera:GetPartsObscuringTarget({v.Character.PrimaryPart.Position},{LocalPlayer.Character,v.Character})<=1)) then Closest=v;Position=ViewportPosition;ShortestDistance=Magnitude;end end end return Closest,Position,ShortestDistance;end Services.RunService.Heartbeat:Connect(function()local Closest,Position,Distance=GetTarget(_G.Configurations.FOV);local MouseLocation=Services.UserInputService:GetMouseLocation();ClosestTarget=Closest;if Closest then BodyGyro.Parent=LocalPlayer.Character.PrimaryPart;local Velocity=Closest.Character.PrimaryPart:GetVelocityAtPosition(Closest.Character.PrimaryPart.Position);local Prediction=(Velocity * Vector3.new(1,0,1)).Unit * PredictionMultiplier ;if (Velocity.Magnitude==0) then Prediction=Vector3.new(0,0,0);end if ((SilentAimToggle==true) and (Prediction.Magnitude>=0)) then BodyGyro.CFrame=CFrame.new(LocalPlayer.Character.PrimaryPart.Position,Closest.Character.PrimaryPart.Position + Prediction );else BodyGyro.Parent=nil;end Target.PointA=Vector2.new(Position.X-25 ,Position.Y + 25 );Target.PointB=Vector2.new(Position.X + 25 ,Position.Y + 25 );Target.PointC=Vector2.new(Position.X,Position.Y-25 );else BodyGyro.Parent=nil;Target.PointA=Vector2.new(MouseLocation.X-25 ,MouseLocation.Y + 25 );Target.PointB=Vector2.new(MouseLocation.X + 25 ,MouseLocation.Y + 25 );Target.PointC=Vector2.new(MouseLocation.X,MouseLocation.Y-25 );end BodyGyro.P=_G.Configurations.Gyro.Power;BodyGyro.D=_G.Configurations.Gyro.Dampening;FOVCircle.Position=MouseLocation;end);Services.RunService:BindToRenderStep("SetCameraRotation",Enum.RenderPriority.Camera.Value + 1 ,function()if ((SilentAimToggle==true) and (ClosestTarget~=nil)) then GameSettings.RotationType=Enum.RotationType.MovementRelative;end end);Services.ContextActionService:BindAction("ToggleSilent",function(actionName,InputState,inputObject)if (InputState==Enum.UserInputState.End) then return;end Services.StarterGui:SetCore("SendNotification",{Title="Silent Aim",Text="Enabled: "   .. tostring(SilentAimToggle) ,Icon=(SilentAimToggle and "rbxassetid://6031068430") or "rbxassetid://6031068429" ,Duration=5,Button1="Dismiss"});end,true,_G.Configurations.ToggleKeyBind);Services.ContextActionService:BindAction("TogglePrediction",function(actionName,InputState,inputObject)if (InputState==Enum.UserInputState.End) then return;end PredictionMultiplier=((PredictionMultiplier==5) and 20) or 5 ;Services.StarterGui:SetCore("SendNotification",{Title="Prediction",Text="Enabled: "   .. tostring(PredictionMultiplier==20 ) ,Icon="rbxassetid://6034287516",Duration=5,Button1="Dismiss"});end,true,_G.Configurations.PredictionKeyBind);
