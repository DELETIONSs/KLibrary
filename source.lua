-- Variables and Services
local f = tostring(math.random(1, 100)) .. tostring(math.random(1, 50)) .. tostring(math.random(1, 100))
local p = game:GetService("UserInputService")
local q = game:GetService("TweenService")
local r = game:GetService("HttpService")
local s = game:GetService("RunService")
local t = game:GetService("Players")
local u = game:GetService("CoreGui")
local Player = t.LocalPlayer

-- Main library
local Linker = {}

-- Drag Function to make UI draggable
function e:DragFunc(g, h)
    h = h or g
    local i = false
    local j, k, l
    g.InputBegan:Connect(function(m)
        if m.UserInputType == Enum.UserInputType.MouseButton1 or m.UserInputType == Enum.UserInputType.Touch then
            i = true
            k = m.Position
            l = h.Position
            m.Changed:Connect(function()
                if m.UserInputState == Enum.UserInputState.End then
                    i = false
                end
            end)
        end
    end)

    g.InputChanged:Connect(function(m)
        if m.UserInputType == Enum.UserInputType.MouseMovement or m.UserInputType == Enum.UserInputType.Touch then
            j = m
        end
    end)

    p.InputChanged:Connect(function(m)
        if m == j and i then
            local n = m.Position - k
            h.Position = UDim2.new(l.X.Scale, l.X.Offset + n.X, l.Y.Scale, l.Y.Offset + n.Y)
        end
    end)
end

-- CreateLibrary: Initializes the UI library and stores configuration settings
function Linker:CreateLibrary(config)
    local defaultConfig = {
        theme = {
            textColor = Color3.fromRGB(255, 255, 255),
            backgroundColor = Color3.fromRGB(19, 19, 19),
            highlightColor = Color3.fromRGB(60, 60, 60),
            Topbar = Color3.fromRGB(23, 23, 23),
            Shadow = Color3.fromRGB(0, 0, 0),
            NotificationBackground = Color3.fromRGB(30, 30, 30),
            NotificationActionsBackground = Color3.fromRGB(55, 55, 55),
            TabBackground = Color3.fromRGB(24, 24, 24),
            TabStroke = Color3.fromRGB(40, 40, 40),
            TabBackgroundSelected = Color3.fromRGB(63, 63, 63),
            TabTextColor = Color3.fromRGB(140, 140, 140),
            SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
            SliderBackground = Color3.fromRGB(0, 206, 255),
            SliderProgress = Color3.fromRGB(255, 255, 255),
            SliderStroke = Color3.fromRGB(255, 255, 255),
            ToggleBackground = Color3.fromRGB(24, 24, 24),
            ToggleEnabled = Color3.fromRGB(255, 255, 0),
            ToggleDisabled = Color3.fromRGB(80, 80, 80),
            ToggleEnabledStroke = Color3.fromRGB(255, 180, 0),
            ToggleDisabledStroke = Color3.fromRGB(100, 100, 100),
            ToggleEnabledOuterStroke = Color3.fromRGB(120, 120, 120),
            ToggleDisabledOuterStroke = Color3.fromRGB(50, 50, 50),
            DropdownSelected = Color3.fromRGB(36, 36, 36),
            DropdownUnselected = Color3.fromRGB(26, 26, 26),
            InputBackground = Color3.fromRGB(26, 26, 26),
            InputStroke = Color3.fromRGB(60, 60, 60),
            PlaceholderColor = Color3.fromRGB(150, 150, 150)
        },
        draggable = true,
        windowSize = UDim2.new(0, 400, 0, 300)
    }

    self.config = setmetatable(config or {}, {
        __index = defaultConfig
    })
    local library = {
        windows = {},
        notifications = {}
    }

    -- Initialize draggable windows
    if self.config.draggable then
        self:AddDraggableWindows(library)
    end

    return library
end

-- AddDraggableWindows: Adds draggable functionality to UI windows
function Linker:AddDraggableWindows(library)
    local exampleWindow = Instance.new("Frame")
    exampleWindow.Size = self.config.windowSize
    exampleWindow.BackgroundColor3 = self.config.theme.backgroundColor
    exampleWindow.Position = UDim2.new(0.5, -200, 0.5, -150)

    -- Use the DragFunc to make this window draggable
    e:DragFunc(exampleWindow, exampleWindow)

    table.insert(library.windows, exampleWindow)
    exampleWindow.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- AddToggle: Adds a toggle button to the UI
function Linker:AddToggle(parent, text, initialState, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 200, 0, 50)
    toggle.Text = text
    toggle.BackgroundColor3 = self.config.theme.backgroundColor
    toggle.TextColor3 = self.config.theme.textColor
    toggle.Parent = parent

    local state = initialState or false
    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 50, 0, 50)
    switch.Position = UDim2.new(1, -60, 0, 0)
    switch.BackgroundColor3 = state and self.config.theme.highlightColor or Color3.fromRGB(200, 200, 200)
    switch.Parent = toggle

    toggle.MouseButton1Click:Connect(function()
        state = not state
        local targetPosition = state and UDim2.new(1, -60, 0, 0) or UDim2.new(0, 10, 0, 0)
        local targetColor = state and self.config.theme.highlightColor or Color3.fromRGB(200, 200, 200)

        q:Create(switch, TweenInfo.new(0.2), {
            Position = targetPosition,
            BackgroundColor3 = targetColor
        }):Play()

        if callback then
            callback(state)
        end
    end)
end

-- AddSlider: Adds a slider to the UI
function Linker:AddSlider(parent, min, max, initialValue, callback)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0, 200, 0, 20)
    slider.BackgroundColor3 = self.config.theme.backgroundColor
    slider.Parent = parent

    local handle = Instance.new("Frame")
    handle.Size = UDim2.new(0, 10, 0, 20)
    handle.BackgroundColor3 = self.config.theme.highlightColor
    handle.Position = UDim2.new((initialValue - min) / (max - min), 0, 0, 0)
    handle.Parent = slider

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local offset = input.Position.X - slider.AbsolutePosition.X
            local value = math.clamp(offset / slider.AbsoluteSize.X, 0, 1)
            handle.Position = UDim2.new(value, 0, 0, 0)
            if callback then
                callback(min + value * (max - min))
            end
        end
    end)
end

-- AddNotification: Adds a notification system
function Linker:AddNotification(text, duration)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Text = text
    notification.BackgroundColor3 = self.config.theme.highlightColor
    notification.TextColor3 = self.config.theme.textColor
    notification.Position = UDim2.new(0.5, -150, 0, 50)
    notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    q:Create(notification, TweenInfo.new(duration), {
        Position = UDim2.new(0.5, -150, 0, 150)
    }):Play()
    task.delay(duration, function()
        notification:Destroy()
    end)
end

-- Keybind Management
function Linker:SetKeybind(key, action)
    self.config.Keybinds[key] = action
end

return Linker
