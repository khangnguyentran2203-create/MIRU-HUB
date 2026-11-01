-- Miru Fisch Hub | keyless GUI demo
-- No automatic fishing or anti-ban functionality.
local P=game:GetService("Players")
local T=game:GetService("TweenService")
local U=game:GetService("UserInputService")
local pg=P.LocalPlayer:WaitForChild("PlayerGui")
local old=pg:FindFirstChild("MiruFischHub")
if old then old:Destroy() end
local g=Instance.new("ScreenGui");g.Name="MiruFischHub";g.ResetOnSpawn=false;g.Parent=pg
local function make(class,parent,props)
 local o=Instance.new(class)
 for k,v in pairs(props) do o[k]=v end
 o.Parent=parent
 return o
end
local bg=Color3.fromRGB(13,9,21)
local purple=Color3.fromRGB(145,70,255)
local panel=Color3.fromRGB(31,23,47)
local f=make("Frame",g,{Size=UDim2.fromOffset(440,355),Position=UDim2.new(.5,-220,.5,-177),BackgroundColor3=bg,BorderSizePixel=0})
make("UICorner",f,{CornerRadius=UDim.new(0,14)})
make("UIStroke",f,{Color=purple,Thickness=1.5})
local bar=make("Frame",f,{Size=UDim2.new(1,0,0,48),BackgroundColor3=panel})
make("UICorner",bar,{CornerRadius=UDim.new(0,14)})
make("TextLabel",bar,{Size=UDim2.new(1,-70,1,0),Position=UDim2.fromOffset(16,0),BackgroundTransparency=1,Text="MIRU  /  FISCH",Font=Enum.Font.GothamBold,TextSize=19,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=Color3.new(1,1,1)})
local min=make("TextButton",bar,{Position=UDim2.new(1,-42,0,8),Size=UDim2.fromOffset(32,30),Text="−",TextSize=22,TextColor3=Color3.new(1,1,1),BackgroundColor3=purple})
make("UICorner",min,{CornerRadius=UDim.new(0,8)})
local body=make("Frame",f,{Position=UDim2.fromOffset(12,58),Size=UDim2.new(1,-24,1,-70),BackgroundTransparency=1})
local tabs={"Fishing","Quest","Visual","Player","Settings"}
local pages={}
for i,name in ipairs(tabs) do
 local tab=make("TextButton",body,{Position=UDim2.fromOffset(0,(i-1)*48),Size=UDim2.fromOffset(102,40),BackgroundColor3=panel,Text=name,TextColor3=Color3.new(1,1,1),Font=Enum.Font.Gotham,TextSize=13})
 make("UICorner",tab,{CornerRadius=UDim.new(0,8)})
 local page=make("Frame",body,{Position=UDim2.fromOffset(112,0),Size=UDim2.new(1,-112,1,0),BackgroundColor3=panel,Visible=i==1})
 make("UICorner",page,{CornerRadius=UDim.new(0,10)})
 pages[name]=page
 tab.MouseButton1Click:Connect(function()
  for _,p in pairs(pages) do p.Visible=false end
  page.Visible=true
 end)
end
local function toggle(page,label,y)
 local on=false
 local b=make("TextButton",page,{Position=UDim2.fromOffset(12,y),Size=UDim2.new(1,-24,0,38),BackgroundColor3=bg,Text=label.."   OFF",TextColor3=Color3.new(1,1,1),Font=Enum.Font.Gotham,TextSize=12})
 make("UICorner",b,{CornerRadius=UDim.new(0,8)})
 b.MouseButton1Click:Connect(function()
  on=not on;b.Text=label..(on and "   ON" or "   OFF")
  T:Create(b,TweenInfo.new(.18),{BackgroundColor3=on and Color3.fromRGB(65,39,101) or bg}):Play()
 end)
end
for i,name in ipairs({"Auto Cast (demo)","Auto Shake (demo)","Auto Reel (demo)","Auto Recast (demo)","Turbo (demo)"}) do toggle(pages.Fishing,name,12+(i-1)*45) end
toggle(pages.Quest,"Quest Tracker (demo)",12)
toggle(pages.Visual,"Visual HUD (demo)",12)
toggle(pages.Player,"Player HUD (demo)",12)
toggle(pages.Settings,"Animations (demo)",12)
local note=make("TextLabel",pages.Fishing,{Position=UDim2.fromOffset(12,240),Size=UDim2.new(1,-24,0,35),BackgroundTransparency=1,Text="UI prototype only — no live Fisch automation",TextWrapped=true,TextSize=11,Font=Enum.Font.Gotham,TextColor3=Color3.fromRGB(186,169,208)})
local minimized=false
min.MouseButton1Click:Connect(function()
 minimized=not minimized;body.Visible=not minimized;min.Text=minimized and "+" or "−"
 T:Create(f,TweenInfo.new(.2),{Size=minimized and UDim2.fromOffset(440,48) or UDim2.fromOffset(440,355)}):Play()
end)
local dragging=false;local start;local pos
bar.InputBegan:Connect(function(input)
 if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=true;start=input.Position;pos=f.Position end
end)
U.InputChanged:Connect(function(input)
 if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
  local d=input.Position-start;f.Position=UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
 end
end)
U.InputEnded:Connect(function(input)
 if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then dragging=false end
end)
