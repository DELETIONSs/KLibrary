local KLibrary = {}

-- Color palette definition
local ColorPalette = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(0, 120, 215),
        Notification = Color3.fromRGB(40, 40, 40)
    }
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Create main GUI
local function CreateWindow(library, name)
    if library == KLibrary then
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = name or "KLibraryWindow"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 400, 0, 300)
        MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
        MainFrame.BackgroundColor3 = ColorPalette.Dark.Background
        MainFrame.BorderSizePixel = 0
        MainFrame.Parent = ScreenGui

        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Size = UDim2.new(1, 0, 0, 30)
        Title.BackgroundTransparency = 1
        Title.Text = name or "Window"
        Title.TextColor3 = ColorPalette.Dark.Text
        Title.Font = Enum.Font.SourceSansBold
        Title.TextSize = 24
        Title.Parent = MainFrame

        -- Notification container
        local NotificationHolder = Instance.new("Frame")
        NotificationHolder.Name = "NotificationHolder"
        NotificationHolder.Size = UDim2.new(0, 300, 1, 0)
        NotificationHolder.Position = UDim2.new(1, -310, 0, 10)
        NotificationHolder.BackgroundTransparency = 1
        NotificationHolder.Parent = ScreenGui

        -- Attach notification function
        function KLibrary.Notify(text, duration)
            duration = duration or 3
            local Notification = Instance.new("TextLabel")
            Notification.Size = UDim2.new(1, 0, 0, 30)
            Notification.Position = UDim2.new(0, 0, 0, 0)
            Notification.BackgroundColor3 = ColorPalette.Dark.Notification
            Notification.TextColor3 = ColorPalette.Dark.Text
            Notification.Text = text or "Notification"
            Notification.Font = Enum.Font.SourceSans
            Notification.TextSize = 18
            Notification.TextWrapped = true
            Notification.BorderSizePixel = 0
            Notification.BackgroundTransparency = 0
            Notification.Parent = NotificationHolder

            -- Move other notifications down
            for _, other in ipairs(NotificationHolder:GetChildren()) do
                if other:IsA("TextLabel") and other ~= Notification then
                    other.Position = other.Position + UDim2.new(0, 0, 0, 35)
                end
            end

            -- Fade out and remove
            task.delay(duration, function()
                local tween = TweenService:Create(Notification, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1})
                tween:Play()
                tween.Completed:Wait()
                Notification:Destroy()
            end)
        end

        return ScreenGui
    end
end

-- Attach the function to the library
KLibrary.CreateWindow = function(name)
    return CreateWindow(KLibrary, name)
end

return KLibrary
