-- Complete Roblox UI Library

-- Colorpicker UI components
local Colorpicker = Instance.new("Frame")
local ColorpickerCorner = Instance.new("UICorner")
local ColorpickerTitle = Instance.new("TextLabel")
local BoxColor = Instance.new("Frame")
local BoxColorCorner = Instance.new("UICorner")
local ConfirmBtn = Instance.new("TextButton")
local ConfirmBtnCorner = Instance.new("UICorner")
local ConfirmBtnTitle = Instance.new("TextLabel")
local ColorpickerBtn = Instance.new("TextButton")
local RainbowToggle = Instance.new("TextButton")
local RainbowToggleCorner = Instance.new("UICorner")
local RainbowToggleTitle = Instance.new("TextLabel")
local FrameRainbowToggle1 = Instance.new("Frame")
local FrameRainbowToggle1Corner = Instance.new("UICorner")
local FrameRainbowToggle2 = Instance.new("Frame")
local FrameRainbowToggle2_2 = Instance.new("UICorner")
local FrameRainbowToggle3 = Instance.new("Frame")
local FrameToggle3 = Instance.new("UICorner")
local FrameRainbowToggleCircle = Instance.new("Frame")
local FrameRainbowToggleCircleCorner = Instance.new("UICorner")
local Color = Instance.new("ImageLabel")
local ColorCorner = Instance.new("UICorner")
local ColorSelection = Instance.new("ImageLabel")
local Hue = Instance.new("ImageLabel")
local HueCorner = Instance.new("UICorner")
local HueGradient = Instance.new("UIGradient")
local HueSelection = Instance.new("ImageLabel")

-- Slider components
local SliderFrame = Instance.new("Frame")
local SliderBar = Instance.new("Frame")
local SliderKnob = Instance.new("Frame")
local SliderText = Instance.new("TextLabel")

-- Toggle components
local ToggleFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local ToggleButtonCorner = Instance.new("UICorner")
local ToggleLabel = Instance.new("TextLabel")

-- Notifications components
local NotificationFrame = Instance.new("Frame")
local NotificationTitle = Instance.new("TextLabel")
local NotificationText = Instance.new("TextLabel")
local NotificationCloseButton = Instance.new("TextButton")

-- Function to create draggable windows
function makeDraggable(frame)
    local dragging = false
    local dragInput, startPos, startDrag
    local function onInputBegan(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = input.Position
            startDrag = frame.Position
        end
    end
    
    local function onInputChanged(input)
        if dragging then
            local delta = input.Position - startPos
            frame.Position = startDrag + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end

    local function onInputEnded(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end
    
    frame.InputBegan:Connect(onInputBegan)
    frame.InputChanged:Connect(onInputChanged)
    frame.InputEnded:Connect(onInputEnded)
end

-- Function to create a toggle switch
function createToggle(parent, position, text, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 100, 0, 30)
    toggleFrame.Position = position
    toggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleFrame.Parent = parent
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 0, 30)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.Text = ""
    toggleButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    toggleButton.Parent = toggleFrame
    
    local toggleButtonCorner = Instance.new("UICorner")
    toggleButtonCorner.CornerRadius = UDim.new(0, 15)
    toggleButtonCorner.Parent = toggleButton
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0, 50, 0, 30)
    toggleLabel.Position = UDim2.new(0, 50, 0, 0)
    toggleLabel.Text = text
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextSize = 14
    toggleLabel.Parent = toggleFrame
    
    local isToggled = false
    
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        if isToggled then
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        end
        callback(isToggled)
    end)
end

-- Function to create a slider
function createSlider(parent, position, minVal, maxVal, text, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 200, 0, 20)
    sliderFrame.Position = position
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderFrame.Parent = parent
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(0, 200, 0, 5)
    sliderBar.Position = UDim2.new(0, 0, 0, 7)
    sliderBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBar.Parent = sliderFrame
    
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Size = UDim2.new(0, 10, 0, 20)
    sliderKnob.Position = UDim2.new(0, 0, 0, -8)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
    sliderKnob.Parent = sliderFrame
    
    local sliderText = Instance.new("TextLabel")
    sliderText.Size = UDim2.new(0, 200, 0, 20)
    sliderText.Position = UDim2.new(0, 0, 0, -25)
    sliderText.Text = text
    sliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderText.Font = Enum.Font.Gotham
    sliderText.TextSize = 14
    sliderText.Parent = sliderFrame
    
    sliderKnob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = game:GetService("UserInputService"):GetMouseLocation().X
            local relPos = math.clamp(mousePos - sliderFrame.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X)
            sliderKnob.Position = UDim2.new(0, relPos, 0, -8)
            local value = math.floor((relPos / sliderBar.AbsoluteSize.X) * (maxVal - minVal) + minVal)
            callback(value)
        end
    end)
end

-- Function to create a notification
function createNotification(title, message, duration)
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 300, 0, 100)
    notificationFrame.Position = UDim2.new(0.5, -150, 0.8, -50)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    notificationFrame.Parent = game.Players.LocalPlayer.PlayerGui
    
    local notificationTitle = Instance.new("TextLabel")
    notificationTitle.Size = UDim2.new(0, 300, 0, 30)
    notificationTitle.Text = title
    notificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationTitle.TextSize = 18
    notificationTitle.Font = Enum.Font.Gotham
    notificationTitle.Parent = notificationFrame
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Size = UDim2.new(0, 300, 0, 60)
    notificationText.Text = message
    notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationText.TextSize = 14
    notificationText.Font = Enum.Font.Gotham
    notificationText.Parent = notificationFrame
    
    local notificationCloseButton = Instance.new("TextButton")
    notificationCloseButton.Size = UDim2.new(0, 50, 0, 30)
    notificationCloseButton.Position = UDim2.new(1, -60, 0, 35)
    notificationCloseButton.Text = "Close"
    notificationCloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
    notificationCloseButton.Font = Enum.Font.Gotham
    notificationCloseButton.TextSize = 14
    notificationCloseButton.Parent = notificationFrame
    
    notificationCloseButton.MouseButton1Click:Connect(function()
        notificationFrame:Destroy()
    end)
    
    wait(duration)
    notificationFrame:Destroy()
end

-- Example Usage:

-- Make draggable UI
makeDraggable(Colorpicker)

-- Create a toggle
createToggle(Tab, UDim2.new(0, 10, 0, 10), "Enable Feature", function(isToggled)
    print("Feature enabled:", isToggled)
end)

-- Create a slider
createSlider(Tab, UDim2.new(0, 10, 0, 60), 0, 100, "Adjust Volume", function(value)
    print("Volume set to:", value)
end)

-- Create a notification
createNotification("Info", "This is a test notification", 3)
