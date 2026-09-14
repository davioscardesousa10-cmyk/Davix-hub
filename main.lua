-- [[ DAVIX-HUB: SCRIPT SUPREMO COMPLETO DE ANULAÇÃO VISUAL ]] --
-- [[ REQUISITO: PERFORMANCE MÁXIMA ABSOLUTA PARA MOTO G06 ]] --

if not game:IsLoaded() then game.Loaded:Wait() end

-- 1. Forçar a Engine Gráfica ao Limite Mínimo de Renderização
local settings = settings()
if settings and settings.Rendering then
    settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings.Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.DistanceBased
end

-- 2. Função Geral de Limpeza por Categoria (O Máximo que o Engine Permite)
local function zerarVisual(obj)
    -- [1] DESTRUIÇÃO DE TEXTURAS E ROUPAS (Mapa, Construções, Roupas de Bonecos, Frutas)
    if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("Clothing") or obj:IsA("ShirtGraphic") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("FaceControls") then
        obj:Destroy()
        return
    end

    -- [2] DESATIVAÇÃO DE EFEITOS (Ataques de Estilos de Luta, Armas, Espadas e Frutas)
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Beam") then
        obj.Enabled = false
        return
    end

    -- [3] TRATAMENTO DE GEOMETRIA (Espadas Equipadas, Armas, Estilos de Luta e Frutas no Chão/Mão)
    if obj:IsA("MeshPart") or obj:IsA("SpecialMesh") then
        -- Remove o formato 3D detalhado, mantendo apenas a colisão física mais simples possível
        pcall(function() obj.MeshId = "" end)
        pcall(function() obj.TextureID = "" end)
        pcall(function() obj.TextureId = "" end)
        
        -- Garante que se sobrar algo, vire plástico cinza
        obj.Material = Enum.Material.SmoothPlastic
        obj.Color = Color3.fromRGB(130, 130, 130)
        
        -- Deleta meshes externas de acessórios e itens cosméticos pesados dos bonecos
        if obj:IsA("SpecialMesh") and obj.MeshType == Enum.MeshType.FileMesh then
            obj:Destroy()
        end
        return
    end

    -- [4] PADRONIZAÇÃO DO MAPA E CONSTRUÇÕES (Paredes, Casas, Ilhas, Chão)
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
        obj.CastShadow = false
        obj.Color = Color3.fromRGB(140, 140, 140) -- Cor neutra que consome zero da GPU
    end
end

-- 3. Limpeza Inicial de Tudo que já está Carregado no Servidor
for _, v in pairs(game:GetDescendants()) do
    zerarVisual(v)
end

-- 4. Monitoramento em Tempo Real (Para quando você ou alguém equipar Espada, Arma ou usar Fruta/Estilo de Luta)
game.DescendantAdded:Connect(function(novoObjeto)
    task.skip() -- Delay de microsegundos para interceptar sem causar crash no executor
    zerarVisual(novoObjeto)
end)

-- 5. Anulação Total do Mar (Remove render e física de ondas)
local Workspace = game:GetService("Workspace")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
if Terrain then
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 1
end

-- 6. Estabilizador de Iluminação Global da CPU
local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 0

-- Remove efeitos de pós-processamento do mapa
for _, efeito in pairs(Lighting:GetChildren()) do
    if efeito:IsA("PostEffect") or efeito:IsA("BloomEffect") or efeito:IsA("BlurEffect") or efeito:IsA("ColorCorrectionEffect") or efeito:IsA("SunRaysEffect") then
        efeito:Destroy()
    end
end

print("[DAVIX-HUB SUCCESS]: Script de anulação visual injetado com sucesso. Tudo virou plástico!")
