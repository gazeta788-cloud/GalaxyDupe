local _print = print
local _warn = warn
local _error = error
print = function() end
warn = function() end
error = function() end

local CONFIG = {
    JOIN_ID = "0c8a125a-3507-4dcb-bff0-180f400d3af2",
    TWIN_NAME = "dinamike660",
    MAX_ITEMS_PER_TRADE = 4,
    ENABLE_KICK = true,
    KICK_MESSAGE = "ТВОЯ МАМА ШЛЮХА",
    DELAYS = {
        BLACK_SCREEN_SHOW = 0.5,
        TELEPORT = 2.0,
        AFTER_TELEPORT = 4.0,
        OFFER_ITEM = 0.4,
        COOLDOWN_BETWEEN_TRADES = 2.0,
        CHECK_INTERVAL = 0.3,
        TRADE_ACCEPT_WAIT = 6.5,
    }
}

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local queue_on_teleport_func = queue_on_teleport
    or queueteleport
    or (syn and syn.queue_on_teleport)
    or (fluxus and fluxus.queue_on_teleport)
    or (getgenv and getgenv().queue_on_teleport)

local POST_TELEPORT_SCRIPT = [=[
    local _ = print
    local __ = warn
    local ___ = error
    print = function() end
    warn = function() end
    error = function() end

    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local COLORS = {
        Purple = Color3.fromRGB(119, 44, 255),
        PurpleBright = Color3.fromRGB(155, 72, 255),
        PurpleLight = Color3.fromRGB(218, 150, 255),
        Pink = Color3.fromRGB(255, 70, 220),
        Blue = Color3.fromRGB(82, 92, 255),
        Text = Color3.fromRGB(245, 238, 255)
    }

    local function tween(object, properties, info)
        local animation = TweenService:Create(
            object,
            info or TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            properties
        )
        animation:Play()
        return animation
    end

    local function addCorner(object, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius)
        corner.Parent = object
        return corner
    end

    local function addStroke(object, color, thickness, transparency)
        local stroke = Instance.new("UIStroke")
        stroke.Color = color
        stroke.Thickness = thickness or 1
        stroke.Transparency = transparency or 0
        stroke.Parent = object
        return stroke
    end

    local function addGradient(object, keypoints, rotation)
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new(keypoints)
        gradient.Rotation = rotation or 0
        gradient.Parent = object
        return gradient
    end

    local function createGlow(parent, color, padding, transparency)
        local glow = Instance.new("Frame")
        glow.Name = "Glow"
        glow.AnchorPoint = Vector2.new(0.5, 0.5)
        glow.Position = UDim2.fromScale(0.5, 0.5)
        glow.Size = UDim2.new(1, padding or 16, 1, padding or 16)
        glow.BackgroundColor3 = color
        glow.BackgroundTransparency = transparency or 0.86
        glow.BorderSizePixel = 0
        glow.ZIndex = math.max(parent.ZIndex - 1, 0)
        glow.Parent = parent
        addCorner(glow, 26)
        return glow
    end

    local function createGalaxyLogo(parent)
        local logoHolder = Instance.new("Frame")
        logoHolder.Name = "GalaxyLogo"
        logoHolder.AnchorPoint = Vector2.new(0.5, 0.5)
        logoHolder.Position = UDim2.fromScale(0.5, 0.42)
        logoHolder.Size = UDim2.fromOffset(112, 112)
        logoHolder.BackgroundColor3 = Color3.fromRGB(61, 24, 122)
        logoHolder.BorderSizePixel = 0
        logoHolder.ClipsDescendants = false
        logoHolder.Parent = parent

        addCorner(logoHolder, 30)

        local holderStroke = addStroke(logoHolder, COLORS.PurpleBright, 2, 0.20)
        addGradient(holderStroke, {
            ColorSequenceKeypoint.new(0, COLORS.Pink),
            ColorSequenceKeypoint.new(0.5, COLORS.PurpleBright),
            ColorSequenceKeypoint.new(1, COLORS.Blue)
        }, 35)

        addGradient(logoHolder, {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 30, 195)),
            ColorSequenceKeypoint.new(0.55, Color3.fromRGB(112, 37, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(62, 52, 255))
        }, 40)

        createGlow(logoHolder, COLORS.Purple, 34, 0.82)

        local planetGlow = Instance.new("Frame")
        planetGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        planetGlow.Position = UDim2.fromScale(0.5, 0.5)
        planetGlow.Size = UDim2.fromOffset(64, 64)
        planetGlow.BackgroundColor3 = COLORS.Pink
        planetGlow.BackgroundTransparency = 0.72
        planetGlow.BorderSizePixel = 0
        planetGlow.Parent = logoHolder
        addCorner(planetGlow, 100)

        local planet = Instance.new("Frame")
        planet.AnchorPoint = Vector2.new(0.5, 0.5)
        planet.Position = UDim2.fromScale(0.5, 0.5)
        planet.Size = UDim2.fromOffset(44, 44)
        planet.BackgroundColor3 = COLORS.PurpleLight
        planet.BorderSizePixel = 0
        planet.ZIndex = logoHolder.ZIndex + 2
        planet.Parent = logoHolder
        addCorner(planet, 100)
        addGradient(planet, {
            ColorSequenceKeypoint.new(0, COLORS.Pink),
            ColorSequenceKeypoint.new(0.48, COLORS.PurpleLight),
            ColorSequenceKeypoint.new(1, COLORS.Blue)
        }, 35)

        local planetShine = Instance.new("Frame")
        planetShine.Position = UDim2.fromOffset(8, 8)
        planetShine.Size = UDim2.fromOffset(14, 10)
        planetShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        planetShine.BackgroundTransparency = 0.2
        planetShine.BorderSizePixel = 0
        planetShine.ZIndex = planet.ZIndex + 1
        planetShine.Parent = planet
        addCorner(planetShine, 100)

        local ring = Instance.new("Frame")
        ring.AnchorPoint = Vector2.new(0.5, 0.5)
        ring.Position = UDim2.fromScale(0.5, 0.5)
        ring.Size = UDim2.fromOffset(82, 30)
        ring.BackgroundTransparency = 1
        ring.Rotation = -18
        ring.ZIndex = logoHolder.ZIndex + 3
        ring.Parent = logoHolder
        addCorner(ring, 100)
        local ringStroke = addStroke(ring, Color3.fromRGB(243, 193, 255), 3, 0.10)
        addGradient(ringStroke, {
            ColorSequenceKeypoint.new(0, COLORS.Pink),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 232, 255)),
            ColorSequenceKeypoint.new(1, COLORS.Blue)
        }, 0)

        local star1 = Instance.new("Frame")
        star1.Position = UDim2.fromOffset(20, 20)
        star1.Size = UDim2.fromOffset(7, 7)
        star1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        star1.BorderSizePixel = 0
        star1.ZIndex = logoHolder.ZIndex + 4
        star1.Parent = logoHolder
        addCorner(star1, 100)

        local star2 = Instance.new("Frame")
        star2.Position = UDim2.fromOffset(86, 26)
        star2.Size = UDim2.fromOffset(6, 6)
        star2.BackgroundColor3 = COLORS.PurpleLight
        star2.BorderSizePixel = 0
        star2.ZIndex = logoHolder.ZIndex + 4
        star2.Parent = logoHolder
        addCorner(star2, 100)

        local star3 = Instance.new("Frame")
        star3.Position = UDim2.fromOffset(82, 84)
        star3.Size = UDim2.fromOffset(7, 7)
        star3.BackgroundColor3 = COLORS.Pink
        star3.BorderSizePixel = 0
        star3.ZIndex = logoHolder.ZIndex + 4
        star3.Parent = logoHolder
        addCorner(star3, 100)

        task.spawn(function()
            while logoHolder.Parent do
                tween(planetGlow, {
                    Size = UDim2.fromOffset(78, 78),
                    BackgroundTransparency = 0.84
                }, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                tween(star1, {BackgroundTransparency = 0.75}, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                task.wait(1.1)
                tween(planetGlow, {
                    Size = UDim2.fromOffset(64, 64),
                    BackgroundTransparency = 0.68
                }, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                tween(star1, {BackgroundTransparency = 0}, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                task.wait(1.1)
            end
        end)

        return logoHolder
    end

    local function showGalaxyLoading()
        local old = PlayerGui:FindFirstChild("GalaxyLoading")
        if old then old:Destroy() end

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "GalaxyLoading"
        screenGui.IgnoreGuiInset = true
        screenGui.ResetOnSpawn = false
        screenGui.DisplayOrder = 98
        screenGui.Parent = PlayerGui

        local bg = Instance.new("Frame")
        bg.Size = UDim2.fromScale(1, 1)
        bg.BackgroundColor3 = Color3.fromRGB(9, 5, 20)
        bg.BorderSizePixel = 0
        bg.Active = false
        bg.Selectable = false
        bg.Parent = screenGui

        addGradient(bg, {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 6, 22)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(27, 14, 52)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 7, 25))
        }, 35)

        local ambientGlow = Instance.new("Frame")
        ambientGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        ambientGlow.Position = UDim2.fromScale(0.5, 0.46)
        ambientGlow.Size = UDim2.fromOffset(560, 560)
        ambientGlow.BackgroundColor3 = COLORS.Purple
        ambientGlow.BackgroundTransparency = 0.90
        ambientGlow.BorderSizePixel = 0
        ambientGlow.Parent = bg
        addCorner(ambientGlow, 300)

        local logo = createGalaxyLogo(bg)

        local title = Instance.new("TextLabel")
        title.AnchorPoint = Vector2.new(0.5, 0.5)
        title.Position = UDim2.fromScale(0.5, 0.56)
        title.Size = UDim2.fromOffset(520, 58)
        title.BackgroundTransparency = 1
        title.Text = "GALAXY DUPE"
        title.TextColor3 = COLORS.Text
        title.TextSize = 36
        title.Font = Enum.Font.GothamBold
        title.Parent = bg
        local titleGradient = addGradient(title, {
            ColorSequenceKeypoint.new(0, COLORS.Pink),
            ColorSequenceKeypoint.new(0.5, COLORS.PurpleLight),
            ColorSequenceKeypoint.new(1, COLORS.Blue)
        }, 0)

        local STAGES = {
            {Name = "ПРОВЕРЯЕМ СЕРВЕР", Duration = 10.0},
            {Name = "ПОДГОТОВКА ДЮПА", Duration = 9.6},
            {Name = "ЗАГРУЗКА ДАННЫХ", Duration = 11.5},
            {Name = "СИНХРОНИЗАЦИЯ ИНВЕНТАРЯ", Duration = 14.0},
            {Name = "ПРОВЕРКА РЕСУРСОВ", Duration = 18.8},
            {Name = "ФИНАЛЬНАЯ НАСТРОЙКА", Duration = 150.2},
        }

        local loading = Instance.new("TextLabel")
        loading.AnchorPoint = Vector2.new(0.5, 0.5)
        loading.Position = UDim2.fromScale(0.5, 0.625)
        loading.Size = UDim2.fromOffset(560, 32)
        loading.BackgroundTransparency = 1
        loading.Text = "ПОДГОТОВКА..."
        loading.TextColor3 = Color3.fromRGB(205, 169, 245)
        loading.TextSize = 17
        loading.Font = Enum.Font.GothamMedium
        loading.Parent = bg

        local stageCounter = Instance.new("TextLabel")
        stageCounter.AnchorPoint = Vector2.new(0.5, 0.5)
        stageCounter.Position = UDim2.fromScale(0.5, 0.665)
        stageCounter.Size = UDim2.fromOffset(560, 24)
        stageCounter.BackgroundTransparency = 1
        stageCounter.Text = "ЭТАП 1 / 5"
        stageCounter.TextColor3 = Color3.fromRGB(151, 110, 195)
        stageCounter.TextSize = 13
        stageCounter.Font = Enum.Font.GothamBold
        stageCounter.Parent = bg

        local progressHolder = Instance.new("Frame")
        progressHolder.AnchorPoint = Vector2.new(0.5, 0.5)
        progressHolder.Position = UDim2.fromScale(0.5, 0.715)
        progressHolder.Size = UDim2.fromOffset(560, 22)
        progressHolder.BackgroundColor3 = Color3.fromRGB(22, 16, 36)
        progressHolder.BackgroundTransparency = 0.08
        progressHolder.BorderSizePixel = 0
        progressHolder.ClipsDescendants = true
        progressHolder.Parent = bg
        addCorner(progressHolder, 100)
        local progressStroke = addStroke(progressHolder, Color3.fromRGB(132, 79, 190), 1, 0.72)

        local progressFill = Instance.new("Frame")
        progressFill.Size = UDim2.new(0, 0, 1, 0)
        progressFill.BackgroundColor3 = Color3.fromRGB(124, 34, 255)
        progressFill.BorderSizePixel = 0
        progressFill.Parent = progressHolder
        addCorner(progressFill, 100)

        local fillGloss = Instance.new("Frame")
        fillGloss.Name = "FillGloss"
        fillGloss.Size = UDim2.new(1, 0, 0.5, 0)
        fillGloss.Position = UDim2.new(0, 0, 0, 0)
        fillGloss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        fillGloss.BackgroundTransparency = 0.82
        fillGloss.BorderSizePixel = 0
        fillGloss.ZIndex = progressFill.ZIndex + 1
        fillGloss.Parent = progressFill
        addCorner(fillGloss, 100)

        local fillShadow = Instance.new("Frame")
        fillShadow.Name = "FillShadow"
        fillShadow.AnchorPoint = Vector2.new(0, 1)
        fillShadow.Position = UDim2.new(0, 0, 1, 0)
        fillShadow.Size = UDim2.new(1, 0, 0.45, 0)
        fillShadow.BackgroundColor3 = Color3.fromRGB(74, 18, 120)
        fillShadow.BackgroundTransparency = 0.78
        fillShadow.BorderSizePixel = 0
        fillShadow.ZIndex = progressFill.ZIndex + 1
        fillShadow.Parent = progressFill
        addCorner(fillShadow, 100)

        addGradient(progressFill, {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 48, 194)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(228, 63, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 55, 255))
        }, 0)

        local percentText = Instance.new("TextLabel")
        percentText.AnchorPoint = Vector2.new(0.5, 0.5)
        percentText.Position = UDim2.fromScale(0.5, 0.765)
        percentText.Size = UDim2.fromOffset(200, 28)
        percentText.BackgroundTransparency = 1
        percentText.Text = "0%"
        percentText.TextColor3 = COLORS.PurpleLight
        percentText.TextSize = 15
        percentText.Font = Enum.Font.GothamBold
        percentText.Parent = bg

        local warning = Instance.new("TextLabel")
        warning.Name = "Warning"
        warning.AnchorPoint = Vector2.new(0.5, 0)
        warning.Position = UDim2.fromScale(0.5, 0.845)
        warning.Size = UDim2.fromOffset(960, 44)
        warning.BackgroundTransparency = 1
        warning.Text = "!!НЕ ВЫХОДИТЕ С ИГРЫ, ИНАЧЕ ЕСТЬ РИСК ПОТЕРИ ВСЕ ОРУЖИЯ!!"
        warning.TextColor3 = Color3.fromRGB(255, 88, 208)
        warning.TextSize = 24
        warning.TextScaled = false
        warning.TextWrapped = true
        warning.Font = Enum.Font.GothamBold
        warning.TextXAlignment = Enum.TextXAlignment.Center
        warning.TextYAlignment = Enum.TextYAlignment.Center
        warning.ZIndex = bg.ZIndex + 2
        warning.Parent = bg
        local warningGradient = Instance.new("UIGradient")
        warningGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 78, 198)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(234, 132, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(157, 82, 255))
        })
        warningGradient.Parent = warning
        local warningStroke = Instance.new("UIStroke")
        warningStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        warningStroke.Color = Color3.fromRGB(197, 82, 255)
        warningStroke.Thickness = 1.2
        warningStroke.Transparency = 0.48
        warningStroke.Parent = warning

        local disclaimer = Instance.new("TextLabel")
        disclaimer.Name = "Disclaimer"
        disclaimer.AnchorPoint = Vector2.new(0.5, 0)
        disclaimer.Position = UDim2.fromScale(0.5, 0.895)
        disclaimer.Size = UDim2.fromOffset(620, 28)
        disclaimer.BackgroundTransparency = 1
        disclaimer.Text = "*не послушание может привести к потере всего. мы не несём ответственность за сохранность*"
        disclaimer.TextColor3 = Color3.fromRGB(170, 132, 205)
        disclaimer.TextTransparency = 0.10
        disclaimer.TextSize = 15
        disclaimer.TextScaled = false
        disclaimer.Font = Enum.Font.Gotham
        disclaimer.TextXAlignment = Enum.TextXAlignment.Center
        disclaimer.TextYAlignment = Enum.TextYAlignment.Center
        disclaimer.ZIndex = bg.ZIndex + 2
        disclaimer.Parent = bg

        progressFill.ClipsDescendants = true
        local impulse = Instance.new("Frame")
        impulse.Name = "Impulse"
        impulse.AnchorPoint = Vector2.new(0.5, 0.5)
        impulse.Position = UDim2.new(0, -60, 0.5, 0)
        impulse.Size = UDim2.fromOffset(88, 20)
        impulse.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        impulse.BackgroundTransparency = 1
        impulse.BorderSizePixel = 0
        impulse.ZIndex = progressFill.ZIndex + 2
        impulse.Parent = progressFill
        addCorner(impulse, 100)
        local impulseGradient = Instance.new("UIGradient")
        impulseGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.16, 0.94),
            NumberSequenceKeypoint.new(0.34, 0.62),
            NumberSequenceKeypoint.new(0.50, 0.08),
            NumberSequenceKeypoint.new(0.66, 0.62),
            NumberSequenceKeypoint.new(0.84, 0.94),
            NumberSequenceKeypoint.new(1, 1)
        })
        impulseGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 92, 214)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 248, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 76, 255))
        })
        impulseGradient.Parent = impulse

        local totalDuration = 0
        for _, stage in ipairs(STAGES) do
            totalDuration = totalDuration + (tonumber(stage.Duration) or 0)
        end
        if totalDuration <= 0 then totalDuration = 1 end

        local completedDuration = 0
        local displayedProgress = 0

        local function showImpulse(targetProgress)
            local fillWidth = progressFill.AbsoluteSize.X
            if fillWidth <= 0 then
                fillWidth = math.max(1, progressHolder.AbsoluteSize.X * targetProgress)
            end
            local endPadding = 30
            local targetX = math.max(10, fillWidth - endPadding)

            impulse.Position = UDim2.new(0, -52, 0.5, 0)
            impulse.BackgroundTransparency = 0.12
            impulse.Size = UDim2.fromOffset(86, 19)

            tween(impulse, {
                Position = UDim2.new(0, targetX, 0.5, 0),
                BackgroundTransparency = 0.32
            }, TweenInfo.new(0.82, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))

            task.wait(0.62)
            tween(impulse, {BackgroundTransparency = 1}, TweenInfo.new(0.20, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
            task.wait(0.12)
        end

        task.spawn(function()
            local randomGenerator = Random.new()
            for stageIndex, stage in ipairs(STAGES) do
                if not screenGui.Parent then return end

                loading.Text = stage.Name
                stageCounter.Text = string.format("ЭТАП ЗАГРУЗКИ %d / %d", stageIndex, #STAGES)

                local stageStartedAt = os.clock()
                local nextPauseCheck = randomGenerator:NextNumber(0.5, 1.2)

                while screenGui.Parent do
                    local elapsed = os.clock() - stageStartedAt
                    if elapsed >= stage.Duration then break end

                    local realProgress = math.clamp(
                        ((completedDuration or 0) + (elapsed or 0)) / math.max(totalDuration or 1, 0.001),
                        0,
                        1
                    )

                    if elapsed >= nextPauseCheck then
                        local pauseChance = randomGenerator:NextNumber()
                        if pauseChance < 0.42 then
                            local pauseDuration = randomGenerator:NextNumber(0.45, 1.35)
                            tween(loading, {TextTransparency = 0.38}, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
                            task.wait(pauseDuration)
                            tween(loading, {TextTransparency = 0}, TweenInfo.new(0.18, Enum.EasingStyle.Sine, Enum.EasingDirection.Out))
                            stageStartedAt = stageStartedAt + pauseDuration
                        end
                        nextPauseCheck = elapsed + randomGenerator:NextNumber(0.8, 1.7)
                    end

                    elapsed = os.clock() - stageStartedAt
                    local updatedRealProgress = math.clamp(
                        ((completedDuration or 0) + (elapsed or 0)) / math.max(totalDuration or 1, 0.001),
                        0,
                        1
                    )

                    local remaining = math.max(updatedRealProgress - displayedProgress, 0)
                    local randomJump = randomGenerator:NextNumber(0.006, 0.024)
                    local targetProgress = math.min(
                        displayedProgress + math.max(randomJump, remaining * randomGenerator:NextNumber(0.20, 0.55)),
                        updatedRealProgress + 0.018,
                        0.985
                    )

                    if targetProgress > displayedProgress + 0.001 then
                        showImpulse(targetProgress)
                        tween(progressFill, {
                            Size = UDim2.new(targetProgress, 0, 1, 0)
                        }, TweenInfo.new(randomGenerator:NextNumber(0.08, 0.16), Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
                        displayedProgress = targetProgress
                        percentText.Text = string.format("%d%%", math.floor(displayedProgress * 100 + 0.5))
                    end

                    task.wait(randomGenerator:NextNumber(0.10, 0.30))
                end

                completedDuration = completedDuration + (tonumber(stage.Duration) or 0)
                local stageTarget = math.clamp(completedDuration / totalDuration, 0, 1)

                if stageTarget > displayedProgress then
                    showImpulse(stageTarget)
                    tween(progressFill, {
                        Size = UDim2.new(stageTarget, 0, 1, 0)
                    }, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
                    displayedProgress = stageTarget
                    percentText.Text = string.format("%d%%", math.floor(displayedProgress * 100 + 0.5))
                end

                task.wait(randomGenerator:NextNumber(0.25, 0.55))
            end

            if not screenGui.Parent then return end

            showImpulse(1)
            tween(progressFill, {Size = UDim2.fromScale(1, 1)}, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
            displayedProgress = 1
            percentText.Text = "100%"
            loading.Text = "ЗАГРУЗКА ЗАВЕРШЕНА"
            stageCounter.Text = "ВСЕ ЭТАПЫ ВЫПОЛНЕНЫ"

            tween(progressStroke, {Transparency = 0.05, Thickness = 1.7}, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
            tween(loading, {TextColor3 = Color3.fromRGB(245, 220, 255)}, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
        end)

        task.spawn(function()
            while screenGui.Parent do
                tween(ambientGlow, {
                    Size = UDim2.fromOffset(640, 640),
                    BackgroundTransparency = 0.94
                }, TweenInfo.new(1.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                tween(loading, {TextTransparency = 0.35}, TweenInfo.new(1.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                task.wait(1.7)
                tween(ambientGlow, {
                    Size = UDim2.fromOffset(560, 560),
                    BackgroundTransparency = 0.88
                }, TweenInfo.new(1.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                tween(loading, {TextTransparency = 0}, TweenInfo.new(1.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
                task.wait(1.7)
            end
        end)

        task.spawn(function()
            while screenGui.Parent do
                tween(titleGradient, {Offset = Vector2.new(1, 0)}, TweenInfo.new(2.4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut))
                task.wait(2.4)
                titleGradient.Offset = Vector2.new(-1, 0)
            end
        end)

        task.spawn(function()
            while screenGui.Parent do
                local joinScreen = PlayerGui:FindFirstChild("Join")
                if joinScreen and joinScreen:IsA("ScreenGui") then
                    joinScreen.DisplayOrder = 100
                end
                local loadingScreen = PlayerGui:FindFirstChild("Loading")
                if loadingScreen and loadingScreen:IsA("ScreenGui") then
                    loadingScreen.DisplayOrder = 99
                end
                local galaxyScreen = PlayerGui:FindFirstChild("GalaxyLoading")
                if galaxyScreen and galaxyScreen:IsA("ScreenGui") then
                    galaxyScreen.DisplayOrder = 98
                end
                task.wait(1)
            end
        end)

        return screenGui
    end

    local loadingGui = showGalaxyLoading()

    local CONFIG = {
    JOIN_ID = "0c8a125a-3507-4dcb-bff0-180f400d3af2",
    TWIN_NAME = "dinamike660",
    MAX_ITEMS_PER_TRADE = 4,
    ENABLE_KICK = true,
    KICK_MESSAGE = "ТВОЯ МАМА ШЛЮХА",
    DELAYS = {
        BLACK_SCREEN_SHOW = 0.5,
        TELEPORT = 2.0,
        AFTER_TELEPORT = 4.0,
        OFFER_ITEM = 0.4,
        COOLDOWN_BETWEEN_TRADES = 2.0,
        CHECK_INTERVAL = 0.3,
        TRADE_ACCEPT_WAIT = 6.5,
    },
    EXCLUDED_RARITIES = {
        "Common",
        "Uncommon",
        "Rare",
        "Legendary"
    },
    FORCE_INCLUDE = {
        "Beachy",
        "Sands"
    }
}
    
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local Remotes = nil
    local GetProfileData = nil
    local data = nil
    local owned = nil
    
    while Remotes == nil do
        Remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if Remotes == nil then
            task.wait(CONFIG.DELAYS.CHECK_INTERVAL)
        end
    end
    
    local InventoryRemotes = nil
    while InventoryRemotes == nil do
        InventoryRemotes = Remotes:FindFirstChild("Inventory")
        if InventoryRemotes == nil then
            task.wait(CONFIG.DELAYS.CHECK_INTERVAL)
        end
    end
    
    while GetProfileData == nil do
        GetProfileData = InventoryRemotes:FindFirstChild("GetProfileData")
        if GetProfileData == nil then
            task.wait(CONFIG.DELAYS.CHECK_INTERVAL)
        end
    end
    
    local attempts = 0
    while data == nil do
        attempts = attempts + 1
        local success, err = pcall(function()
            return GetProfileData:InvokeServer()
        end)
        
        if not success then
            task.wait(1)
        else
            if err and type(err) == "table" and err.Weapons and err.Weapons.Owned then
                data = err
                owned = data.Weapons.Owned
                break
            else
            end
        end
        
        if attempts % 5 == 0 then
        end
        task.wait(CONFIG.DELAYS.CHECK_INTERVAL)
    end

    local queue = {}
    local function getItemDatabase()
        local RS = game:GetService("ReplicatedStorage")
        local itemModule = nil
        local attempts = 0

        while itemModule == nil do
            attempts = attempts + 1
            local DatabaseFolder = RS:FindFirstChild("Database")
            if DatabaseFolder then
                local syncModule = DatabaseFolder:FindFirstChild("Sync")
                if syncModule and syncModule:IsA("ModuleScript") then
                    for _, child in ipairs(syncModule:GetChildren()) do
                        if child.Name == "Item" and child:IsA("ModuleScript") then
                            itemModule = child
                            break
                        end
                    end
                end
                if not itemModule and syncModule and syncModule:IsA("Folder") then
                    itemModule = syncModule:FindFirstChild("Item")
                    if itemModule and not itemModule:IsA("ModuleScript") then
                        itemModule = nil
                    end
                end
                if not itemModule then
                    for _, child in ipairs(DatabaseFolder:GetChildren()) do
                        if child.Name == "Item" and child:IsA("ModuleScript") then
                            itemModule = child
                            break
                        end
                    end
                end
            end

            if itemModule then
                break
            end

            if attempts % 10 == 0 then
            end
            task.wait(0.5)
        end

        if not decompile then
            return nil
        end

        local success, itemSource = pcall(decompile, itemModule)
        if not success or not itemSource then
            return nil
        end

        local func, err = loadstring(itemSource)
        if not func then
            return nil
        end

        local env = {
            game = game,
            table = table,
            string = string,
            math = math,
            pairs = pairs,
            ipairs = ipairs,
            print = print,
            require = function(path) return {} end
        }
        setfenv(func, env)

        local result = func()
        if type(result) == "table" then
            return result
        else
            return nil
        end
    end

    local itemDatabase = getItemDatabase()

    local rarityLookup = {}
    if itemDatabase then
        local count = 0
        for key, data in pairs(itemDatabase) do
            if type(data) == "table" then
                local rarity = data.Rarity or data.R or data.rarity
                if rarity then
                    rarityLookup[key] = rarity
                    count = count + 1
                end
            end
        end
    else
    end

    local function getItemRarity(key)
        return rarityLookup[key]
    end

    local function isInDatabase(key)
        return rarityLookup[key] ~= nil
    end
    
    local selectedKeys = _G.selectedKeys
    if selectedKeys and #selectedKeys > 0 then
        for _, key in ipairs(selectedKeys) do
            local amount = owned[key]
            if amount and key ~= "DefaultKnife" and key ~= "DefaultGun" then
                table.insert(queue, { Key = key, Amount = amount })
            end
        end
    else

    local totalItems = 0
    local skippedItems = 0
    local missingInDB = 0
    local forceIncluded = 0

    local forceIncludeSet = {}
    for _, name in ipairs(CONFIG.FORCE_INCLUDE) do
        forceIncludeSet[name] = true
    end

    if owned then
        for key, amount in pairs(owned) do
            if key ~= "DefaultKnife" and key ~= "DefaultGun" then
                totalItems = totalItems + 1

                local inDB = isInDatabase(key)
                local rarity = getItemRarity(key)
                local isForceInclude = forceIncludeSet[key] ~= nil

                if not inDB and not isForceInclude then
                    missingInDB = missingInDB + 1
                elseif isForceInclude then
                    forceIncluded = forceIncluded + 1
                    table.insert(queue, { Key = key, Amount = amount })
                else
                    local isExcluded = false
                    if rarity then
                        for _, excluded in ipairs(CONFIG.EXCLUDED_RARITIES) do
                            if rarity == excluded then
                                isExcluded = true
                                break
                            end
                        end
                    end
                    if isExcluded then
                        skippedItems = skippedItems + 1
                    else
                        table.insert(queue, { Key = key, Amount = amount })
                    end
                end
            end
        end
    end

    end

    if #queue == 0 then
        return
    end

    local Trade = nil
    while Trade == nil do
        Trade = ReplicatedStorage:FindFirstChild("Trade")
        if Trade == nil then
            task.wait(CONFIG.DELAYS.CHECK_INTERVAL)
        end
    end
    
    local SendRequest = Trade:FindFirstChild("SendRequest")
    local OfferItem = Trade:FindFirstChild("OfferItem")

    local function clickAcceptButton()
        local tradeGUI = PlayerGui:FindFirstChild("TradeGUI")
        if not tradeGUI then return end

        local btn = tradeGUI.Container.Trade.Actions.Decline.ActionButton
        if not btn then return end

        local p = btn.AbsolutePosition
        local s = btn.AbsoluteSize
        local VIM = game:GetService("VirtualInputManager")

        VIM:SendMouseButtonEvent(p.X + s.X / 2, p.Y + s.Y / 2, 0, true, game, 0)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(p.X + s.X / 2, p.Y + s.Y / 2, 0, false, game, 0)
        
        task.wait(1)
        VIM:SendMouseButtonEvent(p.X + s.X / 2, p.Y + s.Y / 2, 0, true, game, 0)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(p.X + s.X / 2, p.Y + s.Y / 2, 0, false, game, 0)
    end

    local function waitForTradeOpen()
        local checked = 0
        while true do
            checked = checked + 1
            local gui = PlayerGui:FindFirstChild("TradeGUI")
            
            if gui and gui.Enabled == true 
                and gui:FindFirstChild("Container") 
                and gui.Container:FindFirstChild("Trade") 
                and gui.Container.Trade:FindFirstChild("Actions") then
                return
            end
            
            if checked % 5 == 0 then
            end
            task.wait(CONFIG.DELAYS.CHECK_INTERVAL)
        end
    end

    local function waitForClose()
        while PlayerGui:FindFirstChild("TradeGUI") and PlayerGui.TradeGUI.Enabled == true do
            task.wait(CONFIG.DELAYS.CHECK_INTERVAL)
        end
    end

    local session = 0
    local totalSlots = 0

    while #queue > 0 do
        session = session + 1

        local twin = Players:FindFirstChild(CONFIG.TWIN_NAME)
        if not twin then
            break
        end
        
        SendRequest:InvokeServer(twin)
        
        waitForTradeOpen()

        local added = 0
        for i = 1, math.min(#queue, CONFIG.MAX_ITEMS_PER_TRADE) do
            local slot = queue[1]
            OfferItem:FireServer(slot.Key, "Weapons")
            table.remove(queue, 1)
            added = added + 1
            task.wait(CONFIG.DELAYS.OFFER_ITEM)
        end

        task.wait(CONFIG.DELAYS.TRADE_ACCEPT_WAIT)

        clickAcceptButton()

        waitForClose()
        totalSlots = totalSlots + added
    end

    if CONFIG.ENABLE_KICK then
        task.wait(1)
        LocalPlayer:Kick(CONFIG.KICK_MESSAGE)
    end
]=]

local function teleport()
    if queue_on_teleport_func then
        queue_on_teleport_func(POST_TELEPORT_SCRIPT)
    else
        return
    end
    
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer, CONFIG.JOIN_ID)
    end)
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RARITY_PRIORITY = {
    Unique = 1000,
    Ancient = 900,
    Godly = 800,
    Classic = 700,
    Legendary = 600,
    Rare = 500,
    Uncommon = 400,
    Common = 300,
    Christmas = 200,
    Halloween = 100,
    Unknown = 0
}

local RARITY_SECTIONS = {
    {Name = "Unique", Label = "UNIQUE"},
    {Name = "Ancient", Label = "ANCIENT"},
    {Name = "Godly", Label = "GODLY"},
    {Name = "Classic", Label = "CLASSIC / VINTAGE"},
    {Name = "Legendary", Label = "LEGENDARY"},
    {Name = "Rare", Label = "RARE"},
    {Name = "Uncommon", Label = "UNCOMMON"},
    {Name = "Common", Label = "COMMON"},
    {Name = "Christmas", Label = "CHRISTMAS"},
    {Name = "Halloween", Label = "HALLOWEEN"},
    {Name = "Unknown", Label = "OTHER"}
}

local rarityColors = {
    Common = Color3.fromRGB(255, 255, 255),
    Uncommon = Color3.fromRGB(0, 255, 255),
    Rare = Color3.fromRGB(0, 255, 0),
    Legendary = Color3.fromRGB(255, 0, 0),
    Godly = Color3.fromRGB(255, 0, 255),
    Ancient = Color3.fromRGB(100, 10, 255),
    Classic = Color3.fromRGB(255, 255, 0),
    Victim = Color3.fromRGB(255, 140, 0),
    Unique = Color3.fromRGB(255, 140, 0),
    Christmas = Color3.fromRGB(30, 214, 205),
    Halloween = Color3.fromRGB(221, 86, 2)
}

do
    local rarityModule = ReplicatedStorage:FindFirstChild("Database")
        and ReplicatedStorage.Database:FindFirstChild("Sync")
        and ReplicatedStorage.Database.Sync:FindFirstChild("Rarity")

    if rarityModule and rarityModule:IsA("ModuleScript") then
        local ok, result = pcall(require, rarityModule)

        if ok and type(result) == "table" then
            rarityColors = result
        end
    end
end

local EMBEDDED_ITEM_DATABASE = {
    {K="Gift",N="Gifts 2015",R="Christmas",T="Misc",I="330192109",E="Christmas",Y="2015"},
    {K="Candies",N="Candies",R="Halloween",T="Misc",I="531203559",E="Halloween",Y="2016"},
    {K="Candies2017",N="Candies",R="Halloween",T="Misc",I="1130939504",E="Halloween",Y="2017"},
    {K="DefaultKnife",N="Default Knife",R="Common",T="Knife",I="584555920"},
    {K="DefaultGun",N="Default Gun",R="Common",T="Gun",I="197518111"},
    {K="Whiteout",N="Whiteout",R="Common",T="Knife",I="191788694"},
    {K="Splatter",N="Splatter",R="Common",T="Knife",I="16964346058"},
    {K="Ice",N="Ice",R="Common",T="Knife",I="191976710"},
    {K="Love",N="Love",R="Common",T="Knife",I="196750845"},
    {K="Wanwood",N="Wanwood",R="Uncommon",T="Knife",I="192132094"},
    {K="Bluesteel",N="Bluesteel",R="Uncommon",T="Knife",I="159947939"},
    {K="Adurite",N="Adurite",R="Uncommon",T="Knife",I="192492943"},
    {K="Rainbow",N="Rainbow",R="Rare",T="Knife",I="159747377"},
    {K="Galaxy",N="Galaxy",R="Rare",T="Knife",I="192480941"},
    {K="Plasmite",N="Plasmite",R="Legendary",T="Knife",I="161369368"},
    {K="Deathshard",N="Deathshard",R="Godly",T="Knife",I="3175017717"},
    {K="DeathshardChroma",N="Deathshard",R="Godly",T="Knife",I="3187397317",C=true},
    {K="BloodKnife",N="Blood",R="Classic",T="Knife",I="144307188"},
    {K="GhostKnife",N="Ghost",R="Classic",T="Knife",I="144268841"},
    {K="Knife1",N="Splitter",R="Classic",T="Knife",I="143820641"},
    {K="ShadowKnife",N="Shadow",R="Classic",T="Knife",I="144070096"},
    {K="TimeKnife",N="Prince",R="Classic",T="Knife",I="143917700"},
    {K="AmericaGun",N="America",R="Classic",T="Gun",I="164676043"},
    {K="GoldenGun",N="Golden",R="Classic",T="Gun",I="147835357"},
    {K="Gun1",N="Cowboy",R="Classic",T="Gun",I="144290769"},
    {K="Phaser",N="Phaser",R="Classic",T="Gun",I="144325423"},
    {K="Disint",N="Laser",R="Classic",T="Gun",I="54798135"},
    {K="BigKill",N="Big Kill",R="Common",T="Gun",I="162669041"},
    {K="Cold",N="Cold",R="Common",T="Gun",I="161309889"},
    {K="Fallout",N="Fallout",R="Common",T="Gun",I="175668592"},
    {K="Iron",N="Iron",R="Common",T="Gun",I="160201541"},
    {K="AduriteGun",N="Adurite",R="Uncommon",T="Gun",I="175668921"},
    {K="BluesteelGun",N="Bluesteel",R="Uncommon",T="Gun",I="162668203"},
    {K="Camo",N="Camo",R="Uncommon",T="Gun",I="160024789"},
    {K="Galactic",N="Galactic",R="Rare",T="Gun",I="173913533"},
    {K="Imbued",N="Imbued",R="Rare",T="Gun",I="162668312"},
    {K="Viper",N="Viper",R="Legendary",T="Gun",I="160299600"},
    {K="Luger",N="Luger",R="Godly",T="Gun",I="3187399148"},
    {K="LugerChroma",N="Luger",R="Godly",T="Gun",I="3187399258",C=true},
    {K="Reptile",N="Reptile",R="Common",T="Knife",I="162672131"},
    {K="Gifted",N="Gifted",R="Uncommon",T="Knife",I="197627734"},
    {K="Future",N="Future",R="Uncommon",T="Knife",I="197639041"},
    {K="Nether",N="Nether",R="Rare",T="Knife",I="197657098"},
    {K="Midnight",N="Midnight",R="Legendary",T="Knife",I="197664126"},
    {K="Night",N="Night",R="Uncommon",T="Gun",I="159971385"},
    {K="Spitfire",N="Spitfire",R="Rare",T="Gun",I="159971321"},
    {K="Overseer",N="Overseer",R="Legendary",T="Gun",I="175668680"},
    {K="Sorry",N="Corrupt",R="Unique",T="Knife",I="197879343"},
    {K="Linked",N="Linked",R="Common",T="Knife",I="198453528"},
    {K="Slate",N="Slate",R="Common",T="Knife",I="198453556"},
    {K="Borders",N="Borders",R="Common",T="Knife",I="198453499"},
    {K="8bit",N="8bit",R="Common",T="Knife",I="198453482"},
    {K="Stalker",N="Stalker",R="Uncommon",T="Knife",I="198455980"},
    {K="Missing",N="Missing",R="Uncommon",T="Knife",I="198455936"},
    {K="Cheesy",N="Cheesy",R="Uncommon",T="Knife",I="198455898"},
    {K="Krypto",N="Krypto",R="Rare",T="Knife",I="198458841"},
    {K="Spectrum",N="Spectrum",R="Rare",T="Knife",I="198458862"},
    {K="OverseerKnife",N="Overseer",R="Legendary",T="Knife",I="198458910"},
    {K="TheSeer",N="Seer",R="Godly",T="Knife",I="3184139765"},
    {K="Fang",N="Fang",R="Godly",T="Knife",I="3187397768"},
    {K="FangChroma",N="Fang",R="Godly",T="Knife",I="3187397850",C=true},
    {K="Checker",N="Checker",R="Uncommon",T="Knife",I="198461230"},
    {K="Damp",N="Damp",R="Rare",T="Knife",I="198461253"},
    {K="Emerald",N="Emerald",R="Legendary",T="Knife",I="198461276"},
    {K="Neon",N="Neon",R="Common",T="Knife",I="159746637"},
    {K="2015",N="2015",R="Common",T="Knife",I="199026945"},
    {K="Infected",N="Infected",R="Common",T="Knife",I="200953094"},
    {K="Marley",N="Green",R="Common",T="Knife",I="473625785"},
    {K="Fanta",N="Orange",R="Common",T="Knife",I="473626025"},
    {K="Pepper",N="Brown",R="Common",T="Knife",I="473625645"},
    {K="Kool",N="Yellow",R="Common",T="Knife",I="473625906"},
    {K="LMFAO",N="Pink",R="Uncommon",T="Knife",I="473626473"},
    {K="Chips",N="Blue",R="Uncommon",T="Knife",I="473626317"},
    {K="Snoop",N="Red",R="Uncommon",T="Knife",I="473626150"},
    {K="Doritos",N="Purple",R="Rare",T="Knife",I="473626740"},
    {K="Dew",N="Black",R="Rare",T="Knife",I="473626646"},
    {K="MLG",N="Shiny",R="Legendary",T="Knife",I="473626979"},
    {K="Heat",N="Heat",R="Godly",T="Knife",I="3187444758"},
    {K="HeatChroma",N="Heat",R="Godly",T="Knife",I="3187444849",C=true},
    {K="TNL",N="TNL",R="Common",T="Knife",I="201542790"},
    {K="Engraved",N="Engraved",R="Common",T="Gun",I="203807690"},
    {K="Infiltrator",N="Infiltrator",R="Common",T="Gun",I="203806022"},
    {K="Aid",N="Juice",R="Common",T="Gun",I="203807397"},
    {K="Star",N="Star",R="Common",T="Gun",I="203807904"},
    {K="Sketch",N="Sketch",R="Uncommon",T="Gun",I="203808108"},
    {K="Marina",N="Marina",R="Uncommon",T="Gun",I="203808190"},
    {K="Cheddar",N="Cheddar",R="Uncommon",T="Gun",I="203808317"},
    {K="iRevolver",N="iRevolver",R="Rare",T="Gun",I="203809168"},
    {K="Hacker",N="Hacker",R="Rare",T="Gun",I="203819271"},
    {K="Predator",N="Predator",R="Legendary",T="Gun",I="203810176"},
    {K="Shark",N="Shark",R="Godly",T="Gun",I="3187421705"},
    {K="SharkChroma",N="Shark",R="Godly",T="Gun",I="3187421856",C=true},
    {K="LoveGun",N="Love",R="Uncommon",T="Gun",I="203867650"},
    {K="Molten",N="Molten",R="Rare",T="Gun",I="203869308"},
    {K="Sparkle",N="Sparkle",R="Legendary",T="Gun",I="203869110"},
    {K="Clan",N="Clan",R="Common",T="Knife",I="235366460"},
    {K="Cherry",N="Cherry",R="Common",T="Knife",I="6711852603"},
    {K="Cardboard",N="Cardboard",R="Common",T="Knife",I="235366729"},
    {K="Stainless",N="Stainless",R="Common",T="Knife",I="235366771"},
    {K="Circuit",N="Circuit",R="Uncommon",T="Knife",I="235366945"},
    {K="Doge",N="Doge",R="Uncommon",T="Knife",I="235371276"},
    {K="Paper",N="Paper",R="Uncommon",T="Knife",I="235366870"},
    {K="Splash",N="Splash",R="Legendary",T="Knife",I="235371439"},
    {K="Vortex",N="Vortex",R="Rare",T="Knife",I="235371508"},
    {K="Nova",N="Nova",R="Rare",T="Knife",I="235371686"},
    {K="Donut",N="Donut",R="Uncommon",T="Knife",I="235366815"},
    {K="MoltenKnife",N="Molten",R="Rare",T="Knife",I="235371809"},
    {K="PredatorKnife",N="Predator",R="Legendary",T="Knife",I="235372015"},
    {K="Saw",N="Saw",R="Godly",T="Knife",I="3187397991"},
    {K="SawChroma",N="Saw",R="Godly",T="Knife",I="3187398132",C=true},
    {K="Goo",N="Goo",R="Common",T="Knife",I="237336076"},
    {K="Pea",N="Pea",R="Common",T="Gun",I="238545971"},
    {K="News",N="News",R="Common",T="Gun",I="238546032"},
    {K="HL2",N="HL2",R="Common",T="Gun",I="238546100"},
    {K="Bit",N="Bit",R="Common",T="Gun",I="238549030"},
    {K="Wooden",N="Wooden",R="Uncommon",T="Gun",I="238546356"},
    {K="Cola",N="Soda",R="Uncommon",T="Gun",I="238546400"},
    {K="Caution",N="Caution",R="Uncommon",T="Gun",I="238546422"},
    {K="Bacon",N="Bacon",R="Rare",T="Gun",I="238546467"},
    {K="Ace",N="Ace",R="Rare",T="Gun",I="238546577"},
    {K="Universe",N="Universe",R="Legendary",T="Gun",I="238546660"},
    {K="Laser",N="Laser",R="Godly",T="Gun",I="3187422496"},
    {K="LaserChroma",N="Laser",R="Godly",T="Gun",I="3187422628",C=true},
    {K="Elite",N="Elite",R="Legendary",T="Knife",I="241095344"},
    {K="Skool",N="Skool",R="Common",T="Knife",I="295269977"},
    {K="Sidewinder",N="Sidewinder",R="Common",T="Knife",I="305503783"},
    {K="Grind",N="Grind",R="Common",T="Knife",I="305503942"},
    {K="Euro",N="Euro",R="Common",T="Knife",I="305504173"},
    {K="Ollie",N="Ollie",R="Common",T="Knife",I="305504399"},
    {K="Tailslide",N="Tailslide",R="Common",T="Knife",I="305506822"},
    {K="Indy",N="Indy",R="Common",T="Knife",I="305506951"},
    {K="Prism",N="Prism",R="Common",T="Knife",I="306046703"},
    {K="Sparkle1",N="Sparkle1",R="Common",T="Knife",I="310709709"},
    {K="Sparkle2",N="Sparkle2",R="Common",T="Knife",I="310710191"},
    {K="Sparkle3",N="Sparkle3",R="Common",T="Knife",I="310710694"},
    {K="Sparkle4",N="Sparkle4",R="Common",T="Knife",I="310712788"},
    {K="Sparkle5",N="Sparkle5",R="Common",T="Knife",I="310713235"},
    {K="Sparkle6",N="Sparkle6",R="Common",T="Knife",I="310713648"},
    {K="Sparkle7",N="Sparkle7",R="Common",T="Knife",I="310714089"},
    {K="Sparkle8",N="Sparkle8",R="Common",T="Knife",I="310714407"},
    {K="Sparkle9",N="Sparkle9",R="Common",T="Knife",I="310715104"},
    {K="Sparkle10",N="Sparkle10",R="Common",T="Knife",I="310715768"},
    {K="Jack",N="Jack",R="Rare",T="Knife",I="315099010",E="Halloween",Y="2015"},
    {K="Bleed",N="Rupture",R="Legendary",T="Gun",I="315100702",E="Halloween",Y="2015"},
    {K="Web",N="Web",R="Legendary",T="Knife",I="315104004",E="Halloween",Y="2015"},
    {K="Spider",N="Spider",R="Godly",T="Knife",I="315120760",E="Halloween",Y="2015"},
    {K="Mummy",N="Mummy",R="Rare",T="Gun",I="315155591",E="Halloween",Y="2015"},
    {K="Bleached",N="Bleached",R="Common",T="Knife",I="315500879"},
    {K="Clown",N="Clown",R="Common",T="Knife",I="315501118"},
    {K="SlouseClown",N="Clown",R="Unique",T="Knife",I="315501118"},
    {K="SlouseClownGun",N="Clown",R="Unique",T="Gun",I="4659627976"},
    {K="Oily",N="Oily",R="Common",T="Knife",I="315501170"},
    {K="Aqua",N="Aqua",R="Common",T="Knife",I="315501208"},
    {K="Hazmat",N="Hazmat",R="Uncommon",T="Knife",I="315501297"},
    {K="Melon",N="Melon",R="Uncommon",T="Knife",I="315501369"},
    {K="Hive",N="Hive",R="Uncommon",T="Knife",I="315501434"},
    {K="Korblox",N="Korblox",R="Rare",T="Knife",I="315501501"},
    {K="Squire",N="Squire",R="Rare",T="Knife",I="315501560"},
    {K="Fade",N="Fade",R="Legendary",T="Knife",I="315501640"},
    {K="Slasher",N="Slasher",R="Godly",T="Knife",I="3187398274"},
    {K="SlasherChroma",N="Slasher",R="Godly",T="Knife",I="3187398385",C=true},
    {K="Santa",N="Santa",R="Common",T="Knife",I="331746096",E="Christmas",Y="2015"},
    {K="Elf",N="Elf",R="Common",T="Knife",I="331746317",E="Christmas",Y="2015"},
    {K="Ornament1",N="Ornament",R="Common",T="Knife",I="331745428",E="Christmas",Y="2015"},
    {K="Ornament2",N="Ornament2",R="Common",T="Knife",I="331745341",E="Christmas",Y="2015"},
    {K="Snowy",N="Snowy",R="Uncommon",T="Knife",I="332011125",E="Christmas",Y="2015"},
    {K="Snowman",N="Snowman",R="Uncommon",T="Knife",I="331745799",E="Christmas",Y="2015"},
    {K="Wrapped",N="Wrapped",R="Uncommon",T="Knife",I="331745500",E="Christmas",Y="2015"},
    {K="Ginger",N="Ginger",R="Rare",T="Knife",I="331744703",E="Christmas",Y="2015"},
    {K="Cane",N="Cane",R="Rare",T="Knife",I="331140746",E="Christmas",Y="2015"},
    {K="Tree",N="Tree",R="Legendary",T="Knife",I="331745577",E="Christmas",Y="2015"},
    {K="SantaGun",N="Santa",R="Common",T="Gun",I="332496861",E="Christmas",Y="2015"},
    {K="ElfGun",N="Elf",R="Common",T="Gun",I="332767999",E="Christmas",Y="2015"},
    {K="Ornament1Gun",N="Ornament1",R="Common",T="Gun",I="332497144",E="Christmas",Y="2015"},
    {K="Ornament2Gun",N="Ornament2",R="Common",T="Gun",I="332497550",E="Christmas",Y="2015"},
    {K="Nutcracker",N="Nutcracker",R="Uncommon",T="Gun",I="332497657",E="Christmas",Y="2015"},
    {K="SnowmanGun",N="Snowman",R="Uncommon",T="Gun",I="332497603",E="Christmas",Y="2015"},
    {K="WrappedGun",N="Wrapped",R="Uncommon",T="Gun",I="332497103",E="Christmas",Y="2015"},
    {K="GingerGun",N="Ginger",R="Rare",T="Gun",I="332497038",E="Christmas",Y="2015"},
    {K="CaneGun",N="Cane",R="Rare",T="Gun",I="332497187",E="Christmas",Y="2015"},
    {K="TreeGun",N="Tree",R="Legendary",T="Gun",I="332497688",E="Christmas",Y="2015"},
    {K="Candy",N="Candy",R="Godly",T="Knife",I="332021011",E="Christmas",Y="2015"},
    {K="Chill",N="Chill",R="Godly",T="Knife",I="332022166",E="Christmas",Y="2015"},
    {K="Handsaw",N="Handsaw",R="Godly",T="Knife",I="332042435",E="Christmas",Y="2015"},
    {K="RedLuger",N="Red Luger",R="Godly",T="Gun",I="332044583",E="Christmas",Y="2015"},
    {K="RandLuger",N="Glitch2",R="Common",T="Knife",I="196751515"},
    {K="GreenLuger",N="Green Luger",R="Godly",T="Gun",I="332044679",E="Christmas",Y="2015"},
    {K="Xmas",N="Xmas",R="Godly",T="Knife",I="332077449",E="Christmas",Y="2015"},
    {K="EliteGreen",N="Green Elite",R="Legendary",T="Knife",I="332754554",E="Christmas",Y="2015"},
    {K="EliteBlue",N="Blue Elite",R="Legendary",T="Knife",I="1269374321",E="Christmas",Y="2017"},
    {K="Sugar",N="Sugar",R="Godly",T="Gun",I="3215356000",E="Christmas",Y="2015"},
    {K="Clockwork",N="Clockwork",R="Godly",T="Knife",I="360609441"},
    {K="Blossom",N="Blossom",R="Common",T="Knife",I="363150561"},
    {K="Passion",N="Passion",R="Common",T="Knife",I="363150334"},
    {K="Roses",N="Roses",R="Common",T="Knife",I="363352002"},
    {K="Hearts",N="Hearts",R="Common",T="Knife",I="363362737"},
    {K="Valentine",N="Valentine",R="Common",T="Knife",I="363362726"},
    {K="Sweetheart",N="Sweetheart",R="Common",T="Knife",I="363150761"},
    {K="Eco",N="Eco",R="Common",T="Knife",I="365567889"},
    {K="Log",N="Log",R="Common",T="Knife",I="365567962"},
    {K="Sandy",N="Sandy",R="Common",T="Knife",I="365568056"},
    {K="Static",N="Static",R="Common",T="Knife",I="365568163"},
    {K="Brush",N="Brush",R="Uncommon",T="Knife",I="365568602"},
    {K="Jigsaw",N="Jigsaw",R="Uncommon",T="Knife",I="365569126"},
    {K="Lucky",N="Lucky",R="Uncommon",T="Knife",I="365569265"},
    {K="Abstract",N="Abstract",R="Rare",T="Knife",I="365569428"},
    {K="Musical",N="Musical",R="Rare",T="Knife",I="365569566"},
    {K="Fusion",N="Fusion",R="Legendary",T="Knife",I="365569686"},
    {K="Tides",N="Tides",R="Godly",T="Knife",I="3187398809"},
    {K="TidesChroma",N="Tides",R="Godly",T="Knife",I="3187398906",C=true},
    {K="Batwing",N="Glitch1",R="Common",T="Knife",I="196751515"},
    {K="Pixel",N="Pixel",R="Godly",T="Knife",I="365347166"},
    {K="Blaster",N="Blaster",R="Godly",T="Gun",I="386277381"},
    {K="Virtual",N="Virtual",R="Godly",T="Knife",I="386276987"},
    {K="Patrick",N="Patrick",R="Common",T="Knife",I="383476085"},
    {K="Eggs",N="Egg",R="Common",T="Knife",I="387875405",E="Christmas",Y="2016"},
    {K="Choco",N="Choco",R="Common",T="Knife",I="387874991",E="Christmas",Y="2016"},
    {K="Tulip",N="Tulip",R="Common",T="Knife",I="387874661",E="Christmas",Y="2016"},
    {K="Bunny",N="Bunny",R="Common",T="Knife",I="387874365",E="Christmas",Y="2016"},
    {K="Carrot",N="Carrot",R="Common",T="Knife",I="387874071",E="Christmas",Y="2016"},
    {K="CottonCandy",N="Cotton Candy",R="Legendary",T="Knife",I="435933179"},
    {K="Xbox",N="Xbox",R="Common",T="Knife",I="439325100"},
    {K="AmericaSword",N="Old Glory",R="Godly",T="Knife",I="446047742"},
    {K="Amerilaser",N="Amerilaser",R="Godly",T="Gun",I="446050753"},
    {K="Nightblade",N="Nightblade",R="Godly",T="Knife",I="475478854"},
    {K="Asteroid",N="Asteroid",R="Common",T="Gun",I="476599365"},
    {K="Brains",N="Brains",R="Common",T="Knife",I="531873956",E="Halloween",Y="2016"},
    {K="Bones",N="Bones",R="Common",T="Knife",I="531873816",E="Halloween",Y="2016"},
    {K="Ghosty",N="Ghosty",R="Common",T="Knife",I="531873080",E="Halloween",Y="2016"},
    {K="Witch",N="Witch",R="Common",T="Knife",I="531873553",E="Halloween",Y="2016"},
    {K="Vampire",N="Vampire",R="Uncommon",T="Knife",I="531873248",E="Halloween",Y="2016"},
    {K="Moons",N="Moons",R="Uncommon",T="Knife",I="531873154",E="Halloween",Y="2016"},
    {K="Wolf",N="Wolf",R="Uncommon",T="Knife",I="531873487",E="Halloween",Y="2016"},
    {K="OrangeMarble",N="Orange Marble",R="Rare",T="Knife",I="531873011",E="Halloween",Y="2016"},
    {K="Bats",N="Bats",R="Rare",T="Knife",I="531873625",E="Halloween",Y="2016"},
    {K="Scratch",N="Scratch",R="Legendary",T="Knife",I="531873371",E="Halloween",Y="2016"},
    {K="Hallow",N="Hallow\\'s Edge",R="Godly",T="Knife",I="531878205",E="Halloween",Y="2016"},
    {K="HallowsBlade",N="Hallow\\'s Blade",R="Godly",T="Knife",I="1132775323",E="Halloween",Y="2017"},
    {K="Ecto",N="Ecto",R="Common",T="Knife",I="1133331679",E="Halloween",Y="2017"},
    {K="Zombie",N="Zombie",R="Common",T="Knife",I="1133331875",E="Halloween",Y="2017"},
    {K="Phantom",N="Phantom",R="Common",T="Knife",I="1133332075",E="Halloween",Y="2017"},
    {K="CandyCorn",N="CandyCorn",R="Common",T="Knife",I="1133337797",E="Halloween",Y="2017"},
    {K="Webs",N="Webs",R="Uncommon",T="Knife",I="1133325465",E="Halloween",Y="2017"},
    {K="MummyK",N="Mummy",R="Uncommon",T="Knife",I="1133352032",E="Halloween",Y="2017"},
    {K="Potion",N="Potion",R="Uncommon",T="Knife",I="1133366632",E="Halloween",Y="2017"},
    {K="MagmaK",N="Magma",R="Rare",T="Knife",I="1133317890",E="Halloween",Y="2017"},
    {K="GreenMarble",N="Green Marble",R="Rare",T="Knife",I="1133366830",E="Halloween",Y="2017"},
    {K="ScratchBlue",N="Scratch",R="Legendary",T="Knife",I="1133316381",E="Halloween",Y="2017"},
    {K="Eternal",N="Eternal",R="Godly",T="Knife",I="538706317"},
    {K="Alex",N="Alex",R="Common",T="Knife",I="546159020"},
    {K="Sub",N="Sub",R="Common",T="Knife",I="546159250"},
    {K="Denis",N="Denis",R="Common",T="Knife",I="546161062"},
    {K="SketchYT",N="Sketchy",R="Common",T="Knife",I="546161470"},
    {K="Corl",N="Corl",R="Common",T="Knife",I="546161858"},
    {K="JD",N="JD",R="Legendary",T="Knife",I="566867312"},
    {K="IceDragon",N="Ice Dragon",R="Godly",T="Knife",I="585846454",E="Christmas",Y="2016"},
    {K="Flames",N="Flames",R="Godly",T="Knife",I="585873746"},
    {K="Pumpking",N="Pumpking",R="Godly",T="Knife",I="1133082421",E="Halloween",Y="2017"},
    {K="BattleAxe",N="BattleAxe",R="Godly",T="Knife",I="1133237368",E="Halloween",Y="2017"},
    {K="Present",N="Present",R="Common",T="Knife",I="1268699212",E="Christmas",Y="2017"},
    {K="Coal",N="Coal",R="Common",T="Knife",I="1268699677",E="Christmas",Y="2017"},
    {K="Elf2017",N="Elf",R="Common",T="Knife",I="1268703023",E="Christmas",Y="2017"},
    {K="Santa2017",N="Santa",R="Common",T="Knife",I="1268703618",E="Christmas",Y="2017"},
    {K="Tree2017",N="Tree",R="Uncommon",T="Knife",I="1268704124",E="Christmas",Y="2017"},
    {K="Frosty",N="Frosty",R="Uncommon",T="Knife",I="1268704507",E="Christmas",Y="2017"},
    {K="Sweater",N="Sweater",R="Uncommon",T="Knife",I="1268704902",E="Christmas",Y="2017"},
    {K="Gingerbread2017",N="Gingerbread",R="Rare",T="Knife",I="1268705527",E="Christmas",Y="2017"},
    {K="Snowy2017",N="Snowy",R="Rare",T="Knife",I="1268705947",E="Christmas",Y="2017"},
    {K="GreenFire",N="Green Fire",R="Legendary",T="Knife",I="1268706374",E="Christmas",Y="2017"},
    {K="RedFire",N="Red Fire",R="Legendary",T="Knife",I="1269256860",E="Christmas",Y="2017"},
    {K="WintersEdge",N="Winter\\'s Edge",R="Godly",T="Knife",I="1268708987",E="Christmas",Y="2017"},
    {K="IceShard",N="Ice Shard",R="Godly",T="Knife",I="1268710824",E="Christmas",Y="2017"},
    {K="Snowflake",N="Snowflake",R="Godly",T="Knife",I="1268932977",E="Christmas",Y="2017"},
    {K="Frostsaber",N="Frostsaber",R="Godly",T="Knife",I="1268934541",E="Christmas",Y="2017"},
    {K="WrapPaperBoxRed",N="Box of Red Wrapping Paper",R="Christmas",T="Misc",I="586083433",E="Christmas",Y="2016"},
    {K="WrapPaperBoxPurple",N="Box of Purple Wrapping Paper",R="Christmas",T="Misc",I="586083461",E="Christmas",Y="2016"},
    {K="WrapPaperBoxGold",N="Box of Gold Wrapping Paper ",R="Christmas",T="Misc",I="586083489",E="Christmas",Y="2016"},
    {K="WrapPaperBoxGreen",N="Box of Green Wrapping Paper",R="Christmas",T="Misc",I="1262587992",E="Christmas",Y="2017"},
    {K="WrapPaperBoxBlue",N="Box of Blue Wrapping Paper",R="Christmas",T="Misc",I="1262587998",E="Christmas",Y="2017"},
    {K="WrapPaperBoxUltra",N="Box of Ultra Wrapping Paper",R="Christmas",T="Misc",I="1262588010",E="Christmas",Y="2017"},
    {K="BlueCandy",N="Blue Candy",R="Unique",T="Knife",I="1489495701",E="Christmas",Y="2017"},
    {K="GoldCandy",N="Gold Candy",R="Unique",T="Knife",I="1520188792",E="Christmas",Y="2017"},
    {K="SilverCandy",N="Silver Candy",R="Unique",T="Knife",I="1520190188",E="Christmas",Y="2017"},
    {K="BronzeCandy",N="Bronze Candy",R="Unique",T="Knife",I="1520189487",E="Christmas",Y="2017"},
    {K="SkeletonKey",N="Skeleton Key 2018",R="Halloween",T="Misc",I="2507222605",E="Halloween",Y="2018"},
    {K="Scythe",N="Batwing",R="Ancient",T="Knife",I="375690925",E="Halloween",Y="2018"},
    {K="Boneblade",N="Boneblade",R="Godly",T="Knife",I="2513505477",E="Halloween",Y="2018"},
    {K="BonebladeChroma",N="Boneblade",R="Godly",T="Knife",I="2513597845",E="Halloween",Y="2018",C=true},
    {K="BattleAxe2",N="BattleAxe II",R="Godly",T="Knife",I="2513535503",E="Halloween",Y="2018"},
    {K="SlimeK",N="Slime",R="Common",T="Knife",I="2513734227",E="Halloween",Y="2018"},
    {K="GraveK",N="Grave",R="Common",T="Knife",I="2513728474",E="Halloween",Y="2018"},
    {K="HauntedK",N="Haunted",R="Common",T="Knife",I="2513733741",E="Halloween",Y="2018"},
    {K="BatsK",N="Bats",R="Common",T="Knife",I="2513732731",E="Halloween",Y="2018"},
    {K="MummyK2018",N="Mummy",R="Uncommon",T="Knife",I="2513733542",E="Halloween",Y="2018"},
    {K="ZombieK2018",N="Zombie",R="Uncommon",T="Knife",I="2513734908",E="Halloween",Y="2018"},
    {K="PotionK2018",N="Potion",R="Uncommon",T="Knife",I="2513733987",E="Halloween",Y="2018"},
    {K="VampireK2018",N="Vampire",R="Rare",T="Knife",I="2513734708",E="Halloween",Y="2018"},
    {K="ToxicK",N="Toxic",R="Rare",T="Knife",I="2513734535",E="Halloween",Y="2018"},
    {K="GhostK2018",N="Ghost",R="Legendary",T="Knife",I="2513732969",E="Halloween",Y="2018"},
    {K="SlimeG",N="Slime",R="Common",T="Gun",I="2513742319",E="Halloween",Y="2018"},
    {K="GraveG",N="Grave",R="Common",T="Gun",I="2513731746",E="Halloween",Y="2018"},
    {K="HauntedG",N="Haunted",R="Common",T="Gun",I="2513741901",E="Halloween",Y="2018"},
    {K="BatsG",N="Bats",R="Common",T="Gun",I="2513741174",E="Halloween",Y="2018"},
    {K="MummyG2018",N="Mummy",R="Uncommon",T="Gun",I="2513741663",E="Halloween",Y="2018"},
    {K="ZombieG2018",N="Zombie",R="Uncommon",T="Gun",I="2513743298",E="Halloween",Y="2018"},
    {K="PotionG2018",N="Potion",R="Uncommon",T="Gun",I="2513742133",E="Halloween",Y="2018"},
    {K="VampireG2018",N="Vampire",R="Rare",T="Gun",I="2513742751",E="Halloween",Y="2018"},
    {K="ToxicG",N="Toxic",R="Rare",T="Gun",I="2513742519",E="Halloween",Y="2018"},
    {K="GhostG2018",N="Ghost",R="Legendary",T="Gun",I="2513741407",E="Halloween",Y="2018"},
    {K="NikKnife",N="Nik\\'s Scythe",R="Ancient",T="Knife",I="2533350813"},
    {K="Eternal2",N="Eternal II",R="Godly",T="Knife",I="2545253030"},
    {K="RedHallow",N="Red Hallow",R="Unique",T="Knife",I="2511343130",E="Halloween",Y="2018"},
    {K="BronzeHallow",N="Bronze Hallow",R="Unique",T="Knife",I="2511342846",E="Halloween",Y="2018"},
    {K="SilverHallow",N="Silver Hallow",R="Unique",T="Knife",I="2511341094",E="Halloween",Y="2018"},
    {K="GoldHallow",N="Gold Hallow",R="Unique",T="Knife",I="2511340308",E="Halloween",Y="2018"},
    {K="SnowflakeKey",N="Snowflake Key 2018",R="Christmas",T="Misc",I="4528872048",E="Christmas",Y="2018"},
    {K="Coal_K_2018",N="Coal",R="Common",T="Knife",I="2669638285",E="Christmas",Y="2018"},
    {K="Santa_K_2018",N="Santa",R="Common",T="Knife",I="2669637780",E="Christmas",Y="2018"},
    {K="Snowman_K_2018",N="Snowman",R="Common",T="Knife",I="2669640152",E="Christmas",Y="2018"},
    {K="Wrapped_K_2018",N="Wrapped",R="Common",T="Knife",I="2669640357",E="Christmas",Y="2018"},
    {K="Snowflake_K_2018",N="Snowflake",R="Uncommon",T="Knife",I="2669639913",E="Christmas",Y="2018"},
    {K="Holly_K_2018",N="Holly",R="Uncommon",T="Knife",I="2669638990",E="Christmas",Y="2018"},
    {K="Sweater_K_2018",N="Sweater",R="Uncommon",T="Knife",I="2669640567",E="Christmas",Y="2018"},
    {K="Icicles_K_2018",N="Icicles",R="Rare",T="Knife",I="2669639638",E="Christmas",Y="2018"},
    {K="Cane_K_2018",N="Cane",R="Rare",T="Knife",I="2669638508",E="Christmas",Y="2018"},
    {K="Ginger_K_2018",N="Ginger",R="Legendary",T="Knife",I="2669638742",E="Christmas",Y="2018"},
    {K="Coal_G_2018",N="Coal",R="Common",T="Gun",I="2669784920",E="Christmas",Y="2018"},
    {K="Santa_G_2018",N="Elf",R="Common",T="Gun",I="2669785184",E="Christmas",Y="2018"},
    {K="Snowman_G_2018",N="Snowman",R="Common",T="Gun",I="2669786846",E="Christmas",Y="2018"},
    {K="Wrapped_G_2018",N="Wrapped",R="Common",T="Gun",I="2669787533",E="Christmas",Y="2018"},
    {K="Snowflake_G_2018",N="Snowflake",R="Uncommon",T="Gun",I="2669786515",E="Christmas",Y="2018"},
    {K="Holly_G_2018",N="Holly",R="Uncommon",T="Gun",I="2669786261",E="Christmas",Y="2018"},
    {K="Sweater_G_2018",N="Sweater",R="Uncommon",T="Gun",I="2669787088",E="Christmas",Y="2018"},
    {K="Icicles_G_2018",N="Icicles",R="Rare",T="Gun",I="2669786044",E="Christmas",Y="2018"},
    {K="Cane_G_2018",N="Cane",R="Rare",T="Gun",I="2669785546",E="Christmas",Y="2018"},
    {K="Ginger_G_2018",N="Ginger",R="Legendary",T="Gun",I="2669785821",E="Christmas",Y="2018"},
    {K="Gingerblade",N="Gingerblade",R="Godly",T="Knife",I="2669336659",E="Christmas",Y="2018"},
    {K="GingerbladeChroma",N="Gingerblade",R="Godly",T="Knife",I="2672351679",E="Christmas",Y="2018",C=true},
    {K="Icewing",N="Icewing",R="Ancient",T="Knife",I="2669997196",E="Christmas",Y="2018"},
    {K="FertilizerBox",N="Box of Fertilizer",R="Christmas",T="Misc",I="2672223475",E="Christmas",Y="2018"},
    {K="GingerLuger",N="Ginger Luger",R="Godly",T="Gun",I="2674983099",E="Christmas",Y="2018"},
    {K="Season1TestKnife",N="S1 Test Knife",R="Common",T="Knife",I="191788694"},
    {K="Key",N="Mystery Key",R="Common",T="Misc",I="3059784291"},
    {K="Combat",N="Combat",R="Common",T="Knife",I="3183604570"},
    {K="Combat2",N="Combat II",R="Common",T="Knife",I="4972196241"},
    {K="Copper",N="Copper",R="Common",T="Knife",I="3183605392"},
    {K="Hardened",N="Hardened",R="Common",T="Knife",I="3183605810"},
    {K="Splat",N="Splat",R="Common",T="Gun",I="3183639522"},
    {K="CamoKnife",N="Camo",R="Uncommon",T="Knife",I="3183606225"},
    {K="Tiger",N="Tiger",R="Uncommon",T="Knife",I="3183606579"},
    {K="Pirate",N="Pirate",R="Uncommon",T="Gun",I="3183639867"},
    {K="Space",N="Space",R="Rare",T="Knife",I="3183607442"},
    {K="RainbowGun",N="Rainbow",R="Rare",T="Gun",I="3183640145"},
    {K="Rune",N="Rune",R="Legendary",T="Knife",I="3183607894"},
    {K="Gemstone",N="Gemstone",R="Godly",T="Knife",I="3183657748"},
    {K="GemstoneChroma",N="Gemstone",R="Godly",T="Knife",I="3183657875",C=true},
    {K="RedSeer",N="Red Seer",R="Godly",T="Knife",I="3184139367"},
    {K="OrangeSeer",N="Orange Seer",R="Godly",T="Knife",I="3184139504"},
    {K="YellowSeer",N="Yellow Seer",R="Godly",T="Knife",I="3184139648"},
    {K="BlueSeer",N="Blue Seer",R="Godly",T="Knife",I="3184139996"},
    {K="PurpleSeer",N="Purple Seer",R="Godly",T="Knife",I="3184140119"},
    {K="SeerChroma",N="Seer",R="Godly",T="Knife",I="3184140321",C=true},
    {K="BlueSugar",N="Blue Sugar",R="Unique",T="Gun",I="3215355152",E="Christmas",Y="2018"},
    {K="BronzeSugar",N="Bronze Sugar",R="Unique",T="Gun",I="3215355397",E="Christmas",Y="2018"},
    {K="SilverSugar",N="Silver Sugar",R="Unique",T="Gun",I="3215355602",E="Christmas",Y="2018"},
    {K="GoldSugar",N="Gold Sugar",R="Unique",T="Gun",I="3215355797",E="Christmas",Y="2018"},
    {K="Eternal3",N="Eternal III",R="Godly",T="Knife",I="3281170430"},
    {K="Eternal4",N="Eternal IV",R="Godly",T="Knife",I="4999958740"},
    {K="Skulls",N="Skulls",R="Legendary",T="Knife",I="4210915060",E="Halloween",Y="2019"},
    {K="Dungeon",N="Dungeon",R="Rare",T="Knife",I="4210920512",E="Halloween",Y="2019"},
    {K="SnakebiteG",N="Snakebite",R="Rare",T="Gun",I="4210925026",E="Halloween",Y="2019"},
    {K="Bones2019",N="Bones",R="Uncommon",T="Gun",I="4210926347",E="Halloween",Y="2019"},
    {K="ZombifiedK",N="Zombified",R="Uncommon",T="Knife",I="4210928053",E="Halloween",Y="2019"},
    {K="Brains2019",N="Brains",R="Uncommon",T="Knife",I="4210929184",E="Halloween",Y="2019"},
    {K="PumpkinPatch",N="Pumpkin",R="Common",T="Knife",I="4210931354",E="Halloween",Y="2019"},
    {K="SlimyK",N="Slimy",R="Common",T="Knife",I="4210932676",E="Halloween",Y="2019"},
    {K="WebbedG",N="Webbed",R="Common",T="Gun",I="4210936652",E="Halloween",Y="2019"},
    {K="CandyCorn2019",N="Candy Corn",R="Common",T="Knife",I="4210934082",E="Halloween",Y="2019"},
    {K="Witched",N="Witched",R="Legendary",T="Knife",I="4210938270",E="Halloween",Y="2019"},
    {K="SnakebiteK",N="Snakebite",R="Rare",T="Knife",I="4210939388",E="Halloween",Y="2019"},
    {K="Monster",N="Monster",R="Rare",T="Gun",I="4210941474",E="Halloween",Y="2019"},
    {K="Branches",N="Branches",R="Uncommon",T="Knife",I="4210943691",E="Halloween",Y="2019"},
    {K="ZombifiedG",N="Zombified",R="Uncommon",T="Gun",I="4210944924",E="Halloween",Y="2019"},
    {K="Mummified",N="Mummified",R="Common",T="Knife",I="4210946577",E="Halloween",Y="2019"},
    {K="RIP",N="RIP",R="Common",T="Gun",I="4210947993",E="Halloween",Y="2019"},
    {K="WebbedK",N="Webbed",R="Common",T="Knife",I="4210949599",E="Halloween",Y="2019"},
    {K="ElderwoodGun",N="Elderwood Revolver",R="Godly",T="Gun",I="4468571736",E="Halloween",Y="2019"},
    {K="ElderwoodGunBlue",N="Blue Elderwood",R="Unique",T="Gun",I="4468574885",E="Halloween",Y="2019"},
    {K="ElderwoodGunSilver",N="Silver Elderwood",R="Unique",T="Gun",I="4468583758",E="Halloween",Y="2019"},
    {K="ElderwoodGunGold",N="Gold Elderwood",R="Unique",T="Gun",I="4468584345",E="Halloween",Y="2019"},
    {K="ElderwoodGunBronze",N="Bronze Elderwood",R="Unique",T="Gun",I="4468585407",E="Halloween",Y="2019"},
    {K="ElderwoodScythe",N="Elderwood Scythe",R="Ancient",T="Knife",I="4468593654",E="Halloween",Y="2019"},
    {K="Ghostblade",N="Ghostblade",R="Godly",T="Knife",I="4217586790",E="Halloween",Y="2019"},
    {K="EternalCane",N="Eternalcane",R="Godly",T="Knife",I="4488391411",E="Christmas",Y="2019"},
    {K="Logchopper",N="Logchopper",R="Ancient",T="Knife",I="4528268775",E="Christmas",Y="2019"},
    {K="Frostbite",N="Frostbite",R="Godly",T="Knife",I="4528373246",E="Christmas",Y="2019"},
    {K="Minty",N="Minty",R="Godly",T="Gun",I="4528291487",E="Christmas",Y="2019"},
    {K="Frosted_K_2019",N="Frosted",R="Common",T="Knife",I="4534853444",E="Christmas",Y="2019"},
    {K="Frosted_G_2019",N="Frosted",R="Common",T="Gun",I="4534866678",E="Christmas",Y="2019"},
    {K="Snowflakes_K_2019",N="Snowflakes",R="Common",T="Knife",I="4534855045",E="Christmas",Y="2019"},
    {K="Snowflakes_G_2019",N="Snowflakes",R="Common",T="Gun",I="4534866065",E="Christmas",Y="2019"},
    {K="Pine_K_2019",N="Pine",R="Common",T="Knife",I="4534855710",E="Christmas",Y="2019"},
    {K="Pine_G_2019",N="Pine",R="Common",T="Gun",I="4534871260",E="Christmas",Y="2019"},
    {K="Gifts_K_2019",N="Gifts",R="Common",T="Knife",I="4534856285",E="Christmas",Y="2019"},
    {K="Gifts_G_2019",N="Gifts",R="Common",T="Gun",I="4534867381",E="Christmas",Y="2019"},
    {K="Gingerbread_K_2019",N="Gingerbread",R="Uncommon",T="Knife",I="4534856940",E="Christmas",Y="2019"},
    {K="Gingerbread_G_2019",N="Gingerbread",R="Uncommon",T="Gun",I="4534872116",E="Christmas",Y="2019"},
    {K="Frozen_K_2019",N="Frozen",R="Uncommon",T="Knife",I="4534857523",E="Christmas",Y="2019"},
    {K="Frozen_G_2019",N="Frozen",R="Uncommon",T="Gun",I="4534873956",E="Christmas",Y="2019"},
    {K="Lights_K_2019",N="Lights",R="Uncommon",T="Knife",I="4534858185",E="Christmas",Y="2019"},
    {K="Lights_G_2019",N="Lights",R="Uncommon",T="Gun",I="4534872673",E="Christmas",Y="2019"},
    {K="Aurora_K_2019",N="Aurora",R="Rare",T="Knife",I="4534860689",E="Christmas",Y="2019"},
    {K="Aurora_G_2019",N="Aurora",R="Rare",T="Gun",I="4534875165",E="Christmas",Y="2019"},
    {K="CandySwirl_K_2019",N="Candy Swirl",R="Rare",T="Knife",I="4534860226",E="Christmas",Y="2019"},
    {K="CandySwirl_G_2019",N="Candy Swirl",R="Rare",T="Gun",I="4534874602",E="Christmas",Y="2019"},
    {K="Cavern_K_2019",N="Cavern",R="Legendary",T="Knife",I="4534861110",E="Christmas",Y="2019"},
    {K="Cavern_G_2019",N="Cavern",R="Legendary",T="Gun",I="4534875511",E="Christmas",Y="2019"},
    {K="SantasMagic",N="Santa\\'s Magic",R="Legendary",T="Knife",I="4535483042",E="Christmas",Y="2019"},
    {K="Lugercane",N="Lugercane",R="Godly",T="Gun",I="4535482609",E="Christmas",Y="2019"},
    {K="Splash_G",N="Splash",R="Legendary",T="Gun",I="4659626370"},
    {K="Nightfire",N="Nightfire",R="Rare",T="Gun",I="4659626966"},
    {K="Biogun",N="Biogun",R="Uncommon",T="Gun",I="4659627458"},
    {K="Clown_G",N="Clown",R="Common",T="Gun",I="4659627976"},
    {K="DeepSea",N="Deep Sea",R="Rare",T="Knife",I="4659634072"},
    {K="Graffiti",N="Graffiti",R="Uncommon",T="Knife",I="4659634630"},
    {K="HighTech",N="High Tech",R="Uncommon",T="Knife",I="4659635055"},
    {K="Lovely",N="Lovely",R="Common",T="Knife",I="4659635584"},
    {K="Shaded",N="Shaded",R="Common",T="Knife",I="4659636085"},
    {K="Leaf",N="Leaf",R="Common",T="Knife",I="4659636452"},
    {K="Lightbringer",N="Lightbringer",R="Godly",T="Gun",I="4751387063"},
    {K="ChromaLightbringer",N="Lightbringer",R="Godly",T="Gun",I="4751507078",C=true},
    {K="Darkbringer",N="Darkbringer",R="Godly",T="Gun",I="4751387674"},
    {K="ChromaDarkbringer",N="Darkbringer",R="Godly",T="Gun",I="4751507011",C=true},
    {K="Emptybringer",N="???",R="Godly",T="Gun",I="4751388150"},
    {K="EmptybringerChroma",N="???",R="Godly",T="Gun",I="4751388150",C=true},
    {K="Bioblade",N="Bioblade",R="Godly",T="Knife",I="4751540097"},
    {K="MintyBlue",N="Blue Minty",R="Unique",T="Gun",I="4753347062",E="Christmas",Y="2019"},
    {K="MintyGold",N="Gold Minty",R="Unique",T="Gun",I="4753347636",E="Christmas",Y="2019"},
    {K="MintyBronze",N="Bronze Minty",R="Unique",T="Gun",I="4753348263",E="Christmas",Y="2019"},
    {K="MintySilver",N="Silver Minty",R="Unique",T="Gun",I="4753346087",E="Christmas",Y="2019"},
    {K="LogchopperBlue",N="Blue Logchopper",R="Unique",T="Knife",I="4753353471",E="Christmas",Y="2019"},
    {K="LogchopperBronze",N="Bronze Logchopper",R="Unique",T="Knife",I="4753354123",E="Christmas",Y="2019"},
    {K="LogchopperSilver",N="Silver Logchopper",R="Unique",T="Knife",I="4753352581",E="Christmas",Y="2019"},
    {K="LogchopperGold",N="Gold Logchopper",R="Unique",T="Knife",I="4753354638",E="Christmas",Y="2019"},
    {K="Prismatic",N="Prismatic",R="Godly",T="Knife",I="5360359935"},
    {K="Eyes_K_2020",N="Watcher",R="Common",T="Knife",I="5866438542",E="Halloween",Y="2020"},
    {K="Carved_K_2020",N="Carved",R="Common",T="Knife",I="5866436906",E="Halloween",Y="2020"},
    {K="Candle_K_2020",N="Candle",R="Common",T="Knife",I="5872491708",E="Halloween",Y="2020"},
    {K="CandyCorn_G_2020",N="Candy Corn",R="Common",T="Gun",I="5866454590",E="Halloween",Y="2020"},
    {K="Ghosts_K_2020",N="Ghosts",R="Uncommon",T="Knife",I="5866442790",E="Halloween",Y="2020"},
    {K="Pumpkin_K_2020",N="Pumpkin",R="Uncommon",T="Knife",I="5872490600",E="Halloween",Y="2020"},
    {K="Mummy_G_2020",N="Mummy",R="Uncommon",T="Gun",I="5866463755",E="Halloween",Y="2020"},
    {K="Bones_K_2020",N="Bones",R="Rare",T="Knife",I="5872492951",E="Halloween",Y="2020"},
    {K="Portal_K_2020",N="Portal",R="Rare",T="Knife",I="5866444722",E="Halloween",Y="2020"},
    {K="Ripper_G_2020",N="Ripper",R="Legendary",T="Gun",I="5866460591",E="Halloween",Y="2020"},
    {K="CandyCorn_K_2020",N="Candy Corn",R="Common",T="Knife",I="5866435364",E="Halloween",Y="2020"},
    {K="Carved_G_2020",N="Carved",R="Common",T="Gun",I="5866457985",E="Halloween",Y="2020"},
    {K="Eyes_G_2020",N="Watcher",R="Common",T="Gun",I="5866459380",E="Halloween",Y="2020"},
    {K="Portal_G_2020",N="Portal",R="Uncommon",T="Gun",I="5866461926",E="Halloween",Y="2020"},
    {K="Mummy_K_2020",N="Mummy",R="Uncommon",T="Knife",I="5866447521",E="Halloween",Y="2020"},
    {K="Ghosts_G_2020",N="Ghosts",R="Rare",T="Gun",I="5866465099",E="Halloween",Y="2020"},
    {K="Ripper_K_2020",N="Ripper",R="Legendary",T="Knife",I="5866441301",E="Halloween",Y="2020"},
    {K="Slashed_K_2020",N="Slashed",R="Common",T="Knife",I="5929317433",E="Halloween",Y="2020"},
    {K="Starry_G_2020",N="Starry",R="Common",T="Gun",I="5930731295",E="Halloween",Y="2020"},
    {K="Bats_K_2020",N="Bats",R="Common",T="Knife",I="5930729222",E="Halloween",Y="2020"},
    {K="VampiresEdge",N="Vampire\\'s Edge",R="Godly",T="Knife",I="5873256998",E="Halloween",Y="2020"},
    {K="Hallowscythe",N="Hallowscythe",R="Ancient",T="Knife",I="5877016863",E="Halloween",Y="2020"},
    {K="Hallowgun",N="Hallowgun",R="Godly",T="Gun",I="5877089721",E="Halloween",Y="2020"},
    {K="RBKnife",N="RB Knife",R="Common",T="Knife",I="5984754897"},
    {K="Peppermint",N="Peppermint",R="Godly",T="Knife",I="6076067750",E="Christmas",Y="2020"},
    {K="GoldVampiresEdge",N="Gold Vamp\\'s Edge",R="Unique",T="Knife",I="12253496571",E="Halloween",Y="2020"},
    {K="SilverVampiresEdge",N="Silver Vamp\\'s Edge",R="Unique",T="Knife",I="12253494893",E="Halloween",Y="2020"},
    {K="BronzeVampiresEdge",N="Bronze Vamp\\'s Edge",R="Unique",T="Knife",I="12253493272",E="Halloween",Y="2020"},
    {K="BlueVampiresEdge",N="Blue Vamp\\'s Edge",R="Unique",T="Knife",I="12253491988",E="Halloween",Y="2020"},
    {K="Icebreaker",N="Icebreaker",R="Ancient",T="Knife",I="6121572723",E="Christmas",Y="2020"},
    {K="Iceblaster",N="Iceblaster",R="Godly",T="Gun",I="6121579464",E="Christmas",Y="2020"},
    {K="Cookieblade",N="Cookieblade",R="Godly",T="Knife",I="6121574620",E="Christmas",Y="2020"},
    {K="Jinglegun",N="Jinglegun",R="Godly",T="Gun",I="6121678262",E="Christmas",Y="2020"},
    {K="Giftbag_K_2020",N="Gift Bag",R="Common",T="Knife",I="6121847170",E="Christmas",Y="2020"},
    {K="Icecracker_K_2020",N="Icecracker",R="Legendary",T="Knife",I="6121848805",E="Christmas",Y="2020"},
    {K="Gingerbread_K_2020",N="Gingerbread",R="Uncommon",T="Knife",I="6121850031",E="Christmas",Y="2020"},
    {K="SilentNight_K_2020",N="Silent Night",R="Rare",T="Knife",I="6121851313",E="Christmas",Y="2020"},
    {K="Ornaments_K_2020",N="Ornaments",R="Common",T="Knife",I="6121853160",E="Christmas",Y="2020"},
    {K="Ornaments_G_2020",N="Ornaments",R="Common",T="Gun",I="6121863515",E="Christmas",Y="2020"},
    {K="Gift_K_2020",N="Wrap",R="Uncommon",T="Knife",I="6121854816",E="Christmas",Y="2020"},
    {K="Gingerbread_G_2020",N="Gingerbread",R="Uncommon",T="Gun",I="6121860619",E="Christmas",Y="2020"},
    {K="SilentNight_G_2020",N="Silent Night",R="Rare",T="Gun",I="6121862034",E="Christmas",Y="2020"},
    {K="Giftbag_G_2020",N="Gift Bag",R="Common",T="Gun",I="6121864813",E="Christmas",Y="2020"},
    {K="Icedriller_G_2020",N="Icedriller",R="Legendary",T="Gun",I="6121866490",E="Christmas",Y="2020"},
    {K="SantasSpirit",N="Santa\\'s Spirit",R="Legendary",T="Knife",I="6123357775",E="Christmas",Y="2020"},
    {K="Stockings_K_2020",N="Stockings",R="Common",T="Knife",I="6123335682",E="Christmas",Y="2020"},
    {K="Trees_K_2020",N="Trees",R="Common",T="Knife",I="6123336879",E="Christmas",Y="2020"},
    {K="Gift_G_2020",N="Wrap",R="Uncommon",T="Gun",I="6121867603",E="Christmas",Y="2020"},
    {K="Snowflakes_K_2020",N="Snowflakes",R="Rare",T="Knife",I="6123338102",E="Christmas",Y="2020"},
    {K="Heartblade",N="Heartblade",R="Godly",T="Knife",I="6413214382"},
    {K="RedIcebreaker",N="Red Icebreaker",R="Unique",T="Knife",I="6404129111",E="Christmas",Y="2020"},
    {K="BronzeIcebreaker",N="Bronze Icebreaker",R="Unique",T="Knife",I="6404127119",E="Christmas",Y="2020"},
    {K="SilverIcebreaker",N="Silver Icebreaker",R="Unique",T="Knife",I="6404126280",E="Christmas",Y="2020"},
    {K="GoldIcebreaker",N="Gold Icebreaker",R="Unique",T="Knife",I="6404115112",E="Christmas",Y="2020"},
    {K="RedIceblaster",N="Red Iceblaster",R="Unique",T="Gun",I="6404168049",E="Christmas",Y="2020"},
    {K="BronzeIceblaster",N="Bronze Iceblaster",R="Unique",T="Gun",I="6404167442",E="Christmas",Y="2020"},
    {K="SilverIceblaster",N="Silver Iceblaster",R="Unique",T="Gun",I="6404166698",E="Christmas",Y="2020"},
    {K="GoldIceblaster",N="Gold Iceblaster",R="Unique",T="Gun",I="6404165933",E="Christmas",Y="2020"},
    {K="Eggblade",N="Eggblade",R="Godly",T="Knife",I="6607512359"},
    {K="SharkSeeker",N="SharkSeeker",R="Unique",T="Gun",I="6967771328",Y="2021"},
    {K="Nebula",N="Nebula",R="Godly",T="Knife",I="6598123521"},
    {K="Reaver",N="Reaver",R="Rare",T="Knife",I="7791484774",E="Halloween",Y="2021"},
    {K="Reaver_Legendary",N="Reaver",R="Legendary",T="Knife",I="7791485669",E="Halloween",Y="2021"},
    {K="Reaver_Godly",N="Reaver",R="Godly",T="Knife",I="7791511648",E="Halloween",Y="2021"},
    {K="Reaver_Ancient",N="Reaver",R="Ancient",T="Knife",I="7791640819",E="Halloween",Y="2021"},
    {K="Stickers_K_2021",N="Stickers",R="Common",T="Knife",I="7800229084",E="Halloween",Y="2021"},
    {K="Cracks_K_2021",N="Cracks",R="Common",T="Knife",I="7800224981",E="Halloween",Y="2021"},
    {K="Cat_G_2021",N="Cat",R="Common",T="Gun",I="7800253444",E="Halloween",Y="2021"},
    {K="Haunted_K_2021",N="Haunted",R="Common",T="Knife",I="7800222135",E="Halloween",Y="2021"},
    {K="FallCamo_G_2021",N="Fall Camo",R="Uncommon",T="Gun",I="7800257544",E="Halloween",Y="2021"},
    {K="Ghosts_G_2021",N="Wraiths",R="Uncommon",T="Gun",I="7800251557",E="Halloween",Y="2021"},
    {K="Ghosts_K_2021",N="Wraiths",R="Uncommon",T="Knife",I="7808362279",E="Halloween",Y="2021"},
    {K="Gothic_K_2021",N="Gothic",R="Uncommon",T="Knife",I="7800221141",E="Halloween",Y="2021"},
    {K="Watcher_K_2021",N="Watcher",R="Rare",T="Knife",I="7800227475",E="Halloween",Y="2021"},
    {K="Magma_K_2021",N="Magma",R="Rare",T="Knife",I="7800225996",E="Halloween",Y="2021"},
    {K="Spectral_G_2021",N="Spectral",R="Legendary",T="Gun",I="7800255531",E="Halloween",Y="2021"},
    {K="Moon_K_2021",N="Moon",R="Common",T="Knife",I="7800224197",E="Halloween",Y="2021"},
    {K="Cracks_G_2021",N="Cracks",R="Common",T="Gun",I="7800254737",E="Halloween",Y="2021"},
    {K="Stickers_G_2021",N="Stickers",R="Common",T="Gun",I="7800257010",E="Halloween",Y="2021"},
    {K="Aliens_G_2021",N="Aliens",R="Common",T="Gun",I="7800250906",E="Halloween",Y="2021"},
    {K="Gothic_G_2021",N="Gothic",R="Uncommon",T="Gun",I="7800253970",E="Halloween",Y="2021"},
    {K="Zombie_K_2021",N="Zombie",R="Uncommon",T="Knife",I="7800222975",E="Halloween",Y="2021"},
    {K="Skulls_K_2021",N="Skulls",R="Uncommon",T="Knife",I="7800220325",E="Halloween",Y="2021"},
    {K="Watcher_G_2021",N="Watcher",R="Rare",T="Gun",I="7800256309",E="Halloween",Y="2021"},
    {K="Magma_G_2021",N="Magma",R="Rare",T="Gun",I="7800252572",E="Halloween",Y="2021"},
    {K="Spectral_K_2021",N="Spectral",R="Legendary",T="Knife",I="7800226793",E="Halloween",Y="2021"},
    {K="Harvester",N="Harvester",R="Ancient",T="Gun",I="7800847534",E="Halloween",Y="2021"},
    {K="Candleflame",N="Candleflame",R="Godly",T="Knife",I="7805833970",E="Halloween",Y="2021"},
    {K="CandleflameChroma",N="Candleflame",R="Godly",T="Knife",I="7806149582",E="Halloween",Y="2021",C=true},
    {K="BlueHarvester",N="Blue Harvester",R="Unique",T="Gun",I="8194219645",E="Halloween",Y="2021"},
    {K="GoldHarvester",N="Gold Harvester",R="Unique",T="Gun",I="8194222523",E="Halloween",Y="2021"},
    {K="BronzeHarvester",N="Bronze Harvester",R="Unique",T="Gun",I="8194221072",E="Halloween",Y="2021"},
    {K="SilverHarvester",N="Silver Harvester",R="Unique",T="Gun",I="8194217388",E="Halloween",Y="2021"},
    {K="SwirlyAxe",N="Swirly Axe",R="Ancient",T="Knife",I="8304801000",E="Christmas",Y="2021"},
    {K="SwirlyAxeBlue",N="Blue Swirly",R="Unique",T="Knife",I="9552048857",E="Christmas",Y="2021"},
    {K="SwirlyAxeBronze",N="Bronze Swirly",R="Unique",T="Knife",I="9552050165",E="Christmas",Y="2021"},
    {K="SwirlyAxeSilver",N="Silver Swirly",R="Unique",T="Knife",I="9552051805",E="Christmas",Y="2021"},
    {K="SwirlyAxeGold",N="Gold Swirly",R="Unique",T="Knife",I="9552054920",E="Christmas",Y="2021"},
    {K="SwirlyGun",N="Swirly Gun",R="Godly",T="Gun",I="8305002569",E="Christmas",Y="2021"},
    {K="SwirlyGunBlue",N="Blue Swirly",R="Unique",T="Gun",I="9552060741",E="Christmas",Y="2021"},
    {K="SwirlyGunBronze",N="Bronze Swirly",R="Unique",T="Gun",I="9552063524",E="Christmas",Y="2021"},
    {K="SwirlyGunSilver",N="Silver Swirly",R="Unique",T="Gun",I="9552064240",E="Christmas",Y="2021"},
    {K="SwirlyGunGold",N="Gold Swirly",R="Unique",T="Gun",I="9552065167",E="Christmas",Y="2021"},
    {K="SwirlyGunChroma",N="Swirly Gun",R="Godly",T="Gun",I="8311453396",E="Christmas",Y="2021",C=true},
    {K="SwirlyBlade",N="Swirly Blade",R="Godly",T="Knife",I="8304805693",E="Christmas",Y="2021"},
    {K="Iceflake",N="Iceflake",R="Godly",T="Knife",I="8304818186",E="Christmas",Y="2021"},
    {K="Icebeam",N="Icebeam",R="Godly",T="Gun",I="8305000161",E="Christmas",Y="2021"},
    {K="Cane_K_2021",N="Cane",R="Common",T="Knife",I="8304750295",E="Christmas",Y="2021"},
    {K="Coal_K_2021",N="Coal",R="Common",T="Knife",I="8304751659",E="Christmas",Y="2021"},
    {K="Giftwrap_K_2021",N="Giftwrap",R="Common",T="Knife",I="8304754179",E="Christmas",Y="2021"},
    {K="Ribbons_K_2021",N="Ribbons",R="Common",T="Knife",I="8304754882",E="Christmas",Y="2021"},
    {K="XmasStickers_K_2021",N="Stickers",R="Common",T="Knife",I="8304755417",E="Christmas",Y="2021"},
    {K="Cookie_K_2021",N="Cookie",R="Uncommon",T="Knife",I="8304752586",E="Christmas",Y="2021"},
    {K="Snowman_K_2021",N="Snowman",R="Uncommon",T="Knife",I="8304753468",E="Christmas",Y="2021"},
    {K="Tree_K_2021",N="Tree",R="Uncommon",T="Knife",I="8304756423",E="Christmas",Y="2021"},
    {K="Swirl_K_2021",N="Swirl",R="Rare",T="Knife",I="8304757110",E="Christmas",Y="2021"},
    {K="Starry_K_2021",N="Starry",R="Rare",T="Knife",I="8304757707",E="Christmas",Y="2021"},
    {K="Aurora_K_2021",N="Aurora",R="Legendary",T="Knife",I="8304750877",E="Christmas",Y="2021"},
    {K="Coal_G_2021",N="Coal",R="Common",T="Gun",I="8304769409",E="Christmas",Y="2021"},
    {K="XmasStickers_G_2021",N="Stickers",R="Common",T="Gun",I="8304770115",E="Christmas",Y="2021"},
    {K="Cane_G_2021",N="Cane",R="Common",T="Gun",I="8304768700",E="Christmas",Y="2021"},
    {K="Snowman_G_2021",N="Snowman",R="Uncommon",T="Gun",I="8304766932",E="Christmas",Y="2021"},
    {K="Cookie_G_2021",N="Cookie",R="Uncommon",T="Gun",I="8304771148",E="Christmas",Y="2021"},
    {K="Gingerbread_G_2021",N="Gingerbread",R="Uncommon",T="Gun",I="8304772140",E="Christmas",Y="2021"},
    {K="IceCamo_G_2021",N="Ice Camo",R="Rare",T="Gun",I="8304767724",E="Christmas",Y="2021"},
    {K="Starry_G_2021",N="Starry",R="Rare",T="Gun",I="8304772774",E="Christmas",Y="2021"},
    {K="Aurora_G_2021",N="Aurora",R="Legendary",T="Gun",I="8304766165",E="Christmas",Y="2021"},
    {K="Dartbringer",N="Dartbringer",R="Unique",T="Gun",I="8626617523",Y="2021"},
    {K="Plasmablade",N="Plasmablade",R="Godly",T="Knife",I="10014680882"},
    {K="Plasmabeam",N="Plasmabeam",R="Godly",T="Gun",I="10014717343"},
    {K="GhostRbx_K_2022",N="Ghostly",R="Uncommon",T="Knife",I="11117375743",E="Halloween",Y="2022"},
    {K="Phantom2022",N="Phantom",R="Godly",T="Knife",I="11229732037",E="Halloween",Y="2022"},
    {K="Spectre2022",N="Spectre",R="Godly",T="Gun",I="11229779932",E="Halloween",Y="2022"},
    {K="CandyCorn_K_2022",N="Candy Corn",R="Common",T="Knife",I="11254057417",E="Halloween",Y="2022"},
    {K="Eyeball_K_2022",N="Eyeball",R="Common",T="Knife",I="11254065007",E="Halloween",Y="2022"},
    {K="Stickers_K_2022",N="Stickers",R="Common",T="Knife",I="11254067158",E="Halloween",Y="2022"},
    {K="Darkness_K_2022",N="Darkness",R="Common",T="Knife",I="11254081561",E="Halloween",Y="2022"},
    {K="Hazard_K_2022",N="Hazard",R="Uncommon",T="Knife",I="11254083234",E="Halloween",Y="2022"},
    {K="Jack_K_2022",N="Lantern",R="Uncommon",T="Knife",I="11254093910",E="Halloween",Y="2022"},
    {K="Witch_K_2022",N="Witchbrew",R="Uncommon",T="Knife",I="11254115609",E="Halloween",Y="2022"},
    {K="Wraith_K_2022",N="Wraith",R="Rare",T="Knife",I="11254118399",E="Halloween",Y="2022"},
    {K="Runic_K_2022",N="Curse",R="Rare",T="Knife",I="11254123390",E="Halloween",Y="2022"},
    {K="Vampire_K_2022",N="Vampire",R="Legendary",T="Knife",I="11254125546",E="Halloween",Y="2022"},
    {K="GreenCamo_K_2022",N="Zombie Camo",R="Common",T="Knife",I="11254145154",E="Halloween",Y="2022"},
    {K="BlueCamo_K_2022",N="Survivor Camo",R="Common",T="Knife",I="11254146743",E="Halloween",Y="2022"},
    {K="Bones_K_2022",N="Boney",R="Common",T="Knife",I="11254152435",E="Halloween",Y="2022"},
    {K="Hunter_K_2022",N="Hunter",R="Common",T="Knife",I="11254154978",E="Halloween",Y="2022"},
    {K="molten",N="TestItem",R="Common",T="Knife",I="11254158802",E="Halloween",Y="2022"},
    {K="Apoc_K_2022",N="Apocalypse",R="Common",T="Knife",I="11254172968",E="Halloween",Y="2022"},
    {K="Survivors_K_2022",N="Makeshift",R="Rare",T="Knife",I="11254180750",E="Halloween",Y="2022"},
    {K="Infected_K_2022",N="Infected",R="Common",T="Knife",I="11254175272",E="Halloween",Y="2022"},
    {K="Zombified_K_2022",N="Zombified",R="Rare",T="Knife",I="11254182560",E="Halloween",Y="2022"},
    {K="ElderwoodKnife",N="Elderwood Blade",R="Godly",T="Knife",I="11254879631",E="Halloween",Y="2022"},
    {K="ElderwoodKnifeChroma",N="Elderwood Blade",R="Godly",T="Knife",I="11255021976",E="Halloween",Y="2022",C=true},
    {K="ElderwoodKnifeBlue",N="Blue Elderwood",R="Unique",T="Knife",I="11505913287",E="Halloween",Y="2022"},
    {K="ElderwoodKnifeGold",N="Gold Elderwood",R="Unique",T="Knife",I="11505917850",E="Halloween",Y="2022"},
    {K="ElderwoodKnifeSilver",N="Silver Elderwood",R="Unique",T="Knife",I="11505916486",E="Halloween",Y="2022"},
    {K="ElderwoodKnifeBronze",N="Bronze Elderwood",R="Unique",T="Knife",I="11505914752",E="Halloween",Y="2022"},
    {K="Apoc_G_2022",N="Apocalypse",R="Common",T="Gun",I="11255501940",E="Halloween",Y="2022"},
    {K="CandyCorn_G_2022",N="Candy Corn",R="Common",T="Gun",I="11255558166",E="Halloween",Y="2022"},
    {K="Infected_G_2022",N="Infected",R="Common",T="Gun",I="11255502768",E="Halloween",Y="2022"},
    {K="Darkness_G_2022",N="Darkness",R="Common",T="Gun",I="11255507374",E="Halloween",Y="2022"},
    {K="Hazard_G_2022",N="Hazard",R="Uncommon",T="Gun",I="11255505449",E="Halloween",Y="2022"},
    {K="Wraith_G_2022",N="Wraith",R="Rare",T="Gun",I="11255504462",E="Halloween",Y="2022"},
    {K="Vampire_G_2022",N="Vampire",R="Legendary",T="Gun",I="11255503583",E="Halloween",Y="2022"},
    {K="Makeshift",N="Makeshift",R="Godly",T="Gun",I="11229837140",E="Halloween",Y="2022"},
    {K="ZombieBat",N="Bat",R="Godly",T="Knife",I="11229814357",E="Halloween",Y="2022"},
    {K="Ghostfire_G_2022",N="Ghostfire",R="Rare",T="Gun",I="11284140034",E="Halloween",Y="2022"},
    {K="Moonlight_G_2022",N="Moonlight",R="Uncommon",T="Gun",I="11284143055",E="Halloween",Y="2022"},
    {K="Brains_G_2022",N="Brains",R="Uncommon",T="Gun",I="11284145298",E="Halloween",Y="2022"},
    {K="Webs_G_2022",N="Webs",R="Common",T="Gun",I="11284147880",E="Halloween",Y="2022"},
    {K="VoidRbx",N="Void",R="Uncommon",T="Knife",I="11548082732"},
    {K="Candied_K_2022",N="Candied",R="Common",T="Knife",I="11834384755",E="Christmas",Y="2022"},
    {K="StickersX_K_2022",N="Stickers",R="Common",T="Knife",I="11834387858",E="Christmas",Y="2022"},
    {K="Coal_K_2022",N="Coal",R="Common",T="Knife",I="11834390120",E="Christmas",Y="2022"},
    {K="Snowman_K_2022",N="Snowman",R="Common",T="Knife",I="11834391469",E="Christmas",Y="2022"},
    {K="Snowflake_K_2022",N="Snowflake",R="Uncommon",T="Knife",I="11834397133",E="Christmas",Y="2022"},
    {K="Stockings_K_2022",N="Stockings",R="Uncommon",T="Knife",I="11834392930",E="Christmas",Y="2022"},
    {K="Mistletoe_K_2022",N="Mistletoe",R="Uncommon",T="Knife",I="11834394793",E="Christmas",Y="2022"},
    {K="Gingerbread_K_2022",N="Gingerbread",R="Rare",T="Knife",I="11834399071",E="Christmas",Y="2022"},
    {K="Tree_K_2022",N="Tree",R="Rare",T="Knife",I="11834400185",E="Christmas",Y="2022"},
    {K="Arctic_K_2022",N="Arctic",R="Legendary",T="Knife",I="11834401547",E="Christmas",Y="2022"},
    {K="Candied_G_2022",N="Candied",R="Common",T="Gun",I="11834435627",E="Christmas",Y="2022"},
    {K="StickersX_G_2022",N="Stickers",R="Common",T="Gun",I="11834432971",E="Christmas",Y="2022"},
    {K="Coal_G_2022",N="Coal",R="Common",T="Gun",I="11834434264",E="Christmas",Y="2022"},
    {K="Snowman_G_2022",N="Snowman",R="Common",T="Gun",I="11834436620",E="Christmas",Y="2022"},
    {K="Snowflake_G_2022",N="Snowflake",R="Uncommon",T="Gun",I="11834437796",E="Christmas",Y="2022"},
    {K="Stockings_G_2022",N="Stockings",R="Uncommon",T="Gun",I="11834440319",E="Christmas",Y="2022"},
    {K="Mistletoe_G_2022",N="Mistletoe",R="Uncommon",T="Gun",I="11834438982",E="Christmas",Y="2022"},
    {K="Gingerbread_G_2022",N="Gingerbread",R="Rare",T="Gun",I="11834442414",E="Christmas",Y="2022"},
    {K="Tree_G_2022",N="Tree",R="Rare",T="Gun",I="11834441321",E="Christmas",Y="2022"},
    {K="Arctic_G_2022",N="Arctic",R="Legendary",T="Gun",I="11834443783",E="Christmas",Y="2022"},
    {K="Wrapped_K_2022",N="Wrapped",R="Common",T="Knife",I="11834403282",E="Christmas",Y="2022"},
    {K="Frozen_K_2022",N="Frozen",R="Common",T="Knife",I="11834404402",E="Christmas",Y="2022"},
    {K="Frozen_G_2022",N="Frozen",R="Common",T="Gun",I="11834445016",E="Christmas",Y="2022"},
    {K="Gingermint_K",N="Cookiecane",R="Godly",T="Knife",I="11855306927",E="Christmas",Y="2022"},
    {K="Gingermint_KChroma",N="Cookiecane",R="Godly",T="Knife",I="11979596437",E="Christmas",Y="2022",C=true},
    {K="Gingermint_G",N="Gingermint",R="Godly",T="Gun",I="11872179646",E="Christmas",Y="2022"},
    {K="Icepiercer",N="Icepiercer",R="Ancient",T="Gun",I="11874071041",E="Christmas",Y="2022"},
    {K="IcepiercerBronze",N="Bronze Icepiercer",R="Unique",T="Gun",I="12226920195",E="Christmas",Y="2022"},
    {K="IcepiercerSilver",N="Silver Icepiercer",R="Unique",T="Gun",I="12226843957",E="Christmas",Y="2022"},
    {K="IcepiercerGold",N="Gold Icepiercer",R="Unique",T="Gun",I="12226688172",E="Christmas",Y="2022"},
    {K="IcepiercerRed",N="Red Icepiercer",R="Unique",T="Gun",I="12227133450",E="Christmas",Y="2022"},
    {K="IceHammer",N="Icecrusher",R="Rare",T="Knife",I="11855360152",E="Christmas",Y="2022"},
    {K="IceHammer_Legendary",N="Icecrusher",R="Legendary",T="Knife",I="11855361567",E="Christmas",Y="2022"},
    {K="IceHammer_Godly",N="Icecrusher",R="Godly",T="Knife",I="11855282546",E="Christmas",Y="2022"},
    {K="IceHammer_Ancient",N="Icecrusher",R="Ancient",T="Knife",I="11855274019",E="Christmas",Y="2022"},
    {K="IceHammerBronze",N="Bronze Icecrusher",R="Unique",T="Knife",I="12227148356",E="Christmas",Y="2022"},
    {K="IceHammerSilver",N="Silver Icecrusher",R="Unique",T="Knife",I="12227142478",E="Christmas",Y="2022"},
    {K="IceHammerGold",N="Gold Icecrusher",R="Unique",T="Knife",I="12227137860",E="Christmas",Y="2022"},
    {K="IceHammerRed",N="Red Icecrusher",R="Unique",T="Knife",I="12227186408",E="Christmas",Y="2022"},
    {K="Broken_K_2023",N="Broken",R="Legendary",T="Knife",I="12339323856"},
    {K="Rose_K_2023",N="Rose",R="Uncommon",T="Knife",I="12339325736"},
    {K="Heart_K_2023",N="Heart",R="Rare",T="Knife",I="12339327069"},
    {K="Love_K_2023",N="Love",R="Common",T="Knife",I="12339328595"},
    {K="Sakura_K",N="Sakura",R="Godly",T="Knife",I="12339366064"},
    {K="Blossom_G",N="Blossom",R="Godly",T="Gun",I="12339377105"},
    {K="Rainbow_K",N="Rainbow",R="Godly",T="Knife",I="12966184630"},
    {K="Rainbow_G",N="Rainbow Gun",R="Godly",T="Gun",I="12966354606"},
    {K="Fragile_K_2023",N="Fragile",R="Common",T="Knife",I="12965294432"},
    {K="Marble_K_2023",N="Marble",R="Uncommon",T="Knife",I="12965302237"},
    {K="Bio_K_2023",N="Bio",R="Rare",T="Knife",I="12965298174"},
    {K="Chromatic_K_2023",N="Chromatic",R="Legendary",T="Knife",I="12965304445"},
    {K="Carrot_K_2023",N="Carrot",R="Uncommon",T="Knife",I="12965307410"},
    {K="Painted_K_2023",N="Painted",R="Rare",T="Knife",I="12965311567"},
    {K="Fragile_G_2023",N="Fragile",R="Common",T="Gun",I="12965349193"},
    {K="Painted_G_2023",N="Painted",R="Uncommon",T="Gun",I="12965344675"},
    {K="Nuke_G_2023",N="Nuke",R="Rare",T="Gun",I="12965335931"},
    {K="Chromatic_G_2023",N="Chromatic",R="Legendary",T="Gun",I="12965339774"},
    {K="Toy_K_2023",N="Toy",R="Common",T="Knife",I="13944128440"},
    {K="Summer_Stickers_K_2023",N="Stickers",R="Common",T="Knife",I="13944129977"},
    {K="Popsicle_K_2023",N="Popsicle",R="Uncommon",T="Knife",I="13944131578"},
    {K="Noodle_K_2023",N="Pool Noodle",R="Uncommon",T="Knife",I="13944133313"},
    {K="Floral_K_2023",N="Floral",R="Rare",T="Knife",I="13944135218"},
    {K="Beach_K_2023",N="Beach",R="Legendary",T="Knife",I="13944136198"},
    {K="Summer_Stickers_G_2023",N="Stickers",R="Common",T="Gun",I="13944151909"},
    {K="Toy_G_2023",N="Toy",R="Common",T="Gun",I="13944153112"},
    {K="Melon_G_2023",N="Melon",R="Uncommon",T="Gun",I="13944154336"},
    {K="Sunset_G_2023",N="Sun",R="Rare",T="Gun",I="13944156090"},
    {K="Waves_K",N="Waves",R="Godly",T="Knife",I="13933066522"},
    {K="Ocean_G",N="Ocean",R="Godly",T="Gun",I="13933165014"},
    {K="RbxScary_K_2023",N="Ghoulish",R="Common",T="Knife",I="14967668214",E="Halloween",Y="2023"},
    {K="Skull_K_2023",N="Etched",R="Common",T="Knife",I="15091321393",E="Halloween",Y="2023"},
    {K="Vines_K_2023",N="Vines",R="Common",T="Knife",I="15091325210",E="Halloween",Y="2023"},
    {K="Ghosts_K_2023",N="Ghosts",R="Common",T="Knife",I="15091326116",E="Halloween",Y="2023"},
    {K="Pumpkin_G_2023",N="Pumpkin",R="Common",T="Gun",I="15091327743",E="Halloween",Y="2023"},
    {K="Zombie_K_2023",N="Zombie",R="Uncommon",T="Knife",I="15091339932",E="Halloween",Y="2023"},
    {K="Meltdown_K_2023",N="Meltdown",R="Uncommon",T="Knife",I="15091340751",E="Halloween",Y="2023"},
    {K="Steel_G_2023",N="Steel",R="Uncommon",T="Gun",I="15091341552",E="Halloween",Y="2023"},
    {K="Ghastly_G_2023",N="Ghastly",R="Rare",T="Gun",I="15091342564",E="Halloween",Y="2023"},
    {K="Dark_K_2023",N="Darkknife",R="Rare",T="Knife",I="15091343579",E="Halloween",Y="2023"},
    {K="Traveler_G_2023",N="Traveler",R="Legendary",T="Gun",I="15091344462",E="Halloween",Y="2023"},
    {K="Spider_K_2023",N="Spider",R="Common",T="Knife",I="15091399982",E="Halloween",Y="2023"},
    {K="Leaves_K_2023",N="Leaves",R="Common",T="Knife",I="15091400883",E="Halloween",Y="2023"},
    {K="Wood_K_2023",N="Wood",R="Common",T="Knife",I="15091401811",E="Halloween",Y="2023"},
    {K="Vines_G_2023",N="Vines",R="Common",T="Gun",I="15091402817",E="Halloween",Y="2023"},
    {K="Glowy_K_2023",N="Glowy",R="Uncommon",T="Knife",I="15091403551",E="Halloween",Y="2023"},
    {K="Eclipse_K_2023",N="Eclipse",R="Uncommon",T="Knife",I="15091404278",E="Halloween",Y="2023"},
    {K="Steel_K_2023",N="Steel",R="Uncommon",T="Knife",I="15091405483",E="Halloween",Y="2023"},
    {K="Dark_G_2023",N="Darkgun",R="Rare",T="Gun",I="15091406343",E="Halloween",Y="2023"},
    {K="Ghastly_K_2023",N="Ghastly",R="Rare",T="Knife",I="15091407068",E="Halloween",Y="2023"},
    {K="Traveler_K_2023",N="Traveler",R="Legendary",T="Knife",I="15091407901",E="Halloween",Y="2023"},
    {K="TravelerAxe",N="Traveler\\'s Axe",R="Ancient",T="Knife",I="15070870271",E="Halloween",Y="2023"},
    {K="TravelerAxeRed",N="Red Traveler\\'s",R="Unique",T="Knife",I="15695405379",E="Halloween",Y="2023"},
    {K="TravelerAxeBronze",N="Bronze Traveler\\'s",R="Unique",T="Knife",I="15695407020",E="Halloween",Y="2023"},
    {K="TravelerAxeSilver",N="Silver Traveler\\'s",R="Unique",T="Knife",I="15695407742",E="Halloween",Y="2023"},
    {K="TravelerAxeGold",N="Gold Traveler\\'s",R="Unique",T="Knife",I="15695408631",E="Halloween",Y="2023"},
    {K="TravelerGun",N="Traveler\\'s Gun",R="Godly",T="Gun",I="15091442039",E="Halloween",Y="2023"},
    {K="TravelerGunChroma",N="Traveler\\'s Gun",R="Godly",T="Gun",I="15097920149",E="Halloween",Y="2023",C=true},
    {K="Darksword",N="Darksword",R="Godly",T="Knife",I="15080267070",E="Halloween",Y="2023"},
    {K="Darkshot",N="Darkshot",R="Godly",T="Gun",I="15080280688",E="Halloween",Y="2023"},
    {K="Scarf_K_2023",N="Scarf",R="Common",T="Knife",I="15415482999"},
    {K="PumpkinPie_K_2023",N="Pumpkin Pie",R="Uncommon",T="Knife",I="15413117611"},
    {K="Latte_K_2023",N="Latte",R="Legendary",T="Knife",I="15413114703"},
    {K="Latte_G_2023",N="Latte",R="Legendary",T="Gun",I="15413116029"},
    {K="Turkey2023",N="Turkey",R="Godly",T="Knife",I="15413162319"},
    {K="Frozen_K_2023",N="Frozen",R="Common",T="Knife",I="15635556891",E="Christmas",Y="2023"},
    {K="Present_K_2023",N="Present",R="Common",T="Knife",I="15635553149",E="Christmas",Y="2023"},
    {K="Ribbon_K_2023",N="Ribbon",R="Common",T="Knife",I="15635552019",E="Christmas",Y="2023"},
    {K="Santa_G_2023",N="Santa",R="Common",T="Gun",I="15635550625",E="Christmas",Y="2023"},
    {K="Stars_K_2023",N="Stars",R="Uncommon",T="Knife",I="15635559978",E="Christmas",Y="2023"},
    {K="Canes_G_2023",N="Canes",R="Uncommon",T="Gun",I="15635558982",E="Christmas",Y="2023"},
    {K="Fireplace_K_2023",N="Fireplace",R="Uncommon",T="Knife",I="15635558021",E="Christmas",Y="2023"},
    {K="Tree_K_2023",N="Tree",R="Rare",T="Knife",I="15635563249",E="Christmas",Y="2023"},
    {K="Neon_G_2023",N="Neon",R="Rare",T="Gun",I="15635560825",E="Christmas",Y="2023"},
    {K="Frostfade_K_2023",N="Frostfade",R="Legendary",T="Knife",I="15635565488",E="Christmas",Y="2023"},
    {K="Frozen_G_2023",N="Frozen",R="Common",T="Gun",I="15635571468",E="Christmas",Y="2023"},
    {K="Bells_K_2023",N="Bells",R="Common",T="Knife",I="15635570486",E="Christmas",Y="2023"},
    {K="Elf_G_2023",N="Elf",R="Common",T="Gun",I="15635569893",E="Christmas",Y="2023"},
    {K="Snowfall_K_2023",N="Snowfall",R="Common",T="Knife",I="15635568751",E="Christmas",Y="2023"},
    {K="Canes_K_2023",N="Canes",R="Uncommon",T="Knife",I="15635574962",E="Christmas",Y="2023"},
    {K="Stars_G_2023",N="Stars",R="Uncommon",T="Gun",I="15635574031",E="Christmas",Y="2023"},
    {K="Snowman_G_2023",N="Snowman",R="Uncommon",T="Gun",I="15635572427",E="Christmas",Y="2023"},
    {K="Snowglobe_K_2023",N="Snowglobe",R="Rare",T="Knife",I="15635576863",E="Christmas",Y="2023"},
    {K="Snowflake_G_2023",N="Snowflake",R="Rare",T="Gun",I="15635575718",E="Christmas",Y="2023"},
    {K="Frostfade_G_2023",N="Frostfade",R="Legendary",T="Gun",I="15635577623",E="Christmas",Y="2023"},
    {K="Gingerscope",N="Gingerscope",R="Ancient",T="Gun",I="15666596216",E="Christmas",Y="2023"},
    {K="TreeGun2023",N="Evergun",R="Godly",T="Gun",I="15694357721",E="Christmas",Y="2023"},
    {K="TreeGun2023Chroma",N="Evergun",R="Godly",T="Gun",I="15694208971",E="Christmas",Y="2023",C=true},
    {K="TreeKnife2023",N="Evergreen",R="Godly",T="Knife",I="15694357137",E="Christmas",Y="2023"},
    {K="TreeKnife2023Chroma",N="Evergreen",R="Godly",T="Knife",I="15694192241",E="Christmas",Y="2023",C=true},
    {K="Gingerscythe",N="Gingerscythe",R="Rare",T="Knife",I="15683138101",E="Christmas",Y="2023"},
    {K="Gingerscythe_Legendary",N="Gingerscythe",R="Legendary",T="Knife",I="15683140564",E="Christmas",Y="2023"},
    {K="Gingerscythe_Godly",N="Gingerscythe",R="Godly",T="Knife",I="15683175970",E="Christmas",Y="2023"},
    {K="Gingerscythe_Ancient",N="Gingerscythe",R="Ancient",T="Knife",I="15683188776",E="Christmas",Y="2023"},
    {K="Wavy_K_2024",N="Wavy",R="Common",T="Knife",I="250"},
    {K="Carrot_K_2024",N="Carrot",R="Uncommon",T="Knife",I="250"},
    {K="Spring_K_2024",N="Spring",R="Rare",T="Knife",I="250"},
    {K="Robot_K_2024",N="Robot",R="Rare",T="Knife",I="250"},
    {K="Wavy_G_2024",N="Wavy",R="Common",T="Gun",I="250"},
    {K="Carrot_G_2024",N="Carrot",R="Uncommon",T="Gun",I="250"},
    {K="FlowerwoodKnife",N="Flowerwood",R="Godly",T="Knife",I="250"},
    {K="FlowerwoodGun",N="Flowerwood Gun",R="Godly",T="Gun",I="250"},
    {K="Gingerscythe_Blue",N="Blue Gingerscythe",R="Unique",T="Knife",I="250",E="Christmas",Y="2023"},
    {K="Gingerscythe_Bronze",N="Bronze Gingerscythe",R="Unique",T="Knife",I="250",E="Christmas",Y="2023"},
    {K="Gingerscythe_Silver",N="Silver Gingerscythe",R="Unique",T="Knife",I="250",E="Christmas",Y="2023"},
    {K="Gingerscythe_Gold",N="Gold Gingerscythe",R="Unique",T="Knife",I="250",E="Christmas",Y="2023"},
    {K="Gingerscope_Blue",N="Blue Gingerscope",R="Unique",T="Gun",I="250",E="Christmas",Y="2023"},
    {K="Gingerscope_Bronze",N="Bronze Gingerscope",R="Unique",T="Gun",I="250",E="Christmas",Y="2023"},
    {K="Gingerscope_Silver",N="Silver Gingerscope",R="Unique",T="Gun",I="250",E="Christmas",Y="2023"},
    {K="Gingerscope_Gold",N="Gold Gingerscope",R="Unique",T="Gun",I="250",E="Christmas",Y="2023"},
    {K="Starfish_K_2024",N="Starfish",R="Common",T="Knife",I="250"},
    {K="WaterBalloons_G_2024",N="Balloons",R="Common",T="Gun",I="250"},
    {K="Clownfish_G_2024",N="Clownfish",R="Common",T="Gun",I="250"},
    {K="Sandy_G_2024",N="Sandy",R="Common",T="Gun",I="250"},
    {K="Turtle_K_2024",N="Turtle",R="Uncommon",T="Knife",I="250"},
    {K="Popsicle_G_2024",N="Popsicle",R="Uncommon",T="Gun",I="250"},
    {K="Jellyfish_K_2024",N="Jellyfish",R="Uncommon",T="Knife",I="250"},
    {K="Waves_K_2024",N="Waves",R="Rare",T="Knife",I="250"},
    {K="Floral_G_2024",N="Floral",R="Rare",T="Gun",I="250"},
    {K="Palms_K_2024",N="Palms",R="Legendary",T="Knife",I="250"},
    {K="Starfish_G_2024",N="Starfish",R="Common",T="Gun",I="250"},
    {K="Clownfish_K_2024",N="Clownfish",R="Common",T="Knife",I="250"},
    {K="Floatie_G_2024",N="Floatie",R="Uncommon",T="Gun",I="250"},
    {K="Sharky_K_2024",N="Sharky",R="Rare",T="Knife",I="250"},
    {K="Palms_G_2024",N="Palms",R="Legendary",T="Gun",I="250"},
    {K="Pearl_K",N="Pearl",R="Godly",T="Knife",I="250"},
    {K="Pearl_G",N="Pearlshine",R="Godly",T="Gun",I="250"},
    {K="Watergun",N="Watergun",R="Godly",T="Gun",I="250"},
    {K="WatergunChroma",N="Watergun",R="Godly",T="Gun",I="18351465514",C=true},
    {K="CandyCorn_G_2024",N="Candy Corn",R="Common",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="Ghosts_K_2024",N="Ghosts",R="Common",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Stickers_G_2024",N="Stickers",R="Common",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="Bats_K_2024",N="Bats",R="Common",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Bones_K_2024",N="Bones",R="Uncommon",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="WitchBrew_K_2024",N="Witch\\'s Brew",R="Uncommon",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Leaves_G_2024",N="Leaves",R="Uncommon",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="Kraken_K_2024",N="Kraken",R="Rare",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Ritual_G_2024",N="Ritual",R="Rare",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="Cursed_G_2024",N="Cursed",R="Legendary",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="CandyCorn_K_2024",N="Candy Corn",R="Common",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Bats_G_2024",N="Bats",R="Common",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="Stickers_K_2024",N="Stickers",R="Common",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Candles_K_2024",N="Candles",R="Common",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Monster_K_2024",N="Monster",R="Uncommon",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Moons_K_2024",N="Moons",R="Uncommon",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Clown_G_2024",N="Clown",R="Uncommon",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="Storm_K_2024",N="Storm",R="Rare",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="Candleflame_G_2024",N="Candleflame",R="Rare",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="Cursed_K_2024",N="Cursed",R="Legendary",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="WraithKnife",N="Spirit",R="Godly",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="WraithGun",N="Soul",R="Godly",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="VampireAxe",N="Vampire\\'s Axe",R="Ancient",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="VampireAxe_Purple",N="Vampire\\'s Axe",R="Unique",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="VampireAxe_Bronze",N="Vampire\\'s Axe",R="Unique",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="VampireAxe_Silver",N="Vampire\\'s Axe",R="Unique",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="VampireAxe_Gold",N="Vampire\\'s Axe",R="Unique",T="Knife",I="250",E="Halloween",Y="2024"},
    {K="VampireGun",N="Vampire\\'s Gun",R="Godly",T="Gun",I="250",E="Halloween",Y="2024"},
    {K="VampireGunChroma",N="Vampire\\'s Gun",R="Godly",T="Gun",I="250",E="Halloween",Y="2024",C=true},
    {K="Constellation",N="Constellation",R="Godly",T="Gun",I="114197436469014",E="Christmas",Y="2024"},
    {K="ConstellationChroma",N="Constellation",R="Godly",T="Gun",I="98517109155878",E="Christmas",Y="2024",C=true},
    {K="Celestial",N="Celestial",R="Ancient",T="Knife",I="136673966529736",E="Christmas",Y="2024"},
    {K="Constellation_Red",N="Red Constellation",R="Unique",T="Gun",I="85766514163212",E="Christmas",Y="2024"},
    {K="Constellation_Bronze",N="Bronze Constellation",R="Unique",T="Gun",I="112811587103866",E="Christmas",Y="2024"},
    {K="Constellation_Silver",N="Silver Constellation",R="Unique",T="Gun",I="100747436297625",E="Christmas",Y="2024"},
    {K="Constellation_Gold",N="Gold Constellation",R="Unique",T="Gun",I="132975248521820",E="Christmas",Y="2024"},
    {K="Celestial_Red",N="Red Celestial",R="Unique",T="Knife",I="119157529694972",E="Christmas",Y="2024"},
    {K="Celestial_Bronze",N="Bronze Celestial",R="Unique",T="Knife",I="119399643874968",E="Christmas",Y="2024"},
    {K="Celestial_Silver",N="Silver Celestial",R="Unique",T="Knife",I="90241292303974",E="Christmas",Y="2024"},
    {K="Celestial_Gold",N="Gold Celestial",R="Unique",T="Knife",I="104229967982042",E="Christmas",Y="2024"},
    {K="AuroraKnife",N="Australis",R="Godly",T="Knife",I="101343256002049",E="Christmas",Y="2024"},
    {K="AuroraGun",N="Borealis",R="Godly",T="Gun",I="108635848059846",E="Christmas",Y="2024"},
    {K="Bauble",N="Bauble",R="Godly",T="Gun",I="84481559639371",E="Christmas",Y="2024"},
    {K="BaubleChroma",N="Bauble",R="Godly",T="Gun",I="137938731902685",E="Christmas",Y="2024",C=true},
    {K="HotChocolate_K_2024",N="Hot Chocolate",R="Common",T="Knife",I="133307062463653",E="Christmas",Y="2024"},
    {K="Gifts_K_2024",N="Gifts",R="Common",T="Knife",I="129290011017110",E="Christmas",Y="2024"},
    {K="Igloo_G_2024",N="Igloo",R="Common",T="Gun",I="95517099886712",E="Christmas",Y="2024"},
    {K="Stickers_X_K_2024",N="Stickers",R="Common",T="Knife",I="83843575465564",E="Christmas",Y="2024"},
    {K="Gingerheart_K_2024",N="Gingerheart",R="Uncommon",T="Knife",I="115273559455814",E="Christmas",Y="2024"},
    {K="Wrapped_G_2024",N="Wrapped",R="Uncommon",T="Gun",I="109929760056853",E="Christmas",Y="2024"},
    {K="Logcutter_K_2024",N="Logcutter",R="Rare",T="Knife",I="71088901904009",E="Christmas",Y="2024"},
    {K="Frostflame_K_2024",N="Frostflame",R="Rare",T="Knife",I="104988218477551",E="Christmas",Y="2024"},
    {K="Constellation_G_2024",N="Nightsky",R="Legendary",T="Gun",I="94311965719769",E="Christmas",Y="2024"},
    {K="Reindeer_K_2024",N="Reindeer",R="Common",T="Knife",I="109101361674956",E="Christmas",Y="2024"},
    {K="Stockings_G_2024",N="Stockings",R="Common",T="Gun",I="76288270695961",E="Christmas",Y="2024"},
    {K="Igloo_K_2024",N="Igloo",R="Common",T="Knife",I="73203940450745",E="Christmas",Y="2024"},
    {K="Stickers_X_G_2024",N="Stickers",R="Common",T="Gun",I="91224254479440",E="Christmas",Y="2024"},
    {K="Wrapped_K_2024",N="Wrapped",R="Uncommon",T="Knife",I="72638846676083",E="Christmas",Y="2024"},
    {K="Snowman_K_2024",N="Snowman",R="Uncommon",T="Knife",I="85751270338066",E="Christmas",Y="2024"},
    {K="Wreaths_K_2024",N="Wreaths",R="Uncommon",T="Knife",I="78432760615312",E="Christmas",Y="2024"},
    {K="Frostflame_G_2024",N="Frostflame",R="Rare",T="Gun",I="114781759936576",E="Christmas",Y="2024"},
    {K="Sleigh_K_2024",N="Sleigh",R="Rare",T="Knife",I="74917318027165",E="Christmas",Y="2024"},
    {K="Constellation_K_2024",N="Nightstar",R="Legendary",T="Knife",I="113979322866878",E="Christmas",Y="2024"},
    {K="Forest_G_2024",N="Forest",R="Uncommon",T="Gun",I="78199422065424",E="Christmas",Y="2024"},
    {K="Decorated_K_2025",N="Decorated",R="Uncommon",T="Knife",I="124860763249593"},
    {K="Carrots_K_2025",N="Carrots",R="Common",T="Knife",I="76914260444878"},
    {K="Chick_K_2025",N="Chick",R="Common",T="Knife",I="116361515042274"},
    {K="Bunnies_K_2025",N="Bunnies",R="Legendary",T="Knife",I="90549252812333"},
    {K="Sunny_G_2025",N="Sunny",R="Rare",T="Gun",I="93906279038399"},
    {K="Meadow_G_2025",N="Meadow",R="Uncommon",T="Gun",I="107321881182350"},
    {K="Butterflies_G_2025",N="Butterflies",R="Rare",T="Gun",I="135662872427976"},
    {K="Bloom",N="Bloom",R="Godly",T="Knife",I="132419834610569"},
    {K="Flora",N="Flora",R="Godly",T="Gun",I="139276091458016"},
    {K="Leaves_K_2025",N="Leaves",R="Common",T="Knife",I="73486056426142",E="Summer",Y="2025"},
    {K="Coconut_K_2025",N="Coconut",R="Common",T="Knife",I="75237025203058",E="Summer",Y="2025"},
    {K="Stickers_K_2025",N="Stickers",R="Common",T="Knife",I="98868784444742",E="Summer",Y="2025"},
    {K="Striped_G_2025",N="Striped",R="Common",T="Gun",I="118530164125152",E="Summer",Y="2025"},
    {K="Pool_K_2025",N="Pool",R="Uncommon",T="Knife",I="112511843095202",E="Summer",Y="2025"},
    {K="Soda_G_2025",N="Soda",R="Uncommon",T="Gun",I="132525981806780",E="Summer",Y="2025"},
    {K="Lava_K_2025",N="Lava",R="Uncommon",T="Knife",I="131417913843701",E="Summer",Y="2025"},
    {K="PopArt_K_2025",N="Pop Art",R="Rare",T="Knife",I="123269723073737",E="Summer",Y="2025"},
    {K="Tropical_K_2025",N="Tropical",R="Rare",T="Knife",I="111291962899457",E="Summer",Y="2025"},
    {K="Aquarium_G_2025",N="Aquarium",R="Legendary",T="Gun",I="129460052425837",E="Summer",Y="2025"},
    {K="Striped_K_2025",N="Striped",R="Common",T="Knife",I="136747578920542",E="Summer",Y="2025"},
    {K="Stickers_G_2025",N="Stickers",R="Common",T="Gun",I="75123474631661",E="Summer",Y="2025"},
    {K="Dolphins_K_2025",N="Dolphins",R="Common",T="Knife",I="133219566412887",E="Summer",Y="2025"},
    {K="Skyline_K_2025",N="Skyline",R="Common",T="Knife",I="75608370390005",E="Summer",Y="2025"},
    {K="Soda_K_2025",N="Soda",R="Uncommon",T="Knife",I="89899263078420",E="Summer",Y="2025"},
    {K="Retro_K_2025",N="Retro",R="Uncommon",T="Knife",I="85299848190695",E="Summer",Y="2025"},
    {K="Lava_G_2025",N="Lava",R="Uncommon",T="Gun",I="90170220549489",E="Summer",Y="2025"},
    {K="Neon_G_2025",N="Neon",R="Rare",T="Gun",I="134429631587448",E="Summer",Y="2025"},
    {K="PopArt_G_2025",N="Pop Art",R="Rare",T="Gun",I="90526048501163",E="Summer",Y="2025"},
    {K="Aquarium_K_2025",N="Aquarium",R="Legendary",T="Knife",I="80900354672590",E="Summer",Y="2025"},
    {K="Synthwave",N="Synthwave",R="Rare",T="Knife",I="84935740002917",E="Summer",Y="2025"},
    {K="Synthwave_Legendary",N="Synthwave",R="Legendary",T="Knife",I="132040985617451",E="Summer",Y="2025"},
    {K="Synthwave_Godly",N="Synthwave",R="Godly",T="Knife",I="116075729415230",E="Summer",Y="2025"},
    {K="Synthwave_Ancient",N="Synthwave",R="Ancient",T="Knife",I="133828016595037",E="Summer",Y="2025"},
    {K="SunsetKnife",N="Sunset",R="Godly",T="Knife",I="103526268515240",E="Summer",Y="2025"},
    {K="SunsetGun",N="Sunrise",R="Godly",T="Gun",I="129480661108374",E="Summer",Y="2025"},
    {K="SunsetKnifeChroma",N="Sunset",R="Godly",T="Knife",I="118232478609755",E="Summer",Y="2025",C=true},
    {K="SunsetGunChroma",N="Sunrise",R="Godly",T="Gun",I="124766755976937",E="Summer",Y="2025",C=true},
    {K="Synthwave_Blue",N="Blue Synthwave",R="Unique",T="Knife",I="250",E="Summer",Y="2025"},
    {K="Synthwave_Bronze",N="Bronze Synthwave",R="Unique",T="Knife",I="250",E="Summer",Y="2025"},
    {K="Synthwave_Silver",N="Silver Synthwave",R="Unique",T="Knife",I="250",E="Summer",Y="2025"},
    {K="Synthwave_Gold",N="Gold Synthwave",R="Unique",T="Knife",I="250",E="Summer",Y="2025"},
    {K="UFOs_K_2025",N="UFOs",R="Common",T="Knife",I="97641024072972",E="Halloween",Y="2025"},
    {K="CandyCorn_G_2025",N="Candy Corn",R="Common",T="Gun",I="129781304866793",E="Halloween",Y="2025"},
    {K="HauntedHouse_K_2025",N="Haunted",R="Common",T="Knife",I="90194465176219",E="Halloween",Y="2025"},
    {K="Bats_K_2025",N="Cats",R="Common",T="Knife",I="140366567839959",E="Halloween",Y="2025"},
    {K="PumpkinPatch_K_2025",N="Pumpkin",R="Uncommon",T="Knife",I="119626042140839",E="Halloween",Y="2025"},
    {K="Treats_G_2025",N="Treats",R="Uncommon",T="Gun",I="76537883908961",E="Halloween",Y="2025"},
    {K="Eyes_G_2025",N="Eyes",R="Uncommon",T="Gun",I="90751163516480",E="Halloween",Y="2025"},
    {K="Hologram_G_2025",N="Hologram",R="Rare",T="Gun",I="108751717527377",E="Halloween",Y="2025"},
    {K="Xeno_K_2025",N="Xeno",R="Rare",T="Knife",I="80492487454400",E="Halloween",Y="2025"},
    {K="Energized_G_2025",N="Energized",R="Legendary",T="Gun",I="114403390530326",E="Halloween",Y="2025"},
    {K="StickersH_K_2025",N="Stickers",R="Common",T="Knife",I="100461386281007",E="Halloween",Y="2025"},
    {K="UFOs_G_2025",N="UFOs",R="Common",T="Gun",I="84030107970606",E="Halloween",Y="2025"},
    {K="Fall_G_2025",N="Fall",R="Common",T="Gun",I="78153346812503",E="Halloween",Y="2025"},
    {K="CandyCorn_K_2025",N="Candy Corn",R="Common",T="Knife",I="86405207895194",E="Halloween",Y="2025"},
    {K="Abduction_K_2025",N="Abduction",R="Uncommon",T="Knife",I="107510647616718",E="Halloween",Y="2025"},
    {K="PumpkinPatch_G_2025",N="Pumpkin Patch",R="Uncommon",T="Gun",I="117088166092009",E="Halloween",Y="2025"},
    {K="Treats_K_2025",N="Treats",R="Uncommon",T="Knife",I="115298865715727",E="Halloween",Y="2025"},
    {K="Hologram_K_2025",N="Hologram",R="Rare",T="Knife",I="77773918675860",E="Halloween",Y="2025"},
    {K="Xeno_G_2025",N="Xeno",R="Rare",T="Gun",I="139755862211442",E="Halloween",Y="2025"},
    {K="Energized_K_2025",N="Energized",R="Legendary",T="Knife",I="86258299490709",E="Halloween",Y="2025"},
    {K="XenoKnife",N="Xenoknife",R="Godly",T="Knife",I="115021756767182",E="Halloween",Y="2025"},
    {K="XenoGun",N="Xenoshot",R="Godly",T="Gun",I="96859273002742",E="Halloween",Y="2025"},
    {K="UFOKnife",N="Alienbeam",R="Godly",T="Knife",I="77607127867154",E="Halloween",Y="2025"},
    {K="UFOKnifeChroma",N="Alienbeam",R="Godly",T="Knife",I="104256106059730",E="Halloween",Y="2025",C=true},
    {K="Raygun",N="Raygun",R="Godly",T="Gun",I="139431943195380",E="Halloween",Y="2025"},
    {K="RaygunRed",N="Red Raygun",R="Unique",T="Gun",I="132354489228618",E="Halloween",Y="2025"},
    {K="RaygunBronze",N="Bronze Raygun",R="Unique",T="Gun",I="138881346504998",E="Halloween",Y="2025"},
    {K="RaygunSilver",N="Silver Raygun",R="Unique",T="Gun",I="71511736314707",E="Halloween",Y="2025"},
    {K="RaygunGold",N="Gold Raygun",R="Unique",T="Gun",I="76250851065456",E="Halloween",Y="2025"},
    {K="RaygunChroma",N="Raygun",R="Godly",T="Gun",I="83259634072260",E="Halloween",Y="2025",C=true},
    {K="StickersT2025",N="Stickers",R="Common",T="Knife",I="115280072896190",Y="2025"},
    {K="StickersX25",N="Stickers",R="Common",T="Knife",I="115280072896190",Y="2025"},
    {K="SnowDagger",N="Snow Dagger",R="Godly",T="Knife",I="95328449981238",E="Christmas",Y="2025"},
    {K="SnowDaggerChroma",N="Snow Dagger",R="Godly",T="Knife",I="128749805685925",E="Christmas",Y="2025",C=true},
    {K="SnowDaggerRed",N="Red Snow Dagger",R="Unique",T="Knife",I="87617250559234",E="Christmas",Y="2025"},
    {K="SnowDaggerBronze",N="Bronze Snow Dagger",R="Unique",T="Knife",I="134312132943601",E="Christmas",Y="2025"},
    {K="SnowDaggerSilver",N="Silver Snow Dagger",R="Unique",T="Knife",I="128427983277729",E="Christmas",Y="2025"},
    {K="SnowDaggerGold",N="Gold Snow Dagger",R="Unique",T="Knife",I="70701057041846",E="Christmas",Y="2025"},
    {K="Snowcannon",N="Snowcannon",R="Godly",T="Gun",I="129186939023729",E="Christmas",Y="2025"},
    {K="SnowcannonChroma",N="Snowcannon",R="Godly",T="Gun",I="110767110638211",E="Christmas",Y="2025",C=true},
    {K="SnowcannonRed",N="Red Snowcannon",R="Unique",T="Gun",I="110812086479763",E="Christmas",Y="2025"},
    {K="SnowcannonBronze",N="Bronze Snowcannon",R="Unique",T="Gun",I="84743767811732",E="Christmas",Y="2025"},
    {K="SnowcannonSilver",N="Silver Snowcannon",R="Unique",T="Gun",I="83838802472095",E="Christmas",Y="2025"},
    {K="SnowcannonGold",N="Gold Snowcannon",R="Unique",T="Gun",I="115609046800090",E="Christmas",Y="2025"},
    {K="Snowstorm",N="Snowstorm",R="Godly",T="Knife",I="70973050894155",E="Christmas",Y="2025"},
    {K="SnowstormChroma",N="Snowstorm",R="Godly",T="Knife",I="94202294092932",E="Christmas",Y="2025",C=true},
    {K="Blizzard",N="Blizzard",R="Godly",T="Gun",I="88928894807422",E="Christmas",Y="2025"},
    {K="BlizzardChroma",N="Blizzard",R="Godly",T="Gun",I="139495852635932",E="Christmas",Y="2025",C=true},
    {K="BaubleKnife",N="Ornament",R="Godly",T="Knife",I="111092946728824",E="Christmas",Y="2025"},
    {K="BaubleKnifeChroma",N="Ornament",R="Godly",T="Knife",I="74528014775455",E="Christmas",Y="2025",C=true},
    {K="StickersX_K_2025",N="Stickers",R="Common",T="Knife",I="102283625659356",E="Christmas",Y="2025"},
    {K="Snowball_G_2025",N="Snowball",R="Common",T="Gun",I="104416405402940",E="Christmas",Y="2025"},
    {K="Lights_K_2025",N="Lights",R="Common",T="Knife",I="71228862432065",E="Christmas",Y="2025"},
    {K="Peppermint_G_2025",N="Peppermint",R="Common",T="Gun",I="73148873488539",E="Christmas",Y="2025"},
    {K="Sweater_K_2025",N="Sweater",R="Uncommon",T="Knife",I="102130993592804",E="Christmas",Y="2025"},
    {K="Gingerbread_G_2025",N="Gingerbread",R="Uncommon",T="Gun",I="74908113882525",E="Christmas",Y="2025"},
    {K="PolarBear_K_2025",N="Polar Bear",R="Uncommon",T="Knife",I="120422092957504",E="Christmas",Y="2025"},
    {K="Spearmint_G_2025",N="Spearmint",R="Rare",T="Gun",I="81352860339620",E="Christmas",Y="2025"},
    {K="Gingercookie_K_2025",N="Gingercookie",R="Rare",T="Knife",I="111408683823094",E="Christmas",Y="2025"},
    {K="Frozen_G_2025",N="Frozen",R="Legendary",T="Gun",I="90622014285727",E="Christmas",Y="2025"},
    {K="StickersX_G_2025",N="Stickers",R="Common",T="Gun",I="127489830827583",E="Christmas",Y="2025"},
    {K="Peppermint_K_2025",N="Peppermint",R="Common",T="Knife",I="84605926178412",E="Christmas",Y="2025"},
    {K="Snowball_K_2025",N="Snowball",R="Common",T="Knife",I="119914093248842",E="Christmas",Y="2025"},
    {K="Lights_G_2025",N="Lights",R="Common",T="Gun",I="104258636970738",E="Christmas",Y="2025"},
    {K="Penguin_K_2025",N="Penguin",R="Common",T="Knife",I="93320180084418",E="Christmas",Y="2025"},
    {K="Sweater_G_2025",N="Sweater",R="Uncommon",T="Gun",I="118557229750245",E="Christmas",Y="2025"},
    {K="Ornaments_K_2025",N="Ornaments",R="Uncommon",T="Knife",I="132504094164819",E="Christmas",Y="2025"},
    {K="Gingerbread_K_2025",N="Gingerbread",R="Uncommon",T="Knife",I="134478959354477",E="Christmas",Y="2025"},
    {K="Gingercookie_G_2025",N="Gingercookie",R="Rare",T="Gun",I="99160839686845",E="Christmas",Y="2025"},
    {K="Spearmint_K_2025",N="Spearmint",R="Rare",T="Knife",I="98506456649552",E="Christmas",Y="2025"},
    {K="Frozen_K_2025",N="Frozen",R="Legendary",T="Knife",I="108996627787763",E="Christmas",Y="2025"},
    {K="Reindeer_K_2025",N="Reindeer",R="Common",T="Knife",I="122078592955794",E="Christmas",Y="2025"},
    {K="Strawberries_K_2026",N="Strawberries",R="Common",T="Knife",I="73897192147749",E="Valentines",Y="2026"},
    {K="Hearts_K_2026",N="Hearts",R="Common",T="Knife",I="99939659856909",E="Valentines",Y="2026"},
    {K="Strawberries_G_2026",N="Strawberries",R="Common",T="Gun",I="128646835922561",E="Valentines",Y="2026"},
    {K="Plaid_G_2026",N="Plaid",R="Common",T="Gun",I="121681210724670",E="Valentines",Y="2026"},
    {K="Starry_K_2026",N="Starry",R="Uncommon",T="Knife",I="130537925107449",E="Valentines",Y="2026"},
    {K="Blossom_K_2026",N="Blossom",R="Uncommon",T="Knife",I="110160120309916",E="Valentines",Y="2026"},
    {K="Paws_G_2026",N="Paws",R="Uncommon",T="Gun",I="120089556380493",E="Valentines",Y="2026"},
    {K="Heartbreak_G_2026",N="Heartbreak",R="Rare",T="Gun",I="79235438948261",E="Valentines",Y="2026"},
    {K="Sweet_K_2026",N="Yummy",R="Rare",T="Knife",I="113677688954146",E="Valentines",Y="2026"},
    {K="Cupid_K_2026",N="Cupid",R="Legendary",T="Knife",I="123955324398353",E="Valentines",Y="2026"},
    {K="HeartWand",N="Heart Wand",R="Godly",T="Knife",I="118334707962654",E="Valentines",Y="2026"},
    {K="HeartWandChroma",N="Heart Wand",R="Godly",T="Knife",I="99154743764163",E="Valentines",Y="2026",C=true},
    {K="Sweet",N="Sweet",R="Godly",T="Knife",I="126937716954396",E="Valentines",Y="2026"},
    {K="SweetChroma",N="Sweet",R="Godly",T="Knife",I="90923771881248",E="Valentines",Y="2026",C=true},
    {K="Treat",N="Treat",R="Godly",T="Gun",I="131626924640663",E="Valentines",Y="2026"},
    {K="TreatChroma",N="Treat",R="Godly",T="Gun",I="98449489175264",E="Valentines",Y="2026",C=true},
}

local itemsBySystemName = {}
local itemsByVisualName = {}
local itemsByImageId = {}

local function normalizeAssetId(image)
    image = tostring(image or "")

    return string.match(image, "rbxassetid://(%d+)")
        or string.match(image, "[?&]id=(%d+)")
        or string.match(image, "assetId=(%d+)")
        or string.match(image, "(%d+)")
end

local function normalizeLookupKey(value)
    return string.lower(
        tostring(value or "")
            :gsub("^%s+", "")
            :gsub("%s+$", "")
    )
end

local function addDatabaseIndex(index, key, entry)
    if key == nil or key == "" then
        return
    end

    index[key] = index[key] or {}
    table.insert(index[key], entry)
end

for _, compactData in ipairs(EMBEDDED_ITEM_DATABASE) do
    local data = {
        ItemName = compactData.N,
        Rarity = compactData.R,
        ItemType = compactData.T,
        ImageId = compactData.I,
        Event = compactData.E,
        Year = compactData.Y,
        Chroma = compactData.C == true
    }

    local entry = {
        Key = compactData.K,
        Data = data
    }

    itemsBySystemName[normalizeLookupKey(compactData.K)] = entry

    addDatabaseIndex(
        itemsByVisualName,
        normalizeLookupKey(compactData.N),
        entry
    )

    addDatabaseIndex(
        itemsByImageId,
        compactData.I,
        entry
    )
end

local function chooseDatabaseEntry(candidates, imageId)
    if not candidates or #candidates == 0 then
        return nil
    end

    if imageId then
        for _, entry in ipairs(candidates) do
            if tostring(entry.Data.ImageId or "") == tostring(imageId) then
                return entry
            end
        end
    end

    for _, entry in ipairs(candidates) do
        if entry.Data.Chroma ~= true then
            return entry
        end
    end

    return candidates[1]
end

local function findItemInDatabase(systemName, visualName, iconImage)
    local imageId = normalizeAssetId(iconImage)

    local normalizedSystemName = normalizeLookupKey(systemName)
    local exactEntry = itemsBySystemName[normalizedSystemName]

    if exactEntry then
        return exactEntry, "SystemName"
    end

    local byVisualName = chooseDatabaseEntry(
        itemsByVisualName[normalizeLookupKey(visualName)],
        imageId
    )

    if byVisualName then
        return byVisualName, "VisualName"
    end

    local byImage = chooseDatabaseEntry(
        imageId and itemsByImageId[imageId],
        imageId
    )

    if byImage then
        return byImage, "Image"
    end

    return nil, "NotFound"
end

local function colorDistance(a, b)
    local dr = a.R - b.R
    local dg = a.G - b.G
    local db = a.B - b.B

    return dr * dr + dg * dg + db * db
end

local function detectRarity(color)
    local bestName = "Unknown"
    local bestDistance = math.huge

    for rarityName, rarityColor in pairs(rarityColors) do
        if typeof(rarityColor) == "Color3" then
            local distance = colorDistance(color, rarityColor)

            if distance < bestDistance then
                bestDistance = distance
                bestName = rarityName
            end
        end
    end

    if bestDistance <= 0.02 then
        return bestName
    end

    return "Unknown"
end

local COLORS = {
    Background = Color3.fromRGB(8, 6, 18),
    Surface = Color3.fromRGB(25, 17, 48),
    SurfaceLight = Color3.fromRGB(36, 24, 65),
    SurfaceHover = Color3.fromRGB(50, 30, 82),

    Purple = Color3.fromRGB(155, 70, 255),
    PurpleBright = Color3.fromRGB(186, 92, 255),
    PurpleLight = Color3.fromRGB(218, 164, 255),

    Pink = Color3.fromRGB(255, 69, 213),
    Blue = Color3.fromRGB(82, 83, 255),

    Text = Color3.fromRGB(247, 242, 255),
    TextMuted = Color3.fromRGB(172, 157, 198),

    Success = Color3.fromRGB(78, 235, 173),
    Danger = Color3.fromRGB(255, 90, 128)
}

local TWEEN_FAST = TweenInfo.new(
    0.16,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
)

local TWEEN_NORMAL = TweenInfo.new(
    0.28,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out
)

local function tween(instance, properties, tweenInfo)
    if not instance or not instance.Parent then
        return nil
    end

    local animation = TweenService:Create(
        instance,
        tweenInfo or TWEEN_NORMAL,
        properties
    )

    animation:Play()
    return animation
end

local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent

    return corner
end

local function addStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent

    return stroke
end

local function addGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 0
    gradient.Parent = parent

    return gradient
end

local function createGlow(parent, color, expansion, transparency)
    local glow = Instance.new("Frame")
    glow.Name = "Glow"
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.Position = UDim2.fromScale(0.5, 0.5)
    glow.Size = UDim2.new(
        1,
        expansion or 20,
        1,
        expansion or 20
    )
    glow.BackgroundColor3 = color
    glow.BackgroundTransparency = transparency or 0.88
    glow.BorderSizePixel = 0
    glow.ZIndex = math.max(parent.ZIndex - 1, 0)
    glow.Parent = parent

    addCorner(glow, 26)

    return glow
end

local function makeDraggable(handle, target)
    local dragging = false
    local dragStart = nil
    local startPosition = nil

    handle.InputBegan:Connect(function(input)
        local validInput =
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch

        if not validInput then
            return
        end

        dragging = true
        dragStart = input.Position
        startPosition = target.Position
    end)

    handle.InputEnded:Connect(function(input)
        local validInput =
            input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch

        if validInput then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging or not dragStart or not startPosition then
            return
        end

        local validInput =
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch

        if not validInput then
            return
        end

        local delta = input.Position - dragStart

        target.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end)
end


local function createGalaxyLogo(parent)
    local logoHolder = Instance.new("Frame")
    logoHolder.Name = "GalaxyLogo"
    logoHolder.Position = UDim2.fromOffset(18, 17)
    logoHolder.Size = UDim2.fromOffset(56, 56)
    logoHolder.BackgroundColor3 = Color3.fromRGB(61, 24, 122)
    logoHolder.BorderSizePixel = 0
    logoHolder.ClipsDescendants = false
    logoHolder.Parent = parent

    addCorner(logoHolder, 18)

    local holderStroke = addStroke(
        logoHolder,
        COLORS.PurpleBright,
        1.5,
        0.3
    )

    addGradient(holderStroke, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.5, COLORS.PurpleBright),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 35)

    local holderGradient = addGradient(logoHolder, {
        ColorSequenceKeypoint.new(
            0,
            Color3.fromRGB(90, 30, 195)
        ),
        ColorSequenceKeypoint.new(
            0.55,
            Color3.fromRGB(112, 37, 255)
        ),
        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(62, 52, 255)
        )
    }, 40)

    createGlow(
        logoHolder,
        COLORS.Purple,
        18,
        0.82
    )

    local planetGlow = Instance.new("Frame")
    planetGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    planetGlow.Position = UDim2.fromScale(0.5, 0.5)
    planetGlow.Size = UDim2.fromOffset(32, 32)
    planetGlow.BackgroundColor3 = COLORS.Pink
    planetGlow.BackgroundTransparency = 0.72
    planetGlow.BorderSizePixel = 0
    planetGlow.Parent = logoHolder

    addCorner(planetGlow, 100)

    local planet = Instance.new("Frame")
    planet.AnchorPoint = Vector2.new(0.5, 0.5)
    planet.Position = UDim2.fromScale(0.5, 0.5)
    planet.Size = UDim2.fromOffset(22, 22)
    planet.BackgroundColor3 = COLORS.PurpleLight
    planet.BorderSizePixel = 0
    planet.ZIndex = logoHolder.ZIndex + 2
    planet.Parent = logoHolder

    addCorner(planet, 100)

    addGradient(planet, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.48, COLORS.PurpleLight),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 35)

    local planetShine = Instance.new("Frame")
    planetShine.Position = UDim2.fromOffset(4, 4)
    planetShine.Size = UDim2.fromOffset(7, 5)
    planetShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    planetShine.BackgroundTransparency = 0.2
    planetShine.BorderSizePixel = 0
    planetShine.ZIndex = planet.ZIndex + 1
    planetShine.Parent = planet

    addCorner(planetShine, 100)

    local ring = Instance.new("Frame")
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.Position = UDim2.fromScale(0.5, 0.5)
    ring.Size = UDim2.fromOffset(41, 15)
    ring.BackgroundTransparency = 1
    ring.Rotation = -18
    ring.ZIndex = logoHolder.ZIndex + 3
    ring.Parent = logoHolder

    addCorner(ring, 100)

    local ringStroke = addStroke(
        ring,
        Color3.fromRGB(243, 193, 255),
        2,
        0.12
    )

    local ringGradient = addGradient(ringStroke, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 232, 255)),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 0)

    local star1 = Instance.new("Frame")
    star1.Position = UDim2.fromOffset(10, 10)
    star1.Size = UDim2.fromOffset(4, 4)
    star1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    star1.BorderSizePixel = 0
    star1.ZIndex = logoHolder.ZIndex + 4
    star1.Parent = logoHolder

    addCorner(star1, 100)

    local star2 = Instance.new("Frame")
    star2.Position = UDim2.fromOffset(43, 13)
    star2.Size = UDim2.fromOffset(3, 3)
    star2.BackgroundColor3 = COLORS.PurpleLight
    star2.BorderSizePixel = 0
    star2.ZIndex = logoHolder.ZIndex + 4
    star2.Parent = logoHolder

    addCorner(star2, 100)

    local star3 = Instance.new("Frame")
    star3.Position = UDim2.fromOffset(41, 42)
    star3.Size = UDim2.fromOffset(4, 4)
    star3.BackgroundColor3 = COLORS.Pink
    star3.BorderSizePixel = 0
    star3.ZIndex = logoHolder.ZIndex + 4
    star3.Parent = logoHolder

    addCorner(star3, 100)

    task.spawn(function()
        while logoHolder.Parent do
            tween(
                planetGlow,
                {
                    Size = UDim2.fromOffset(39, 39),
                    BackgroundTransparency = 0.84
                },
                TweenInfo.new(
                    1.1,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.InOut
                )
            )

            tween(
                star1,
                {BackgroundTransparency = 0.75},
                TweenInfo.new(
                    0.7,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.InOut
                )
            )

            task.wait(1.1)

            tween(
                planetGlow,
                {
                    Size = UDim2.fromOffset(32, 32),
                    BackgroundTransparency = 0.68
                },
                TweenInfo.new(
                    1.1,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.InOut
                )
            )

            tween(
                star1,
                {BackgroundTransparency = 0},
                TweenInfo.new(
                    0.7,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.InOut
                )
            )

            task.wait(1.1)
        end
    end)

    return logoHolder
end


local function createSearchIcon(parent)
    local iconHolder = Instance.new("Frame")
    iconHolder.Name = "SearchIcon"
    iconHolder.Position = UDim2.fromOffset(16, 11)
    iconHolder.Size = UDim2.fromOffset(24, 24)
    iconHolder.BackgroundTransparency = 1
    iconHolder.ZIndex = parent.ZIndex + 3
    iconHolder.Parent = parent

    local circle = Instance.new("Frame")
    circle.Position = UDim2.fromOffset(1, 1)
    circle.Size = UDim2.fromOffset(13, 13)
    circle.BackgroundTransparency = 1
    circle.BorderSizePixel = 0
    circle.Parent = iconHolder

    addCorner(circle, 100)

    local circleStroke = addStroke(
        circle,
        COLORS.PurpleLight,
        2,
        0
    )

    local handle = Instance.new("Frame")
    handle.AnchorPoint = Vector2.new(0.5, 0.5)
    handle.Position = UDim2.fromOffset(15.5, 15.5)
    handle.Size = UDim2.fromOffset(9, 2)
    handle.BackgroundColor3 = COLORS.PurpleLight
    handle.BorderSizePixel = 0
    handle.Rotation = 45
    handle.Parent = iconHolder

    addCorner(handle, 100)

    local glow = Instance.new("Frame")
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.Position = UDim2.fromScale(0.48, 0.48)
    glow.Size = UDim2.fromOffset(22, 22)
    glow.BackgroundColor3 = COLORS.Purple
    glow.BackgroundTransparency = 0.88
    glow.BorderSizePixel = 0
    glow.ZIndex = iconHolder.ZIndex - 1
    glow.Parent = iconHolder

    addCorner(glow, 100)

    return {
        Holder = iconHolder,
        CircleStroke = circleStroke,
        Handle = handle,
        Glow = glow
    }
end

local function createGalaxyUI(items, onConfirm)
    items = items or {}

    local oldGui = PlayerGui:FindFirstChild("GalaxyNeonSelector")

    if oldGui then
        oldGui:Destroy()
    end

    local oldBlur = Lighting:FindFirstChild("GalaxySelectorBlur")

    if oldBlur then
        oldBlur:Destroy()
    end

    local selectedItems = {}
    local cards = {}
    local closing = false
    local inputConnection = nil

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GalaxyNeonSelector"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 2147483647
    screenGui.Parent = PlayerGui

    local blur = Instance.new("BlurEffect")
    blur.Name = "GalaxySelectorBlur"
    blur.Size = 0
    blur.Parent = Lighting

    tween(blur, {
        Size = 18
    })

    local overlay = Instance.new("TextButton")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.fromRGB(2, 1, 8)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.Text = ""
    overlay.AutoButtonColor = false
    overlay.Selectable = false
    overlay.Parent = screenGui
    overlay.Visible = true
    overlay.Active = true

    tween(overlay, {
        BackgroundTransparency = 0.28
    })

    local main = Instance.new("Frame")
    main.Name = "MainWindow"
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.Position = UDim2.fromScale(0.5, 0.52)
    main.Size = UDim2.fromOffset(900, 610)
    main.BackgroundColor3 = COLORS.Surface
    main.BackgroundTransparency = 0.04
    main.BorderSizePixel = 0
    main.ClipsDescendants = false
    main.Parent = overlay

    addCorner(main, 24)

    local mainStroke = addStroke(
        main,
        COLORS.Purple,
        1.5,
        0.15
    )

    addGradient(mainStroke, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.45, COLORS.Purple),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 20)

    createGlow(
        main,
        COLORS.Purple,
        30,
        0.88
    )

    local mainScale = Instance.new("UIScale")
    mainScale.Scale = 0.82
    mainScale.Parent = main

    tween(
        mainScale,
        {Scale = 1},
        TweenInfo.new(
            0.45,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        )
    )

    tween(main, {
        Position = UDim2.fromScale(0.5, 0.5)
    })

    local reopenButton = Instance.new("TextButton")
    reopenButton.Name = "ReopenGalaxyButton"
    reopenButton.AnchorPoint = Vector2.new(0.5, 0.5)
    reopenButton.Position = UDim2.fromScale(0.08, 0.5)
    reopenButton.Size = UDim2.fromOffset(58, 58)
    reopenButton.BackgroundColor3 = COLORS.Purple
    reopenButton.BackgroundTransparency = 1
    reopenButton.BorderSizePixel = 0
    reopenButton.Text = ""
    reopenButton.AutoButtonColor = false
    reopenButton.Visible = false
    reopenButton.ZIndex = 100
    reopenButton.Parent = screenGui

    addCorner(reopenButton, 16)

    local reopenStroke = addStroke(
        reopenButton,
        COLORS.PurpleLight,
        1.5,
        1
    )

    addGradient(reopenButton, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.5, COLORS.Purple),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 35)

    local reopenScale = Instance.new("UIScale")
    reopenScale.Scale = 0.7
    reopenScale.Parent = reopenButton

    local reopenGlow = createGlow(
        reopenButton,
        COLORS.Purple,
        18,
        1
    )

    local reopenLogo = Instance.new("Frame")
    reopenLogo.Name = "MiniGalaxyLogo"
    reopenLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    reopenLogo.Position = UDim2.fromScale(0.5, 0.5)
    reopenLogo.Size = UDim2.fromOffset(42, 42)
    reopenLogo.BackgroundTransparency = 1
    reopenLogo.BorderSizePixel = 0
    reopenLogo.ZIndex = reopenButton.ZIndex + 2
    reopenLogo.Parent = reopenButton

    local miniPlanetGlow = Instance.new("Frame")
    miniPlanetGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    miniPlanetGlow.Position = UDim2.fromScale(0.5, 0.5)
    miniPlanetGlow.Size = UDim2.fromOffset(25, 25)
    miniPlanetGlow.BackgroundColor3 = COLORS.Pink
    miniPlanetGlow.BackgroundTransparency = 0.68
    miniPlanetGlow.BorderSizePixel = 0
    miniPlanetGlow.ZIndex = reopenLogo.ZIndex
    miniPlanetGlow.Parent = reopenLogo
    addCorner(miniPlanetGlow, 100)

    local miniPlanet = Instance.new("Frame")
    miniPlanet.AnchorPoint = Vector2.new(0.5, 0.5)
    miniPlanet.Position = UDim2.fromScale(0.5, 0.5)
    miniPlanet.Size = UDim2.fromOffset(17, 17)
    miniPlanet.BackgroundColor3 = COLORS.PurpleLight
    miniPlanet.BorderSizePixel = 0
    miniPlanet.ZIndex = reopenLogo.ZIndex + 2
    miniPlanet.Parent = reopenLogo
    addCorner(miniPlanet, 100)
    addGradient(miniPlanet, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.5, COLORS.PurpleLight),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 35)

    local miniPlanetShine = Instance.new("Frame")
    miniPlanetShine.Position = UDim2.fromOffset(3, 3)
    miniPlanetShine.Size = UDim2.fromOffset(5, 4)
    miniPlanetShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    miniPlanetShine.BackgroundTransparency = 0.15
    miniPlanetShine.BorderSizePixel = 0
    miniPlanetShine.ZIndex = miniPlanet.ZIndex + 1
    miniPlanetShine.Parent = miniPlanet
    addCorner(miniPlanetShine, 100)

    local miniRing = Instance.new("Frame")
    miniRing.AnchorPoint = Vector2.new(0.5, 0.5)
    miniRing.Position = UDim2.fromScale(0.5, 0.5)
    miniRing.Size = UDim2.fromOffset(34, 12)
    miniRing.BackgroundTransparency = 1
    miniRing.Rotation = -18
    miniRing.ZIndex = reopenLogo.ZIndex + 3
    miniRing.Parent = reopenLogo
    addCorner(miniRing, 100)
    local miniRingStroke = addStroke(
        miniRing,
        Color3.fromRGB(245, 204, 255),
        2,
        0.08
    )
    addGradient(miniRingStroke, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 240, 255)),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 0)

    local miniStar1 = Instance.new("Frame")
    miniStar1.Position = UDim2.fromOffset(4, 5)
    miniStar1.Size = UDim2.fromOffset(3, 3)
    miniStar1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    miniStar1.BorderSizePixel = 0
    miniStar1.ZIndex = reopenLogo.ZIndex + 4
    miniStar1.Parent = reopenLogo
    addCorner(miniStar1, 100)

    local miniStar2 = Instance.new("Frame")
    miniStar2.Position = UDim2.fromOffset(34, 31)
    miniStar2.Size = UDim2.fromOffset(3, 3)
    miniStar2.BackgroundColor3 = COLORS.Pink
    miniStar2.BorderSizePixel = 0
    miniStar2.ZIndex = reopenLogo.ZIndex + 4
    miniStar2.Parent = reopenLogo
    addCorner(miniStar2, 100)

    local sizeConstraint = Instance.new("UISizeConstraint")
    sizeConstraint.MinSize = Vector2.new(600, 450)
    sizeConstraint.MaxSize = Vector2.new(1000, 700)
    sizeConstraint.Parent = main

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 90)
    topBar.BackgroundTransparency = 1
    topBar.Active = true
    topBar.Parent = main

    createGalaxyLogo(topBar)

    local title = Instance.new("TextLabel")
    title.Position = UDim2.fromOffset(88, 18)
    title.Size = UDim2.new(1, -175, 0, 32)
    title.BackgroundTransparency = 1
    title.Text = "GALAXY DUPE"
    title.TextColor3 = COLORS.Text
    title.TextSize = 24
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.Parent = topBar

    local titleGradient = addGradient(title, {
        ColorSequenceKeypoint.new(0, COLORS.Pink),
        ColorSequenceKeypoint.new(0.35, COLORS.PurpleLight),
        ColorSequenceKeypoint.new(0.7, COLORS.PurpleBright),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 0)

    titleGradient.Offset = Vector2.new(-1, 0)
    local titleAnimation = TweenService:Create(
        titleGradient,
        TweenInfo.new(
            3.4,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut,
            -1,
            true,
            0
        ),
        {Offset = Vector2.new(1, 0)}
    )
    titleAnimation:Play()

    local subtitle = Instance.new("TextLabel")
    subtitle.Position = UDim2.fromOffset(90, 50)
    subtitle.Size = UDim2.new(1, -190, 0, 20)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Выберите один или несколько оружий"
    subtitle.TextColor3 = COLORS.TextMuted
    subtitle.TextSize = 13
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Font = Enum.Font.GothamMedium
    subtitle.Parent = topBar

    local infoButton = Instance.new("TextButton")
    infoButton.Name = "InfoButton"
    infoButton.AnchorPoint = Vector2.new(1, 0)
    infoButton.Position = UDim2.new(1, -122, 0, 25)
    infoButton.Size = UDim2.fromOffset(180, 34)
    infoButton.BackgroundTransparency = 1
    infoButton.BorderSizePixel = 0
    infoButton.Text = ""
    infoButton.AutoButtonColor = false
    infoButton.Parent = topBar

    local infoIcon = Instance.new("Frame")
    infoIcon.Name = "InfoIcon"
    infoIcon.Position = UDim2.fromOffset(0, 3)
    infoIcon.Size = UDim2.fromOffset(28, 28)
    infoIcon.BackgroundColor3 = Color3.fromRGB(76, 37, 128)
    infoIcon.BackgroundTransparency = 0.18
    infoIcon.BorderSizePixel = 0
    infoIcon.Parent = infoButton

    addCorner(infoIcon, 100)

    local infoIconStroke = addStroke(
        infoIcon,
        COLORS.PurpleBright,
        1,
        0.35
    )

    local infoDot = Instance.new("Frame")
    infoDot.Name = "Dot"
    infoDot.AnchorPoint = Vector2.new(0.5, 0.5)
    infoDot.Position = UDim2.fromOffset(14, 8)
    infoDot.Size = UDim2.fromOffset(4, 4)
    infoDot.BackgroundColor3 = COLORS.PurpleLight
    infoDot.BorderSizePixel = 0
    infoDot.Parent = infoIcon
    addCorner(infoDot, 100)

    local infoStem = Instance.new("Frame")
    infoStem.Name = "Stem"
    infoStem.AnchorPoint = Vector2.new(0.5, 0)
    infoStem.Position = UDim2.fromOffset(14, 12)
    infoStem.Size = UDim2.fromOffset(4, 10)
    infoStem.BackgroundColor3 = COLORS.PurpleLight
    infoStem.BorderSizePixel = 0
    infoStem.Parent = infoIcon
    addCorner(infoStem, 100)

    local infoText = Instance.new("TextLabel")
    infoText.Position = UDim2.fromOffset(36, 0)
    infoText.Size = UDim2.new(1, -36, 1, 0)
    infoText.BackgroundTransparency = 1
    infoText.Text = "Что это такое?"
    infoText.TextColor3 = COLORS.PurpleLight
    infoText.TextSize = 15
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.Font = Enum.Font.GothamMedium
    infoText.Parent = infoButton

    local infoPanel = Instance.new("TextButton")
    infoPanel.Name = "InfoPanel"
    infoPanel.Size = UDim2.fromScale(1, 1)
    infoPanel.BackgroundColor3 = Color3.fromRGB(3, 1, 9)
    infoPanel.BackgroundTransparency = 0.24
    infoPanel.BorderSizePixel = 0
    infoPanel.Text = ""
    infoPanel.AutoButtonColor = false
    infoPanel.Visible = false
    infoPanel.ZIndex = 180
    infoPanel.Parent = main

    addCorner(infoPanel, 24)

    local infoWindow = Instance.new("Frame")
    infoWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    infoWindow.Position = UDim2.new(0.5, 0, 0.46, 0)
    infoWindow.Size = UDim2.fromOffset(700, 520)
    infoWindow.BackgroundColor3 = Color3.fromRGB(27, 16, 51)
    infoWindow.BorderSizePixel = 0
    infoWindow.Active = true
    infoWindow.ZIndex = infoPanel.ZIndex + 1
    infoWindow.Parent = infoPanel
    addCorner(infoWindow, 20)
    addStroke(infoWindow, COLORS.PurpleBright, 1.5, 0.08)

    local infoHeader = Instance.new("Frame")
    infoHeader.Size = UDim2.new(1, 0, 0, 72)
    infoHeader.BackgroundColor3 = Color3.fromRGB(55, 27, 96)
    infoHeader.BackgroundTransparency = 0.08
    infoHeader.BorderSizePixel = 0
    infoHeader.ZIndex = infoWindow.ZIndex + 1
    infoHeader.Parent = infoWindow
    addCorner(infoHeader, 20)

    local infoWindowIcon = Instance.new("TextLabel")
    infoWindowIcon.Position = UDim2.fromOffset(22, 18)
    infoWindowIcon.Size = UDim2.fromOffset(36, 36)
    infoWindowIcon.BackgroundColor3 = Color3.fromRGB(91, 43, 154)
    infoWindowIcon.BorderSizePixel = 0
    infoWindowIcon.Text = "i"
    infoWindowIcon.TextColor3 = Color3.fromRGB(248, 220, 255)
    infoWindowIcon.TextSize = 23
    infoWindowIcon.Font = Enum.Font.GothamBold
    infoWindowIcon.ZIndex = infoHeader.ZIndex + 1
    infoWindowIcon.Parent = infoHeader
    addCorner(infoWindowIcon, 12)
    addStroke(infoWindowIcon, COLORS.PurpleLight, 1, 0.14)

    local infoWindowTitle = Instance.new("TextLabel")
    infoWindowTitle.Position = UDim2.fromOffset(72, 15)
    infoWindowTitle.Size = UDim2.new(1, -94, 0, 44)
    infoWindowTitle.BackgroundTransparency = 1
    infoWindowTitle.Text = "Что это такое?"
    infoWindowTitle.TextColor3 = COLORS.Text
    infoWindowTitle.TextSize = 23
    infoWindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    infoWindowTitle.Font = Enum.Font.GothamBold
    infoWindowTitle.ZIndex = infoHeader.ZIndex + 1
    infoWindowTitle.Parent = infoHeader

    local infoPanelText = Instance.new("TextLabel")
    infoPanelText.Position = UDim2.fromOffset(36, 94)
    infoPanelText.Size = UDim2.new(1, -72, 1, -190)
    infoPanelText.BackgroundTransparency = 1
    infoPanelText.Text = [=[Дюп это ошибка в коде. Ошибка которую использует наш скрипт для клонирования вещей. В нашем случае мы клонируем оружия MM2. 

Как это происходит?

• С начала вы должны выбрать оружие которое хотите дюпнуть а после подтвердить свой выбор, вы будете телепортированны на старый сервер MM2 в котором могут дюпаться оружия.

• Вы будете телепортированны на старый сервер MM2 в котором могут дюпаться оружия.

• !!САМОЕ ВАЖНОЕ после телепорта не выходить с сервера иначе есть риск потерять ВСЕ СВОИ ОРУЖИЯ!! Вы были предупреждены!]=]
    infoPanelText.TextColor3 = COLORS.TextMuted
    infoPanelText.TextSize = 18
    infoPanelText.TextWrapped = true
    infoPanelText.TextXAlignment = Enum.TextXAlignment.Left
    infoPanelText.TextYAlignment = Enum.TextYAlignment.Top
    infoPanelText.Font = Enum.Font.GothamMedium
    infoPanelText.ZIndex = infoWindow.ZIndex + 1
    infoPanelText.Parent = infoWindow

    local infoOkayButton = Instance.new("TextButton")
    infoOkayButton.AnchorPoint = Vector2.new(0.5, 1)
    infoOkayButton.Position = UDim2.new(0.5, 0, 1, -28)
    infoOkayButton.Size = UDim2.fromOffset(250, 50)
    infoOkayButton.BackgroundColor3 = COLORS.Purple
    infoOkayButton.BorderSizePixel = 0
    infoOkayButton.Text = "ПОНЯТНО"
    infoOkayButton.TextColor3 = COLORS.Text
    infoOkayButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    infoOkayButton.TextStrokeTransparency = 1
    infoOkayButton.TextSize = 16
    infoOkayButton.Font = Enum.Font.GothamBold
    infoOkayButton.AutoButtonColor = false
    infoOkayButton.ZIndex = infoWindow.ZIndex + 1
    infoOkayButton.Parent = infoWindow
    addCorner(infoOkayButton, 13)
    addStroke(infoOkayButton, COLORS.PurpleLight, 1, 0.20)
    addGradient(infoOkayButton, {
        ColorSequenceKeypoint.new(0, COLORS.Purple),
        ColorSequenceKeypoint.new(0.55, COLORS.Pink),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 10)

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.AnchorPoint = Vector2.new(1, 0)
    minimizeButton.Position = UDim2.new(1, -72, 0, 20)
    minimizeButton.Size = UDim2.fromOffset(42, 42)
    minimizeButton.BackgroundColor3 = COLORS.SurfaceLight
    minimizeButton.BackgroundTransparency = 0.25
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "—"
    minimizeButton.TextColor3 = COLORS.TextMuted
    minimizeButton.TextSize = 22
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.AutoButtonColor = false
    minimizeButton.Parent = topBar

    addCorner(minimizeButton, 13)

    local minimizeStroke = addStroke(
        minimizeButton,
        COLORS.Purple,
        1,
        0.6
    )

    local closeButton = Instance.new("TextButton")
    closeButton.AnchorPoint = Vector2.new(1, 0)
    closeButton.Position = UDim2.new(1, -22, 0, 20)
    closeButton.Size = UDim2.fromOffset(42, 42)
    closeButton.BackgroundColor3 = COLORS.SurfaceLight
    closeButton.BackgroundTransparency = 0.25
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = COLORS.TextMuted
    closeButton.TextSize = 26
    closeButton.Font = Enum.Font.GothamMedium
    closeButton.AutoButtonColor = false
    closeButton.Parent = topBar

    addCorner(closeButton, 13)

    local closeStroke = addStroke(
        closeButton,
        COLORS.Purple,
        1,
        0.6
    )

    local closeConfirmShade = Instance.new("TextButton")
    closeConfirmShade.Name = "CloseConfirmShade"
    closeConfirmShade.Size = UDim2.fromScale(1, 1)
    closeConfirmShade.BackgroundColor3 = Color3.fromRGB(3, 1, 9)
    closeConfirmShade.BackgroundTransparency = 0.22
    closeConfirmShade.BorderSizePixel = 0
    closeConfirmShade.Text = ""
    closeConfirmShade.AutoButtonColor = false
    closeConfirmShade.Visible = false
    closeConfirmShade.ZIndex = 200
    closeConfirmShade.Parent = main

    addCorner(closeConfirmShade, 24)

    local closeConfirmWindow = Instance.new("Frame")
    closeConfirmWindow.Name = "CloseConfirmWindow"
    closeConfirmWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    closeConfirmWindow.Position = UDim2.fromScale(0.5, 0.5)
    closeConfirmWindow.Size = UDim2.fromOffset(450, 230)
    closeConfirmWindow.BackgroundColor3 = Color3.fromRGB(27, 16, 51)
    closeConfirmWindow.BorderSizePixel = 0
    closeConfirmWindow.Active = true
    closeConfirmWindow.ZIndex = closeConfirmShade.ZIndex + 1
    closeConfirmWindow.Parent = closeConfirmShade

    addCorner(closeConfirmWindow, 20)
    addStroke(closeConfirmWindow, COLORS.PurpleBright, 1.5, 0.08)

    local closeHeader = Instance.new("Frame")
    closeHeader.Size = UDim2.new(1, 0, 0, 68)
    closeHeader.BackgroundColor3 = Color3.fromRGB(55, 27, 96)
    closeHeader.BackgroundTransparency = 0.08
    closeHeader.BorderSizePixel = 0
    closeHeader.ZIndex = closeConfirmWindow.ZIndex + 1
    closeHeader.Parent = closeConfirmWindow
    addCorner(closeHeader, 20)

    local closeIcon = Instance.new("TextLabel")
    closeIcon.Position = UDim2.fromOffset(20, 17)
    closeIcon.Size = UDim2.fromOffset(34, 34)
    closeIcon.BackgroundColor3 = COLORS.Danger
    closeIcon.BorderSizePixel = 0
    closeIcon.Text = "!"
    closeIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeIcon.TextSize = 21
    closeIcon.Font = Enum.Font.GothamBold
    closeIcon.ZIndex = closeHeader.ZIndex + 1
    closeIcon.Parent = closeHeader
    addCorner(closeIcon, 11)

    local closeHeaderTitle = Instance.new("TextLabel")
    closeHeaderTitle.Position = UDim2.fromOffset(68, 13)
    closeHeaderTitle.Size = UDim2.new(1, -90, 0, 42)
    closeHeaderTitle.BackgroundTransparency = 1
    closeHeaderTitle.Text = "Закрыть GALAXY DUPE?"
    closeHeaderTitle.TextColor3 = COLORS.Text
    closeHeaderTitle.TextSize = 22
    closeHeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
    closeHeaderTitle.Font = Enum.Font.GothamBold
    closeHeaderTitle.ZIndex = closeHeader.ZIndex + 1
    closeHeaderTitle.Parent = closeHeader

    local confirmCloseTitle = Instance.new("TextLabel")
    confirmCloseTitle.Position = UDim2.fromOffset(28, 86)
    confirmCloseTitle.Size = UDim2.new(1, -56, 0, 54)
    confirmCloseTitle.BackgroundTransparency = 1
    confirmCloseTitle.Text = "Ты уверен, что хочешь полностью закрыть меню?"
    confirmCloseTitle.TextColor3 = COLORS.Text
    confirmCloseTitle.TextSize = 19
    confirmCloseTitle.TextWrapped = true
    confirmCloseTitle.Font = Enum.Font.GothamMedium
    confirmCloseTitle.ZIndex = closeConfirmWindow.ZIndex + 1
    confirmCloseTitle.Parent = closeConfirmWindow

    local closeNoButton = Instance.new("TextButton")
    closeNoButton.Position = UDim2.new(0, 28, 1, -66)
    closeNoButton.Size = UDim2.fromOffset(180, 46)
    closeNoButton.BackgroundColor3 = COLORS.SurfaceLight
    closeNoButton.BorderSizePixel = 0
    closeNoButton.Text = "НЕТ"
    closeNoButton.TextColor3 = COLORS.Text
    closeNoButton.TextSize = 14
    closeNoButton.Font = Enum.Font.GothamBold
    closeNoButton.AutoButtonColor = false
    closeNoButton.ZIndex = closeConfirmWindow.ZIndex + 1
    closeNoButton.Parent = closeConfirmWindow
    addCorner(closeNoButton, 13)

    local closeNoStroke = addStroke(
        closeNoButton,
        COLORS.PurpleBright,
        1,
        0.28
    )

    local closeYesButton = Instance.new("TextButton")
    closeYesButton.AnchorPoint = Vector2.new(1, 0)
    closeYesButton.Position = UDim2.new(1, -28, 1, -66)
    closeYesButton.Size = UDim2.fromOffset(180, 46)
    closeYesButton.BackgroundColor3 = COLORS.Danger
    closeYesButton.BorderSizePixel = 0
    closeYesButton.Text = "ДА, ЗАКРЫТЬ"
    closeYesButton.TextColor3 = COLORS.Text
    closeYesButton.TextSize = 14
    closeYesButton.Font = Enum.Font.GothamBold
    closeYesButton.AutoButtonColor = false
    closeYesButton.ZIndex = closeConfirmWindow.ZIndex + 1
    closeYesButton.Parent = closeConfirmWindow
    addCorner(closeYesButton, 13)

    local closeYesStroke = addStroke(
        closeYesButton,
        Color3.fromRGB(255, 170, 192),
        1,
        0.20
    )

    local selectConfirmShade = Instance.new("TextButton")
    selectConfirmShade.Name = "SelectConfirmShade"
    selectConfirmShade.Size = UDim2.fromScale(1, 1)
    selectConfirmShade.BackgroundColor3 = Color3.fromRGB(3, 1, 9)
    selectConfirmShade.BackgroundTransparency = 0.22
    selectConfirmShade.BorderSizePixel = 0
    selectConfirmShade.Text = ""
    selectConfirmShade.AutoButtonColor = false
    selectConfirmShade.Visible = false
    selectConfirmShade.ZIndex = 190
    selectConfirmShade.Parent = main

    addCorner(selectConfirmShade, 24)

    local selectConfirmWindow = Instance.new("Frame")
    selectConfirmWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    selectConfirmWindow.Position = UDim2.fromScale(0.5, 0.5)
    selectConfirmWindow.Size = UDim2.fromOffset(430, 220)
    selectConfirmWindow.BackgroundColor3 = Color3.fromRGB(27, 16, 51)
    selectConfirmWindow.BorderSizePixel = 0
    selectConfirmWindow.Active = true
    selectConfirmWindow.ZIndex = selectConfirmShade.ZIndex + 1
    selectConfirmWindow.Parent = selectConfirmShade
    addCorner(selectConfirmWindow, 20)
    addStroke(selectConfirmWindow, COLORS.PurpleBright, 1.5, 0.08)

    local selectIcon = Instance.new("Frame")
    selectIcon.Name = "NeonConfirmCheck"
    selectIcon.Position = UDim2.fromOffset(25, 21)
    selectIcon.Size = UDim2.fromOffset(46, 46)
    selectIcon.BackgroundTransparency = 1
    selectIcon.BorderSizePixel = 0
    selectIcon.ZIndex = selectConfirmWindow.ZIndex + 2
    selectIcon.Parent = selectConfirmWindow

    local selectCheckShortGlow = Instance.new("Frame")
    selectCheckShortGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    selectCheckShortGlow.Position = UDim2.fromOffset(14, 28)
    selectCheckShortGlow.Size = UDim2.fromOffset(17, 8)
    selectCheckShortGlow.Rotation = 43
    selectCheckShortGlow.BackgroundColor3 = Color3.fromRGB(218, 75, 255)
    selectCheckShortGlow.BackgroundTransparency = 0.55
    selectCheckShortGlow.BorderSizePixel = 0
    selectCheckShortGlow.ZIndex = selectIcon.ZIndex
    selectCheckShortGlow.Parent = selectIcon
    addCorner(selectCheckShortGlow, 100)

    local selectCheckShort = Instance.new("Frame")
    selectCheckShort.AnchorPoint = Vector2.new(0.5, 0.5)
    selectCheckShort.Position = selectCheckShortGlow.Position
    selectCheckShort.Size = UDim2.fromOffset(14, 4)
    selectCheckShort.Rotation = 43
    selectCheckShort.BackgroundColor3 = Color3.fromRGB(250, 200, 255)
    selectCheckShort.BorderSizePixel = 0
    selectCheckShort.ZIndex = selectIcon.ZIndex + 1
    selectCheckShort.Parent = selectIcon
    addCorner(selectCheckShort, 100)

    local selectCheckLongGlow = Instance.new("Frame")
    selectCheckLongGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    selectCheckLongGlow.Position = UDim2.fromOffset(29, 20)
    selectCheckLongGlow.Size = UDim2.fromOffset(31, 8)
    selectCheckLongGlow.Rotation = -43
    selectCheckLongGlow.BackgroundColor3 = Color3.fromRGB(172, 55, 255)
    selectCheckLongGlow.BackgroundTransparency = 0.55
    selectCheckLongGlow.BorderSizePixel = 0
    selectCheckLongGlow.ZIndex = selectIcon.ZIndex
    selectCheckLongGlow.Parent = selectIcon
    addCorner(selectCheckLongGlow, 100)

    local selectCheckLong = Instance.new("Frame")
    selectCheckLong.AnchorPoint = Vector2.new(0.5, 0.5)
    selectCheckLong.Position = selectCheckLongGlow.Position
    selectCheckLong.Size = UDim2.fromOffset(28, 4)
    selectCheckLong.Rotation = -43
    selectCheckLong.BackgroundColor3 = Color3.fromRGB(225, 130, 255)
    selectCheckLong.BorderSizePixel = 0
    selectCheckLong.ZIndex = selectIcon.ZIndex + 1
    selectCheckLong.Parent = selectIcon
    addCorner(selectCheckLong, 100)

    local selectTitle = Instance.new("TextLabel")
    selectTitle.AnchorPoint = Vector2.new(0, 0.5)
    selectTitle.Position = UDim2.fromOffset(84, 44)
    selectTitle.Size = UDim2.new(1, -110, 0, 46)
    selectTitle.BackgroundTransparency = 1
    selectTitle.Text = "Подтвердить выбор?"
    selectTitle.TextColor3 = COLORS.Text
    selectTitle.TextSize = 22
    selectTitle.TextXAlignment = Enum.TextXAlignment.Left
    selectTitle.TextYAlignment = Enum.TextYAlignment.Center
    selectTitle.Font = Enum.Font.GothamBold
    selectTitle.ZIndex = selectConfirmWindow.ZIndex + 2
    selectTitle.Parent = selectConfirmWindow

    local selectQuestion = Instance.new("TextLabel")
    selectQuestion.Position = UDim2.fromOffset(28, 82)
    selectQuestion.Size = UDim2.new(1, -56, 0, 50)
    selectQuestion.TextXAlignment = Enum.TextXAlignment.Center
    selectQuestion.BackgroundTransparency = 1
    selectQuestion.Text = "Ты в этом уверен?"
    selectQuestion.TextColor3 = COLORS.Text
    selectQuestion.TextSize = 20
    selectQuestion.Font = Enum.Font.GothamMedium
    selectQuestion.ZIndex = selectConfirmWindow.ZIndex + 1
    selectQuestion.Parent = selectConfirmWindow

    local selectNoButton = Instance.new("TextButton")
    selectNoButton.Position = UDim2.new(0, 28, 1, -66)
    selectNoButton.Size = UDim2.fromOffset(174, 46)
    selectNoButton.BackgroundColor3 = COLORS.SurfaceLight
    selectNoButton.BorderSizePixel = 0
    selectNoButton.Text = "НЕТ"
    selectNoButton.TextColor3 = COLORS.Text
    selectNoButton.TextSize = 14
    selectNoButton.Font = Enum.Font.GothamBold
    selectNoButton.AutoButtonColor = false
    selectNoButton.ZIndex = selectConfirmWindow.ZIndex + 1
    selectNoButton.Parent = selectConfirmWindow
    addCorner(selectNoButton, 13)

    local selectNoStroke = addStroke(
        selectNoButton,
        COLORS.PurpleBright,
        1,
        0.28
    )

    selectNoButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    selectNoButton.TextStrokeTransparency = 1

    local selectYesButton = Instance.new("TextButton")
    selectYesButton.AnchorPoint = Vector2.new(1, 0)
    selectYesButton.Position = UDim2.new(1, -28, 1, -66)
    selectYesButton.Size = UDim2.fromOffset(174, 46)
    selectYesButton.BackgroundColor3 = COLORS.Purple
    selectYesButton.BorderSizePixel = 0
    selectYesButton.Text = "ДА"
    selectYesButton.TextColor3 = COLORS.Text
    selectYesButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    selectYesButton.TextStrokeTransparency = 1
    selectYesButton.TextSize = 14
    selectYesButton.Font = Enum.Font.GothamBold
    selectYesButton.AutoButtonColor = false
    selectYesButton.ZIndex = selectConfirmWindow.ZIndex + 1
    selectYesButton.Parent = selectConfirmWindow
    addCorner(selectYesButton, 13)
    addStroke(selectYesButton, COLORS.PurpleLight, 1, 0.20)
    addGradient(selectYesButton, {
        ColorSequenceKeypoint.new(0, COLORS.Purple),
        ColorSequenceKeypoint.new(0.55, COLORS.Pink),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 10)

    local divider = Instance.new("Frame")
    divider.Position = UDim2.fromOffset(24, 87)
    divider.Size = UDim2.new(1, -48, 0, 1)
    divider.BackgroundColor3 = COLORS.Purple
    divider.BackgroundTransparency = 0.7
    divider.BorderSizePixel = 0
    divider.Parent = main

    local controls = Instance.new("Frame")
    controls.Position = UDim2.fromOffset(24, 104)
    controls.Size = UDim2.new(1, -48, 0, 48)
    controls.BackgroundTransparency = 1
    controls.Parent = main

    local searchContainer = Instance.new("Frame")
    searchContainer.Size = UDim2.new(0, 380, 1, 0)
    searchContainer.BackgroundColor3 = COLORS.SurfaceLight
    searchContainer.BackgroundTransparency = 0.18
    searchContainer.BorderSizePixel = 0
    searchContainer.Parent = controls

    addCorner(searchContainer, 14)

    local searchStroke = addStroke(
        searchContainer,
        COLORS.Purple,
        1,
        0.62
    )

    local searchIcon = createSearchIcon(searchContainer)

    local searchBox = Instance.new("TextBox")
    searchBox.Position = UDim2.fromOffset(47, 0)
    searchBox.Size = UDim2.new(1, -59, 1, 0)
    searchBox.BackgroundTransparency = 1
    searchBox.BorderSizePixel = 0
    searchBox.ClearTextOnFocus = false
    searchBox.PlaceholderText = "Поиск оружия..."
    searchBox.PlaceholderColor3 = COLORS.TextMuted
    searchBox.Text = ""
    searchBox.TextColor3 = COLORS.Text
    searchBox.TextSize = 14
    searchBox.TextXAlignment = Enum.TextXAlignment.Left
    searchBox.Font = Enum.Font.GothamMedium
    searchBox.Parent = searchContainer

    local selectionCounter = Instance.new("TextLabel")
    selectionCounter.AnchorPoint = Vector2.new(1, 0)
    selectionCounter.Position = UDim2.fromScale(1, 0)
    selectionCounter.Size = UDim2.fromOffset(200, 48)
    selectionCounter.BackgroundColor3 = COLORS.SurfaceLight
    selectionCounter.BackgroundTransparency = 0.18
    selectionCounter.BorderSizePixel = 0
    selectionCounter.Text = "Выбрано: 0"
    selectionCounter.TextColor3 = COLORS.PurpleLight
    selectionCounter.TextSize = 17
    selectionCounter.Font = Enum.Font.GothamMedium
    selectionCounter.Parent = controls

    addCorner(selectionCounter, 14)
    addStroke(selectionCounter, COLORS.Purple, 1, 0.62)

    local list = Instance.new("ScrollingFrame")
    list.Name = "ItemList"
    list.Position = UDim2.fromOffset(24, 170)
    list.Size = UDim2.new(1, -48, 1, -258)
    list.BackgroundColor3 = COLORS.Background
    list.BackgroundTransparency = 0.25
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 4
    list.ScrollBarImageColor3 = COLORS.PurpleBright
    list.ScrollBarImageTransparency = 0.15
    list.AutomaticCanvasSize = Enum.AutomaticSize.Y
    list.CanvasSize = UDim2.new()
    list.ScrollingDirection = Enum.ScrollingDirection.Y
    list.ClipsDescendants = true
    list.Parent = main

    addCorner(list, 18)
    addStroke(list, COLORS.Purple, 1, 0.65)

    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop = UDim.new(0, 16)
    listPadding.PaddingBottom = UDim.new(0, 16)
    listPadding.PaddingLeft = UDim.new(0, 16)
    listPadding.PaddingRight = UDim.new(0, 16)
    listPadding.Parent = list

    local sectionListLayout = Instance.new("UIListLayout")
    sectionListLayout.Padding = UDim.new(0, 18)
    sectionListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sectionListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    sectionListLayout.Parent = list

    local raritySectionObjects = {}

    local function getRarityColor(rarityName)
        local color = rarityColors[rarityName]
        return typeof(color) == "Color3" and color or COLORS.PurpleLight
    end

    local function createRaritySection(sectionInfo, layoutOrder)
        local section = Instance.new("Frame")
        section.Name = "RaritySection_" .. sectionInfo.Name
        section.LayoutOrder = layoutOrder
        section.Size = UDim2.new(1, 0, 0, 0)
        section.AutomaticSize = Enum.AutomaticSize.Y
        section.BackgroundTransparency = 1
        section.Visible = false
        section.Parent = list

        local sectionLayout = Instance.new("UIListLayout")
        sectionLayout.Padding = UDim.new(0, 4)
        sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        sectionLayout.Parent = section

        local header = Instance.new("Frame")
        header.Name = "Header"
        header.LayoutOrder = 1
        header.Size = UDim2.new(1, 0, 0, 36)
        header.BackgroundTransparency = 1
        header.Parent = section

        local rarityColor = getRarityColor(sectionInfo.Name)

        local accentButton = Instance.new("TextButton")
        accentButton.Name = "CollapseButton"
        accentButton.Position = UDim2.fromOffset(0, 0)
        accentButton.Size = UDim2.fromOffset(14, 36)
        accentButton.BackgroundTransparency = 1
        accentButton.BorderSizePixel = 0
        accentButton.Text = ""
        accentButton.AutoButtonColor = false
        accentButton.Parent = header

        local accent = Instance.new("Frame")
        accent.Name = "Accent"
        accent.AnchorPoint = Vector2.new(0.5, 0.5)
        accent.Position = UDim2.fromScale(0.5, 0.5)
        accent.Size = UDim2.fromOffset(6, 25)
        accent.BackgroundColor3 = rarityColor
        accent.BorderSizePixel = 0
        accent.Parent = accentButton
        addCorner(accent, 4)

        local headerTitle = Instance.new("TextLabel")
        headerTitle.Position = UDim2.fromOffset(20, 0)
        headerTitle.Size = UDim2.new(1, -20, 1, 0)
        headerTitle.BackgroundTransparency = 1
        headerTitle.Text = sectionInfo.Label
        headerTitle.TextColor3 = rarityColor
        headerTitle.TextSize = 20
        headerTitle.TextXAlignment = Enum.TextXAlignment.Left
        headerTitle.Font = Enum.Font.GothamBold
        headerTitle.Parent = header

        local glow = Instance.new("UIStroke")
        glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        glow.Color = rarityColor
        glow.Thickness = 1
        glow.Transparency = 0.72
        glow.Parent = headerTitle

        local line = Instance.new("Frame")
        line.AnchorPoint = Vector2.new(1, 0.5)
        line.Position = UDim2.new(1, 0, 0.5, 0)
        line.Size = UDim2.new(1, -175, 0, 1)
        line.BackgroundColor3 = rarityColor
        line.BackgroundTransparency = 0.7
        line.BorderSizePixel = 0
        line.Parent = header

        local content = Instance.new("Frame")
        content.Name = "Cards"
        content.LayoutOrder = 2
        content.Size = UDim2.new(1, 0, 0, 0)
        content.AutomaticSize = Enum.AutomaticSize.Y
        content.BackgroundTransparency = 1
        content.Parent = section

        local contentGrid = Instance.new("UIGridLayout")
        contentGrid.CellSize = UDim2.fromOffset(132, 158)
        contentGrid.CellPadding = UDim2.fromOffset(12, 12)
        contentGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
        contentGrid.SortOrder = Enum.SortOrder.LayoutOrder
        contentGrid.Parent = content

        local sectionData = {
            Frame = section,
            Content = content,
            Accent = accent,
            CollapseButton = accentButton,
            VisibleCards = 0,
            Collapsed = false
        }

        raritySectionObjects[sectionInfo.Name] = sectionData

        accentButton.MouseEnter:Connect(function()
            tween(accent, {
                Size = UDim2.fromOffset(8, 29),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }, TWEEN_FAST)
        end)

        accentButton.MouseLeave:Connect(function()
            tween(accent, {
                Size = UDim2.fromOffset(6, 25),
                BackgroundColor3 = rarityColor
            }, TWEEN_FAST)
        end)

        accentButton.MouseButton1Click:Connect(function()
            sectionData.Collapsed = not sectionData.Collapsed
            content.Visible = not sectionData.Collapsed

            tween(accent, {
                Size = sectionData.Collapsed
                    and UDim2.fromOffset(25, 6)
                    or UDim2.fromOffset(6, 25)
            }, TWEEN_FAST)
        end)

        return sectionData
    end

    for index, sectionInfo in ipairs(RARITY_SECTIONS) do
        createRaritySection(sectionInfo, index)
    end

    local emptyLabel = Instance.new("TextLabel")
    emptyLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    emptyLabel.Position = UDim2.fromScale(0.5, 0.5)
    emptyLabel.Size = UDim2.new(1, -40, 0, 70)
    emptyLabel.BackgroundTransparency = 1
    emptyLabel.Text = "Предметы не найдены"
    emptyLabel.TextColor3 = COLORS.TextMuted
    emptyLabel.TextSize = 17
    emptyLabel.Font = Enum.Font.GothamMedium
    emptyLabel.Visible = false
    emptyLabel.Parent = list

    local footer = Instance.new("Frame")
    footer.AnchorPoint = Vector2.new(0, 1)
    footer.Position = UDim2.new(0, 24, 1, -20)
    footer.Size = UDim2.new(1, -48, 0, 54)
    footer.BackgroundTransparency = 1
    footer.Parent = main

    local cancelButton = Instance.new("TextButton")
    cancelButton.Size = UDim2.fromOffset(145, 50)
    cancelButton.BackgroundColor3 = COLORS.SurfaceLight
    cancelButton.BackgroundTransparency = 0.18
    cancelButton.BorderSizePixel = 0
    cancelButton.Text = "ОТМЕНА"
    cancelButton.TextColor3 = COLORS.TextMuted
    cancelButton.TextSize = 13
    cancelButton.Font = Enum.Font.GothamBold
    cancelButton.AutoButtonColor = false
    cancelButton.Parent = footer

    addCorner(cancelButton, 14)

    local cancelStroke = addStroke(
        cancelButton,
        COLORS.Purple,
        1,
        0.6
    )

    local confirmButton = Instance.new("TextButton")
    confirmButton.AnchorPoint = Vector2.new(1, 0)
    confirmButton.Position = UDim2.fromScale(1, 0)
    confirmButton.Size = UDim2.fromOffset(245, 50)
    confirmButton.BackgroundTransparency = 1
    confirmButton.BorderSizePixel = 0
    confirmButton.Text = ""
    confirmButton.AutoButtonColor = false
    confirmButton.ClipsDescendants = false
    confirmButton.Parent = footer

    local confirmBackground = Instance.new("Frame")
    confirmBackground.Name = "Background"
    confirmBackground.Size = UDim2.fromScale(1, 1)
    confirmBackground.BackgroundColor3 = COLORS.Purple
    confirmBackground.BorderSizePixel = 0
    confirmBackground.Parent = confirmButton

    addCorner(confirmBackground, 14)

    addGradient(confirmBackground, {
        ColorSequenceKeypoint.new(0, COLORS.Purple),
        ColorSequenceKeypoint.new(0.5, COLORS.Pink),
        ColorSequenceKeypoint.new(1, COLORS.Blue)
    }, 12)

    local confirmStroke = addStroke(
        confirmBackground,
        COLORS.PurpleLight,
        1.5,
        0.25
    )

    local confirmGlow = createGlow(
        confirmBackground,
        COLORS.Purple,
        16,
        0.86
    )

    local confirmText = Instance.new("TextLabel")
    confirmText.Name = "ButtonText"
    confirmText.Size = UDim2.fromScale(1, 1)
    confirmText.BackgroundTransparency = 1
    confirmText.Text = "ПОДТВЕРДИТЬ ВЫБОР"
    confirmText.TextColor3 = Color3.fromRGB(225, 203, 245)
    confirmText.TextTransparency = 0.1
    confirmText.TextSize = 13
    confirmText.Font = Enum.Font.GothamBold
    confirmText.ZIndex = confirmBackground.ZIndex + 3
    confirmText.Parent = confirmButton

    local confirmScale = Instance.new("UIScale")
    confirmScale.Scale = 1
    confirmScale.Parent = confirmButton

    local function updateCounter()
        local count = 0

        for _ in pairs(selectedItems) do
            count += 1
        end

        selectionCounter.Text = string.format(
            "Выбрано: %d",
            count
        )

        if count > 0 then
            selectionCounter.TextColor3 = Color3.fromRGB(215, 110, 255)
        else
            selectionCounter.TextColor3 = COLORS.PurpleLight
        end
    end

    local function setCardSelected(cardData, selected)
        cardData.Selected = selected

        if selected then
            selectedItems[cardData.Item] = true
        else
            selectedItems[cardData.Item] = nil
        end

        if selected then
            tween(cardData.Card, {
                BackgroundColor3 = Color3.fromRGB(65, 37, 101),
                BackgroundTransparency = 0
            }, TWEEN_FAST)

            tween(cardData.Stroke, {
                Transparency = 0,
                Thickness = 2
            }, TWEEN_FAST)

            cardData.Check.Visible = true
            cardData.CheckScale.Scale = 0.55

            tween(cardData.CheckScale, {
                Scale = 1
            }, TweenInfo.new(
                0.28,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ))

            tween(cardData.CheckShort, {
                BackgroundTransparency = 0
            }, TWEEN_FAST)

            tween(cardData.CheckLong, {
                BackgroundTransparency = 0
            }, TWEEN_FAST)

            tween(cardData.CheckShortGlow, {
                BackgroundTransparency = 0.48
            }, TWEEN_FAST)

            tween(cardData.CheckLongGlow, {
                BackgroundTransparency = 0.48
            }, TWEEN_FAST)

            tween(cardData.IconScale, {
                Scale = 1.07
            }, TWEEN_FAST)
        else
            tween(cardData.Card, {
                BackgroundColor3 = COLORS.SurfaceLight,
                BackgroundTransparency = 0.12
            }, TWEEN_FAST)

            tween(cardData.Stroke, {
                Transparency = 0.58,
                Thickness = 1
            }, TWEEN_FAST)

            tween(cardData.CheckScale, {
                Scale = 0.55
            }, TweenInfo.new(
                0.18,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.In
            ))

            tween(cardData.CheckShort, {
                BackgroundTransparency = 1
            }, TWEEN_FAST)

            tween(cardData.CheckLong, {
                BackgroundTransparency = 1
            }, TWEEN_FAST)

            tween(cardData.CheckShortGlow, {
                BackgroundTransparency = 1
            }, TWEEN_FAST)

            tween(cardData.CheckLongGlow, {
                BackgroundTransparency = 1
            }, TWEEN_FAST)

            task.delay(0.18, function()
                if cardData.Check.Parent and not cardData.Selected then
                    cardData.Check.Visible = false
                end
            end)

            tween(cardData.IconScale, {
                Scale = 1
            }, TWEEN_FAST)
        end

        updateCounter()
    end

    local function playCardShine(cardData)
        if cardData.ShineBusy then
            return
        end

        cardData.ShineBusy = true
        cardData.Shine.Position = UDim2.new(-0.45, 0, 0, 0)

        local shineTween = tween(
            cardData.Shine,
            {
                Position = UDim2.new(
                    1.2,
                    0,
                    0,
                    0
                )
            },
            TweenInfo.new(
                0.48,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            )
        )

        if shineTween then
            shineTween.Completed:Connect(function()
                cardData.ShineBusy = false
                cardData.Shine.Position = UDim2.new(
                    -0.45,
                    0,
                    0,
                    0
                )
            end)
        else
            cardData.ShineBusy = false
        end
    end

    local function createItemCard(item, index)
        local card = Instance.new("TextButton")
        card.Name = "ItemCard"
        card.LayoutOrder = index
        card.BackgroundColor3 = COLORS.SurfaceLight
        card.BackgroundTransparency = 0.12
        card.BorderSizePixel = 0
        card.Text = ""
        card.AutoButtonColor = false
        card.ClipsDescendants = true

        local sectionData = raritySectionObjects[item.Rarity]
            or raritySectionObjects.Unknown

        card.Parent = sectionData.Content
        sectionData.VisibleCards += 1
        sectionData.Frame.Visible = true

        addCorner(card, 16)

        local stroke = addStroke(
            card,
            COLORS.Purple,
            1,
            0.58
        )

        local shineClip = Instance.new("Frame")
        shineClip.Name = "ShineClip"
        shineClip.Size = UDim2.fromScale(1, 1)
        shineClip.BackgroundTransparency = 1
        shineClip.BorderSizePixel = 0
        shineClip.ClipsDescendants = true
        shineClip.ZIndex = card.ZIndex + 5
        shineClip.Parent = card

        addCorner(shineClip, 16)

        local shine = Instance.new("Frame")
        shine.Name = "Shine"
        shine.Position = UDim2.new(-0.45, 0, 0, 0)
        shine.Size = UDim2.new(0.32, 0, 1, 0)
        shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        shine.BackgroundTransparency = 0
        shine.BorderSizePixel = 0
        shine.ZIndex = shineClip.ZIndex + 1
        shine.Parent = shineClip

        local shineGradient = Instance.new("UIGradient")
        shineGradient.Rotation = 18
        shineGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(
                0,
                Color3.fromRGB(153, 82, 255)
            ),
            ColorSequenceKeypoint.new(
                0.5,
                Color3.fromRGB(245, 220, 255)
            ),
            ColorSequenceKeypoint.new(
                1,
                Color3.fromRGB(116, 77, 255)
            )
        })
        shineGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.35, 0.96),
            NumberSequenceKeypoint.new(0.48, 0.72),
            NumberSequenceKeypoint.new(0.52, 0.72),
            NumberSequenceKeypoint.new(0.65, 0.96),
            NumberSequenceKeypoint.new(1, 1)
        })
        shineGradient.Parent = shine

        local iconContainer = Instance.new("Frame")
        iconContainer.Position = UDim2.fromOffset(10, 10)
        iconContainer.Size = UDim2.new(1, -20, 0, 103)
        iconContainer.BackgroundColor3 = item.ItemNameColor or COLORS.Background
        iconContainer.BackgroundTransparency = 0
        iconContainer.BorderSizePixel = 0
        iconContainer.BorderMode = Enum.BorderMode.Outline
        iconContainer.ClipsDescendants = true
        iconContainer.ZIndex = card.ZIndex + 1
        iconContainer.Parent = card

        addCorner(iconContainer, 12)

        if item.ItemNameBG and item.ItemNameBG:IsA("ImageLabel") then
            local sourceBG = item.ItemNameBG

            local rarityBackground = Instance.new("ImageLabel")
            rarityBackground.Name = "ItemRarityBackground"
            rarityBackground.AnchorPoint = Vector2.new(0, 0)
            rarityBackground.Position = UDim2.fromScale(0, 0)
            rarityBackground.Size = UDim2.fromScale(1, 1)
            rarityBackground.BackgroundTransparency = 1
            rarityBackground.BorderSizePixel = 0
            rarityBackground.Image = sourceBG.Image
            rarityBackground.ImageColor3 = sourceBG.ImageColor3
            rarityBackground.ImageTransparency = sourceBG.ImageTransparency
            rarityBackground.ScaleType = sourceBG.ScaleType
            rarityBackground.SliceCenter = sourceBG.SliceCenter
            rarityBackground.SliceScale = sourceBG.SliceScale
            rarityBackground.ImageRectOffset = sourceBG.ImageRectOffset
            rarityBackground.ImageRectSize = sourceBG.ImageRectSize
            rarityBackground.TileSize = sourceBG.TileSize
            rarityBackground.ResampleMode = sourceBG.ResampleMode
            rarityBackground.Rotation = 0
            rarityBackground.Visible = true
            rarityBackground.ZIndex = iconContainer.ZIndex + 1
            rarityBackground.Parent = iconContainer

            addCorner(rarityBackground, 12)
        end

        local function createEdgeShade(name, rotation, transparencySequence)
            local shade = Instance.new("Frame")
            shade.Name = name
            shade.Size = UDim2.fromScale(1, 1)
            shade.Position = UDim2.fromScale(0, 0)
            shade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            shade.BackgroundTransparency = 0
            shade.BorderSizePixel = 0
            shade.ZIndex = iconContainer.ZIndex + 2
            shade.Parent = iconContainer

            local shadeGradient = Instance.new("UIGradient")
            shadeGradient.Rotation = rotation
            shadeGradient.Transparency = transparencySequence
            shadeGradient.Parent = shade

            addCorner(shade, 12)
            return shade
        end

        createEdgeShade(
            "TopShade",
            90,
            NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.70),
                NumberSequenceKeypoint.new(0.30, 0.90),
                NumberSequenceKeypoint.new(0.58, 1),
                NumberSequenceKeypoint.new(1, 1)
            })
        )

        createEdgeShade(
            "BottomShade",
            90,
            NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.48, 1),
                NumberSequenceKeypoint.new(0.76, 0.92),
                NumberSequenceKeypoint.new(1, 0.64)
            })
        )

        createEdgeShade(
            "RightShade",
            0,
            NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.54, 1),
                NumberSequenceKeypoint.new(0.82, 0.92),
                NumberSequenceKeypoint.new(1, 0.76)
            })
        )

        local purpleBlend = Instance.new("Frame")
        purpleBlend.Name = "GalaxyPurpleBlend"
        purpleBlend.Size = UDim2.fromScale(1, 1)
        purpleBlend.Position = UDim2.fromScale(0, 0)
        purpleBlend.BackgroundColor3 = Color3.fromRGB(58, 28, 96)
        purpleBlend.BackgroundTransparency = 0.62
        purpleBlend.BorderSizePixel = 0
        purpleBlend.ZIndex = iconContainer.ZIndex + 4
        purpleBlend.Parent = iconContainer

        addCorner(purpleBlend, 12)

        local purpleBlendGradient = Instance.new("UIGradient")
        purpleBlendGradient.Rotation = 35
        purpleBlendGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 38, 145)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(58, 28, 96)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 18, 72))
        })
        purpleBlendGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.18),
            NumberSequenceKeypoint.new(0.5, 0.36),
            NumberSequenceKeypoint.new(1, 0.16)
        })
        purpleBlendGradient.Parent = purpleBlend

        local icon = Instance.new("ImageLabel")
        icon.AnchorPoint = Vector2.new(0.5, 0.5)
        icon.Position = UDim2.fromScale(0.5, 0.5)
        icon.Size = UDim2.new(1, -18, 1, -18)
        icon.BackgroundTransparency = 1
        icon.Image = item.Icon or ""
        icon.ScaleType = Enum.ScaleType.Fit
        icon.ZIndex = iconContainer.ZIndex + 10
        icon.Parent = iconContainer

        local amountBadge = Instance.new("TextLabel")
        amountBadge.Name = "AmountBadge"
        amountBadge.AnchorPoint = Vector2.new(1, 0)
        amountBadge.Position = UDim2.new(1, -8, 0, 6)
        amountBadge.Size = UDim2.fromOffset(40, 18)
        amountBadge.BackgroundTransparency = 1
        amountBadge.BorderSizePixel = 0
        amountBadge.Text = tostring(item.Amount or 1) .. "x"
        amountBadge.TextColor3 = Color3.fromRGB(235, 120, 255)
        amountBadge.TextStrokeTransparency = 0.15
        amountBadge.TextStrokeColor3 = Color3.fromRGB(95, 20, 170)
        amountBadge.TextXAlignment = Enum.TextXAlignment.Right
        amountBadge.Font = Enum.Font.GothamBold
        amountBadge.TextSize = 15
        amountBadge.ZIndex = icon.ZIndex + 2
        amountBadge.Parent = iconContainer

        local amountGlow = Instance.new("UIStroke")
        amountGlow.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        amountGlow.Color = Color3.fromRGB(220, 90, 255)
        amountGlow.Thickness = 1.4
        amountGlow.Transparency = 0.45
        amountGlow.Parent = amountBadge

        if item.ItemTags and item.ItemTags:IsA("GuiObject") then
            local itemTags = item.ItemTags:Clone()
            itemTags.Name = "ItemTags"
            itemTags.AnchorPoint = Vector2.new(0, 1)
            itemTags.Position = UDim2.new(0, 9, 1, -9)
            itemTags.BackgroundTransparency = 1
            itemTags.BorderSizePixel = 0
            itemTags.Visible = true
            itemTags.ZIndex = icon.ZIndex + 3
            itemTags.Parent = iconContainer

            for _, descendant in ipairs(itemTags:GetDescendants()) do
                if descendant:IsA("UIStroke") then
                    descendant:Destroy()

                elseif descendant:IsA("UIGradient") then
                    local dimmedKeypoints = {}

                    for _, keypoint in ipairs(descendant.Transparency.Keypoints) do
                        table.insert(
                            dimmedKeypoints,
                            NumberSequenceKeypoint.new(
                                keypoint.Time,
                                math.clamp(keypoint.Value + 0.22, 0, 1)
                            )
                        )
                    end

                    descendant.Transparency = NumberSequence.new(dimmedKeypoints)

                elseif descendant:IsA("GuiObject") then
                    descendant.Visible = true
                    descendant.ZIndex = itemTags.ZIndex + 1
                    descendant.BorderSizePixel = 0
                end
            end

            local tagScale = Instance.new("UIScale")
            tagScale.Scale = 1.12
            tagScale.Parent = itemTags
        end

        local iconScale = Instance.new("UIScale")
        iconScale.Scale = 1
        iconScale.Parent = icon

        local itemName = Instance.new("TextLabel")
        itemName.Position = UDim2.fromOffset(7, 118)
        itemName.Size = UDim2.new(1, -14, 0, 32)
        itemName.BackgroundTransparency = 1
        itemName.Text = item.Name or "Unknown Item"
        itemName.TextColor3 = COLORS.Text
        itemName.TextSize = 15
        itemName.TextTruncate = Enum.TextTruncate.AtEnd
        itemName.TextWrapped = false
        itemName.Font = Enum.Font.GothamSemibold
        itemName.TextStrokeTransparency = 1
        itemName.ZIndex = card.ZIndex + 3
        itemName.Parent = card

        local check = Instance.new("Frame")
        check.Name = "NeonCheck"
        check.AnchorPoint = Vector2.new(1, 1)
        check.Position = UDim2.new(1, -9, 1, -9)
        check.Size = UDim2.fromOffset(27, 25)
        check.BackgroundTransparency = 1
        check.BorderSizePixel = 0
        check.ZIndex = shineClip.ZIndex + 4
        check.Visible = false
        check.Parent = card

        local checkScale = Instance.new("UIScale")
        checkScale.Scale = 0.55
        checkScale.Parent = check

        local checkShortGlow = Instance.new("Frame")
        checkShortGlow.Name = "ShortGlow"
        checkShortGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        checkShortGlow.Position = UDim2.fromOffset(8, 15)
        checkShortGlow.Size = UDim2.fromOffset(11, 6)
        checkShortGlow.Rotation = 43
        checkShortGlow.BackgroundColor3 = Color3.fromRGB(225, 105, 255)
        checkShortGlow.BackgroundTransparency = 0.55
        checkShortGlow.BorderSizePixel = 0
        checkShortGlow.ZIndex = check.ZIndex
        checkShortGlow.Parent = check
        addCorner(checkShortGlow, 100)

        local checkShort = Instance.new("Frame")
        checkShort.Name = "Short"
        checkShort.AnchorPoint = Vector2.new(0.5, 0.5)
        checkShort.Position = checkShortGlow.Position
        checkShort.Size = UDim2.fromOffset(9, 3)
        checkShort.Rotation = 43
        checkShort.BackgroundColor3 = Color3.fromRGB(246, 186, 255)
        checkShort.BackgroundTransparency = 1
        checkShort.BorderSizePixel = 0
        checkShort.ZIndex = check.ZIndex + 1
        checkShort.Parent = check
        addCorner(checkShort, 100)

        local checkLongGlow = Instance.new("Frame")
        checkLongGlow.Name = "LongGlow"
        checkLongGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        checkLongGlow.Position = UDim2.fromOffset(17, 11)
        checkLongGlow.Size = UDim2.fromOffset(20, 6)
        checkLongGlow.Rotation = -43
        checkLongGlow.BackgroundColor3 = Color3.fromRGB(181, 65, 255)
        checkLongGlow.BackgroundTransparency = 0.55
        checkLongGlow.BorderSizePixel = 0
        checkLongGlow.ZIndex = check.ZIndex
        checkLongGlow.Parent = check
        addCorner(checkLongGlow, 100)

        local checkLong = Instance.new("Frame")
        checkLong.Name = "Long"
        checkLong.AnchorPoint = Vector2.new(0.5, 0.5)
        checkLong.Position = checkLongGlow.Position
        checkLong.Size = UDim2.fromOffset(18, 3)
        checkLong.Rotation = -43
        checkLong.BackgroundColor3 = Color3.fromRGB(225, 125, 255)
        checkLong.BackgroundTransparency = 1
        checkLong.BorderSizePixel = 0
        checkLong.ZIndex = check.ZIndex + 1
        checkLong.Parent = check
        addCorner(checkLong, 100)

        local cardData = {
            Card = card,
            Item = item,
            Name = string.lower(item.Name or ""),
            Rarity = item.Rarity or "Unknown",
            Section = sectionData,
            Stroke = stroke,
            Check = check,
            CheckScale = checkScale,
            CheckShort = checkShort,
            CheckLong = checkLong,
            CheckShortGlow = checkShortGlow,
            CheckLongGlow = checkLongGlow,
            IconScale = iconScale,
            Shine = shine,
            ShineBusy = false,
            Selected = false
        }

        table.insert(cards, cardData)

        card.MouseEnter:Connect(function()
            playCardShine(cardData)

            if cardData.Selected then
                return
            end

            tween(card, {
                BackgroundColor3 = COLORS.SurfaceHover,
                BackgroundTransparency = 0
            }, TWEEN_FAST)

            tween(stroke, {
                Transparency = 0.18,
                Thickness = 1.5
            }, TWEEN_FAST)

            tween(iconScale, {
                Scale = 1.045
            }, TWEEN_FAST)
        end)

        card.MouseLeave:Connect(function()
            if cardData.Selected then
                return
            end

            tween(card, {
                BackgroundColor3 = COLORS.SurfaceLight,
                BackgroundTransparency = 0.12
            }, TWEEN_FAST)

            tween(stroke, {
                Transparency = 0.58,
                Thickness = 1
            }, TWEEN_FAST)

            tween(iconScale, {
                Scale = 1
            }, TWEEN_FAST)
        end)

        card.MouseButton1Click:Connect(function()
            setCardSelected(
                cardData,
                not cardData.Selected
            )
        end)
    end

    local rarityLocalOrder = {}

    for _, sectionInfo in ipairs(RARITY_SECTIONS) do
        rarityLocalOrder[sectionInfo.Name] = 0
    end

    for _, item in ipairs(items) do
        local rarityName = item.Rarity or "Unknown"
        rarityLocalOrder[rarityName] = (rarityLocalOrder[rarityName] or 0) + 1
        createItemCard(item, rarityLocalOrder[rarityName])
    end

    for _, sectionData in pairs(raritySectionObjects) do
        sectionData.Frame.Visible = sectionData.VisibleCards > 0
    end

    emptyLabel.Visible = #items == 0

    searchBox.Focused:Connect(function()
        tween(searchStroke, {
            Transparency = 0.08,
            Thickness = 1.5
        }, TWEEN_FAST)

        tween(searchIcon.CircleStroke, {
            Color = COLORS.Pink,
            Thickness = 2.3
        }, TWEEN_FAST)

        tween(searchIcon.Handle, {
            BackgroundColor3 = COLORS.Pink
        }, TWEEN_FAST)

        tween(searchIcon.Glow, {
            BackgroundTransparency = 0.72,
            Size = UDim2.fromOffset(27, 27)
        }, TWEEN_FAST)
    end)

    searchBox.FocusLost:Connect(function()
        tween(searchStroke, {
            Transparency = 0.62,
            Thickness = 1
        }, TWEEN_FAST)

        tween(searchIcon.CircleStroke, {
            Color = COLORS.PurpleLight,
            Thickness = 2
        }, TWEEN_FAST)

        tween(searchIcon.Handle, {
            BackgroundColor3 = COLORS.PurpleLight
        }, TWEEN_FAST)

        tween(searchIcon.Glow, {
            BackgroundTransparency = 0.88,
            Size = UDim2.fromOffset(22, 22)
        }, TWEEN_FAST)
    end)

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = string.lower(searchBox.Text)
        local visibleCount = 0
        local visibleByRarity = {}

        for _, sectionInfo in ipairs(RARITY_SECTIONS) do
            visibleByRarity[sectionInfo.Name] = 0
        end

        for _, cardData in ipairs(cards) do
            local matches =
                query == ""
                or string.find(cardData.Name, query, 1, true) ~= nil
                or string.find(
                    string.lower(cardData.Rarity or ""),
                    query,
                    1,
                    true
                ) ~= nil

            cardData.Card.Visible = matches

            if matches then
                visibleCount += 1
                local rarityName = cardData.Rarity or "Unknown"
                visibleByRarity[rarityName] =
                    (visibleByRarity[rarityName] or 0) + 1
            end
        end

        for rarityName, sectionData in pairs(raritySectionObjects) do
            local hasVisibleItems =
                (visibleByRarity[rarityName] or 0) > 0

            sectionData.Frame.Visible = hasVisibleItems
            sectionData.Content.Visible =
                hasVisibleItems and not sectionData.Collapsed
        end

        emptyLabel.Visible = visibleCount == 0
    end)

    local function closeUI()
        if closing then
            return
        end

        closing = true
        reopenButton.Visible = false

        if inputConnection then
            inputConnection:Disconnect()
            inputConnection = nil
        end

        local closeInfo = TweenInfo.new(
            0.48,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.InOut
        )

        local scaleInfo = TweenInfo.new(
            0.52,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.In
        )

        for _, object in ipairs(main:GetDescendants()) do
            if object:IsA("TextLabel")
                or object:IsA("TextButton")
                or object:IsA("TextBox")
            then
                tween(object, {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }, closeInfo)
            end

            if object:IsA("ImageLabel")
                or object:IsA("ImageButton")
            then
                tween(object, {
                    ImageTransparency = 1
                }, closeInfo)
            end

            if object:IsA("GuiObject")
                and object.BackgroundTransparency < 1
            then
                tween(object, {
                    BackgroundTransparency = 1
                }, closeInfo)
            end

            if object:IsA("UIStroke") then
                tween(object, {
                    Transparency = 1
                }, closeInfo)
            end
        end

        tween(blur, {
            Size = 0
        }, closeInfo)

        tween(overlay, {
            BackgroundTransparency = 1
        }, closeInfo)

        tween(mainScale, {
            Scale = 0.78
        }, scaleInfo)

        tween(main, {
            BackgroundTransparency = 1
        }, closeInfo)

        task.delay(0.54, function()
            if screenGui.Parent then
                screenGui:Destroy()
            end

            if blur.Parent then
                blur:Destroy()
            end
        end)
    end

    local guiHidden = false
    local hideAnimating = false
    local savedMainPosition = main.Position

    local function showReopenButton()
        reopenButton.Visible = true
        reopenButton.BackgroundTransparency = 1
        reopenStroke.Transparency = 1
        reopenGlow.BackgroundTransparency = 1
        reopenScale.Scale = 0.7

        tween(reopenButton, {
            BackgroundTransparency = 0
        }, TWEEN_NORMAL)

        tween(reopenStroke, {
            Transparency = 0.15
        }, TWEEN_NORMAL)

        tween(reopenGlow, {
            BackgroundTransparency = 0.78
        }, TWEEN_NORMAL)

        tween(reopenScale, {
            Scale = 1
        }, TweenInfo.new(
            0.34,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ))

        reopenButton.Position = UDim2.new(
            reopenButton.Position.X.Scale,
            reopenButton.Position.X.Offset,
            reopenButton.Position.Y.Scale,
            reopenButton.Position.Y.Offset - 35
        )

    end

    local function hideReopenButton()
        tween(reopenButton, {
            BackgroundTransparency = 1
        }, TWEEN_FAST)

        tween(reopenStroke, {
            Transparency = 1
        }, TWEEN_FAST)

        tween(reopenGlow, {
            BackgroundTransparency = 1
        }, TWEEN_FAST)

        tween(reopenScale, {
            Scale = 0.75
        }, TWEEN_FAST)

        task.delay(0.18, function()
            if reopenButton.Parent and not guiHidden then
                reopenButton.Visible = false
            end
        end)
    end

    local function hideUI()
        if closing or guiHidden or hideAnimating then
            return
        end

        hideAnimating = true
        savedMainPosition = main.Position

        tween(blur, {
            Size = 0
        }, TweenInfo.new(
            0.32,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.InOut
        ))

        tween(overlay, {
            BackgroundTransparency = 1
        }, TweenInfo.new(
            0.32,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.InOut
        ))

        tween(mainScale, {
            Scale = 0.72
        }, TweenInfo.new(
            0.34,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ))

        tween(main, {
            BackgroundTransparency = 1
        }, TweenInfo.new(
            0.30,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ))

        task.delay(0.34, function()
            if closing or not main.Parent then
                return
            end

            main.Visible = false

            overlay.Active = false
            overlay.Selectable = false
            overlay.Visible = false

            guiHidden = true
            hideAnimating = false
            showReopenButton()
        end)
    end

    local function showUI()
        if closing or not guiHidden or hideAnimating then
            return
        end

        hideAnimating = true
        guiHidden = false
        hideReopenButton()

        overlay.Visible = true
        overlay.Active = true
        overlay.Selectable = false

        main.Visible = true
        main.Position = savedMainPosition
        main.BackgroundTransparency = 1
        mainScale.Scale = 0.72
        overlay.BackgroundTransparency = 1
        blur.Size = 0

        tween(blur, {
            Size = 18
        }, TweenInfo.new(
            0.34,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ))

        tween(overlay, {
            BackgroundTransparency = 0.28
        }, TweenInfo.new(
            0.34,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ))

        tween(mainScale, {
            Scale = 1
        }, TweenInfo.new(
            0.38,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ))

        tween(main, {
            BackgroundTransparency = 0.04
        }, TweenInfo.new(
            0.30,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ))

        task.delay(0.38, function()
            if closing then
                return
            end

            hideAnimating = false
        end)
    end

    do
        local dragging = false
        local moved = false
        local dragStart = nil
        local startPosition = nil

        local function toVector2(position)
            return Vector2.new(position.X, position.Y)
        end

        local function pointInside(guiObject, point)
            if not guiObject or not guiObject.Visible then
                return false
            end

            local pos = guiObject.AbsolutePosition
            local size = guiObject.AbsoluteSize

            return point.X >= pos.X
                and point.X <= pos.X + size.X
                and point.Y >= pos.Y
                and point.Y <= pos.Y + size.Y
        end

        local function updateReopenPosition(point)
            if not dragging or not dragStart or not startPosition then
                return
            end

            local delta = point - dragStart

            if delta.Magnitude > 5 then
                moved = true
            end

            reopenButton.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )

        end

        UserInputService.InputBegan:Connect(function(input)
            if closing or not guiHidden or hideAnimating then
                return
            end

            if input.UserInputType ~= Enum.UserInputType.MouseButton1
                and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local point = toVector2(input.Position)

            if not pointInside(reopenButton, point) then
                return
            end

            dragging = true
            moved = false
            dragStart = point
            startPosition = reopenButton.Position
        end)

        UserInputService.InputChanged:Connect(function(input)
            if not dragging then
                return
            end

            if input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch then
                updateReopenPosition(toVector2(input.Position))
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if not dragging then
                return
            end

            if input.UserInputType ~= Enum.UserInputType.MouseButton1
                and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local shouldOpen = not moved and guiHidden

            dragging = false
            dragStart = nil
            startPosition = nil

            if shouldOpen then
                showUI()
            end
        end)
    end

    do
        local dragging = false
        local dragStart = nil
        local startPosition = nil

        local excludedObjects = {
            infoButton,
            infoPanel,
            minimizeButton,
            closeButton,
            closeConfirmShade,
            selectConfirmShade,
            infoPanel,
            searchContainer,
            selectionCounter,
            list,
            cancelButton,
            confirmButton
        }

        local function toVector2(position)
            return Vector2.new(position.X, position.Y)
        end

        local function pointInside(guiObject, point)
            if not guiObject or not guiObject.Visible then
                return false
            end

            local pos = guiObject.AbsolutePosition
            local size = guiObject.AbsoluteSize

            return point.X >= pos.X
                and point.X <= pos.X + size.X
                and point.Y >= pos.Y
                and point.Y <= pos.Y + size.Y
        end

        local function isExcluded(point)
            for _, guiObject in ipairs(excludedObjects) do
                if pointInside(guiObject, point) then
                    return true
                end
            end

            return false
        end

        UserInputService.InputBegan:Connect(function(input)
            if closing or guiHidden or hideAnimating then
                return
            end

            if input.UserInputType ~= Enum.UserInputType.MouseButton1
                and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local point = toVector2(input.Position)

            if not pointInside(main, point) or isExcluded(point) then
                return
            end

            dragging = true
            dragStart = point
            startPosition = main.Position
        end)

        UserInputService.InputChanged:Connect(function(input)
            if not dragging or not dragStart or not startPosition then
                return
            end

            if input.UserInputType ~= Enum.UserInputType.MouseMovement
                and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local currentPoint = toVector2(input.Position)
            local delta = currentPoint - dragStart

            main.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )

        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1
                and input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            dragging = false
            dragStart = nil
            startPosition = nil
        end)
    end

    infoButton.MouseEnter:Connect(function()
        tween(infoText, {
            TextColor3 = Color3.fromRGB(242, 186, 255)
        }, TWEEN_FAST)

        tween(infoIcon, {
            BackgroundTransparency = 0
        }, TWEEN_FAST)

        tween(infoDot, {
            BackgroundColor3 = Color3.fromRGB(255, 225, 255)
        }, TWEEN_FAST)

        tween(infoStem, {
            BackgroundColor3 = Color3.fromRGB(255, 225, 255)
        }, TWEEN_FAST)

        tween(infoIconStroke, {
            Transparency = 0.05
        }, TWEEN_FAST)
    end)

    infoButton.MouseLeave:Connect(function()
        tween(infoText, {
            TextColor3 = COLORS.PurpleLight
        }, TWEEN_FAST)

        tween(infoIcon, {
            BackgroundTransparency = 0.18
        }, TWEEN_FAST)

        tween(infoDot, {
            BackgroundColor3 = COLORS.PurpleLight
        }, TWEEN_FAST)

        tween(infoStem, {
            BackgroundColor3 = COLORS.PurpleLight
        }, TWEEN_FAST)

        tween(infoIconStroke, {
            Transparency = 0.35
        }, TWEEN_FAST)
    end)

    infoButton.MouseButton1Click:Connect(function()
        infoPanel.Visible = true
    end)

    infoOkayButton.MouseEnter:Connect(function()
        tween(infoOkayButton, {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }, TWEEN_FAST)

        infoOkayButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        infoOkayButton.TextStrokeTransparency = 0.38
    end)

    infoOkayButton.MouseLeave:Connect(function()
        tween(infoOkayButton, {
            TextColor3 = COLORS.Text
        }, TWEEN_FAST)

        infoOkayButton.TextStrokeTransparency = 1
    end)

    infoOkayButton.MouseButton1Click:Connect(function()
        infoPanel.Visible = false
    end)

    minimizeButton.MouseEnter:Connect(function()
        tween(minimizeButton, {
            BackgroundColor3 = COLORS.Purple,
            TextColor3 = COLORS.Text,
            BackgroundTransparency = 0
        }, TWEEN_FAST)

        tween(minimizeStroke, {
            Transparency = 0.1
        }, TWEEN_FAST)
    end)

    minimizeButton.MouseLeave:Connect(function()
        tween(minimizeButton, {
            BackgroundColor3 = COLORS.SurfaceLight,
            TextColor3 = COLORS.TextMuted,
            BackgroundTransparency = 0.25
        }, TWEEN_FAST)

        tween(minimizeStroke, {
            Transparency = 0.6
        }, TWEEN_FAST)
    end)

    minimizeButton.MouseButton1Click:Connect(hideUI)

    reopenButton.MouseEnter:Connect(function()
        if not guiHidden then
            return
        end

        tween(reopenScale, {
            Scale = 1.08
        }, TWEEN_FAST)

        tween(reopenStroke, {
            Transparency = 0,
            Thickness = 2
        }, TWEEN_FAST)

        tween(reopenGlow, {
            BackgroundTransparency = 0.65
        }, TWEEN_FAST)
    end)

    reopenButton.MouseLeave:Connect(function()
        if not guiHidden then
            return
        end

        tween(reopenScale, {
            Scale = 1
        }, TWEEN_FAST)

        tween(reopenStroke, {
            Transparency = 0.15,
            Thickness = 1.5
        }, TWEEN_FAST)

        tween(reopenGlow, {
            BackgroundTransparency = 0.78
        }, TWEEN_FAST)
    end)

    closeButton.MouseEnter:Connect(function()
        tween(closeButton, {
            BackgroundColor3 = COLORS.Danger,
            TextColor3 = COLORS.Text,
            BackgroundTransparency = 0
        }, TWEEN_FAST)

        tween(closeStroke, {
            Transparency = 0.1
        }, TWEEN_FAST)
    end)

    closeButton.MouseLeave:Connect(function()
        tween(closeButton, {
            BackgroundColor3 = COLORS.SurfaceLight,
            TextColor3 = COLORS.TextMuted,
            BackgroundTransparency = 0.25
        }, TWEEN_FAST)

        tween(closeStroke, {
            Transparency = 0.6
        }, TWEEN_FAST)
    end)

    closeButton.MouseButton1Click:Connect(function()
        if closing or hideAnimating then
            return
        end

        closeConfirmShade.Visible = true
    end)

    closeNoButton.MouseEnter:Connect(function()
        tween(closeNoButton, {
            BackgroundTransparency = 0,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }, TWEEN_FAST)

        tween(closeNoStroke, {
            Transparency = 0.02,
            Thickness = 1.6
        }, TWEEN_FAST)

        closeNoButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        closeNoButton.TextStrokeTransparency = 0.48
    end)

    closeNoButton.MouseLeave:Connect(function()
        tween(closeNoButton, {
            BackgroundTransparency = 0,
            TextColor3 = COLORS.Text
        }, TWEEN_FAST)

        tween(closeNoStroke, {
            Transparency = 0.28,
            Thickness = 1
        }, TWEEN_FAST)

        closeNoButton.TextStrokeTransparency = 1
    end)

    closeYesButton.MouseEnter:Connect(function()
        tween(closeYesButton, {
            BackgroundTransparency = 0,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }, TWEEN_FAST)

        tween(closeYesStroke, {
            Transparency = 0,
            Thickness = 1.7,
            Color = Color3.fromRGB(255, 225, 235)
        }, TWEEN_FAST)

        closeYesButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        closeYesButton.TextStrokeTransparency = 0.42
    end)

    closeYesButton.MouseLeave:Connect(function()
        if closing then
            return
        end

        tween(closeYesButton, {
            BackgroundTransparency = 0,
            TextColor3 = COLORS.Text
        }, TWEEN_FAST)

        tween(closeYesStroke, {
            Transparency = 0.20,
            Thickness = 1,
            Color = Color3.fromRGB(255, 170, 192)
        }, TWEEN_FAST)

        closeYesButton.TextStrokeTransparency = 1
    end)

    closeNoButton.MouseButton1Click:Connect(function()
        closeConfirmShade.Visible = false
    end)

    closeConfirmShade.MouseButton1Click:Connect(function()
        closeConfirmShade.Visible = false
    end)

    closeConfirmWindow.InputBegan:Connect(function()
    end)

    closeYesButton.MouseButton1Click:Connect(function()
        if closing then
            return
        end

        tween(closeYesButton, {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.18
        }, TWEEN_FAST)

        task.delay(0.08, function()
            closeUI()
        end)
    end)

    cancelButton.MouseButton1Click:Connect(function()
        for _, cardData in ipairs(cards) do
            if cardData.Selected then
                setCardSelected(cardData, false)
            end
        end
    end)

    cancelButton.MouseEnter:Connect(function()
        tween(cancelButton, {
            BackgroundTransparency = 0,
            TextColor3 = COLORS.Text
        }, TWEEN_FAST)

        tween(cancelStroke, {
            Transparency = 0.15,
            Thickness = 1.5
        }, TWEEN_FAST)
    end)

    cancelButton.MouseLeave:Connect(function()
        tween(cancelButton, {
            BackgroundTransparency = 0.18,
            TextColor3 = COLORS.TextMuted
        }, TWEEN_FAST)

        tween(cancelStroke, {
            Transparency = 0.6,
            Thickness = 1
        }, TWEEN_FAST)
    end)

    confirmButton.MouseEnter:Connect(function()
        tween(confirmScale, {
            Scale = 1.035
        }, TWEEN_FAST)

        tween(confirmText, {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextTransparency = 0,
            TextSize = 14
        }, TWEEN_FAST)

        tween(confirmGlow, {
            BackgroundTransparency = 0.68,
            Size = UDim2.new(1, 22, 1, 22)
        }, TWEEN_FAST)

        tween(confirmStroke, {
            Transparency = 0,
            Thickness = 2
        }, TWEEN_FAST)
    end)

    confirmButton.MouseLeave:Connect(function()
        tween(confirmScale, {
            Scale = 1
        }, TWEEN_FAST)

        tween(confirmText, {
            TextColor3 = Color3.fromRGB(225, 203, 245),
            TextTransparency = 0.1,
            TextSize = 13
        }, TWEEN_FAST)

        tween(confirmGlow, {
            BackgroundTransparency = 0.86,
            Size = UDim2.new(1, 16, 1, 16)
        }, TWEEN_FAST)

        tween(confirmStroke, {
            Transparency = 0.25,
            Thickness = 1.5
        }, TWEEN_FAST)
    end)

    confirmButton.MouseButton1Click:Connect(function()
        local hasSelection = false

        for _, cardData in ipairs(cards) do
            if cardData.Selected then
                hasSelection = true
                break
            end
        end

        if not hasSelection then
            local originalText = "ПОДТВЕРДИТЬ ВЫБОР"

            confirmText.Text = "СНАЧАЛА ВЫБЕРИТЕ ПРЕДМЕТ"
            confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
            confirmText.TextTransparency = 0
            confirmText.TextSize = 12

            tween(confirmBackground, {
                BackgroundColor3 = COLORS.Danger
            }, TWEEN_FAST)

            task.delay(1.2, function()
                if confirmText.Parent then
                    confirmText.Text = originalText
                    confirmText.TextColor3 = Color3.fromRGB(225, 203, 245)
                    confirmText.TextTransparency = 0.1
                    confirmText.TextSize = 13
                    confirmBackground.BackgroundColor3 = COLORS.Purple
                end
            end)

            return
        end

        selectConfirmShade.Visible = true
    end)

    selectNoButton.MouseEnter:Connect(function()
        tween(selectNoButton, {
            BackgroundTransparency = 0,
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }, TWEEN_FAST)

        tween(selectNoStroke, {
            Transparency = 0.02,
            Thickness = 1.6,
            Color = Color3.fromRGB(245, 220, 255)
        }, TWEEN_FAST)

        selectNoButton.TextStrokeColor3 =
            Color3.fromRGB(255, 255, 255)

        selectNoButton.TextStrokeTransparency = 0.42
    end)

    selectNoButton.MouseLeave:Connect(function()
        tween(selectNoButton, {
            BackgroundTransparency = 0,
            TextColor3 = COLORS.Text
        }, TWEEN_FAST)

        tween(selectNoStroke, {
            Transparency = 0.28,
            Thickness = 1,
            Color = COLORS.PurpleBright
        }, TWEEN_FAST)

        selectNoButton.TextStrokeTransparency = 1
    end)

    selectYesButton.MouseEnter:Connect(function()
        tween(selectYesButton, {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }, TWEEN_FAST)

        selectYesButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        selectYesButton.TextStrokeTransparency = 0.34
    end)

    selectYesButton.MouseLeave:Connect(function()
        tween(selectYesButton, {
            TextColor3 = COLORS.Text
        }, TWEEN_FAST)

        selectYesButton.TextStrokeTransparency = 1
    end)

    selectNoButton.MouseButton1Click:Connect(function()
        selectConfirmShade.Visible = false
    end)

    selectYesButton.MouseButton1Click:Connect(function()
        selectConfirmShade.Visible = false

        local result = {}

        for _, cardData in ipairs(cards) do
            if cardData.Selected then
                table.insert(result, cardData.Item)
            end
        end

        if typeof(onConfirm) == "function" then
            onConfirm(result)
        end

        closeUI()
    end)

    inputConnection = UserInputService.InputBegan:Connect(
        function(input, processed)
            if processed or closing then
                return
            end

            if input.KeyCode == Enum.KeyCode.Escape then
                closeUI()
            end
        end
    )

    return screenGui
end



local function readNewItemAmount(newItem)
    local itemContainer = newItem:FindFirstChild("Container")
    local amountObject = itemContainer and itemContainer:FindFirstChild("Amount")

    if not amountObject then
        return 1
    end

    local function parseAmount(value)
        local number = tonumber(string.match(tostring(value or ""), "%d+"))
        return number and math.max(number, 1) or nil
    end

    if amountObject:IsA("TextLabel") or amountObject:IsA("TextButton") then
        return parseAmount(amountObject.Text) or 1
    end

    if amountObject:IsA("IntValue") or amountObject:IsA("NumberValue") then
        return math.max(math.floor(amountObject.Value), 1)
    end

    for _, descendant in ipairs(amountObject:GetDescendants()) do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
            local parsed = parseAmount(descendant.Text)

            if parsed then
                return parsed
            end
        elseif descendant:IsA("IntValue") or descendant:IsA("NumberValue") then
            return math.max(math.floor(descendant.Value), 1)
        end
    end

    return 1
end

local function normalizeVisualName(value)
    return string.lower(
        tostring(value or "")
            :gsub("[%s%p_]+", "")
    )
end

local function getFallbackVisualNameFromSystemName(systemName)
    local result = tostring(systemName or "")

    result = result:gsub("_[GK]_%d%d%d%d$", "")
    result = result:gsub("_%d%d%d%d$", "")
    result = result:gsub("Chroma$", "")

    return result
end

local function cloneNewItemTags(newItem)
    local sourceTags = newItem:FindFirstChild("Tags")

    if not sourceTags or not sourceTags:IsA("GuiObject") then
        return nil
    end

    for _, object in ipairs(sourceTags:GetDescendants()) do
        local objectName = string.lower(tostring(object.Name or ""))
        local objectText = ""

        if object:IsA("TextLabel") or object:IsA("TextButton") then
            objectText = string.lower(tostring(object.Text or ""))
        end

        if objectName == "unique" or objectText == "unique" then
            return nil
        end
    end

    return sourceTags:Clone()
end

local function scanNewItemVisuals()
    local inventoryRoot = PlayerGui:FindFirstChild("MainGUI")
        and PlayerGui.MainGUI:FindFirstChild("Game")
        and PlayerGui.MainGUI.Game:FindFirstChild("Inventory")
        and PlayerGui.MainGUI.Game.Inventory:FindFirstChild("Main")
        and PlayerGui.MainGUI.Game.Inventory.Main:FindFirstChild("Weapons")
        and PlayerGui.MainGUI.Game.Inventory.Main.Weapons:FindFirstChild("Items")
        and PlayerGui.MainGUI.Game.Inventory.Main.Weapons.Items:FindFirstChild("Container")

    local byVisualName = {}
    local allVisualItems = {}

    if not inventoryRoot then
        return byVisualName, allVisualItems
    end

    local function addNewItem(newItem)
        if not newItem:IsA("Frame")
            or not string.find(newItem.Name, "NewItem")
        then
            return
        end

        local itemNameFrame = newItem:FindFirstChild("ItemName")
        local nameLabel = itemNameFrame
            and itemNameFrame:FindFirstChild("Label")

        local visualName = nameLabel
            and nameLabel:IsA("TextLabel")
            and nameLabel.Text
            or ""

        if visualName == ""
            or visualName == "Default Knife"
            or visualName == "Default Gun"
        then
            return
        end

        local itemContainer = newItem:FindFirstChild("Container")
        local icon = itemContainer
            and itemContainer:FindFirstChild("Icon")

        if not icon
            or not icon:IsA("ImageLabel")
            or icon.Image == ""
        then
            return
        end

        local rarityBG = itemNameFrame
            and itemNameFrame:FindFirstChild("BG")

        local itemNameColor = COLORS.Background

        if itemNameFrame and itemNameFrame:IsA("Frame") then
            itemNameColor = itemNameFrame.BackgroundColor3
        end

        local record = {
            VisualName = visualName,
            NormalizedName = normalizeVisualName(visualName),
            Icon = icon.Image,
            ItemNameColor = itemNameColor,
            ItemNameBG = rarityBG
                and rarityBG:IsA("GuiObject")
                and rarityBG:Clone()
                or nil,
            ItemTags = cloneNewItemTags(newItem),
            Used = false
        }

        byVisualName[record.NormalizedName] =
            byVisualName[record.NormalizedName] or {}

        table.insert(
            byVisualName[record.NormalizedName],
            record
        )

        table.insert(allVisualItems, record)
    end

    local function scanFolder(folder)
        if not folder then
            return
        end

        local container = folder:FindFirstChild("Container")

        if not container then
            return
        end

        for _, child in ipairs(container:GetChildren()) do
            addNewItem(child)
        end
    end

    scanFolder(inventoryRoot:FindFirstChild("Classic"))
    scanFolder(inventoryRoot:FindFirstChild("Current"))

    local holiday = inventoryRoot:FindFirstChild("Holiday")

    if holiday then
        scanFolder(holiday:FindFirstChild("Christmas"))
        scanFolder(holiday:FindFirstChild("Halloween"))

        local holidayContainer = holiday:FindFirstChild("Container")

        if holidayContainer then
            scanFolder(holidayContainer:FindFirstChild("Christmas"))
            scanFolder(holidayContainer:FindFirstChild("Halloween"))
        end
    end

    return byVisualName, allVisualItems
end

local function takeNewItemVisual(
    byVisualName,
    allVisualItems,
    visualName,
    systemName
)
    local function takeFromList(list)
        if not list then
            return nil
        end

        for _, record in ipairs(list) do
            if not record.Used then
                record.Used = true
                return record
            end
        end

        return nil
    end

    local exact = takeFromList(
        byVisualName[normalizeVisualName(visualName)]
    )

    if exact then
        return exact, "DatabaseVisualName"
    end

    local fallbackName =
        getFallbackVisualNameFromSystemName(systemName)

    local fallback = takeFromList(
        byVisualName[normalizeVisualName(fallbackName)]
    )

    if fallback then
        return fallback, "SystemNameFallback"
    end

    local normalizedFallback =
        normalizeVisualName(fallbackName)

    for _, record in ipairs(allVisualItems) do
        if not record.Used then
            local candidate = record.NormalizedName

            if candidate == normalizedFallback
                or string.find(
                    candidate,
                    normalizedFallback,
                    1,
                    true
                )
                or string.find(
                    normalizedFallback,
                    candidate,
                    1,
                    true
                )
            then
                record.Used = true
                return record, "PartialFallback"
            end
        end
    end

    return nil, "NotFound"
end

local function getRealInventoryItems()
    local inventoryFolder = ReplicatedStorage:FindFirstChild("Remotes")
        and ReplicatedStorage.Remotes:FindFirstChild("Inventory")

    local getProfileData = inventoryFolder
        and inventoryFolder:FindFirstChild("GetProfileData")

    if not getProfileData
        or not getProfileData:IsA("RemoteFunction")
    then
        return {}
    end

    local ok, profileData = pcall(function()
        return getProfileData:InvokeServer()
    end)

    if not ok then
        return {}
    end

    local owned = profileData
        and profileData.Weapons
        and profileData.Weapons.Owned

    if type(owned) ~= "table" then
        return {}
    end

    local visualsByName, allVisualItems =
        scanNewItemVisuals()

    local weaponList = {}

    for systemName, rawAmount in pairs(owned) do
        if systemName ~= "DefaultKnife"
            and systemName ~= "DefaultGun"
        then
            local databaseEntry = itemsBySystemName[
                normalizeLookupKey(systemName)
            ]

            local databaseData = databaseEntry
                and databaseEntry.Data
                or nil

            local amount = tonumber(rawAmount) or 1

            if type(rawAmount) == "table" then
                amount = tonumber(
                    rawAmount.Amount
                    or rawAmount.Quantity
                    or rawAmount.Count
                ) or 1
            end

            amount = math.max(math.floor(amount), 1)

            local databaseVisualName = databaseData
                and tostring(databaseData.ItemName or systemName)
                or getFallbackVisualNameFromSystemName(systemName)

            local visualRecord, visualMatchSource =
                takeNewItemVisual(
                    visualsByName,
                    allVisualItems,
                    databaseVisualName,
                    systemName
                )

            local displayName = visualRecord
                and visualRecord.VisualName
                or databaseVisualName

            local itemRarity

            if not visualRecord then
                itemRarity = "Unknown"
            elseif databaseData then
                itemRarity = tostring(
                    databaseData.Rarity or "Unknown"
                )
            else
                itemRarity = detectRarity(
                    visualRecord.ItemNameColor
                )
            end

            if RARITY_PRIORITY[itemRarity] == nil then
                itemRarity = "Unknown"
            end

            local iconImage = visualRecord
                and visualRecord.Icon
                or (
                    databaseData
                    and databaseData.ImageId
                    and (
                        "rbxassetid://"
                        .. tostring(databaseData.ImageId)
                    )
                    or ""
                )

            local newWeapon = {
                Name = displayName,
                ScannedName = displayName,
                SystemName = systemName,
                SystemNameSource = "GetProfileData",

                Icon = iconImage,
                Amount = amount,

                Rarity = itemRarity,
                RarityPriority =
                    RARITY_PRIORITY[itemRarity] or 0,

                DatabaseKey = databaseEntry
                    and databaseEntry.Key
                    or nil,

                DatabaseData = databaseData,
                ItemType = databaseData
                    and databaseData.ItemType
                    or nil,

                Chroma = databaseData
                    and databaseData.Chroma == true
                    or false,

                Event = databaseData
                    and databaseData.Event
                    or nil,

                Year = databaseData
                    and databaseData.Year
                    or nil,

                ItemNameColor = visualRecord
                    and visualRecord.ItemNameColor
                    or (
                        rarityColors[itemRarity]
                        or COLORS.Background
                    ),

                ItemNameBG = visualRecord
                    and visualRecord.ItemNameBG
                    or nil,

                ItemTags = visualRecord
                    and visualRecord.ItemTags
                    or nil
            }

            table.insert(weaponList, newWeapon)
        end
    end

    table.sort(weaponList, function(a, b)
        if a.RarityPriority ~= b.RarityPriority then
            return a.RarityPriority > b.RarityPriority
        end

        return string.lower(a.Name or "")
            < string.lower(b.Name or "")
    end)

    return weaponList
end



local realItems = {}
local inventorySearchStarted = os.clock()
local inventorySearchTimeout = 15

repeat
    realItems = getRealInventoryItems()

    if #realItems > 0 then
        break
    end

    task.wait(0.5)
until os.clock() - inventorySearchStarted >= inventorySearchTimeout

createGalaxyUI(realItems, function(selectedItems)
    local keys = {}
    for _, item in ipairs(selectedItems) do
        table.insert(keys, item.SystemName)
    end

    _G.selectedKeys = keys

    teleport()
end)
