--[[\
    NEBOLUSVERSE - UI Replica Script (Roblox Delta Style)
    Target UI Cloned from Reference Images
]]--

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Hapus UI lama kalau ada biar gak numpuk
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
FloatBtn.Size = UDim2.new(0, 45, 0, 45)
FloatBtn.Image = "rbxassetid://6034287593" -- Placeholder icon, silakan ganti asset id jika perlu
FloatBtn.Draggable = true

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatBtn

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(180, 0, 0)
FloatStroke.Thickness = 2
FloatStroke.Parent = FloatBtn

-- ==========================================
-- MAIN WINDOW CONTAINER
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -115)
MainFrame.Size = UDim2.new(0, 380, 0, 230)
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(180, 0, 0)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Fungsi Buka/Tutup UI lewat Float Button
FloatBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==========================================
-- DRAGGABLE SYSTEM (BATAS SCREEN / TIDAK TEMBUS)
-- ==========================================
local dragging, dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local viewportSize = workspace.CurrentCamera.ViewportSize
        
        -- Hitung posisi baru
        local targetX = startPos.X.Offset + delta.X
        local targetY = startPos.Y.Offset + delta.Y
        
        -- Clamp agar tidak tembus layar (menjaga batas viewport)
        local maxX = viewportSize.X - MainFrame.AbsoluteSize.X
        local maxY = viewportSize.Y - MainFrame.AbsoluteSize.Y
        
        targetX = math.clamp(targetX, 0, maxX)
        targetY = math.clamp(targetY, 0, maxY)
        
        MainFrame.Position = UDim2.new(0, targetX, 0, targetY)
    end
end)

-- ==========================================
-- TITLE BAR & HEADER ("B2AL PROXY")
-- ==========================================
local Header = Instance.new("TextLabel")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundTransparency = 1
Header.Position = UDim2.new(0.3, 0, 0, 8)
Header.Size = UDim2.new(0.5, 0, 0, 25)
Header.Font = Enum.Font.GothamBold
Header.Text = "B2AL PROXY"
Header.TextColor3 = Color3.fromRGB(180, 0, 0)
Header.TextSize = 14

-- ==========================================
-- SIDEBAR NAVIGATION (Visuals, Misc, Info)
-- ==========================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.Position = UDim2.new(0, 8, 0, 35)
Sidebar.Size = UDim2.new(0, 55, 0, 185)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 6)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SidebarLayout.Padding = UDim.new(0, 15)

-- Fungsi Pembuatan Tombol Sidebar
local function createTabButton(name, iconId, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Tab"
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Size = UDim2.new(0, 42, 0, 42)
    btn.AutoButtonColor = false
    btn.Text = ""
    btn.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    local icon = Instance.new("ImageLabel")
    icon.Parent = btn
    icon.BackgroundTransparency = 1
    icon.Position = UDim2.new(0.5, -10, 0.5, -16)
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Image = iconId
    icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    
    local label = Instance.new("TextLabel")
    label.Parent = btn
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 0, 0, 24)
    label.Size = UDim2.new(1, 0, 0, 15)
    label.Font = Enum.Font.GothamMedium
    label.Text = name
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.TextSize = 9
    
    return btn, icon, label
end

local VisualsBtn, VisIcon, VisLabel = createTabButton("Visuals", "rbxassetid://6034287593", 1)
local MiscBtn, MiscIcon, MiscLabel = createTabButton("Misc", "rbxassetid://6035047409", 2)
local InfoBtn, InfoIcon, InfoLabel = createTabButton("Info", "rbxassetid://6035047398", 3)

-- ==========================================
-- CONTAINER CONTENT (Halaman Menu)
-- ==========================================
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 70, 0, 38)
ContentContainer.Size = UDim2.new(0, 300, 0, 180)

-- Buat Halaman (Page)
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
    layout.Padding = UDim.new(0, 8)
    
    return page
end

local VisualsPage = createPage("Visuals")
local MiscPage = createPage("Misc")
local InfoPage = createPage("Info")

VisualsPage.Visible = true -- Default buka Visuals

-- Fungsi Tombol Tab Aktif
local function setActiveTab(tabName)
    VisIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    VisLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    VisualsPage.Visible = false
    
    MiscIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    MiscLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    MiscPage.Visible = false
    
    InfoIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
    InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    InfoPage.Visible = false
    
    if tabName == "Visuals" then
        VisIcon.ImageColor3 = Color3.fromRGB(180, 0, 0)
        VisLabel.TextColor3 = Color3.fromRGB(180, 0, 0)
        VisualsPage.Visible = true
    elseif tabName == "Misc" then
        MiscIcon.ImageColor3 = Color3.fromRGB(180, 0, 0)
        MiscLabel.TextColor3 = Color3.fromRGB(180, 0, 0)
        MiscPage.Visible = true
    elseif tabName == "Info" then
        InfoIcon.ImageColor3 = Color3.fromRGB(180, 0, 0)
        InfoLabel.TextColor3 = Color3.fromRGB(180, 0, 0)
        InfoPage.Visible = true
    end
end

VisualsBtn.MouseButton1Click:Connect(function() setActiveTab("Visuals") end)
MiscBtn.MouseButton1Click:Connect(function() setActiveTab("Misc") end)
InfoBtn.MouseButton1Click:Connect(function() setActiveTab("Info") end)

-- ==========================================
-- KOMPONEN TOGGLE ITEM (DUMMY)
-- ==========================================
local function createToggleItem(parent, titleText)
    local item = Instance.new("Frame")
    item.Parent = parent
    item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    item.Size = UDim2.new(1, -5, 0, 36)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = item
    
    local label = Instance.new("TextLabel")
    label.Parent = item
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = titleText
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Switch Toggle UI ala Delta
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = item
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    toggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
    toggleBtn.Size = UDim2.new(0, 36, 0, 20)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn
    
    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn
    circle.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.Size = UDim2.new(0, 16, 0, 16)
    
    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle
    
    local toggled = false
    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 0, 0)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(120, 120, 120)}):Play()
        end
    end)
    
    return item
end

-- Masukin Item Dummy Sesuai Request (Fitur 1, Fitur 2, dst)
createToggleItem(VisualsPage, "Fitur 1 (ESP Line)")
createToggleItem(VisualsPage, "Fitur 2 (ESP Box)")
createToggleItem(VisualsPage, "Fitur 3 (Radar)")
createToggleItem(VisualsPage, "Fitur 4 (Crosshair)")
createToggleItem(VisualsPage, "Fitur 5 (ESP Color)")

createToggleItem(MiscPage, "Fitur 6 (Ghost)")
createToggleItem(MiscPage, "Fitur 7 (Freeze)")
createToggleItem(MiscPage, "Fitur 8 (Tunnel)")

-- Halaman Info (Menyesuaikan gambar referensi info tab)
local function createInfoRow(parent, labelText, valText)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    row.Size = UDim2.new(1, -5, 0, 36)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = row
    
    local label = Instance.new("TextLabel")
    label.Parent = row
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local val = Instance.new("TextLabel")
    val.Parent = row
    val.BackgroundTransparency = 1
    val.Position = UDim2.new(0, 120, 0, 0)
    val.Size = UDim2.new(1, -130, 1, 0)
    val.Font = Enum.Font.GothamMedium
    val.Text = valText
    val.TextColor3 = Color3.fromRGB(180, 0, 0)
    val.TextSize = 11
    val.TextXAlignment = Enum.TextXAlignment.Right
end

createInfoRow(InfoPage, "Developed", "B2AL VIP")
createInfoRow(InfoPage, "Telegram", "@b2alvipep")

print("Nebolusverse Delta UI successfully injected for: " .. LocalPlayer.Name)