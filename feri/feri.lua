-- ============================================
-- FERI PROXY — 100% MIRIP B2AL
-- Roblox Delta Script
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// KONFIGURASI WARNA — PERSIS B2AL
local C = {
    Bg = Color3.fromRGB(10, 10, 15),           -- Hitam pekat
    Panel = Color3.fromRGB(13, 27, 42),        -- Biru gelap
    PanelItem = Color3.fromRGB(20, 20, 30),    -- Item background
    Border = Color3.fromRGB(86, 0, 255),       -- Ungu neon
    Accent = Color3.fromRGB(138, 43, 226),     -- Ungu elektrik
    Red = Color3.fromRGB(255, 0, 0),           -- Merah B2AL
    Text = Color3.fromRGB(255, 255, 255),      -- Putih
    TextDim = Color3.fromRGB(120, 120, 140),   -- Abu
    Off = Color3.fromRGB(64, 64, 64),          -- Abu toggle off
}

--// State
local State = {
    ESPLine = false,
    ESPBox = false,
    ESPName = false,
    ESPDistance = false,
    ESPHealth = false,
    Radar = false,
    Crosshair = false,
    ESPCustom = false,
    ESPColor = Color3.fromRGB(255, 0, 0),
    Ghost = false,
    Freeze = false,
    Tune = false,
    MenuOpen = false,
}

local ScreenGui, MainFrame, IconButton
local currentTab = "Visuals"

--// ============================================
-- BIKIN GUI
-- ============================================
local function createGUI()
    if CoreGui:FindFirstChild("FeriProxyGUI") then
        CoreGui.FeriProxyGUI:Destroy()
    end

    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FeriProxyGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    -- ============================================
    -- BOLITA
    -- ============================================
    IconButton = Instance.new("TextButton")
    IconButton.Name = "IconButton"
    IconButton.Size = UDim2.new(0, 60, 0, 60)
    IconButton.Position = UDim2.new(0.5, -30, 0.1, 0)
    IconButton.BackgroundColor3 = C.Bg
    IconButton.BorderSizePixel = 0
    IconButton.Text = "FERI"
    IconButton.TextColor3 = C.Red
    IconButton.TextSize = 14
    IconButton.Font = Enum.Font.GothamBold
    IconButton.AutoButtonColor = false
    IconButton.Parent = ScreenGui

    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(1, 0)
    ic.Parent = IconButton

    local is = Instance.new("UIStroke")
    is.Color = C.Red
    is.Thickness = 2
    is.Parent = IconButton

    -- ============================================
    -- MAIN FRAME
    -- ============================================
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 420, 0, 340)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    MainFrame.BackgroundColor3 = C.Bg
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    local mc = Instance.new("UICorner")
    mc.CornerRadius = UDim.new(0, 14)
    mc.Parent = MainFrame

    local ms = Instance.new("UIStroke")
    ms.Color = C.Border
    ms.Thickness = 1.5
    ms.Parent = MainFrame

    -- ============================================
    -- HEADER
    -- ============================================
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = C.Bg
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame

    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(0, 14)
    hc.Parent = Header

    -- Judul "FERI PROXY" warna merah
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "FERI PROXY"
    Title.TextColor3 = C.Red
    Title.TextSize = 22
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header

    -- Tombol close merah
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Position = UDim2.new(1, -45, 0.5, -16)
    CloseBtn.BackgroundColor3 = C.Red
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = C.Text
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = Header

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 8)
    cc.Parent = CloseBtn

    -- ============================================
    -- SIDEBAR (TAB KIRI)
    -- ============================================
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 110, 1, -60)
    Sidebar.Position = UDim2.new(0, 0, 0, 55)
    Sidebar.BackgroundColor3 = C.Bg
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 10)
    sc.Parent = Sidebar

    -- ============================================
    -- CONTENT AREA (KANAN)
    -- ============================================
    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -120, 1, -70)
    Content.Position = UDim2.new(0, 115, 0, 60)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 3
    Content.ScrollBarImageColor3 = C.Border
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.Parent = MainFrame

    local cl = Instance.new("UIListLayout")
    cl.Padding = UDim.new(0, 6)
    cl.SortOrder = Enum.SortOrder.LayoutOrder
    cl.Parent = Content

    -- ============================================
    -- FUNGSI TOGGLE
    -- ============================================
    local function createToggle(name, stateKey, callback)
        local F = Instance.new("Frame")
        F.Name = name
        F.Size = UDim2.new(1, 0, 0, 42)
        F.BackgroundColor3 = C.PanelItem
        F.BorderSizePixel = 0
        F.Parent = Content

        local fc = Instance.new("UICorner")
        fc.CornerRadius = UDim.new(0, 8)
        fc.Parent = F

        local fs = Instance.new("UIStroke")
        fs.Color = C.Border
        fs.Thickness = 1
        fs.Transparency = 0.6
        fs.Parent = F

        local L = Instance.new("TextLabel")
        L.Size = UDim2.new(1, -80, 1, 0)
        L.Position = UDim2.new(0, 15, 0, 0)
        L.BackgroundTransparency = 1
        L.Text = name
        L.TextColor3 = C.Text
        L.TextSize = 14
        L.Font = Enum.Font.Gotham
        L.TextXAlignment = Enum.TextXAlignment.Left
        L.Parent = F

        local T = Instance.new("TextButton")
        T.Size = UDim2.new(0, 44, 0, 22)
        T.Position = UDim2.new(1, -55, 0.5, -11)
        T.BackgroundColor3 = C.Off
        T.BorderSizePixel = 0
        T.Text = ""
        T.Parent = F

        local tc = Instance.new("UICorner")
        tc.CornerRadius = UDim.new(1, 0)
        tc.Parent = T

        local K = Instance.new("Frame")
        K.Size = UDim2.new(0, 16, 0, 16)
        K.Position = UDim2.new(0, 3, 0.5, -8)
        K.BackgroundColor3 = C.Text
        K.BorderSizePixel = 0
        K.Parent = T

        local kc = Instance.new("UICorner")
        kc.CornerRadius = UDim.new(1, 0)
        kc.Parent = K

        T.MouseButton1Click:Connect(function()
            State[stateKey] = not State[stateKey]
            if State[stateKey] then
                TweenService:Create(T, TweenInfo.new(0.15), {BackgroundColor3 = C.Red}):Play()
                TweenService:Create(K, TweenInfo.new(0.15), {Position = UDim2.new(1, -19, 0.5, -8)}):Play()
            else
                TweenService:Create(T, TweenInfo.new(0.15), {BackgroundColor3 = C.Off}):Play()
                TweenService:Create(K, TweenInfo.new(0.15), {Position = UDim2.new(0, 3, 0.5, -8)}):Play()
            end
            if callback then callback(State[stateKey]) end
        end)
    end

    -- ============================================
    -- FUNGSI TOGGLE + KOTAK WARNA
    -- ============================================
    local function createToggleWithColor(name, stateKey, colorKey)
        local F = Instance.new("Frame")
        F.Name = name
        F.Size = UDim2.new(1, 0, 0, 42)
        F.BackgroundColor3 = C.PanelItem
        F.BorderSizePixel = 0
        F.Parent = Content

        local fc = Instance.new("UICorner")
        fc.CornerRadius = UDim.new(0, 8)
        fc.Parent = F

        local fs = Instance.new("UIStroke")
        fs.Color = C.Border
        fs.Thickness = 1
        fs.Transparency = 0.6
        fs.Parent = F

        local L = Instance.new("TextLabel")
        L.Size = UDim2.new(1, -140, 1, 0)
        L.Position = UDim2.new(0, 15, 0, 0)
        L.BackgroundTransparency = 1
        L.Text = name
        L.TextColor3 = C.Text
        L.TextSize = 14
        L.Font = Enum.Font.Gotham
        L.TextXAlignment = Enum.TextXAlignment.Left
        L.Parent = F

        local CB = Instance.new("TextButton")
        CB.Size = UDim2.new(0, 22, 0, 22)
        CB.Position = UDim2.new(1, -115, 0.5, -11)
        CB.BackgroundColor3 = State[colorKey]
        CB.BorderSizePixel = 0
        CB.Text = ""
        CB.Parent = F

        local cbc = Instance.new("UICorner")
        cbc.CornerRadius = UDim.new(0, 5)
        cbc.Parent = CB

        local cbs = Instance.new("UIStroke")
        cbs.Color = C.Border
        cbs.Thickness = 1
        cbs.Parent = CB

        local T = Instance.new("TextButton")
        T.Size = UDim2.new(0, 44, 0, 22)
        T.Position = UDim2.new(1, -85, 0.5, -11)
        T.BackgroundColor3 = C.Off
        T.BorderSizePixel = 0
        T.Text = ""
        T.Parent = F

        local tc = Instance.new("UICorner")
        tc.CornerRadius = UDim.new(1, 0)
        tc.Parent = T

        local K = Instance.new("Frame")
        K.Size = UDim2.new(0, 16, 0, 16)
        K.Position = UDim2.new(0, 3, 0.5, -8)
        K.BackgroundColor3 = C.Text
        K.BorderSizePixel = 0
        K.Parent = T

        local kc = Instance.new("UICorner")
        kc.CornerRadius = UDim.new(1, 0)
        kc.Parent = K

        T.MouseButton1Click:Connect(function()
            State[stateKey] = not State[stateKey]
            if State[stateKey] then
                TweenService:Create(T, TweenInfo.new(0.15), {BackgroundColor3 = C.Red}):Play()
                TweenService:Create(K, TweenInfo.new(0.15), {Position = UDim2.new(1, -19, 0.5, -8)}):Play()
            else
                TweenService:Create(T, TweenInfo.new(0.15), {BackgroundColor3 = C.Off}):Play()
                TweenService:Create(K, TweenInfo.new(0.15), {Position = UDim2.new(0, 3, 0.5, -8)}):Play()
            end
        end)

        -- Color picker
        CB.MouseButton1Click:Connect(function()
            local P = Instance.new("Frame")
            P.Size = UDim2.new(0, 240, 0, 190)
            P.Position = UDim2.new(0.5, -120, 0.5, -95)
            P.BackgroundColor3 = C.Bg
            P.BorderSizePixel = 0
            P.ZIndex = 10
            P.Parent = ScreenGui

            local pc = Instance.new("UICorner")
            pc.CornerRadius = UDim.new(0, 10)
            pc.Parent = P

            local ps = Instance.new("UIStroke")
            ps.Color = C.Border
            ps.Thickness = 2
            ps.Parent = P

            local PT = Instance.new("TextLabel")
            PT.Size = UDim2.new(1, 0, 0, 30)
            PT.BackgroundTransparency = 1
            PT.Text = "PILIH WARNA"
            PT.TextColor3 = C.Red
            PT.TextSize = 15
            PT.Font = Enum.Font.GothamBold
            PT.Parent = P

            local PC = Instance.new("TextButton")
            PC.Size = UDim2.new(0, 24, 0, 24)
            PC.Position = UDim2.new(1, -30, 0, 3)
            PC.BackgroundColor3 = C.Red
            PC.BorderSizePixel = 0
            PC.Text = "✕"
            PC.TextColor3 = C.Text
            PC.TextSize = 11
            PC.Font = Enum.Font.GothamBold
            PC.Parent = P

            local pcc = Instance.new("UICorner")
            pcc.CornerRadius = UDim.new(0, 5)
            pcc.Parent = PC

            local PV = Instance.new("Frame")
            PV.Size = UDim2.new(1, -20, 0, 35)
            PV.Position = UDim2.new(0, 10, 0, 38)
            PV.BackgroundColor3 = State[colorKey]
            PV.BorderSizePixel = 0
            PV.Parent = P

            local pvc = Instance.new("UICorner")
            pvc.CornerRadius = UDim.new(0, 6)
            pvc.Parent = PV

            local function slider(label, y, val, cb)
                local SL = Instance.new("TextLabel")
                SL.Size = UDim2.new(0, 20, 0, 20)
                SL.Position = UDim2.new(0, 10, 0, y)
                SL.BackgroundTransparency = 1
                SL.Text = label
                SL.TextColor3 = C.Text
                SL.TextSize = 13
                SL.Font = Enum.Font.GothamBold
                SL.Parent = P

                local SB = Instance.new("Frame")
                SB.Size = UDim2.new(1, -50, 0, 6)
                SB.Position = UDim2.new(0, 40, 0, y + 7)
                SB.BackgroundColor3 = C.Panel
                SB.BorderSizePixel = 0
                SB.Parent = P

                local sbc = Instance.new("UICorner")
                sbc.CornerRadius = UDim.new(1, 0)
                sbc.Parent = SB

                local SF = Instance.new("Frame")
                SF.Size = UDim2.new(val, 0, 1, 0)
                SF.BackgroundColor3 = C.Red
                SF.BorderSizePixel = 0
                SF.Parent = SB

                local sfc = Instance.new("UICorner")
                sfc.CornerRadius = UDim.new(1, 0)
                sfc.Parent = SF

                local SK = Instance.new("Frame")
                SK.Size = UDim2.new(0, 14, 0, 14)
                SK.Position = UDim2.new(val, -7, 0.5, -7)
                SK.BackgroundColor3 = C.Text
                SK.BorderSizePixel = 0
                SK.Parent = SB

                local skc = Instance.new("UICorner")
                skc.CornerRadius = UDim.new(1, 0)
                skc.Parent = SK

                local drag = false
                SB.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        drag = true
                    end
                end)
                UserInputService.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                        drag = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(i)
                    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                        local p = math.clamp((i.Position.X - SB.AbsolutePosition.X) / SB.AbsoluteSize.X, 0, 1)
                        SF.Size = UDim2.new(p, 0, 1, 0)
                        SK.Position = UDim2.new(p, -7, 0.5, -7)
                        cb(p)
                    end
                end)
            end

            local r, g, b = State[colorKey].R, State[colorKey].G, State[colorKey].B
            slider("R", 85, r, function(v) r = v; State[colorKey] = Color3.new(r,g,b); PV.BackgroundColor3 = State[colorKey]; CB.BackgroundColor3 = State[colorKey] end)
            slider("G", 115, g, function(v) g = v; State[colorKey] = Color3.new(r,g,b); PV.BackgroundColor3 = State[colorKey]; CB.BackgroundColor3 = State[colorKey] end)
            slider("B", 145, b, function(v) b = v; State[colorKey] = Color3.new(r,g,b); PV.BackgroundColor3 = State[colorKey]; CB.BackgroundColor3 = State[colorKey] end)

            PC.MouseButton1Click:Connect(function() P:Destroy() end)
        end)
    end

    -- ============================================
    -- FUNGSI BIKIN TAB SIDEBAR
    -- ============================================
    local tabs = {
        {name = "Visuals", icon = "👁"},
        {name = "Misc", icon = "📦"},
        {name = "Info", icon = "ℹ"},
    }
    local tabButtons = {}

    for i, tab in ipairs(tabs) do
        local B = Instance.new("TextButton")
        B.Name = tab.name
        B.Size = UDim2.new(1, -10, 0, 38)
        B.Position = UDim2.new(0, 5, 0, (i-1) * 42 + 5)
        B.BackgroundColor3 = C.Bg
        B.BorderSizePixel = 0
        B.Text = tab.icon .. "  " .. tab.name
        B.TextColor3 = C.TextDim
        B.TextSize = 13
        B.Font = Enum.Font.GothamBold
        B.TextXAlignment = Enum.TextXAlignment.Left
        B.Parent = Sidebar

        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 7)
        bc.Parent = B

        tabButtons[tab.name] = B
    end

    -- Set tab default
    tabButtons["Visuals"].TextColor3 = C.Red
    tabButtons["Visuals"].BackgroundColor3 = C.PanelItem

    -- ============================================
    -- ISI CONTENT
    -- ============================================
    createToggle("ESP Line", "ESPLine")
    createToggle("ESP Box", "ESPBox")
    createToggle("ESP Name", "ESPName")
    createToggle("ESP Distance", "ESPDistance")
    createToggle("ESP Health", "ESPHealth")
    createToggle("Radar", "Radar")
    createToggle("Crosshair", "Crosshair")
    createToggleWithColor("Custom ESP", "ESPCustom", "ESPColor")
    createToggle("Ghost", "Ghost")
    createToggle("Freeze", "Freeze")
    createToggle("Tune", "Tune")

    -- ============================================
    -- FOOTER
    -- ============================================
    local Footer = Instance.new("Frame")
    Footer.Size = UDim2.new(1, 0, 0, 25)
    Footer.Position = UDim2.new(0, 0, 1, -25)
    Footer.BackgroundColor3 = C.Bg
    Footer.BorderSizePixel = 0
    Footer.Parent = MainFrame

    local FText = Instance.new("TextLabel")
    FText.Size = UDim2.new(1, -20, 1, 0)
    FText.Position = UDim2.new(0, 10, 0, 0)
    FText.BackgroundTransparency = 1
    FText.Text = "● LIVE & OPERATIONAL   |   " .. C.Telegram
    FText.TextColor3 = C.TextDim
    FText.TextSize = 10
    FText.Font = Enum.Font.Gotham
    FText.TextXAlignment = Enum.TextXAlignment.Left
    FText.Parent = Footer

    -- ============================================
    -- DRAG MENU
    -- ============================================
    local drag, ds, sp = false, nil, nil
    Header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = i.Position; sp = MainFrame.Position
        end
    end)
    Header.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            MainFrame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)

    -- ============================================
    -- DRAG ICON
    -- ============================================
    local idrag, ids, isp = false, nil, nil
    IconButton.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            idrag = true; ids = i.Position; isp = IconButton.Position
        end
    end)
    IconButton.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            idrag = false
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if idrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ids
            IconButton.Position = UDim2.new(isp.X.Scale, isp.X.Offset + d.X, isp.Y.Scale, isp.Y.Offset + d.Y)
        end
    end)

    -- ============================================
    -- KLIK ICON → BUKA MENU
    -- ============================================
    IconButton.MouseButton1Click:Connect(function()
        State.MenuOpen = not State.MenuOpen
        MainFrame.Visible = State.MenuOpen
        if State.MenuOpen then
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 420, 0, 340)}):Play()
        end
    end)

    -- ============================================
    -- KLIK CLOSE
    -- ============================================
    CloseBtn.MouseButton1Click:Connect(function()
        State.MenuOpen = false
        MainFrame.Visible = false
    end)

    -- ============================================
    -- TAB SWITCHING
    -- ============================================
    for name, btn in pairs(tabButtons) do
        btn.MouseButton1Click:Connect(function()
            currentTab = name
            for n, b in pairs(tabButtons) do
                if n == name then
                    b.TextColor3 = C.Red
                    b.BackgroundColor3 = C.PanelItem
                else
                    b.TextColor3 = C.TextDim
                    b.BackgroundColor3 = C.Bg
                end
            end
        end)
    end
end

--// ============================================
-- ESP SYSTEM
-- ============================================
local espObjects = {}

local function createESP(player)
    if player == LocalPlayer then return end
    local esp = {}
    esp.Box = Drawing.new("Square")
    esp.Box.Thickness = 1
    esp.Box.Color = State.ESPColor
    esp.Box.Filled = false
    esp.Box.Transparency = 1

    esp.Line = Drawing.new("Line")
    esp.Line.Thickness = 1
    esp.Line.Color = State.ESPColor
    esp.Line.Transparency = 1

    esp.Name = Drawing.new("Text")
    esp.Name.Size = 14
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Color = C.Text
    esp.Name.Transparency = 1

    esp.Distance = Drawing.new("Text")
    esp.Distance.Size = 12
    esp.Distance.Center = true
    esp.Distance.Outline = true
    esp.Distance.Color = C.TextDim
    esp.Distance.Transparency = 1

    espObjects[player] = esp
end

local function removeESP(player)
    if espObjects[player] then
        for _, o in pairs(espObjects[player]) do o:Remove() end
        espObjects[player] = nil
    end
end

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not espObjects[player] then createESP(player) end
            local esp = espObjects[player]
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")

            if hrp and hum and hum.Health > 0 then
                local sp, on = Camera:WorldToViewportPoint(hrp.Position)
                if on then
                    local head = char:FindFirstChild("Head")
                    if head then
                        local hp = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local fp = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                        local h = math.abs(hp.Y - fp.Y)
                        local w = h * 0.6

                        esp.Box.Color = State.ESPColor
                        esp.Line.Color = State.ESPColor

                        esp.Box.Size = Vector2.new(w, h)
                        esp.Box.Position = Vector2.new(sp.X - w/2, sp.Y - h/2)
                        esp.Box.Visible = State.ESPBox or State.ESPCustom

                        esp.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        esp.Line.To = Vector2.new(sp.X, sp.Y - h/2)
                        esp.Line.Visible = State.ESPLine or State.ESPCustom

                        esp.Name.Text = player.Name
                        esp.Name.Position = Vector2.new(sp.X, sp.Y - h/2 - 20)
                        esp.Name.Visible = State.ESPName

                        local d = (hrp.Position - Camera.CFrame.Position).Magnitude
                        esp.Distance.Text = math.floor(d) .. "m"
                        esp.Distance.Position = Vector2.new(sp.X, sp.Y + h/2 + 5)
                        esp.Distance.Visible = State.ESPDistance
                    end
                else
                    for _, o in pairs(esp) do o.Visible = false end
                end
            else
                for _, o in pairs(esp) do o.Visible = false end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(removeESP)

--// START
createGUI()

StarterGui:SetCore("SendNotification", {
    Title = "FERI PROXY",
    Text = "Script loaded! Klik bolita buat buka menu.",
    Duration = 5,
})

print("[FERI PROXY] Loaded!")