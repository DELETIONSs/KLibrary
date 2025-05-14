Here's a revamped **README.md** file for your custom UI library, incorporating the **linker** (a method for loading the library through a URL, similar to `loadstring`) and detailed instructions on how to use it.

---

# My Custom UI Library

A simple, customizable UI library for creating dynamic, interactive interfaces in Roblox games. This library includes window creation, tab management, UI elements like buttons, toggles, and sliders, as well as notifications and configuration saving.

---

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)

  * [Booting the Library](#booting-the-library)
  * [Creating a Window](#creating-a-window)
  * [Creating a Tab](#creating-a-tab)
  * [Creating a Section](#creating-a-section)
  * [Creating UI Elements](#creating-ui-elements)

    * [Buttons](#creating-a-button)
    * [Toggles](#creating-a-checkbox-toggle)
    * [Sliders](#creating-a-slider)
    * [Textboxes](#creating-an-adaptive-input)
    * [Color Pickers](#creating-a-color-picker)
    * [Dropdowns](#creating-a-dropdown-menu)
    * [Keybinds](#creating-a-keybind)
    * [Labels and Paragraphs](#creating-a-label)
    * [Notifications](#notifying-the-user)
  * [Using Flags](#how-flags-work)
  * [Initialization & Cleanup](#final-initialization-required)
  * [Destroying the Interface](#destroying-the-interface)
* [Advanced Features](#advanced-features)

  * [Config Saving](#making-your-interface-work-with-configs)
  * [Tab Switching](#tab-switching-functionality)
* [License](#license)

---

## Installation

To use the **My Custom UI Library**, simply include the following in your script:

```lua
local MyLibrary = loadstring(game:HttpGet('https://example.com/your-library-source'))()
```

This will load the latest version of the library from the provided link.

---

## Usage

### Booting the Library

The library can be loaded using a `loadstring` function, which will fetch and execute the library's source code.

```lua
local MyLibrary = loadstring(game:HttpGet('https://example.com/your-library-source'))()
```

---

### Creating a Window

To create a new window for your UI:

```lua
local Window = MyLibrary:MakeWindow({
    Name = "My Custom Library", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "MyCustomLibraryConfigs"
})
```

**Parameters:**

* `Name` - (string) The name of the UI window.
* `HidePremium` - (bool) Whether or not to hide premium details.
* `SaveConfig` - (bool) Whether to save user settings across sessions.
* `ConfigFolder` - (string) The name of the folder where configurations will be saved.

---

### Creating a Tab

To add a tab to your window:

```lua
local Tab1 = Window:MakeTab({
    Name = "Tab 1",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
```

**Parameters:**

* `Name` - (string) The name of the tab.
* `Icon` - (string) The icon displayed on the tab (use `rbxassetid://<id>` format).
* `PremiumOnly` - (bool) Whether the tab is only accessible to premium users.

---

### Creating a Section

Sections are added within a tab and group together related UI elements.

```lua
local Section1 = Tab1:AddSection({
    Name = "Section 1"
})

Section1:AddButton({
    Name = "Click Me!",
    Callback = function()
        print("Button pressed!")
    end
})
```

**Parameters for AddSection:**

* `Name` - (string) The name of the section.

---

### Creating UI Elements

You can add various types of elements to your tabs and sections. Below are examples of common elements:

#### Creating a Button

```lua
Tab1:AddButton({
    Name = "Button!",
    Callback = function()
        print("Button pressed!")
    end
})
```

**Parameters:**

* `Name` - (string) The name of the button.
* `Callback` - (function) The function executed when the button is pressed.

#### Creating a Checkbox Toggle

```lua
Tab1:AddToggle({
    Name = "This is a toggle!",
    Default = false,
    Callback = function(Value)
        print(Value)
    end    
})
```

**Parameters:**

* `Name` - (string) The name of the toggle.
* `Default` - (bool) The default state of the toggle.
* `Callback` - (function) The function executed when the toggle value changes.

#### Creating a Slider

```lua
Tab1:AddSlider({
    Name = "Slider",
    Min = 0,
    Max = 20,
    Default = 5,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "items",
    Callback = function(Value)
        print(Value)
    end    
})
```

**Parameters:**

* `Name` - (string) The name of the slider.
* `Min` - (number) The minimum value of the slider.
* `Max` - (number) The maximum value of the slider.
* `Default` - (number) The default value of the slider.
* `Callback` - (function) The function executed when the slider value changes.

#### Creating a Textbox

```lua
Tab1:AddTextbox({
    Name = "Textbox",
    Default = "default box input",
    TextDisappear = true,
    Callback = function(Value)
        print(Value)
    end    
})
```

#### Creating a Color Picker

```lua
Tab1:AddColorpicker({
    Name = "Colorpicker",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        print(Value)
    end    
})
```

#### Creating a Dropdown Menu

```lua
Tab1:AddDropdown({
    Name = "Dropdown",
    Default = "Option1",
    Options = {"Option1", "Option2", "Option3"},
    Callback = function(Value)
        print(Value)
    end    
})
```

#### Creating a Keybind

```lua
Tab1:AddBind({
    Name = "Keybind",
    Default = Enum.KeyCode.E,
    Hold = false,
    Callback = function()
        print("Key pressed")
    end    
})
```

---

### Notifying the User

```lua
MyLibrary:MakeNotification({
    Name = "Success!",
    Content = "Action completed successfully.",
    Image = "rbxassetid://4483345998",
    Time = 5
})
```

---

### Using Flags

Flags help in storing element states that can be saved or accessed later.

```lua
Tab1:AddToggle({
    Name = "Save Toggle",
    Default = true,
    Save = true,
    Flag = "toggleFlag"
})

print(MyLibrary.Flags["toggleFlag"].Value)  -- Access the value later
```

---

### Final Initialization (Required)

To finalize your UI setup, call the `Init` function.

```lua
MyLibrary:Init()
```

---

### Destroying the Interface

To destroy the UI when it is no longer needed:

```lua
MyLibrary:Destroy()
```

---

## Advanced Features

### Config Saving

If you want to save user preferences (such as toggle states, slider values, etc.), make sure to add the `SaveConfig` and `ConfigFolder` parameters to your window, and set `Flag` and `Save` on the elements you want to save.

### Tab Switching Functionality

Tabs are dynamically created and can be switched between by calling the `SwitchTab` function.

```lua
local function SwitchTab(tab)
    -- Hide active tab content
    if activeTab then
        activeTab.Content.Visible = false
    end
    -- Show selected tab content
    tab.Content.Visible = true
    activeTab = tab
end
```

---

## License

MIT License - See LICENSE for more details.

---

This **README.md** provides the full documentation for setting up and using your custom UI library. It includes the **linker** for booting the library, instructions on how to create windows, tabs, sections, and UI elements, and more advanced features like config saving and flag handling.
