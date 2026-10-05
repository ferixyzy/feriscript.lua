--[[\
    NEBOLUSVERSE - Precision UI Replica Script (Roblox Delta Style)
    Fixed Proportions & Added Custom Functional Features
]]--

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("NebolusDeltaUI") then
    CoreGui.NebolusDeltaUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NebolusDeltaUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- ==========================================
-- FLOATING TOGGLE BUTTON (LOGO BULAT KIRI ATAS)
-- ==========================================
local FloatBtn = Instance.new("ImageButton")
FloatBtn.Name = "FloatButton"
FloatBtn.Parent = ScreenGui
FloatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
FloatBtn.Position = UDim2.new(0, 15, 0.35, 0)
FloatBtn.Size = UDim2.new(0, 42, 0, 42)
FloatBtn.Image = "rbxassetid://6034287593"
FloatBtn.Draggable = true

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatBtn

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(180, 0, 0)
FloatStroke.Thickness = 2
FloatStroke.Parent = FloatBtn

-- ==========================================
-- MAIN WINDOW CONTAINER (UKURAN DIPERSEMPIT & PAS)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Position = UDim2.new(0.5, -165, 0.5, -100)
MainFrame.Size = UDim2.new(0, 330, 0, 210)
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(180, 0, 0)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

FloatBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- DRAGGABLE SYSTEM (BATAS SCREEN)
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
        local viewportSize = workspace.CurrentCamera.ViewportSize
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

-- TITLE BAR ("B2AL PROXY")
local Header = Instance.new("TextLabel")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundTransparency = 1
Header.Position = UDim2.new(0.28, 0, 0, 6)
Header.Size = UDim2.new(0.5, 0, 0, 20)
Header.Font = Enum.Font.GothamBold
Header.Text = "B2AL PROXY"
Header.TextColor3 = Color3.fromRGB(180, 0, 0)
Header.TextSize = 13

-- ==========================================
-- SIDEBAR NAVIGATION
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.Position = UDim2.new(0, 6, 0, 30)
Sidebar.Size = UDim2.new(0, 50, 0, 172)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 5)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SidebarLayout.Padding = UDim.new(0, 10)

local function createTabButton(name, iconId, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Tab"
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Size = UDim2.new(0, 38, 0, 38)
    btn.AutoButtonColor = false
    btn.Text = ""
    btn.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    local icon = Instance.new("ImageLabel")
    icon.Parent = btn
    icon.BackgroundTransparency = 1
    icon.Position = UDim2.new(0.5, -9, 0.5, -14)
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Image = iconId
    icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    
    local label = Instance.new("TextLabel")
    label.Parent = btn
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 0, 0, 22)
    label.Size = UDim2.new(1, 0, 0, 12)
    label.Font = Enum.Font.GothamMedium
    label.Text = name
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.TextSize = 8
    
    return btn, icon, label
end

local VisualsBtn, VisIcon, VisLabel = createTabButton("Visuals", "rbxassetid://6034287593", 1)
local MiscBtn, MiscIcon, MiscLabel = createTabButton("Misc", "rbxassetid://6035047409", 2)
local InfoBtn, InfoIcon, InfoLabel = createTabButton("Info", "rbxassetid://6035047398", 3)

-- ==========================================
-- CONTENT CONTAINER (PAGES)
-- ==========================================
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 60, 0, 32)
ContentContainer.Size = UDim2.new(0, 264, 0, 172)

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Parent = ContentContainer
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
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

-- ==========================================
-- VISUALS: ESP Line, ESP Box, ESP Color (Popup Dropdown)
-- ==========================================
local function createToggleItem(parent, titleText)
    local item = Instance.new("Frame")
    item.Parent = parent
    item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    item.Size = UDim2.new(1, -4, 0, 32)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = titleText
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = item
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    toggleBtn.Position = UDim2.new(1, -40, 0.5, -9)
    toggleBtn.Size = UDim2.new(0, 32, 0, 18)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn
    
    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn
    circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    circle.Position = UDim2.new(0, 2, 0.5, -7)
    circle.Size = UDim2.new(0, 14, 0, 14)
    
    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle
    
    local toggled = false
    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 0, 0)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
        end
    end)
    
    return item
end

createToggleItem(VisualsPage, "ESP Line")
createToggleItem(VisualsPage, "ESP Box")

-- ESP Color dengan Popup Dropdown di sebelah kanan
local function createEspColorItem(parent)
    local item = Instance.new("Frame")
    item.Parent = parent
    item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    item.Size = UDim2.new(1, -4, 0, 32)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = "ESP Color"
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Kotak indikator warna aktif di kanan
    local colorDisplay = Instance.new("Frame")
    colorDisplay.Parent = item
    colorDisplay.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    colorDisplay.Position = UDim2.new(1, -45, 0.5, -8)
    colorDisplay.Size = UDim2.new(0, 16, 0, 16)
    local cdCorner = Instance.new("UICorner")
    cdCorner.CornerRadius = UDim.new(0, 4)
    cdCorner.Parent = colorDisplay
    
    -- Tombol Arrow/Trigger Popup di sebelah kanan
    local triggerBtn = Instance.new("TextButton")
    triggerBtn.Parent = item
    triggerBtn.BackgroundTransparency = 1
    triggerBtn.Position = UDim2.new(1, -25, 0, 0)
    triggerBtn.Size = UDim2.new(0, 20, 1, 0)
    triggerBtn.Font = Enum.Font.GothamBold
    triggerBtn.Text = "▼"
    triggerBtn.TextColor3 = Color3.fromRGB(180, 0, 0)
    triggerBtn.TextSize = 10
    
    -- Popup Menu Pilihan Warna (White, Cyan, Green, Red) persis seperti referensi gambar[cite: 6]
    local dropdown = Instance.new("Frame")
    dropdown.Parent = ScreenGui
    dropdown.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    dropdown.Size = UDim2.new(0, 110, 0, 115)
    dropdown.Visible = false
    dropdown.ZIndex = 10
    
    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 6)
    dCorner.Parent = dropdown
    
    local dStroke = Instance.new("UIStroke")
    dStroke.Color = Color3.fromRGB(180, 0, 0)
    dStroke.Thickness = 1.2
    dStroke.Parent = dropdown
    
    local dLayout = Instance.new("UIListLayout")
    dLayout.Parent = dropdown
    dLayout.SortOrder = Enum.SortOrder.LayoutOrder
    dLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    dLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    dLayout.Padding = UDim.new(0, 4)
    
    local colors = {
        {Name = "White", Color = Color3.fromRGB(255, 255, 255)},
        {Name = "Cyan", Color = Color3.fromRGB(0, 255, 255)},
        {Name = "Green", Color = Color3.fromRGB(0, 255, 0)},
        {Name = "Red", Color = Color3.fromRGB(255, 0, 0)}
    }
    
    for _, col in ipairs(colors) do
        local cBtn = Instance.new("TextButton")
        cBtn.Parent = dropdown
        cBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        cBtn.Size = UDim2.new(1, -12, 0, 22)
        cBtn.AutoButtonColor = false
        cBtn.Font = Enum.Font.GothamMedium
        cBtn.Text = "  " .. col.Name
        cBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        cBtn.TextSize = 9
        cBtn.TextXAlignment = Enum.TextXAlignment.Left
        cBtn.ZIndex = 11
        
        local cbCorner = Instance.new("UICorner")
        cbCorner.CornerRadius = UDim.new(0, 4)
        cbCorner.Parent = cBtn
        
        local dot = Instance.new("Frame")
        dot.Parent = cBtn
        dot.BackgroundColor3 = col.Color
        dot.Position = UDim2.new(1, -18, 0.5, -5)
        dot.Size = UDim2.new(0, 10, 0, 10)
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
        
        cBtn.MouseButton1Click:Connect(function()
            colorDisplay.BackgroundColor3 = col.Color
            dropdown.Visible = false
        end)
    end
    
    triggerBtn.MouseButton1Click:Connect(function()
        dropdown.Visible = not dropdown.Visible
        if dropdown.Visible then
            local absPos = triggerBtn.AbsolutePosition
            dropdown.Position = UDim2.new(0, absPos.X - 115, 0, absPos.Y)
        end
    end)
end

createEspColorItem(VisualsPage)


-- ==========================================
-- MISC MENU FEATURES
-- ==========================================

-- 1. Fitur Muter-Muter Karakter + Slider Kecepatan
local spinConn
local spinSpeed = 5
local function createSpinFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent
    item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    item.Size = UDim2.new(1, -4, 0, 56)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 4)
    label.Size = UDim2.new(0, 150, 0, 20)
    label.Font = Enum.Font.GothamMedium
    label.Text = "Karakter Mutar"
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = item
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    toggleBtn.Position = UDim2.new(1, -40, 0, 6)
    toggleBtn.Size = UDim2.new(0, 32, 0, 18)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""
    local tCorner = Instance.new("UICorner"); tCorner.CornerRadius = UDim.new(1, 0); tCorner.Parent = toggleBtn
    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn; circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120); circle.Position = UDim2.new(0, 2, 0.5, -7); circle.Size = UDim2.new(0, 14, 0, 14)
    local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(1, 0); cCorner.Parent = circle
    
    -- Slider Speed
    local sliderBg = Instance.new("Frame")
    sliderBg.Parent = item
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderBg.Position = UDim2.new(0, 10, 0, 32)
    sliderBg.Size = UDim2.new(1, -20, 0, 14)
    local sCorner = Instance.new("UICorner"); sCorner.CornerRadius = UDim.new(1, 0); sCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Parent = sliderBg
    sliderFill.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    local sfCorner = Instance.new("UICorner"); sfCorner.CornerRadius = UDim.new(1, 0); sfCorner.Parent = sliderFill
    
    local spinning = false
    toggleBtn.MouseButton1Click:Connect(function()
        spinning = not spinning
        if spinning then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 0, 0)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            spinConn = RunService.RenderStepped:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                end
            end)
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
            if spinConn then spinConn:Disconnect() end
        end
    end)
end
createSpinFeature(MiscPage)

-- 2. Simbol dengan Toggle dan Sub-Menu (Head, Body, Chest)
local function createSimbolFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent
    item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    item.Size = UDim2.new(1, -4, 0, 32)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 5); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 10, 0, 0); label.Size = UDim2.new(0, 100, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = "Simbol Set"; label.TextColor3 = Color3.fromRGB(220, 220, 220); label.TextSize = 10; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = item; toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); toggleBtn.Position = UDim2.new(1, -40, 0.5, -9); toggleBtn.Size = UDim2.new(0, 32, 0, 18); toggleBtn.AutoButtonColor = false; toggleBtn.Text = ""
    local tCorner = Instance.new("UICorner"); tCorner.CornerRadius = UDim.new(1, 0); tCorner.Parent = toggleBtn
    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn; circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120); circle.Position = UDim2.new(0, 2, 0.5, -7); circle.Size = UDim2.new(0, 14, 0, 14)
    local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(1, 0); cCorner.Parent = circle
    
    -- Tombol disamping toggle untuk memunculkan sub-menu setting Head, Body, Chest
    local subMenuBtn = Instance.new("TextButton")
    subMenuBtn.Parent = item; subMenuBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); subMenuBtn.Position = UDim2.new(1, -75, 0.5, -9); subMenuBtn.Size = UDim2.new(0, 28, 0, 18)
    subMenuBtn.Font = Enum.Font.GothamBold; subMenuBtn.Text = "⚙"; subMenuBtn.TextColor3 = Color3.fromRGB(180, 0, 0); subMenuBtn.TextSize = 10
    local smCorner = Instance.new("UICorner"); smCorner.CornerRadius = UDim.new(0, 4); smCorner.Parent = subMenuBtn
    
    -- Sub Panel Setting (Head, Body, Chest)
    local subPanel = Instance.new("Frame")
    subPanel.Parent = ScreenGui
    subPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    subPanel.Size = UDim2.new(0, 120, 0, 90)
    subPanel.Visible = false
    subPanel.ZIndex = 15
    local spCorner = Instance.new("UICorner"); spCorner.CornerRadius = UDim.new(0, 6); spCorner.Parent = subPanel
    local spStroke = Instance.new("UIStroke"); spStroke.Color = Color3.fromRGB(180, 0, 0); spStroke.Thickness = 1.2; spStroke.Parent = subPanel
    local spLayout = Instance.new("UIListLayout"); spLayout.Parent = subPanel; spLayout.SortOrder = Enum.SortOrder.LayoutOrder; spLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; spLayout.VerticalAlignment = Enum.VerticalAlignment.Center; spLayout.Padding = UDim.new(0, 5)
    
    local parts = {"Head", "Body", "Chest"}
    for _, partName in ipairs(parts) do
        local pBtn = Instance.new("TextButton")
        pBtn.Parent = subPanel; pBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); pBtn.Size = UDim2.new(1, -10, 0, 22)
        pBtn.Font = Enum.Font.GothamMedium; pBtn.Text = "Target: " .. partName; pBtn.TextColor3 = Color3.fromRGB(200, 200, 200); pBtn.TextSize = 9; pBtn.ZIndex = 16
        local pbCorner = Instance.new("UICorner"); pbCorner.CornerRadius = UDim.new(0, 4); pbCorner.Parent = pBtn
        pBtn.MouseButton1Click:Connect(function()
            subPanel.Visible = false
        end)
    end
    
    subMenuBtn.MouseButton1Click:Connect(function()
        subPanel.Visible = not subPanel.Visible
        if subPanel.Visible then
            local absPos = subMenuBtn.AbsolutePosition
            subPanel.Position = UDim2.new(0, absPos.X - 120, 0, absPos.Y)
        end
    end)
end
createSimbolFeature(MiscPage)

-- Basic Toggles: Fly & No Clip
createToggleItem(MiscPage, "Fly Mode")
createToggleItem(MiscPage, "No Clip")

-- 3. Teleport Player (List Akun Satu Map & Auto-Refresh)
local function createTeleportPlayerFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent
    item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    item.Size = UDim2.new(1, -4, 0, 32)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 5); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 10, 0, 0); label.Size = UDim2.new(0, 110, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = "Teleport Player"; label.TextColor3 = Color3.fromRGB(220, 220, 220); label.TextSize = 10; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local playerListBtn = Instance.new("TextButton")
    playerListBtn.Parent = item; playerListBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); playerListBtn.Position = UDim2.new(1, -55, 0.5, -9); playerListBtn.Size = UDim2.new(0, 50, 0, 18)
    playerListBtn.Font = Enum.Font.GothamBold; playerListBtn.Text = "List 👤"; playerListBtn.TextColor3 = Color3.fromRGB(180, 0, 0); playerListBtn.TextSize = 9
    local plCorner = Instance.new("UICorner"); plCorner.CornerRadius = UDim.new(0, 4); plCorner.Parent = playerListBtn
    
    -- Dropdown List Player
    local listPanel = Instance.new("ScrollingFrame")
    listPanel.Parent = ScreenGui
    listPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    listPanel.Size = UDim2.new(0, 140, 0, 120)
    listPanel.Visible = false
    listPanel.ZIndex = 20
    listPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    listPanel.ScrollBarThickness = 3
    local lpCorner = Instance.new("UICorner"); lpCorner.CornerRadius = UDim.new(0, 6); lpCorner.Parent = listPanel
    local lpStroke = Instance.new("UIStroke"); lpStroke.Color = Color3.fromRGB(180, 0, 0); lpStroke.Thickness = 1.2; lpStroke.Parent = listPanel
    local lpLayout = Instance.new("UIListLayout"); lpLayout.Parent = listPanel; lpLayout.SortOrder = Enum.SortOrder.LayoutOrder; lpLayout.Padding = UDim.new(0, 4)
    
    playerListBtn.MouseButton1Click:Connect(function()
        listPanel.Visible = not listPanel.Visible
        if listPanel.Visible then
            local absPos = playerListBtn.AbsolutePosition
            listPanel.Position = UDim2.new(0, absPos.X - 140, 0, absPos.Y)
            
            -- Clear old list
            for _, child in ipairs(listPanel:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            
            -- Populate players in map
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton")
                    pBtn.Parent = listPanel
                    pBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    pBtn.Size = UDim2.new(1, -6, 0, 24)
                    pBtn.Font = Enum.Font.GothamMedium
                    pBtn.Text = "  " .. p.Name
                    pBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                    pBtn.TextSize = 9
                    pBtn.TextXAlignment = Enum.TextXAlignment.Left
                    pBtn.ZIndex = 21
                    local pbC = Instance.new("UICorner"); pbC.CornerRadius = UDim.new(0, 4); pbC.Parent = pBtn
                    
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

-- 4. Copy Baju Player Lain (List Akun Satu Map)
local function createCopyBajuFeature(parent)
    local item = Instance.new("Frame")
    item.Parent = parent
    item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    item.Size = UDim2.new(1, -4, 0, 32)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 5); corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 10, 0, 0); label.Size = UDim2.new(0, 110, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = "Copy Baju Player"; label.TextColor3 = Color3.fromRGB(220, 220, 220); label.TextSize = 10; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local copyListBtn = Instance.new("TextButton")
    copyListBtn.Parent = item; copyListBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); copyListBtn.Position = UDim2.new(1, -55, 0.5, -9); copyListBtn.Size = UDim2.new(0, 50, 0, 18)
    copyListBtn.Font = Enum.Font.GothamBold; copyListBtn.Text = "Copy 👕"; copyListBtn.TextColor3 = Color3.fromRGB(180, 0, 0); copyListBtn.TextSize = 9
    local clCorner = Instance.new("UICorner"); clCorner.CornerRadius = UDim.new(0, 4); clCorner.Parent = copyListBtn
    
    local copyPanel = Instance.new("ScrollingFrame")
    copyPanel.Parent = ScreenGui
    copyPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    copyPanel.Size = UDim2.new(0, 140, 0, 120)
    copyPanel.Visible = false
    copyPanel.ZIndex = 20
    copyPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    copyPanel.ScrollBarThickness = 3
    local cpCorner = Instance.new("UICorner"); cpCorner.CornerRadius = UDim.new(0, 6); cpCorner.Parent = copyPanel
    local cpStroke = Instance.new("UIStroke"); cpStroke.Color = Color3.fromRGB(180, 0, 0); cpStroke.Thickness = 1.2; cpStroke.Parent = copyPanel
    local cpLayout = Instance.new("UIListLayout"); cpLayout.Parent = copyPanel; cpLayout.SortOrder = Enum.SortOrder.LayoutOrder; cpLayout.Padding = UDim.new(0, 4)
    
    copyListBtn.MouseButton1Click:Connect(function()
        copyPanel.Visible = not copyPanel.Visible
        if copyPanel.Visible then
            local absPos = copyListBtn.AbsolutePosition
            copyPanel.Position = UDim2.new(0, absPos.X - 140, 0, absPos.Y)
            
            for _, child in ipairs(copyPanel:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton")
                    pBtn.Parent = copyPanel
                    pBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    pBtn.Size = UDim2.new(1, -6, 0, 24)
                    pBtn.Font = Enum.Font.GothamMedium
                    pBtn.Text = "  " .. p.Name
                    pBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                    pBtn.TextSize = 9
                    pBtn.TextXAlignment = Enum.TextXAlignment.Left
                    pBtn.ZIndex = 21
                    local pbC = Instance.new("UICorner"); pbC.CornerRadius = UDim.new(0, 4); pbC.Parent = pBtn
                    
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

-- ==========================================
-- INFO TAB CONTENT
-- ==========================================
local function createInfoRow(parent, labelText, valText)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    row.Size = UDim2.new(1, -4, 0, 32)
    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 5); corner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Parent = row; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 10, 0, 0); label.Size = UDim2.new(0, 100, 1, 0)
    label.Font = Enum.Font.GothamMedium; label.Text = labelText; label.TextColor3 = Color3.fromRGB(220, 220, 220); label.TextSize = 10; label.TextXAlignment = Enum.TextXAlignment.Left
    
    local val = Instance.new("TextLabel")
    val.Parent = row; val.BackgroundTransparency = 1; val.Position = UDim2.new(0, 110, 0, 0); val.Size = UDim2.new(1, -120, 1, 0)
    val.Font = Enum.Font.GothamMedium; val.Text = valText; val.TextColor3 = Color3.fromRGB(180, 0, 0); val.TextSize = 10; val.TextXAlignment = Enum.TextXAlignment.Right
end

createInfoRow(InfoPage, "Developed", "B2AL VIP")
createInfoRow(InfoPage, "Telegram", "@b2alvipep")

print("Nebolusverse Delta UI successfully updated for: " .. LocalPlayer.Name)