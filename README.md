
# Hyprland Workspace Groups

On most desktop environments, switching workspaces changes all monitors to a new screen. For whatever reason, on Hyprland, each monitor is assigned its own workspace and when switching workspaces, only that monitor is changed.

This repo creates "workspace groups" where each group is one workspace per monitor. When switching groups, all monitors will switch to the workspace assiged to its group. Removing the inconvenience of swapping workspaces when using Hyprland with multiple monitors.

## Features

* Switch multiple monitor workspaces at once
* Compatable with any number of monitors
* Customizable keybinds
* Limit number of workspace groups
* Compatable with Hyprland 0.55+ using the Lua config system

## How it works

Heres an example of the workspaces used as you switch group with 3 monitors:
| Workspace Group | Monitor 1 workspace | Monitor 2 workspace | Monitor 3 workspace |
|-----------------|---------------------|---------------------|---------------------|
| 1               | 1                   | 2                   | 3                   |
| 2               | 4                   | 5                   | 6                   |
| 3               | 7                   | 8                   | 9                   |

When switching to workspace group 1, your monitors will display workspaces 1, 2, and 3.

When switching to workspace group 2, your monitors will display workspaces 4, 5, and 6.

And so on.

## Setup

### 1. Clone the repo:
```bash
git clone https://github.com/Real1F2L/Hyprland-Workspace-Groups.git
cd Hyprland-Workspace-Groups
```

### 2. Remove old config


```bash
# Look at Hyprland config files
ls -la ~/.config/hypr/

# Edit a file
nano ~/.config/hypr/file
```

To prevent any conflicts from your existing dotfiles, remove any lines that add keybinds for switching workspaces or any workspace rules that bind workspaces to a monitor, this repo will replace them.

### 2. Check your monitors:
```bash
hyprctl monitors
```

This should output information on your monitors. Each monitor will start with "Monitor ____ (ID #)", remember what's written in the blank spot for each monitor, we will need to put this into the Hyprland config. The blank spot should contain something like "DP-1", "HDMI-A-1", or something similar.

### 3. Edit the Hyprland config file:
```bash
nano "./src/Hyprland Config/Workspace Groups.lua"
```

In this file, you'll need to enter the monitors you just checked into the monitors list. Do not change anything else in this file unless you know what you're doing. This is also your oppertunity to decide where you will store the "Workspace Group Switcher.sh" script. We reccommend the default location.

### 4. Move the config file into your Hyprland config
```bash
mv "./src/Hyprland Config/Workspace Groups.lua" ~/.config/hypr/
```

### 5. Require the Workspace Groups config in Hyprland config
```bash
nano ~/.config/hypr/hyprland.lua
```

Add this line to the bottom:
```lua
require("Workspace Groups")
```

### 5. Move "Workspace Group Switcher.sh" and make it executeable
```bash
# Move
mkdir ~/.config/Real1F2L/
mv "./src/Scripts/Workspace Group Switcher.sh" ~/.config/Real1F2L/Workspace Group Switcher.sh

# Make executable
chmod +x ~/.config/Real1F2L/Workspace Group Switcher.sh
```

You may need to change these paths if you changed the file path in Workspace Groups.lua

### 6. Test and delete old repo

Attempt to use SUPER + 1-9, it should change workspace group as expected.