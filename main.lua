-- [[ DAVIX-HUB: INTERFACE VISUAL ULTRA PERFORMANCE ]] --
-- [[ ESTILO PRETO E BRANCO - SPECIAL FOR MOTO G06 ]] --

if not game:IsLoaded() then game.Loaded:Wait() end

-- Evita duplicar a interface se reexecutar o script
if game.CoreGui:FindFirstChild("DavixHubUi") then
    game.CoreGui:FindFirstChild("DavixHubUi"):Destroy()
end

-- 1. CRIAÇÃO DA INTERFACE VISUAL (GUI) PRETA E BRANCA
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AntiLagButton = Instance.new("TextButton")
local Corner = Instance.new("UICorner")
local ButtonCorner = Instance.new("UICorner")

ScreenGui.Name = "DavixHubUi"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Painel Principal (Fundo Preto)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Preto escuro
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Permite arrastar o painel pela tela do celular

Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Título do Menu (Texto Branco)
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "DAVIX-HUB v1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
Title.TextSize = 18

-- Botão Ativar Anti-Lag (Estilo Clean)
AntiLagButton.Name = "AntiLagButton"
AntiLagButton.Parent = MainFrame
AntiLagButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Fundo Branco
AntiLagButton.Position = UDim2.new(0.1, 0, 0.45, 0)
AntiLagButton.Size = UDim2.new(0.8, 0, 0, 45)
AntiLagButton.Font = Enum.Font.GothamBold
AntiLagButton.Text = "ATIVAR ANTI-LAG"
AntiLagButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- Texto Preto
AntiLagButton.TextSize = 14

ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = AntiLagButton

-- 2. ENGINE HARDCORE ANTI-LAG (AÇÃO DO BOTÃO)
local lagAtivado = false

local function atomizarObjeto(obj)
    if not lagAtivado then return end
    
    -- Deleta blocos de ataques da Dough e destroços no chão
    if obj:IsA("BasePart") and (obj.Name == "Part" or obj.Name == "Effect" or obj.Name == "Smash" or obj.Name == "GroundChunk") then
        if obj.Parent and (obj.Parent.Name:find("Skill") or obj.Parent.Name:find("Attack") or obj.Parent.Name == "Workspace") then
            obj:Destroy()
            return
        end
    end

    -- Remove texturas e roupas de bonecos/frutas
    if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("Clothing") or obj:IsA("ShirtGraphic") or obj:IsA("Shirt") or obj:IsA("Pants") then
        obj:Destroy()
    
    -- Desativa fumaça, rastros de espadas e partículas de estilos de luta
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Beam") then
        obj.Enabled = false
    
    -- Transforma mapa, espadas equipadas e armas em plástico cinza liso
    elseif obj:IsA("MeshPart") or obj:IsA("SpecialMesh") then
        pcall(function() obj.MeshId = "" end) 
        pcall(function() obj.TextureID = "" end)
        pcall(function() obj.TextureId = "" end)
        obj.Material = Enum.Material.SmoothPlastic
        obj.Color = Color3.fromRGB(130, 130, 130)
        if obj:IsA("SpecialMesh") and obj.MeshType == Enum.MeshType.FileMesh then
            obj:Destroy()
        end
    elseif obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
        obj.CastShadow = false
        obj.Color = Color3.fromRGB(140, 140, 140)
    
    -- Deleta o céu pesado e atmosfera
    elseif obj:IsA("Atmosphere") or obj:IsA("Sky") or obj:IsA("Clouds") or obj:IsA("SunRaysEffect") or obj:IsA("BlurEffect") or obj:IsA("BloomEffect") then
        obj:Destroy()
    end
end

-- Ativação ao clicar no botão
AntiLagButton.MouseButton1Click:Connect(function()
    if lagAtivado then return end -- Evita clicar duas vezes
    lagAtivado = true
    
    -- Muda o visual do botão para indicar sucesso
    AntiLagButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    AntiLagButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    AntiLagButton.Text = "ANTI-LAG ATIVADO!"
    
    -- Força a Engine Gráfica ao mínimo
    local settings = settings()
    if settings and settings.Rendering then
        settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
        settings.Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.DistanceBased
    end

    -- Varre o servidor na hora
    for _, v in pairs(game:GetDescendants()) do
        atomizarObjeto(v)
    end
    
    -- Monitora em tempo real ataques e novos objetos equipados
    game.DescendantAdded:Connect(atomizarObjeto)
    
    -- Deleta o mar
    local Workspace = game:GetService("Workspace")
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0 Terrain.WaterWaveSpeed = 0 Terrain.WaterReflectance = 0 Terrain.WaterTransparency = 1
    end
    
    -- Ajusta iluminação da CPU
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
    for _, efeito in pairs(Lighting:GetChildren()) do
        if efeito:IsA("PostEffect") or efeito:IsA("BloomEffect") or efeito:IsA("BlurEffect") or efeito:IsA("ColorCorrectionEffect") or efeito:IsA("SunRaysEffect") then
            efeito:Destroy()
        end
    end
end)

print("[DAVIX-HUB]: Menu pronto. Use sua loadstring para abrir o painel!")
