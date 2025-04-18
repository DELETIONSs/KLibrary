local KLibrary = {}

local ColorPalette = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 30), -- Example color
        Text = Color3.fromRGB(255, 255, 255),    -- White text
        Accent = Color3.fromRGB(0, 120, 215)     -- Blue accent
    }
}

local function CreateWindow(library, name)
    if library == KLibrary then
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = name or "KLibraryWindow"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

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

        return ScreenGui
    end
end

KLibrary.CreateWindow = function(name)
    return CreateWindow(KLibrary, name)
end

return KLibrary
