--[[
    NEBOLUSVERSE - Ultimate Fixed Functional Script with Online Key System Login UI
    Theme: Black & Red Gaming Theme matching website & Delta style.
]]--

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

if CoreGui:FindFirstChild("NebolusDeltaUI") then
    CoreGui.NebolusDeltaUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NebolusDeltaUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- ==========================================
-- 1. LOGIN KEY SYSTEM UI (TEMA SESUAI WEB & UI)
-- ==========================================
local KeySystemGui = Instance.new("Frame")
KeySystemGui.Name = "KeySystemGui"
KeySystemGui.Parent = ScreenGui
KeySystemGui.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
KeySystemGui.Position = UDim2.new(0.5, -140, 0.5, -90)
KeySystemGui.Size = UDim2.new(0, 280, 0, 180)
KeySystemGui.ZIndex = 50

local ksCorner = Instance.new("UICorner"); ksCorner.CornerRadius = UDim.new(0, 6); ksCorner.Parent = KeySystemGui
local ksStroke = Instance.new("UIStroke"); ksStroke.Color = Color3.fromRGB(180, 0, 0); ksStroke.Thickness = 1.5; ksStroke.Parent = KeySystemGui

local ksTitle = Instance.new("TextLabel")
ksTitle.Parent = KeySystemGui
ksTitle.BackgroundTransparency = 1
ksTitle.Position = UDim2.new(0, 0, 0, 12)
ksTitle.Size = UDim2.new(1, 0, 0, 20)
ksTitle.Font = Enum.Font.GothamBold
ksTitle.Text = "FERI PROXY // LOGIN"
ksTitle.TextColor3 = Color3.fromRGB(180, 0, 0)
ksTitle.TextSize = 12
ksTitle.ZIndex = 51

local ksSub = Instance.new("TextLabel")
ksSub.Parent = KeySystemGui
ksSub.BackgroundTransparency = 1
ksSub.Position = UDim2.new(0, 0, 0, 32)
ksSub.Size = UDim2.new(1, 0, 0, 14)
ksSub.Font = Enum.Font.GothamMedium
ksSub.Text = "Masukkan Key Valid dari Website"
ksSub.TextColor3 = Color3.fromRGB(150, 150, 150)
ksSub.TextSize = 8
ksSub.ZIndex = 51

local keyBox = Instance.new("TextBox")
keyBox.Parent = KeySystemGui
keyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
keyBox.Position = UDim2.new(0.1, 0, 0, 55)
keyBox.Size = UDim2.new(0.8, 0, 0, 32)
keyBox.Font = Enum.Font.GothamMedium
keyBox.PlaceholderText = "FERICOD-XXXX-XXXX-XXXX"
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
keyBox.TextSize = 9
keyBox.ClearTextOnFocus = false
keyBox.ZIndex = 51
local kbC = Instance.new("UICorner"); kbC.CornerRadius = UDim.new(0, 4); kbC.Parent = keyBox
local kbS = Instance.new("UIStroke"); kbS.Color = Color3.fromRGB(50, 50, 50); kbS.Thickness = 1; kbS.Parent = keyBox

local statusLabel = Instance.new("TextLabel")
statusLabel.Parent = KeySystemGui
statusLabel.BackgroundTransparency = 1
statusLabel.Position = UDim2.new(0, 0, 0, 92)
statusLabel.Size = UDim2.new(1, 0, 0, 14)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
statusLabel.TextSize = 8
statusLabel.ZIndex = 51

local submitBtn = Instance.new("TextButton")
submitBtn.Parent = KeySystemGui
submitBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
submitBtn.Position = UDim2.new(0.1, 0, 0, 115)
submitBtn.Size = UDim2.new(0.8, 0, 0, 30)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Text = "VERIFY KEY"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.TextSize = 10
submitBtn.AutoButtonColor = false
submitBtn.ZIndex = 51
local sbC = Instance.new("UICorner"); sbC.CornerRadius = UDim.new(0, 4); sbC.Parent = submitBtn

-- Forward deklarasi fungsi utama UI
local function loadMainUI()
    KeySystemGui:Destroy()

    -- ==========================================
    -- FLOATING TOGGLE BUTTON (SKULL LOGO MURNI CODING)
    -- ==========================================
    local FloatBtn = Instance.new("ImageButton")
    FloatBtn.Name = "FloatButton"
    FloatBtn.Parent = ScreenGui
    FloatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    FloatBtn.Position = UDim2.new(0, 15, 0.35, 0)
    FloatBtn.Size = UDim2.new(0, 40, 0, 40)
    FloatBtn.Image = ""
    FloatBtn.Draggable = true

    local FloatCorner = Instance.new("UICorner"); FloatCorner.CornerRadius = UDim.new(1, 0); FloatCorner.Parent = FloatBtn
    local FloatStroke = Instance.new("UIStroke"); FloatStroke.Color = Color3.fromRGB(180, 0, 0); FloatStroke.Thickness = 1.5; FloatStroke.Parent = FloatBtn

    local SkullHead = Instance.new("Frame")
    SkullHead.Name = "SkullHead"; SkullHead.Parent = FloatBtn; SkullHead.BackgroundColor3 = Color3.fromRGB(200, 200, 200); SkullHead.Position = UDim2.new(0.5, -8, 0.5, -11); SkullHead.Size = UDim2.new(0, 16, 0, 14)
    local shCorner = Instance.new("UICorner"); shCorner.CornerRadius = UDim.new(0.4, 0); shCorner.Parent = SkullHead

    local SkullJaw = Instance.new("Frame")
    SkullJaw.Name = "SkullJaw"; SkullJaw.Parent = FloatBtn; SkullJaw.BackgroundColor3 = Color3.fromRGB(200, 200, 200); SkullJaw.Position = UDim2.new(0.5, -5, 0.5, 3); SkullJaw.Size = UDim2.new(0, 10, 0, 6)
    local sjCorner = Instance.new("UICorner"); sjCorner.CornerRadius = UDim.new(0.2, 0); sjCorner.Parent = SkullJaw

    local Eye1 = Instance.new("Frame")
    Eye1.Name = "Eye1"; Eye1.Parent = SkullHead; Eye1.BackgroundColor3 = Color3.fromRGB(12, 12, 12); Eye1.Position = UDim2.new(0, 2, 0, 3); Eye1.Size = UDim2.new(0, 3, 0, 4)
    local e1c = Instance.new("UICorner"); e1c.CornerRadius = UDim.new(1,0); e1c.Parent = Eye1

    local Eye2 = Instance.new("Frame")
    Eye2.Name = "Eye2"; Eye2.Parent = SkullHead; Eye2.BackgroundColor3 = Color3.fromRGB(12, 12, 12); Eye2.Position = UDim2.new(1, -5, 0, 3); Eye2.Size = UDim2.new(0, 3, 0, 4)
    local e2c = Instance.new("UICorner"); e2c.CornerRadius = UDim.new(1,0); e2c.Parent = Eye2

    -- ==========================================
    -- MAIN WINDOW CONTAINER
    -- ==========================================
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"; MainFrame.Parent = ScreenGui; MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -95); MainFrame.Size = UDim2.new(0, 320, 0, 195); MainFrame.Visible = true

    local MainCorner = Instance.new("UICorner"); MainCorner.CornerRadius = UDim.new(0, 5); MainCorner.Parent = MainFrame
    local MainStroke = Instance.new("UIStroke"); MainStroke.Color = Color3.fromRGB(180, 0, 0); MainStroke.Thickness = 1.2; MainStroke.Parent = MainFrame

    FloatBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
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

    local Header = Instance.new("TextLabel")
    Header.Name = "Header"; Header.Parent = MainFrame; Header.BackgroundTransparency = 1; Header.Position = UDim2.new(0.28, 0, 0, 4); Header.Size = UDim2.new(0.5, 0, 0, 18)
    Header.Font = Enum.Font.GothamBold; Header.Text = "FERI PROXY"; Header.TextColor3 = Color3.fromRGB(180, 0, 0); Header.TextSize = 11

    -- Sidebar & Pages setup
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"; Sidebar.Parent = MainFrame; Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18); Sidebar.Position = UDim2.new(0, 5, 0, 26); Sidebar.Size = UDim2.new(0, 45, 0, 163)
    local SidebarCorner = Instance.new("UICorner"); SidebarCorner.CornerRadius = UDim.new(0, 4); SidebarCorner.Parent = Sidebar

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.Parent = Sidebar; SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder; SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; SidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Center; SidebarLayout.Padding = UDim.new(0, 8)

    local function createTabButtonWithCustomIcon(name, order, iconType)
        local btn = Instance.new("TextButton")
        btn.Name = name .. "Tab"; btn.Parent = Sidebar; btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25); btn.Size = UDim2.new(0, 35, 0, 35); btn.AutoButtonColor = false; btn.Text = ""; btn.LayoutOrder = order
        local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = btn
        
        local iconHolder = Instance.new("Frame")
        iconHolder.Parent = btn; iconHolder.BackgroundTransparency = 1; iconHolder.Position = UDim2.new(0.5, -8, 0, 4); iconHolder.Size = UDim2.new(0, 16, 0, 12)
        
        if iconType == "Visuals" then
            local box = Instance.new("Frame"); box.Parent = iconHolder; box.BackgroundColor3 = Color3.fromRGB(150, 150, 150); box.Size = UDim2.new(1, 0, 1, 0)
            local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 2); bc.Parent = box
            local inner = Instance.new("Frame"); inner.Parent = box; inner.BackgroundColor3 = Color3.fromRGB(25, 25, 25); inner.Position = UDim2.new(0, 2, 0, 2); inner.Size = UDim2.new(1, -4, 1, -4)
            local ic = Instance.new("UICorner"); ic.CornerRadius = UDim.new(0, 1); ic.Parent = inner
        elseif iconType == "Misc" then
            local gear = Instance.new("Frame"); gear.Parent = iconHolder; gear.BackgroundColor3 = Color3.fromRGB(150, 150, 150); gear.Position = UDim2.new(0.5, -5, 0.5, -5); gear.Size = UDim2.new(0, 10, 0, 10)
            local gc = Instance.new("UICorner"); gc.CornerRadius = UDim.new(1, 0); gc.Parent = gear
            local center = Instance.new("Frame"); center.Parent = gear; center.BackgroundColor3 = Color3.fromRGB(25, 25, 25); center.Position = UDim2.new(0.5, -2, 0.5, -2); center.Size = UDim2.new(0, 4, 0, 4)
            local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(1, 0); cc.Parent = center
        elseif iconType == "Info" then
            local dot = Instance.new("Frame"); dot.Parent = iconHolder; dot.BackgroundColor3 = Color3.fromRGB(150, 150, 150); dot.Position = UDim2.new(0.5, -1, 0, 1); dot.Size = UDim2.new(0, 2, 0, 2)
            local line = Instance.new("Frame"); line.Parent = iconHolder; line.BackgroundColor3 = Color3.fromRGB(150, 150, 150); line.Position = UDim2.new(0.5, -1, 0, 5); line.Size = UDim2.new(0, 2, 0, 7)
        end
        
        local label = Instance.new("TextLabel")
        label.Parent = btn; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 0, 0, 18); label.Size = UDim2.new(1, 0, 0, 14)
        label.Font = Enum.Font.GothamMedium; label.Text = name; label.TextColor3 = Color3.fromRGB(150, 150, 150); label.TextSize = 7
        
        return btn, iconHolder, label
    end

    local VisualsBtn, VisIcon, VisLabel = createTabButtonWithCustomIcon("Visuals", 1, "Visuals")
    local MiscBtn, MiscIcon, MiscLabel = createTabButtonWithCustomIcon("Misc", 2, "Misc")
    local InfoBtn, InfoIcon, InfoLabel = createTabButtonWithCustomIcon("Info", 3, "Info")

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"; ContentContainer.Parent = MainFrame; ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 54, 0, 26); ContentContainer.Size = UDim2.new(0, 260, 0, 163)

    local function createPage(name)
        local page = Instance.new("ScrollingFrame")
        page.Name = name .. "Page"; page.Parent = ContentContainer; page.BackgroundTransparency = 1; page.Size = UDim2.new(1, 0, 1, 0)
        page.CanvasSize = UDim2.new(0, 0, 0, 0); page.AutomaticCanvasSize = Enum.AutomaticSize.Y; page.ScrollBarThickness = 2; page.Visible = false
        local layout = Instance.new("UIListLayout"); layout.Parent = page; layout.SortOrder = Enum.SortOrder.LayoutOrder; layout.Padding = UDim.new(0, 5)
        return page
    end

    local VisualsPage = createPage("Visuals")
    local MiscPage = createPage("Misc")
    local InfoPage = createPage("Info")
    VisualsPage.Visible = true

    local function setActiveTab(tabName)
        for _, ch in ipairs(VisIcon:GetChildren()) do if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(150, 150, 150) end end
        VisLabel.TextColor3 = Color3.fromRGB(150, 150, 150); VisualsPage.Visible = false
        for _, ch in ipairs(MiscIcon:GetChildren()) do if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(150, 150, 150) end end
        MiscLabel.TextColor3 = Color3.fromRGB(150, 150, 150); MiscPage.Visible = false
        for _, ch in ipairs(InfoIcon:GetChildren()) do if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(150, 150, 150) end end
        InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150); InfoPage.Visible = false
        
        if tabName == "Visuals" then
            for _, ch in ipairs(VisIcon:GetChildren()) do if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(180, 0, 0) end end
            VisLabel.TextColor3 = Color3.fromRGB(180, 0, 0); VisualsPage.Visible = true
        elseif tabName == "Misc" then
            for _, ch in ipairs(MiscIcon:GetChildren()) do if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(180, 0, 0) end end
            MiscLabel.TextColor3 = Color3.fromRGB(180, 0, 0); MiscPage.Visible = true
        elseif tabName == "Info" then
            for _, ch in ipairs(InfoIcon:GetChildren()) do if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(180, 0, 0) end end
            InfoLabel.TextColor3 = Color3.fromRGB(180, 0, 0); InfoPage.Visible = true
        end
    end

    VisualsBtn.MouseButton1Click:Connect(function() setActiveTab("Visuals") end)
    MiscBtn.MouseButton1Click:Connect(function() setActiveTab("Misc") end)
    InfoBtn.MouseButton1Click:Connect(function() setActiveTab("Info") end)

    -- Global States & Features
    local currentEspColor = Color3.fromRGB(255, 0, 0)
    local espLineEnabled = false
    local espBoxEnabled = false
    local espSkeletonEnabled = false
    local espNameEnabled = false
    local espNameSize = 12
    local espLinePosition = "Center"

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

    -- ESP Name Feature
    local function createEspNameFeature(parent)
        local item = Instance.new("Frame")
        item.Parent = parent; item.BackgroundColor3 = Color3.fromRGB(20, 20, 20); item.Size = UDim2.new(1, -2, 0, 50)
        local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 4); corner.Parent = item
        local label = Instance.new("TextLabel")
        label.Parent = item; label.BackgroundTransparency = 1; label.Position = UDim2.new(0, 8, 0, 3); label.Size = UDim2.new(0, 90, 0, 16)
        label.Font = Enum.Font.GothamMedium; label.Text = "ESP Name"; label.TextColor3 = Color3.fromRGB(210, 210, 210); label.TextSize = 9; label.TextXAlignment = Enum.TextXAlignment.Left
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Parent = item; toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); toggleBtn.Position = UDim2.new(1, -36, 0, 4); toggleBtn.Size = UDim2.new(0, 28, 0, 16); toggleBtn.AutoButtonColor = false; toggleBtn.Text = ""
        local tCorner = Instance.new("UICorner"); tCorner.CornerRadius = UDim.new(1, 0); tCorner.Parent = toggleBtn
        local circle = Instance.new("Frame")
        circle.Parent = toggleBtn; circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120); circle.Position = UDim2.new(0, 2, 0.5, -6); circle.Size = UDim2.new(0, 12, 0, 12)
        local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(1, 0); cCorner.Parent = circle
        
        toggleBtn.MouseButton1Click:Connect(function()
            espNameEnabled = not espNameEnabled
            if espNameEnabled then
                TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 0, 0)}):Play()
                TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -14, 0.5, -6), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            else
                TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -6), BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
            end
        end)
        
        local sizeNumLabel = Instance.new("TextLabel")
        sizeNumLabel.Parent = item; sizeNumLabel.BackgroundTransparency = 1; sizeNumLabel.Position = UDim2.new(1, -40, 0, 22); sizeNumLabel.Size = UDim2.new(0, 30, 0, 14)
        sizeNumLabel.Font = Enum.Font.GothamBold; sizeNumLabel.Text = "12"; sizeNumLabel.TextColor3 = Color3.fromRGB(180, 0, 0); sizeNumLabel.TextSize = 9; sizeNumLabel.TextXAlignment = Enum.TextXAlignment.Right
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Parent = item; sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40); sliderBg.Position = UDim2.new(0, 8, 0, 36); sliderBg.Size = UDim2.new(1, -16, 0, 10)
        local sCorner = Instance.new("UICorner"); sCorner.CornerRadius = UDim.new(1, 0); sCorner.Parent = sliderBg
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Parent = sliderBg; sliderFill.BackgroundColor3 = Color3.fromRGB(180, 0, 0); sliderFill.Size = UDim2.new(12/30, 0, 1, 0)
        local sfCorner = Instance.new("UICorner"); sfCorner.CornerRadius = UDim.new(1, 0); sfCorner.Parent = sliderFill
        
        local draggingSize = false
        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSize = true end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSize = false end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if draggingSize and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local relX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                sliderFill.Size = UDim2.new(relX, 0, 1, 0)
                espNameSize = math.clamp(math.floor(relX * 30), 8, 30)
                sizeNumLabel.Text = tostring(espNameSize)
            end
        end)
    end
    createEspNameFeature(VisualsPage)

    -- ESP Rendering Loop
    local espObjects = {}
    RunService.RenderStepped:Connect(function()
        local cam = Workspace.CurrentCamera
        for p, cache in pairs(espObjects) do
            if not p or not p.Parent or not p.Character or not p.Character:FindFirstChild("Humanoid") or p.Character.Humanoid.Health <= 0 then
                pcall(function()
                    cache.Line:Remove()
                    cache.Box:Remove()
                    cache.NameText:Remove()
                    for _, sk in ipairs(cache.Skels) do sk:Remove() end
                end)
                espObjects[p] = nil
            end
        end
        
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                local isValid = char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char:FindFirstChild("Head") and char.Humanoid.Health > 0
                
                if isValid then
                    if not espObjects[p] then
                        espObjects[p] = {
                            Line = Drawing.new("Line"),
                            Box = Drawing.new("Square"),
                            NameText = Drawing.new("Text"),
                            Skels = { Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line"), Drawing.new("Line") }
                        }
                        espObjects[p].Line.Thickness = 1.2
                        espObjects[p].Box.Thickness = 1.2
                        espObjects[p].Box.Filled = false
                        espObjects[p].NameText.Center = true
                        espObjects[p].NameText.Outline = true
                        for _, sk in ipairs(espObjects[p].Skels) do sk.Thickness = 1.2 end
                    end
                    
                    local cache = espObjects[p]
                    local hrp = char.HumanoidRootPart
                    local vector, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    
                    if onScreen then
                        if espLineEnabled then
                            cache.Line.Visible = true
                            cache.Line.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
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
                        
                        if espNameEnabled then
                            cache.NameText.Visible = true
                            cache.NameText.Text = p.Name
                            cache.NameText.Size = espNameSize
                            cache.NameText.Color = currentEspColor
                            cache.NameText.Position = Vector2.new(vector.X, vector.Y - (2000 / vector.Z) - 18)
                        else
                            cache.NameText.Visible = false
                        end
                        
                        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                        local head = char.Head
                        local la = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")
                        local ra = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
                        local ll = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")
                        local rl = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
                        
                        if espSkeletonEnabled and head and torso then
                            local hPos, hVis = cam:WorldToViewportPoint(head.Position)
                            local tPos, tVis = cam:WorldToViewportPoint(torso.Position)
                            
                            if hVis and tVis then
                                cache.Skels[1].Visible = true; cache.Skels[1].From = Vector2.new(hPos.X, hPos.Y); cache.Skels[1].To = Vector2.new(tPos.X, tPos.Y); cache.Skels[1].Color = currentEspColor
                            else cache.Skels[1].Visible = false end
                            
                            if la and tVis then
                                local laPos, laVis = cam:WorldToViewportPoint(la.Position)
                                cache.Skels[2].Visible = laVis; cache.Skels[2].From = Vector2.new(tPos.X, tPos.Y); cache.Skels[2].To = Vector2.new(laPos.X, laPos.Y); cache.Skels[2].Color = currentEspColor
                            else cache.Skels[2].Visible = false end
                            
                            if ra and tVis then
                                local raPos, raVis = cam:WorldToViewportPoint(ra.Position)
                                cache.Skels[3].Visible = raVis; cache.Skels[3].From = Vector2.new(tPos.X, tPos.Y); cache.Skels[3].To = Vector2.new(raPos.X, raPos.Y); cache.Skels[3].Color = currentEspColor
                            else cache.Skels[3].Visible = false end
                            
                            if ll and tVis then
                                local llPos, llVis = cam:WorldToViewportPoint(ll.Position)
                                cache.Skels[4].Visible = llVis; cache.Skels[4].From = Vector2.new(tPos.X, tPos.Y); cache.Skels[4].To = Vector2.new(llPos.X, llPos.Y); cache.Skels[4].Color = currentEspColor
                            else cache.Skels[4].Visible = false end
                            
                            if rl and tVis then
                                local rlPos, rlVis = cam:WorldToViewportPoint(rl.Position)
                                cache.Skels[5].Visible = rlVis; cache.Skels[5].From = Vector2.new(tPos.X, tPos.Y); cache.Skels[5].To = Vector2.new(rlPos.X, rlPos.Y); cache.Skels[5].Color = currentEspColor
                            else cache.Skels[5].Visible = false end
                        else
                            for _, sk in ipairs(cache.Skels) do sk.Visible = false end
                        end
                    else
                        cache.Line.Visible = false; cache.Box.Visible = false; cache.NameText.Visible = false
                        for _, sk in ipairs(cache.Skels) do sk.Visible = false end
                    end
                else
                    if espObjects[p] then
                        pcall(function()
                            espObjects[p].Line:Remove()
                            espObjects[p].Box:Remove()
                            espObjects[p].NameText:Remove()
                            for _, sk in ipairs(espObjects[p].Skels) do sk:Remove() end
                        end)
                        espObjects[p] = nil
                    end
                end
            end
        end
    end)
end

-- Tombol Submit Key untuk Validasi Online ke Vercel (`ferivip.vercel.app`)
submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = keyBox.Text
    if enteredKey == "" then
        statusLabel.Text = "Key tidak boleh kosong!"
        return
    end

    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    statusLabel.Text = "Menghubungkan ke Server..."

    local success, response = pcall(function()
        -- URL Endpoint dari website Vercel kamu
        local url = "https://ferivip.vercel.app/api/verify?key=" .. enteredKey
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if success and response and response.success then
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        statusLabel.Text = "Key Valid! Memuat Menu..."
        task.wait(0.8)
        loadMainUI()
    else
        statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        statusLabel.Text = "Key Salah, Expired, atau Dimatikan Admin!"
    end
end)