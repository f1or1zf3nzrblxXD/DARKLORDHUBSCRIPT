local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

-- Detect the current game name
local gameName = "Unknown Game"
local success, result = pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)
    return info.Name
end)
if success then
    gameName = result
else
    warn("Failed to fetch game name: " .. tostring(result))
end

-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Rayfield Window with dynamic title
local Window = Rayfield:CreateWindow({
   Name = "🔥 DARK LORD HUB (" .. gameName .. ")",
   LoadingTitle = "🔫 DARK LORD HUB 💥",
   LoadingSubtitle = "by f1or1zf3nzrblx",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "DarkLordHub"
   },
   Discord = {
      Enabled = true,
      Invite = "t2xPXFuNjB", -- Discord invite code without discord.gg/
      RememberJoins = true
   },
   KeySystem = false, -- Set to true if you want to use the key system (uncomment and configure KeySettings below if needed)
})

-- Create Tabs
local HomeTab = Window:CreateTab("🗿 Main Thing", nil)
local MiscTab = Window:CreateTab("💀 Others", nil)

-- Home Tab Sections
local MainSection = HomeTab:CreateSection("Main")
local OtherSection = HomeTab:CreateSection("Other")

-- Notification on Script Execution
Rayfield:Notify({
   Title = "Script Executed",
   Content = "DARK LORD HUB is now running in " .. gameName .. "!",
   Duration = 5,
   Image = 13047715178,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
            print("The user tapped Okay!")
         end
      },
   },
})

-- Create Tabs
local CustomScriptInput

-- Button to "Create your own script"
CustomScriptInput = HomeTab:CreateInput({
   Name = "Enter Your Custom Script (loadstring)",
   PlaceholderText = "Paste your loadstring script here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(text)
      -- This is where the custom script is entered
      if text and text ~= "" then
         -- Notify that script execution is starting
         local loadingNotification = Rayfield:Notify({
            Title = "Executing Script",
            Content = "Running your script... Please wait.",
            Duration = 10,
         })

         -- Simulate a fake progress bar (console/log based)
         local loadingMessage = "Loading... ["
         for i = 1, 10 do
            wait(0.5) -- Simulate script loading time
            loadingMessage = loadingMessage .. "="
            Rayfield:Notify({
                Title = "Executing Script",
                Content = loadingMessage .. "]",
                Duration = 1,
            })
         end

         -- Execute the custom script entered
         local success, err = pcall(function()
            loadstring(text)()  -- Run the loadstring provided by the user
         end)

         -- Check if the script was executed successfully
         if success then
            Rayfield:Notify({
               Title = "Script Executed",
               Content = "Your custom script was executed successfully!",
               Duration = 3,
            })
            print("Custom script executed successfully!")
         else
            Rayfield:Notify({
               Title = "Error",
               Content = "Failed to execute your custom script: " .. err,
               Duration = 3,
            })
            warn("Failed to execute custom script: " .. err)
         end
      else
         Rayfield:Notify({
            Title = "Input Error",
            Content = "Please enter a valid script.",
            Duration = 3,
         })
      end
   end,
})

-- Create "Execute Script" button
local ExecuteScriptButton = HomeTab:CreateButton({
   Name = "Execute Custom Script",
   Callback = function()
      -- Show loading message with progress (fake progress bar)
      local scriptText = CustomScriptInput:GetText()
      if scriptText and scriptText ~= "" then
         -- Notify that script execution is in progress
         Rayfield:Notify({
            Title = "Execution Started",
            Content = "Executing your script. Please wait...",
            Duration = 5,
         })

         -- Simulate loading bar in console or using notifications
         local loadingMessage = "Loading Script... ["
         for i = 1, 10 do
            wait(0.5)  -- Simulate the time taken for script execution
            loadingMessage = loadingMessage .. "="
            Rayfield:Notify({
                Title = "Script Progress",
                Content = loadingMessage .. "]",
                Duration = 2,
            })
         end

         -- Execute the loadstring script
         local success, err = pcall(function()
            loadstring(scriptText)()  -- Run the custom script
         end)

         if success then
            Rayfield:Notify({
               Title = "Script Executed",
               Content = "Your custom script was executed successfully!",
               Duration = 3,
            })
            print("Custom script executed successfully!")
         else
            Rayfield:Notify({
               Title = "Execution Error",
               Content = "Error executing custom script: " .. err,
               Duration = 3,
            })
            warn("Error executing custom script: " .. err)
         end
      else
         Rayfield:Notify({
            Title = "Error",
            Content = "Please enter a valid script.",
            Duration = 3,
         })
      end
   end,
})

-- Infinite Jump Toggle
local InfiniteJumpToggle = HomeTab:CreateToggle({
   Name = "Infinite Jump Toggle",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(Value)
      _G.infinjump = Value
      if _G.infinJumpStarted == nil and Value then
         _G.infinJumpStarted = true
         game.StarterGui:SetCore("SendNotification", {Title="DARK LORD HUB"; Text="Infinite Jump Activated!"; Duration=5;})
         local plr = game:GetService('Players').LocalPlayer
         local m = plr:GetMouse()
         m.KeyDown:Connect(function(k)
            if _G.infinjump and k:byte() == 32 then
               local humanoid = plr.Character and plr.Character:FindFirstChildOfClass('Humanoid')
               if humanoid then
                  humanoid:ChangeState('Jumping')
                  wait()
                  humanoid:ChangeState('Seated')
               end
            end
         end)
      end
   end,
})

-- WalkSpeed Slider
local WalkSpeedSlider = HomeTab:CreateSlider({
   Name = "WalkSpeed Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
      if humanoid then
         humanoid.WalkSpeed = Value
      end
   end,
})

-- JumpPower Slider
local JumpPowerSlider = HomeTab:CreateSlider({
   Name = "JumpPower Slider",
   Range = {1, 350},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 16,
   Flag = "JumpPower",
   Callback = function(Value)
      local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
      if humanoid then
         humanoid.JumpPower = Value
      end
   end,
})

-- Walkspeed Input
local WalkspeedInput = HomeTab:CreateInput({
   Name = "Walkspeed",
   PlaceholderText = "1-500",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
      if humanoid then
         humanoid.WalkSpeed = tonumber(Text) or 16
      end
   end,
})

-- Script Execution Buttons with Descriptions
local function createScriptButton(name, url, description)
   HomeTab:CreateButton({
      Name = name,
      Callback = function()
         local dateTime = os.date("*t")
         local date = string.format("%04d-%02d-%02d", dateTime.year, dateTime.month, dateTime.day)
         local time = string.format("%02d:%02d:%02d", dateTime.hour, dateTime.min, dateTime.sec)
         local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
         end)
         if success then
            Rayfield:Notify({
               Title = "🗿 (SCRIPT) EXECUTED",
               Content = name .. " loaded!",
               Duration = 3,
            })
            print("[" .. date .. "] [" .. time .. "] " .. name .. " executed successfully.")
         else
            Rayfield:Notify({
               Title = "Error",
               Content = "Failed to load " .. name .. "!",
               Duration = 3,
            })
            warn("Failed to execute " .. name .. ": " .. err)
            print("[" .. date .. "] [" .. time .. "] Error executing " .. name .. ": " .. err)
         end
         -- Show description on first click
         Rayfield:Notify({
            Title = name .. " Description",
            Content = description,
            Duration = 5,
         })
      end,
   })
end

createScriptButton("Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "A powerful administration and debugging tool for Roblox.")
createScriptButton("Jerk Off", "https://raw.githubusercontent.com/Sakupenny/Universal-Jerk-Off/refs/heads/main/Main.lua", "A universal script for various fun interactions.")
createScriptButton("Slap Battles Script", "https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua", "Enhances gameplay in Slap Battles with additional features.")
createScriptButton("Dex", "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", "A bypassed explorer tool for Roblox game analysis.")
createScriptButton("Owl Hub", "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt", "A multi-game hub with a variety of scripts.")
createScriptButton("V.G Hub", "https://raw.githubusercontent.com/1201for/v3rmillion.net/main/V.GHub.txt", "A versatile game hub for multiple Roblox experiences.")

-- Re-added Discord Button
local DiscordButton = HomeTab:CreateButton({
   Name = "Discord",
   Callback = function()
      if setclipboard then
         setclipboard("https://discord.gg/t2xPXFuNjB")
         Rayfield:Notify({
            Title = "Success",
            Content = "Discord Link Copied!",
            Duration = 2,
         })
      else
         warn("Clipboard function not supported by this executor.")
         Rayfield:Notify({
            Title = "Error",
            Content = "Clipboard not supported!",
            Duration = 3,
         })
      end
      -- Show description
      Rayfield:Notify({
         Title = "Discord Description",
         Content = "Join the community for support and updates.",
         Duration = 5,
      })
   end,
})

-- Misc Tab Buttons (Logs, Credits, Controls) with Descriptions
local LogsButton = MiscTab:CreateButton({
   Name = "Logs",
   Callback = function()
      Rayfield:Notify({
         Title = "Logs",
         Content = "Execution logs will appear here...\nCheck console for details.",
         Duration = 5,
      })
      print("Logs opened. Check console for execution logs.")
      -- Show description
      Rayfield:Notify({
         Title = "Logs Description",
         Content = "View execution logs and timestamps in the console.",
         Duration = 5,
      })
   end,
})

local CreditsButton = MiscTab:CreateButton({
   Name = "Credits",
   Callback = function()
      Rayfield:Notify({
         Title = "Credits",
         Content = [[
Dark Lord Team
Roblox Scripters
Roblox Coders
f1or1zf3nzrblx on discord the owner of the script
]],
         Duration = 5,
      })
      -- Show description
      Rayfield:Notify({
         Title = "Credits Description",
         Content = "Acknowledge the team behind DARK LORD HUB.",
         Duration = 5,
      })
   end,
})

local ControlsButton = MiscTab:CreateButton({
   Name = "Controls",
   Callback = function()
      Rayfield:Notify({
         Title = "Controls",
         Content = "RightCtrl to Hide/Show The Script.\nMORE CONTROLS COMING SOON, ADD F1OR1ZF3NZRBLX ON DISCORD.",
         Duration = 5,
      })
      -- Show description
      Rayfield:Notify({
         Title = "Controls Description",
         Content = "Learn how to interact with the script interface.",
         Duration = 5,
      })
   end,
})

-- RightCtrl to toggle visibility
local isVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
   if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
      isVisible = not isVisible
      Window:Destroy() -- Destroy and recreate to toggle visibility
      if isVisible then
         Window = Rayfield:CreateWindow({
            Name = "🔥 DARK LORD HUB (" .. gameName .. ")",
            LoadingTitle = "🔫 DARK LORD HUB 💥",
            LoadingSubtitle = "by f1or1zf3nzrblx",
            LoadingTitle = "Script Loaded",
            ConfigurationSaving = {Enabled = false, FolderName = nil, FileName = "DarkLordHub"},
            Discord = {Enabled = true, Invite = "t2xPXFuNjB", RememberJoins = true},
            KeySystem = false,
         })
         -- Recreate tabs and elements (simplified by keeping global state)
         Rayfield:Notify({
            Title = "Visibility",
            Content = "GUI toggled to visible.",
            Duration = 3,
         })
      else
         Rayfield:Notify({
            Title = "Visibility",
            Content = "GUI toggled to hidden.",
            Duration = 3,
         })
      end
   end
end)

print("DARK LORD HUB loaded in " .. gameName .. "!")
Rayfield:Notify({
   Title = "DARK LORD HUB",
   Content = "Hub loaded in " .. gameName .. "! Press RightCtrl to toggle visibility.",
   Duration = 5,
})