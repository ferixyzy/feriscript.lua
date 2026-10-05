--[[
    NEBOLUSVERSE - Ultimate Fixed Functional Script (Roblox Delta Style)
    Scrolling fixed, all 'B2AL' text replaced with 'FERI', FOV Aimbot, Speed Slider, Skull Logo & Visibility Check Added.
]]--

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

if CoreGui:FindFirstChild("NebolusDeltaUI") then
    CoreGui.NebolusDeltaUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NebolusDeltaUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- ==========================================
-- FLOATING TOGGLE BUTTON (SKULL LOGO MENGGUNAKAN CODING)
-- ==========================================
local FloatBtn = Instance.new("ImageButton")
FloatBtn.Name = "FloatButton"
FloatBtn.Parent = ScreenGui
FloatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FloatBtn.Position = UDim2.new(0, 15, 0.35, 0)
FloatBtn.Size = UDim2.new(0, 40, 0, 40)
FloatBtn.Image = "" -- Kosongkan agar murni pakai coding bentuk tengkorak
FloatBtn.Draggable = true

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatBtn

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(180, 0, 0)
FloatStroke.Thickness = 1.5
FloatStroke.Parent = FloatBtn

-- Coding murni membuat bentuk tengkorak (Kepala Tengkorak)
local SkullHead = Instance.new("Frame")
SkullHead.Name = "SkullHead"
SkullHead.Parent = FloatBtn
SkullHead.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SkullHead.Position = UDim2.new(0.5, -8, 0.5, -11)
SkullHead.Size = UDim2.new(0, 16, 0, 14)
local shCorner = Instance.new("UICorner")
shCorner.CornerRadius = UDim.new(0.4, 0)
shCorner.Parent = SkullHead

-- Rahang Tengkorak
local SkullJaw = Instance.new("Frame")
SkullJaw.Name = "SkullJaw"
SkullJaw.Parent = FloatBtn
SkullJaw.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SkullJaw.Position = UDim2.new(0.5, -5, 0.5, 3)
SkullJaw.Size = UDim2.new(0, 10, 0, 6)
local sjCorner = Instance.new("UICorner")
sjCorner.CornerRadius = UDim.new(0.2, 0)
sjCorner.Parent = SkullJaw

-- Mata Kiri Tengkorak
local Eye1 = Instance.new("Frame")
Eye1.Name = "Eye1"
Eye1.Parent = SkullHead
Eye1.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Eye1.Position = UDim2.new(0, 2, 0, 3)
Eye1.Size = UDim2.new(0, 3, 0, 4)
local e1c = Instance.new("UICorner"); e1c.CornerRadius = UDim.new(1,0); e1c.Parent = Eye1

-- Mata Kanan Tengkorak
local Eye2 = Instance.new("Frame")
Eye2.Name = "Eye2"
Eye2.Parent = SkullHead
Eye2.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Eye2.Position = UDim2.new(1, -5, 0, 3)
Eye2.Size = UDim2.new(0, 3, 0, 4)
local e2c = Instance.new("UICorner"); e2c.CornerRadius = UDim.new(1,0); e2c.Parent = Eye2

-- ==========================================
-- MAIN WINDOW CONTAINER
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -95)
MainFrame.Size = UDim2.new(0, 320, 0, 195)
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 5)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(180, 0, 0)
MainStroke.Thickness = 1.2
MainStroke.Parent = MainFrame

FloatBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- DRAGGABLE SCREEN BOUNDS
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local viewportSize = Workspace.CurrentCamera.ViewportSize
        local targetX = math.clamp(startPos.X.Offset + delta.X, 0, viewportSize.X - MainFrame.AbsoluteSize.X)
        local targetY = math.clamp(startPos.Y.Offset + delta.Y, 0, viewportSize.Y - MainFrame.AbsoluteSize.Y)
        MainFrame.Position = UDim2.new(0, targetX, 0, targetY)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- TITLE BAR ("FERI PROXY")
local Header = Instance.new("TextLabel")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundTransparency = 1
Header.Position = UDim2.new(0.28, 0, 0, 4)
Header.Size = UDim2.new(0.5, 0, 0, 18)
Header.Font = Enum.Font.GothamBold
Header.Text = "FERI PROXY"
Header.TextColor3 = Color3.fromRGB(180, 0, 0)
Header.TextSize = 11

-- ==========================================
-- SIDEBAR NAVIGATION
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.Position = UDim2.new(0, 5, 0, 26)
Sidebar.Size = UDim2.new(0, 45, 0, 163)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 4)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SidebarLayout.Padding = UDim.new(0, 8)

local function createTabButton(name, iconId, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Tab"
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Size = UDim2.new(0, 35, 0, 35)
    btn.AutoButtonColor = false
    btn.Text = ""
    btn.LayoutOrder = order
    
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = btn
    
    local icon = Instance.new("ImageLabel")
    icon.Parent = btn; icon.BackgroundTransparency = 1; icon.Position = UDim2.new(0.5, -8, 0.5, -12); icon.Size = UDim2.new(0, 16, 0, 16)
    icon.Image = iconId; icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    
    local label = Instance.new("TextLabel")
    label.Parent = btn; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 0, 0, 20); label.Size = UDim2.new(1, 0, 0, 10)
    label.Font = Enum.Font.GothamMedium; label.Text = name; label.TextColor3 = Color3.fromRGB(150, 150, 150); label.TextSize = 7
    
    return btn, icon, label
end

local VisualsBtn, VisIcon, VisLabel = createTabButton("Visuals", "rbxassetid://6034287593", 1)
local MiscBtn, MiscIcon, MiscLabel = createTabButton("Misc", "rbxassetid://6035047409", 2)
local InfoBtn, InfoIcon, InfoLabel = createTabButton("Info", "rbxassetid://6035047398", 3)

-- ==========================================
-- CONTENT CONTAINER
-- ==========================================
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 54, 0, 26)
ContentContainer.Size = UDim2.new(0, 260, 0, 163)

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Parent = ContentContainer
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    
    return page
end

local VisualsPage = createPage("Visuals")
local MiscPage = createPage("Misc")
local InfoPage = createPage("Info")
VisualsPage.Visible = true

local function setActiveTab(tabName)
    VisIcon.ImageColor3 = Color3.fromRGB(150, 150, 150); VisLabel.TextColor3 = Color3.fromRGB(150, 150, 150); VisualsPage.Visible = false
    MiscIcon.ImageColor3 = Color3.fromRGB(150, 150, 150); MiscLabel.TextColor3 = Color3.fromRGB(150, 150, 150); MiscPage.Visible = false
    InfoIcon.ImageColor3 = Color3.fromRGB(150, 150, 150); InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150); InfoPage.Visible = false
    
    if tabName == "Visuals" then
        VisIcon.ImageColor3 = Color3.fromRGB(180, 0, 0); VisLabel.TextColor3 = Color3.fromRGB(180, 0, 0); VisualsPage.Visible = true
    elseif tabName == "Misc" then
        MiscIcon.ImageColor3 = Color3.fromRGB(180, 0, 0); MiscLabel.TextColor3 = Color3.fromRGB(180, 0, 0); MiscPage.Visible = true
    elseif tabName == "Info" then
        InfoIcon.ImageColor3 = Color3.fromRGB(180, 0, 0); InfoLabel.TextColor3 = Color3.fromRGB(180, 0, 0); InfoPage.Visible = true
    end
end

VisualsBtn.MouseButton1Click:Connect(function() setActiveTab("Visuals") end)
MiscBtn.MouseButton1Click:Connect(function() setActiveTab("Misc") end)
InfoBtn.MouseButton1Click:Connect(function() setActiveTab("Info") end)

-- Global States
local currentEspColor = Color3.fromRGB(255, 0, 0)
local espLineEnabled = false
local espBoxEnabled = false
local espSkeletonEnabled = false
local espLinePosition = "Center"

-- ==========================================
-- 1. VISUALS MENU ITEMS
-- ==========================================
local function createToggleItem(parent, titleText, callback)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 28)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 0); label.Size = UDim2.new(0, 130, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = titleText; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = item; toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); toggleBtn.Position = UDim2.new(1, -36, 0.5, -8); toggleBtn.Size = UDim2.new(0, 28, 0, 16); toggleBtn.AutoButtonColor = false; toggleBtn.Text = ""
    local tCorner = Instance.new("UICorner"); tCorner.CornerRadius = UDim.new(1, 0); tCorner.Parent = toggleBtn
    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn; circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120); circle.Position = UDim2.new(0, 2, 0.5, -6); circle.Size = UDim2.new(0, 12, 0, 12)
    local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(1, 0); cCorner.Parent = circle
    
    local toggled = false
    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 0, 0)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
        end
        if callback then callback(toggled) end
    end)
    return item
end

createToggleItem(VisualsPage, "ESP Line", function(state) espLineEnabled = state end)
createToggleItem(VisualsPage, "ESP Box", function(state) espBoxEnabled = state end)
createToggleItem(VisualsPage, "ESP Skeleton", function(state) espSkeletonEnabled = state end)

local function createEspPositionItem(parent)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 28)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 0); label.Size = UDim2.new(0, 110, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = "ESP Position"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local valDisplay = Instance.new("TextLabel")
    valDisplay.Parent = item; valDisplay.BackgroundTransparency = 1; valDisplay.Position = UDim2.new(1, -85, 0, 0); valDisplay.Size = UDim2.new(0, 45, 1, 0)
    valDisplay.Font = Enum.Font.GothamBold; valDisplay.Text = espLinePosition; valDisplay.TextColor3 = Color3.fromRGB(180, 0, 0); valDisplay.TextSize = 8; valDisplay.TextXAlignment = Enum.TextXAlignment.Right
    
    local triggerBtn = Instance.new("TextButton")
    triggerBtn.Parent = item; triggerBtn.BackgroundTransparency = 1; triggerBtn.Position = UDim2.new(1, -22, 0, 0); triggerBtn.Size = UDim2.new(0, 20, 1, 0)
    triggerBtn.Font = Enum.Font.GothamBold; triggerBtn.Text = "▼"; triggerBtn.TextColor3 = Color3.fromRGB(180, 0, 0); triggerBtn.TextSize = 9
    
    local dropdown = Instance.new("Frame")
    dropdown.Parent = ScreenGui; dropdown.BackgroundColor3 = Color3.fromRGB(18, 18, 18); dropdown.Size = UDim2.new(0, 100, 0, 80); dropdown.Visible = false; dropdown.ZIndex = 10
    local dCorner = Instance.new("UICorner"); dCorner.CornerRadius = UDim.new(0, 5); dCorner.Parent = dropdown
    local dStroke = Instance.new("UIStroke"); dStroke.Color = Color3.fromRGB(180, 0, 0); dStroke.Thickness = 1; dStroke.Parent = dropdown
    local dLayout = Instance.new("UIListLayout"); dLayout.Parent = dropdown; dLayout.SortOrder = Enum.SortOrder.LayoutOrder; dLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; dLayout.VerticalAlignment = Enum.VerticalAlignment.Center; dLayout.Padding = UDim.new(0, 3)
    
    for _, posName in ipairs({"Top", "Bottom", "Center"}) do
        local pBtn = Instance.new("TextButton")
        pBtn.Parent = dropdown; pBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28); pBtn.Size = UDim2.new(1, -10, 0, 20); pBtn.AutoButtonColor = false
        pBtn.Font = Enum.Font.GothamMedium; pBtn.Text = "  " .. posName; pBtn.TextColor3 = Color3.fromRGB(200, 200, 200); pBtn.TextSize = 8; pBtn.TextXAlignment = Enum.TextXAlignment.Left; pBtn.ZIndex = 11
        local pbC = Instance.new("UICorner"); pbC.CornerRadius = UDim.new(0, 3); pbC.Parent = pBtn
        
        pBtn.MouseButton1Click:Connect(function()
            espLinePosition = posName
            valDisplay.Text = posName
            dropdown.Visible = false
        end)
    end
    
    triggerBtn.MouseButton1Click:Connect(function()
        dropdown.Visible = not dropdown.Visible
        if dropdown.Visible then
            local absPos = triggerBtn.AbsolutePosition
            dropdown.Position = UDim2.new(0, absPos.X - 100, 0, absPos.Y + 18)
        end
    end)
end
createEspPositionItem(VisualsPage)

local function createEspColorItem(parent)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 28)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 0); label.Size = UDim2.new(0, 110, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = "ESP Color"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local colorDisplay = Instance.new("Frame")
    colorDisplay.Parent = item; colorDisplay.BackgroundColor3 = currentEspColor; colorDisplay.Position = UDim2.new(1, -40, 0.5, -6); colorDisplay.Size = UDim2.new(0, 14, 0, 14)
    local cdCorner = Instance.new("UICorner"); cdCorner.CornerRadius = UDim.new(0, 3); cdCorner.Parent = colorDisplay
    
    local triggerBtn = Instance.new("TextButton")
    triggerBtn.Parent = item; triggerBtn.BackgroundTransparency = 1; triggerBtn.Position = UDim2.new(1, -22, 0, 0); triggerBtn.Size = UDim2.new(0, 20, 1, 0)
    triggerBtn.Font = Enum.Font.GothamBold; triggerBtn.Text = "▼"; triggerBtn.TextColor3 = Color3.fromRGB(180, 0, 0); triggerBtn.TextSize = 9
    
    local dropdown = Instance.new("Frame")
    dropdown.Parent = ScreenGui; dropdown.BackgroundColor3 = Color3.fromRGB(18, 18, 18); dropdown.Size = UDim2.new(0, 100, 0, 100); dropdown.Visible = false; dropdown.ZIndex = 10
    local dCorner = Instance.new("UICorner"); dCorner.CornerRadius = UDim.new(0, 5); dCorner.Parent = dropdown
    local dStroke = Instance.new("UIStroke"); dStroke.Color = Color3.fromRGB(180, 0, 0); dStroke.Thickness = 1; dStroke.Parent = dropdown
    local dLayout = Instance.new("UIListLayout"); dLayout.Parent = dropdown; dLayout.SortOrder = Enum.SortOrder.LayoutOrder; dLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; dLayout.VerticalAlignment = Enum.VerticalAlignment.Center; dLayout.Padding = UDim.new(0, 3)
    
    local colors = {
        {Name = "White", Color = Color3.fromRGB(255, 255, 255)},
        {Name = "Cyan", Color = Color3.fromRGB(0, 255, 255)},
        {Name = "Green", Color = Color3.fromRGB(0, 255, 0)},
        {Name = "Red", Color = Color3.fromRGB(255, 0, 0)}
    }
    
    for _, col in ipairs(colors) do
        local cBtn = Instance.new("TextButton")
        cBtn.Parent = dropdown; cBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28); cBtn.Size = UDim2.new(1, -10, 0, 20); cBtn.AutoButtonColor = false; cBtn.Font = Enum.Font.GothamMedium; cBtn.Text = "  " .. col.Name; cBtn.TextColor3 = Color3.fromRGB(200, 200, 200); cBtn.TextSize = 8; cBtn.TextXAlignment = Enum.TextXAlignment.Left; cBtn.ZIndex = 11
        local cbC = Instance.new("UICorner"); cbC.CornerRadius = UDim.new(0, 3); cbC.Parent = cBtn
        
        local dot = Instance.new("Frame")
        dot.Parent = cBtn; dot.BackgroundColor3 = col.Color; dot.Position = UDim2.new(1, -15, 0.5, -4); dot.Size = UDim2.new(0, 8, 0, 8)
        local dotCorner = Instance.new("UICorner"); dotCorner.CornerRadius = UDim.new(1, 0); dotCorner.Parent = dot
        
        cBtn.MouseButton1Click:Connect(function()
            currentEspColor = col.Color
            colorDisplay.BackgroundColor3 = col.Color
            dropdown.Visible = false
        end)
    end
    
    triggerBtn.MouseButton1Click:Connect(function()
        dropdown.Visible = not dropdown.Visible
        if dropdown.Visible then
            local absPos = triggerBtn.AbsolutePosition
            dropdown.Position = UDim2.new(0, absPos.X - 100, 0, absPos.Y + 18)
        end
    end)
end
createEspColorItem(VisualsPage)

local espObjects = {}
RunService.RenderStepped:Connect(function()
    local cam = Workspace.CurrentCamera
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if not espObjects[p] then
                espObjects[p] = {
                    Line = Drawing.new("Line"),
                    Box = Drawing.new("Square"),
                    Skels = {Drawing.new("Line")}
                }
                espObjects[p].Line.Thickness = 1.2
                espObjects[p].Box.Thickness = 1.2
                espObjects[p].Box.Filled = false
                espObjects[p].Skels[1].Thickness = 1.2
            end
            
            local cache = espObjects[p]
            local char = p.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                local hrp = char.HumanoidRootPart
                local vector, onScreen = cam:WorldToViewportPoint(hrp.Position)
                
                if onScreen then
                    if espLineEnabled then
                        cache.Line.Visible = true
                        local fromPos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                        if espLinePosition == "Top" then fromPos = Vector2.new(cam.ViewportSize.X / 2, 0)
                        elseif espLinePosition == "Bottom" then fromPos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                        elseif espLinePosition == "Center" then fromPos = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2) end
                        cache.Line.From = fromPos
                        cache.Line.To = Vector2.new(vector.X, vector.Y)
                        cache.Line.Color = currentEspColor
                    else
                        cache.Line.Visible = false
                    end
                    
                    if espBoxEnabled then
                        cache.Box.Visible = true
                        cache.Box.Size = Vector2.new(2200 / vector.Z, 4000 / vector.Z)
                        cache.Box.Position = Vector2.new(vector.X - cache.Box.Size.X / 2, vector.Y - cache.Box.Size.Y / 2)
                        cache.Box.Color = currentEspColor
                    else
                        cache.Box.Visible = false
                    end
                    
                    if espSkeletonEnabled and char:FindFirstChild("Head") and (char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")) then
                        local headV = cam:WorldToViewportPoint(char.Head.Position)
                        local torsoV = cam:WorldToViewportPoint((char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")).Position)
                        cache.Skels[1].Visible = true
                        cache.Skels[1].From = Vector2.new(headV.X, headV.Y)
                        cache.Skels[1].To = Vector2.new(torsoV.X, torsoV.Y)
                        cache.Skels[1].Color = currentEspColor
                    else
                        cache.Skels[1].Visible = false
                    end
                else
                    cache.Line.Visible = false; cache.Box.Visible = false; cache.Skels[1].Visible = false
                end
            else
                cache.Line.Visible = false; cache.Box.Visible = false; cache.Skels[1].Visible = false
            end
        end
    end
end)


-- ==========================================
-- 2. MISC MENU ITEMS (Speed Slider, Aimbot + Visibility Check, dll)
-- ==========================================

-- Fitur Slider Kecepatan Jalan (Speed Slider)
local function createSpeedFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 38)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 2); label.Size = UDim2.new(0, 100, 0, 14)
    label.Font = Enum.Font.GothamMedium; label.Text = "WalkSpeed"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local speedNumLabel = Instance.new("TextLabel")
    speedNumLabel.Parent = item; speedNumLabel.BackgroundTransparency = 1; speedNumLabel.Position = UDim2.new(1, -40, 0, 2); speedNumLabel.Size = UDim2.new(0, 30, 0, 14)
    speedNumLabel.Font = Enum.Font.GothamBold; speedNumLabel.Text = "16"; speedNumLabel.TextColor3 = Color3.fromRGB(180, 0, 0); speedNumLabel.TextSize = 9; speedNumLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = item; sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40); sliderBg.Position = UDim2.new(0, 8, 0, 20); sliderBg.Size = UDim2.new(1, -16, 0, 10)
    local sCorner = Instance.new("UICorner"); sCorner.CornerRadius = UDim.new(1, 0); sCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = sliderBg; sliderFill.BackgroundColor3 = Color3.fromRGB(180, 0, 0); sliderFill.Size = UDim2.new(16/200, 0, 1, 0)
    local sfCorner = Instance.new("UICorner"); sfCorner.CornerRadius = UDim.new(1, 0); sfCorner.Parent = sliderFill
    
    local draggingSpeed = false
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSpeed = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSpeed = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingSpeed and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(relX, 0, 1, 0)
            local currentSpeed = math.floor(relX * 200)
            speedNumLabel.Text = tostring(currentSpeed)
            
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = currentSpeed
            end
        end
    end)
end
createSpeedFeature(MiscPage)

local function createSpinFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 48)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 3); label.Size = UDim2.new(0, 130, 0, 16)
    label.Font = Enum.Font.GothamMedium; label.Text = "Karakter Mutar"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = item; toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); toggleBtn.Position = UDim2.new(1, -36, 0, 4); toggleBtn.Size = UDim2.new(0, 28, 0, 16); toggleBtn.AutoButtonColor = false; toggleBtn.Text = ""
    local tCorner = Instance.new("UICorner"); tCorner.CornerRadius = UDim.new(1, 0); tCorner.Parent = toggleBtn
    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn; circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120); circle.Position = UDim2.new(0, 2, 0.5, -6); circle.Size = UDim2.new(0, 12, 0, 12)
    local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(1, 0); cCorner.Parent = circle
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = item; sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40); sliderBg.Position = UDim2.new(0, 8, 0, 26); sliderBg.Size = UDim2.new(1, -16, 0, 12)
    local sCorner = Instance.new("UICorner"); sCorner.CornerRadius = UDim.new(1, 0); sCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = sliderBg; sliderFill.BackgroundColor3 = Color3.fromRGB(180, 0, 0); sliderFill.Size = UDim2.new(0.2, 0, 1, 0)
    local sfCorner = Instance.new("UICorner"); sfCorner.CornerRadius = UDim.new(1, 0); sfCorner.Parent = sliderFill
    
    local spinSpeed = 10
    local spinning = false
    local spinConn
    local draggingSlider = false
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(relX, 0, 1, 0)
            spinSpeed = math.floor(relX * 50)
        end
    end)
    
    toggleBtn.MouseButton1Click:Connect(function()
        spinning = not spinning
        if spinning then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 0, 0)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            spinConn = RunService.RenderStepped:Connect(function(dt)
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed * dt * 60), 0)
                end
            end)
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
            if spinConn then spinConn:Disconnect() end
        end
    end)
end
createSpinFeature(MiscPage)

-- Aimbot dengan Logo Tengkorak (Coding) & Fitur Objek / Wall Check (Objek menghalangi = Aimbot tidak work)
local function createAimbotFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 72)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 3); label.Size = UDim2.new(0, 90, 0, 16)
    label.Font = Enum.Font.GothamMedium; label.Text = "Aimbot + FOV"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = item; toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); toggleBtn.Position = UDim2.new(1, -36, 0, 4); toggleBtn.Size = UDim2.new(0, 28, 0, 16); toggleBtn.AutoButtonColor = false; toggleBtn.Text = ""
    local tCorner = Instance.new("UICorner"); tCorner.CornerRadius = UDim.new(1, 0); tCorner.Parent = toggleBtn
    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn; circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120); circle.Position = UDim2.new(0, 2, 0.5, -6); circle.Size = UDim2.new(0, 12, 0, 12)
    local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(1, 0); cCorner.Parent = circle
    
    -- Tombol Target Settings BERBASIS LOGO TENGKORAK MURNI CODING (Bukan Gerigi/Emoji)
    local targetBtn = Instance.new("TextButton")
    targetBtn.Parent = item; targetBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); targetBtn.Position = UDim2.new(1, -66, 0, 4); targetBtn.Size = UDim2.new(0, 24, 0, 16)
    targetBtn.AutoButtonColor = false; targetBtn.Text = ""
    local tbC = Instance.new("UICorner"); tbC.CornerRadius = UDim.new(0, 3); tbC.Parent = targetBtn
    
    -- Gambar Tengkorak Kecil di Tombol Target
    local sHeadMini = Instance.new("Frame")
    sHeadMini.Parent = targetBtn; sHeadMini.BackgroundColor3 = Color3.fromRGB(180, 0, 0); sHeadMini.Position = UDim2.new(0.5, -5, 0.5, -5); sHeadMini.Size = UDim2.new(0, 10, 0, 8)
    local shmc = Instance.new("UICorner"); shmc.CornerRadius = UDim.new(0.4, 0); shmc.Parent = sHeadMini
    local sJawMini = Instance.new("Frame")
    sJawMini.Parent = targetBtn; sJawMini.BackgroundColor3 = Color3.fromRGB(180, 0, 0); sJawMini.Position = UDim2.new(0.5, -3, 0.5, 3); sJawMini.Size = UDim2.new(0, 6, 0, 3)
    local sjmc = Instance.new("UICorner"); sjmc.CornerRadius = UDim.new(0.2, 0); sjmc.Parent = sJawMini
    
    -- Target Panel Popup
    local targetPanel = Instance.new("Frame")
    targetPanel.Parent = ScreenGui; targetPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15); targetPanel.Size = UDim2.new(0, 100, 0, 80); targetPanel.Visible = false; targetPanel.ZIndex = 15
    local tpC = Instance.new("UICorner"); tpC.CornerRadius = UDim.new(0, 5); tpC.Parent = targetPanel
    local tpS = Instance.new("UIStroke"); tpS.Color = Color3.fromRGB(180, 0, 0); tpS.Thickness = 1; tpS.Parent = targetPanel
    local tpL = Instance.new("UIListLayout"); tpL.Parent = targetPanel; tpL.SortOrder = Enum.SortOrder.LayoutOrder; tpL.HorizontalAlignment = Enum.HorizontalAlignment.Center; tpL.VerticalAlignment = Enum.VerticalAlignment.Center; tpL.Padding = UDim.new(0, 3)
    
    local aimTarget = "Head"
    for _, partName in ipairs({"Head", "Body", "Chest"}) do
        local pBtn = Instance.new("TextButton")
        pBtn.Parent = targetPanel; pBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); pBtn.Size = UDim2.new(1, -8, 0, 20)
        pBtn.Font = Enum.Font.GothamMedium; pBtn.Text = partName; pBtn.TextColor3 = Color3.fromRGB(200, 200, 200); pBtn.TextSize = 8; pBtn.ZIndex = 16
        local pbC = Instance.new("UICorner"); pbC.CornerRadius = UDim.new(0, 3); pbC.Parent = pBtn
        pBtn.MouseButton1Click:Connect(function() aimTarget = partName; targetPanel.Visible = false end)
    end
    
    targetBtn.MouseButton1Click:Connect(function()
        targetPanel.Visible = not targetPanel.Visible
        if targetPanel.Visible then
            local absPos = targetBtn.AbsolutePosition
            targetPanel.Position = UDim2.new(0, absPos.X - 100, 0, absPos.Y + 18)
        end
    end)
    
    -- FOV Slider
    local fovLabel = Instance.new("TextLabel")
    fovLabel.Parent = item; fovLabel.BackgroundTransparency = 1; fovLabel.Position = UDim2.new(0, 8, 0, 24); fovLabel.Size = UDim2.new(0, 100, 0, 14)
    fovLabel.Font = Enum.Font.GothamMedium; fovLabel.Text = "FOV Size"; fovLabel.TextColor3 = Color3.fromRGB(180, 180, 180); fovLabel.TextSize = 8; fovLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local fovNumLabel = Instance.new("TextLabel")
    fovNumLabel.Parent = item; fovNumLabel.BackgroundTransparency = 1; fovNumLabel.Position = UDim2.new(1, -40, 0, 24); fovNumLabel.Size = UDim2.new(0, 30, 0, 14)
    fovNumLabel.Font = Enum.Font.GothamBold; fovNumLabel.Text = "100"; fovNumLabel.TextColor3 = Color3.fromRGB(180, 0, 0); fovNumLabel.TextSize = 9; fovNumLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = item; sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40); sliderBg.Position = UDim2.new(0, 8, 0, 42); sliderBg.Size = UDim2.new(1, -16, 0, 12)
    local sCorner = Instance.new("UICorner"); sCorner.CornerRadius = UDim.new(1, 0); sCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = sliderBg; sliderFill.BackgroundColor3 = Color3.fromRGB(180, 0, 0); sliderFill.Size = UDim2.new(0.4, 0, 1, 0)
    local sfCorner = Instance.new("UICorner"); sfCorner.CornerRadius = UDim.new(1, 0); sfCorner.Parent = sliderFill
    
    local fovRadius = 100
    local draggingFov = false
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFov = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFov = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingFov and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(relX, 0, 1, 0)
            fovRadius = math.floor(relX * 300)
            fovNumLabel.Text = tostring(fovRadius)
        end
    end)
    
    local fovCircle = Drawing.new("Circle")
    fovCircle.Thickness = 1.2
    fovCircle.NumSides = 64
    fovCircle.Filled = false
    fovCircle.Transparency = 0.7
    fovCircle.Color = Color3.fromRGB(180, 0, 0)
    fovCircle.Visible = false
    
    local aimbotEnabled = false
    toggleBtn.MouseButton1Click:Connect(function()
        aimbotEnabled = not aimbotEnabled
        fovCircle.Visible = aimbotEnabled
        if aimbotEnabled then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 0, 0)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        local cam = Workspace.CurrentCamera
        local mousePos = UserInputService:GetMouseLocation()
        fovCircle.Position = mousePos
        fovCircle.Radius = fovRadius
        
        if aimbotEnabled then
            local closestTarget = nil
            local shortestDist = fovRadius
            
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    local targetPart = p.Character:FindFirstChild(aimTarget) or p.Character:FindFirstChild("Head")
                    if targetPart then
                        local screenPos, onScreen = cam:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            if dist < shortestDist then
                                -- Raycast Visibility Check (Objek menghalangi = aimbot tidak work, tidak ada objek = aimbot work)
                                local origin = cam.CFrame.Position
                                local direction = (targetPart.Position - origin)
                                local raycastParams = RaycastParams.new()
                                raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                                
                                local raycastResult = Workspace:Raycast(origin, direction, raycastParams)
                                local isVisible = true
                                if raycastResult and raycastResult.Instance then
                                    -- Jika objek yang tertembus raycast bukan bagian dari karakter target, berarti ada objek penghalang (tembok/benda)
                                    if not raycastResult.Instance:IsDescendantOf(p.Character) then
                                        isVisible = false
                                    end
                                end
                                
                                if isVisible then
                                    shortestDist = dist
                                    closestTarget = targetPart
                                end
                            end
                        end
                    end
                end
            end
            
            if closestTarget then
                cam.CFrame = CFrame.new(cam.CFrame.Position, closestTarget.Position)
            end
        end
    end)
end
createAimbotFeature(MiscPage)

createToggleItem(MiscPage, "Unlimited Jump", function(state)
    local uJumpConn
    if state then
        uJumpConn = UserInputService.JumpRequest:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if uJumpConn then uJumpConn:Disconnect() end
    end
end)

local flyConn
createToggleItem(MiscPage, "Fly Mode", function(state)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    
    if state then
        local bv = Instance.new("BodyVelocity"); bv.Name = "FeriFlyVel"; bv.Parent = hrp; bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge); bv.Velocity = Vector3.new(0, 0, 0)
        local bg = Instance.new("BodyGyro"); bg.Name = "FeriFlyGyro"; bg.Parent = hrp; bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        
        flyConn = RunService.RenderStepped:Connect(function()
            local cam = Workspace.CurrentCamera
            bg.CFrame = cam.CFrame
            local moveDir = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then moveDir = moveDir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then moveDir = moveDir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then moveDir = moveDir - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then moveDir = moveDir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            bv.Velocity = moveDir * 50
        end)
    else
        if flyConn then flyConn:Disconnect() end
        if hrp:FindFirstChild("FeriFlyVel") then hrp.FeriFlyVel:Destroy() end
        if hrp:FindFirstChild("FeriFlyGyro") then hrp.FeriFlyGyro:Destroy() end
    end
end)

local noclipConn
createToggleItem(MiscPage, "No Clip", function(state)
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
    end
end)

local function createTeleportPlayerFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 28)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 0); label.Size = UDim2.new(0, 100, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = "Teleport Player"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local playerListBtn = Instance.new("TextButton")
    playerListBtn.Parent = item; playerListBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); playerListBtn.Position = UDim2.new(1, -46, 0.5, -7); playerListBtn.Size = UDim2.new(0, 42, 0, 14)
    playerListBtn.Font = Enum.Font.GothamBold; playerListBtn.Text = "List"; playerListBtn.TextColor3 = Color3.fromRGB(180, 0, 0); playerListBtn.TextSize = 8
    local plC = Instance.new("UICorner"); plC.CornerRadius = UDim.new(0, 3); plC.Parent = playerListBtn
    
    local listPanel = Instance.new("ScrollingFrame")
    listPanel.Parent = ScreenGui; listPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15); listPanel.Size = UDim2.new(0, 120, 0, 100); listPanel.Visible = false; listPanel.ZIndex = 20
    listPanel.CanvasSize = UDim2.new(0, 0, 0, 0); listPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y; listPanel.ScrollBarThickness = 2
    local lpC = Instance.new("UICorner"); lpC.CornerRadius = UDim.new(0, 5); lpC.Parent = listPanel
    local lpS = Instance.new("UIStroke"); lpS.Color = Color3.fromRGB(180, 0, 0); lpS.Thickness = 1; lpS.Parent = listPanel
    local lpL = Instance.new("UIListLayout"); lpL.Parent = listPanel; lpL.SortOrder = Enum.SortOrder.LayoutOrder; lpL.Padding = UDim.new(0, 3)
    
    playerListBtn.MouseButton1Click:Connect(function()
        listPanel.Visible = not listPanel.Visible
        if listPanel.Visible then
            local absPos = playerListBtn.AbsolutePosition
            listPanel.Position = UDim2.new(0, absPos.X - 120, 0, absPos.Y + 18)
            
            for _, child in ipairs(listPanel:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
            
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton")
                    pBtn.Parent = listPanel; pBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); pBtn.Size = UDim2.new(1, -6, 0, 22)
                    pBtn.Font = Enum.Font.GothamMedium; pBtn.Text = "  " .. p.Name; pBtn.TextColor3 = Color3.fromRGB(200, 200, 200); pBtn.TextSize = 8; pBtn.TextXAlignment = Enum.TextXAlignment.Left; pBtn.ZIndex = 21
                    local pbC = Instance.new("UICorner"); pbC.CornerRadius = UDim.new(0, 3); pbC.Parent = pBtn
                    
                    pBtn.MouseButton1Click:Connect(function()
                        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                        end
                        listPanel.Visible = false
                    end)
                end
            end
        end
    end)
end
createTeleportPlayerFeature(MiscPage)

local function createCopyBajuFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 28)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 0); label.Size = UDim2.new(0, 100, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = "Copy Baju Player"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local copyListBtn = Instance.new("TextButton")
    copyListBtn.Parent = item; copyListBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); copyListBtn.Position = UDim2.new(1, -46, 0.5, -7); copyListBtn.Size = UDim2.new(0, 42, 0, 14)
    copyListBtn.Font = Enum.Font.GothamBold; copyListBtn.Text = "Copy"; copyListBtn.TextColor3 = Color3.fromRGB(180, 0, 0); copyListBtn.TextSize = 8
    local clC = Instance.new("UICorner"); clC.CornerRadius = UDim.new(0, 3); clC.Parent = copyListBtn
    
    local copyPanel = Instance.new("ScrollingFrame")
    copyPanel.Parent = ScreenGui; copyPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15); copyPanel.Size = UDim2.new(0, 120, 0, 100); copyPanel.Visible = false; copyPanel.ZIndex = 20
    copyPanel.CanvasSize = UDim2.new(0, 0, 0, 0); copyPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y; copyPanel.ScrollBarThickness = 2
    local cpC = Instance.new("UICorner"); cpC.CornerRadius = UDim.new(0, 5); cpC.Parent = copyPanel
    local cpS = Instance.new("UIStroke"); cpS.Color = Color3.fromRGB(180, 0, 0); cpS.Thickness = 1; cpS.Parent = copyPanel
    local cpL = Instance.new("UIListLayout"); cpL.Parent = copyPanel; cpL.SortOrder = Enum.SortOrder.LayoutOrder; cpL.Padding = UDim.new(0, 3)
    
    copyListBtn.MouseButton1Click:Connect(function()
        copyPanel.Visible = not copyPanel.Visible
        if copyPanel.Visible then
            local absPos = copyListBtn.AbsolutePosition
            copyPanel.Position = UDim2.new(0, absPos.X - 120, 0, absPos.Y + 18)
            
            for _, child in ipairs(copyPanel:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
            
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton")
                    pBtn.Parent = copyPanel; pBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); pBtn.Size = UDim2.new(1, -6, 0, 22)
                    pBtn.Font = Enum.Font.GothamMedium; pBtn.Text = "  " .. p.Name; pBtn.TextColor3 = Color3.fromRGB(200, 200, 200); pBtn.TextSize = 8; pBtn.TextXAlignment = Enum.TextXAlignment.Left; pBtn.ZIndex = 21
                    local pbC = Instance.new("UICorner"); pbC.CornerRadius = UDim.new(0, 3); pbC.Parent = pBtn
                    
                    pBtn.MouseButton1Click:Connect(function()
                        if p.Character and LocalPlayer.Character then
                            for _, v in ipairs(p.Character:GetChildren()) do
                                if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("Accessory") then
                                    local cloned = v:Clone()
                                    local old = LocalPlayer.Character:FindFirstChild(v.Name)
                                    if old then old:Destroy() end
                                    cloned.Parent = LocalPlayer.Character
                                end
                            end
                        end
                        copyPanel.Visible = false
                    end)
                end
            end
        end
    end)
end
createCopyBajuFeature(MiscPage)

local function createInfoRow(parent, labelText, valText)
    local row = Instance.new("Frame")
    row.Parent = parent; row.BackgroundColor3 = Color3.fromRGB(20, 20, 20); row.Size = UDim2.new(1, -2, 0, 28)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Parent = row; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 0); label.Size = UDim2.new(0, 90, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = labelText; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local val = Instance.new("TextLabel")
    val.Parent = row; val.BackgroundTransparency = 1; val.Position = UDim2.new(0, 95, 0, 0); val.Size = UDim2.new(1, -100, 1, 0)
    val.Font = Enum.Font.GothamMedium; val.Text = valText; val.TextColor3 = Color3.fromRGB(180, 0, 0); val.TextSize = 9; val.TextXAlignment = Enum.TextXAlignment.Right
end

createInfoRow(InfoPage, "Developed", "FERI VIP")
createInfoRow(InfoPage, "Telegram", "@feri_vip")

print("Feri Setiawan - FERI Proxy UI successfully loaded with Speed Slider, Skull Logo, and Visibility Check Aimbot.")