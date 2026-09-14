-- [[ DAVIX DNYX HUB - MOTO G06 DREAM FPS BOOST EDITION ]] --

-- Evita duplicar a interface se reexecutar o script no Delta
if game.CoreGui:FindFirstChild("DavixDnyxHub") then
    game.CoreGui:FindFirstChild("DavixDnyxHub"):Destroy()
end

-- Proteção de Injeção e Inicialização Oficializada para o Delta Mobile
if not game:IsLoaded() then game.Loaded:Wait() end

-- Criando a Interface Otimizada Preto e Branco (Visual Clean)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DavixDnyxHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 1. Painel Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 420, 0, 260)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Título Oficial do Script
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(0.5, 0, 0.15, 0)
Title.Position = UDim2.new(0.04, 0, 0.02, 0)
Title.Text = "★ Davix Dnyx Project ★"
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Contador de FPS e Ping (Direto no topo do Menu)
local PerformanceLabel = Instance.new("TextLabel")
PerformanceLabel.Parent = MainFrame
PerformanceLabel.Size = UDim2.new(0.4, 0, 0.15, 0)
PerformanceLabel.Position = UDim2.new(0.56, 0, 0.02, 0)
PerformanceLabel.Text = "FPS: -- | Ping: --"
PerformanceLabel.TextSize = 11
PerformanceLabel.Font = Enum.Font.GothamSemibold
PerformanceLabel.TextColor3 = Color3.fromRGB(0, 255, 150) -- Verde performance neon
PerformanceLabel.BackgroundTransparency = 1
PerformanceLabel.TextXAlignment = Enum.TextXAlignment.Right

-- Sistema de Atualização do FPS e Ping em tempo real
task.spawn(function()
    local StartTime = tick()
    local FrameCount = 0
    while task.wait(0.5) do
        FrameCount = FrameCount + 1
        local Duration = tick() - StartTime
        if Duration >= 1 then
            local CurrentFPS = math.floor(FrameCount / Duration)
            local CurrentPing = math.floor(game:GetService("Stats").Network.ServerPing:GetValue())
            PerformanceLabel.Text = "FPS: " .. tostring(CurrentFPS) .. " | Ping: " .. tostring(CurrentPing) .. "ms"
            StartTime = tick()
            FrameCount = 0
        end
    end
end)

-- 2. Container das Abas Superiores
local TabContainer = Instance.new("Frame")
TabContainer.Parent = MainFrame
TabContainer.Position = UDim2.new(0.03, 0, 0.18, 0)
TabContainer.Size = UDim2.new(0.94, 0, 0.12, 0)
TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabContainer

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabContainer
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 6)

-- Container de Páginas
local PageContainer = Instance.new("Frame")
PageContainer.Parent = MainFrame
PageContainer.Position = UDim2.new(0.03, 0, 0.35, 0)
PageContainer.Size = UDim2.new(0.94, 0, 0.6, 0)
PageContainer.BackgroundTransparency = 1

local MainPage = Instance.new("Frame")
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.BackgroundTransparency = 1
MainPage.Visible = true
MainPage.Parent = PageContainer

local OptimizationPage = Instance.new("Frame")
OptimizationPage.Size = UDim2.new(1, 0, 1, 0)
OptimizationPage.BackgroundTransparency = 1
OptimizationPage.Visible = false
OptimizationPage.Parent = PageContainer

-- Alternar abas
local function CreateTab(name, page)
    local Btn = Instance.new("TextButton")
    Btn.Parent = TabContainer
    Btn.Size = UDim2.new(0, 110, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = name
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 12
    Btn.TextColor3 = Color3.fromRGB(160, 160, 160)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(PageContainer:GetChildren()) do p.Visible = false end
        for _, b in pairs(TabContainer:GetChildren()) do
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(160, 160, 160) end
        end
        page.Visible = true
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return Btn
end

local MainTabBtn = CreateTab("🏠 Main", MainPage)
local OptiTabBtn = CreateTab("🚀 Optimization", OptimizationPage)
MainTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- 3. Painel da Esquerda (Main Page)
local InfoBox = Instance.new("Frame")
InfoBox.Parent = MainPage
InfoBox.Size = UDim2.new(0.48, 0, 0.95, 0)
InfoBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = InfoBox

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Parent = InfoBox
InfoTitle.Size = UDim2.new(1, 0, 0.25, 0)
InfoTitle.Text = "Script Info"
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoTitle.BackgroundTransparency = 1

local FreeBtn = Instance.new("TextButton")
FreeBtn.Parent = InfoBox
FreeBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
FreeBtn.Size = UDim2.new(0.8, 0, 0.35, 0)
FreeBtn.Text = "Get Free Version"
FreeBtn.Font = Enum.Font.GothamBold
FreeBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
FreeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local FreeCorner = Instance.new("UICorner")
FreeCorner.CornerRadius = UDim.new(0, 4)
FreeCorner.Parent = FreeBtn

-- 4. Painel da Direita / Caixa de Anti-Lag na aba Optimization
local LagBox = Instance.new("Frame")
LagBox.Parent = OptimizationPage
LagBox.Size = UDim2.new(0.96, 0, 0.95, 0)
LagBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local LagCorner = Instance.new("UICorner")
LagCorner.CornerRadius = UDim.new(0, 6)
LagCorner.Parent = LagBox

local LagTitle = Instance.new("TextLabel")
LagTitle.Parent = LagBox
LagTitle.Size = UDim2.new(1, 0, 0.25, 0)
LagTitle.Text = "Moto G06 Dream Performance"
LagTitle.Font = Enum.Font.GothamBold
LagTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LagTitle.BackgroundTransparency = 1

local LagBtn = Instance.new("TextButton")
LagBtn.Parent = LagBox
LagBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
LagBtn.Size = UDim2.new(0.8, 0, 0.35, 0)
LagBtn.Text = "Dream Anti-Lag: OFF"
LagBtn.Font = Enum.Font.GothamBold
LagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LagBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local LagBtnCorner = Instance.new("UICorner")
LagBtnCorner.CornerRadius = UDim.new(0, 4)
LagBtnCorner.Parent = LagBtn

-- Lógicas principais e Toggles
_G.HasLicense = false
_G.DreamAntiLag = false

-- Ativar Versão Grátis
FreeBtn.MouseButton1Click:Connect(function()
    if not _G.HasLicense then
        _G.HasLicense = true
        FreeBtn.Text = "Activated! ✔"
        FreeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        FreeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- MOTOR SUPREMO ANTI-LAG PARA ESTABILIZAR EM 60 FPS
LagBtn.MouseButton1Click:Connect(function()
    if not _G.HasLicense then
        LagBtn.Text = "Get License First!"
        task.wait(1)
        LagBtn.Text = "Dream Anti-Lag: OFF"
        return
    end

    _G.DreamAntiLag = not _G.DreamAntiLag
    if _G.DreamAntiLag then
        LagBtn.Text = "Dream Anti-Lag: ON"
        LagBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LagBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
        
        task.spawn(function()
            while _G.DreamAntiLag do
                pcall(function()
                    -- Força o Roblox a usar o nível mínimo absoluto de renderização
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                    
                    -- Desliga sombras globais, névoa pesada e reflexos 3D
                    local Lighting = game:GetService("Lighting")
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 9e9
                    Lighting.Brightness = 2 -- Mantém o jogo claro mesmo sem sombras
                    
                    -- Varredura agressiva de limpeza de mapa
                    for _, v in pairs(game:GetDescendants()) do
                        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") or v:IsA("WedgePart") then
                            v.Material = Enum.Material.SmoothPlastic
                            v.Reflectance = 0
                            v.CastShadow = false
                        elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("Beam") then
                            v:Destroy()
                        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                            v.Enabled = false
                        elseif v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") then
                            v.Enabled = false
                        end
                    end
                end)
                task.wait(4) -- Varre e limpa o mapa do Blox Fruits a cada 4 segundos
            end
        end)
    else
        LagBtn.Text = "Dream Anti-Lag: OFF"
        LagBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        LagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

