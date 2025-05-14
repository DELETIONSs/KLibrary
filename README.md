# Roblox UI Library

A simple, flexible, and customizable UI library for Roblox. This library allows you to create draggable windows, toggle switches, sliders, and notifications with smooth animations and a modern design.

## Features

- **Draggable Windows**: Allows windows to be dragged around the screen with smooth transitions.
- **Toggle Buttons**: Toggle switches with animated state changes and customizable colors.
- **Sliders**: Horizontal sliders with adjustable min/max values and smooth interaction.
- **Notifications**: Simple notification system with customizable duration and smooth animations.
- **Keybind Management**: Custom keybinds can be assigned to trigger specific actions.
- **Customizable Theme**: Easily modify UI colors, text, and layout to fit your needs.

## Installation

To use this UI library, simply copy the code into your own Roblox project:

1. **Create a LocalScript** in the `StarterPlayer -> StarterPlayerScripts` folder of your game.
2. Paste the entire content of the library into the script.

```lua
-- Example: Library Usage
local Linker = require(path_to_your_library)

-- Initialize the library with custom configuration
local library = Linker:CreateLibrary({
    theme = {
        textColor = Color3.fromRGB(255, 255, 255),
        backgroundColor = Color3.fromRGB(19, 19, 19),
    },
    windowSize = UDim2.new(0, 500, 0, 400),
    draggable = true
})

-- Example: Add a draggable window
library:AddDraggableWindows()

-- Example: Add a toggle button
library:AddToggle(library.windows[1], "Enable Feature", true, function(state)
    print("Toggle state is: " .. tostring(state))
end)

-- Example: Add a slider
library:AddSlider(library.windows[1], 0, 100, 50, function(value)
    print("Slider value: " .. value)
end)

-- Example: Add a notification
library:AddNotification("Welcome to the UI Library!", 3)
