-- Obiisenpai Hub | Find Fruits UI
-- Tự động điều chỉnh cho Executor hoặc Roblox Studio
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local ParentGui = RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or CoreGui

-- Hàm hỗ trợ tạo UI nhanh và gọn
local function create(className, properties)
    local inst = Instance.new(className)
    for k, v in pairs(properties) do
        if k ~= "Parent" then inst[k] = v end
    end
    if properties.Parent then inst.Parent = properties.Parent end
    return inst
end

-- 1. Tạo ScreenGui
local ScreenGui = create("ScreenGui", {
    Name = "ObiisenpaiHub",
    Parent = ParentGui,
    ResetOnSpawn = false
})

-- 2. Tạo Main Frame (Hiệu ứng kính mờ)
local MainFrame = create("Frame", {
    Name = "Main",
    Parent = ScreenGui,
    BackgroundColor3 = Color3.fromRGB(240, 244, 248), -- Màu trắng pha xám nhạt
    BackgroundTransparency = 0.15, -- Độ trong suốt giống ảnh
    Position = UDim2.new(0.5, -240, 0.5, -135),
    Size = UDim2.new(0, 480, 0, 270),
    Active = true,
    Draggable = true -- Cho phép kéo thả menu
})

create("UICorner", {Parent = MainFrame, CornerRadius = UDim.new(0, 8)})
create("UIStroke", {Parent = MainFrame, Color = Color3.fromRGB(200, 200, 200), Thickness = 1})

-- Drop Shadow ảo (tạo viền mờ phía sau)
local Shadow = create("ImageLabel", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, -15, 0, -15),
    Size = UDim2.new(1, 30, 1, 30),
    Image = "rbxassetid://6015897843",
    ImageColor3 = Color3.fromRGB(0, 0, 0),
    ImageTransparency = 0.8,
    ZIndex = 0
})

-- 3. Top Bar (Title và Nút Đóng/Thu nhỏ)
local Title = create("TextLabel", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 10),
    Size = UDim2.new(0, 200, 0, 20),
    Font = Enum.Font.GothamBold,
    Text = "Obiisenpai Hub | Find Fruits",
    TextColor3 = Color3.fromRGB(20, 20, 20),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
})

local CloseBtn = create("TextButton", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -25, 0, 10),
    Size = UDim2.new(0, 15, 0, 15),
    Font = Enum.Font.Gotham,
    Text = "x",
    TextColor3 = Color3.fromRGB(100, 100, 100),
    TextSize = 14
})

local MinBtn = create("TextButton", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -45, 0, 10),
    Size = UDim2.new(0, 15, 0, 15),
    Font = Enum.Font.Gotham,
    Text = "-",
    TextColor3 = Color3.fromRGB(100, 100, 100),
    TextSize = 18
})

-- Đóng UI khi ấn X
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 4. Phần Bên Trái (Left Panel)
-- Khung Ảnh viền xanh nhạt (Chứa ID: 16060333448)
local ImageBox = create("ImageLabel", {
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0,
    Position = UDim2.new(0, 15, 0, 40),
    Size = UDim2.new(0, 260, 0, 50),
    Image = "rbxassetid://16060333448",
    ScaleType = Enum.ScaleType.Crop
})
create("UICorner", {Parent = ImageBox, CornerRadius = UDim.new(0, 4)})
create("UIStroke", {Parent = ImageBox, Color = Color3.fromRGB(0, 200, 255), Thickness = 1.5}) -- Vòng màu xanh

-- Hàm tạo các ô Status
local function createStatusBox(yPos, iconTxt, labelTxt)
    local box = create("Frame", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new(0, 15, 0, yPos),
        Size = UDim2.new(0, 260, 0, 25)
    })
    create("UICorner", {Parent = box, CornerRadius = UDim.new(0, 4)})
    create("UIStroke", {Parent = box, Color = Color3.fromRGB(210, 210, 210), Thickness = 1})
    
    create("TextLabel", {
        Parent = box,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 0),
        Size = UDim2.new(0, 20, 1, 0),
        Font = Enum.Font.Gotham,
        Text = iconTxt,
        TextColor3 = Color3.fromRGB(50, 50, 50),
        TextSize = 14
    })
    
    create("TextLabel", {
        Parent = box,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 30, 0, 0),
        Size = UDim2.new(1, -30, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = labelTxt,
        TextColor3 = Color3.fromRGB(30, 30, 30),
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end

createStatusBox(100, "🍎", "Status Fruit Spawn:")
createStatusBox(132, "📍", "Distance to fruit:")
createStatusBox(164, "👤", "Target Fruit:")

-- Version Text
create("TextLabel", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 1, -25),
    Size = UDim2.new(0, 260, 0, 15),
    Font = Enum.Font.GothamBold,
    Text = "Vision 2.1 | Premium",
    TextColor3 = Color3.fromRGB(50, 50, 50),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Right
})

-- 5. Phần Bên Phải (Configurations & Logs)
local RightPanelX = 290

create("TextLabel", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, RightPanelX, 0, 35),
    Size = UDim2.new(0, 100, 0, 15),
    Font = Enum.Font.GothamMedium,
    Text = "Configurations",
    TextColor3 = Color3.fromRGB(80, 80, 80),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Hàm tạo Toggles (Công tắc)
local function createToggle(yPos, text)
    local frame = create("Frame", {
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, RightPanelX, 0, yPos),
        Size = UDim2.new(0, 175, 0, 20)
    })
    
    create("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -35, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = text,
        TextColor3 = Color3.fromRGB(30, 30, 30),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Nền nút gạt
    local toggleBg = create("Frame", {
        Parent = frame,
        BackgroundColor3 = Color3.fromRGB(200, 200, 200),
        Position = UDim2.new(1, -30, 0.5, -7),
        Size = UDim2.new(0, 30, 0, 14)
    })
    create("UICorner", {Parent = toggleBg, CornerRadius = UDim.new(1, 0)})
    
    -- Nút tròn bên trong
    create("Frame", {
        Parent = toggleBg,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Position = UDim2.new(0, 2, 0.5, -5),
        Size = UDim2.new(0, 10, 0, 10)
    })
    create("UICorner", {Parent = toggleBg:GetChildren()[2], CornerRadius = UDim.new(1, 0)})
end

createToggle(55, "Auto Random")
createToggle(75, "Auto Store")
createToggle(95, "Esp Fruit")

-- Recent Logs
create("TextLabel", {
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, RightPanelX, 0, 120),
    Size = UDim2.new(0, 100, 0, 15),
    Font = Enum.Font.GothamMedium,
    Text = "Recent Logs",
    TextColor3 = Color3.fromRGB(80, 80, 80),
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left
})

local LogBox = create("Frame", {
    Parent = MainFrame,
    BackgroundColor3 = Color3.fromRGB(245, 245, 245),
    Position = UDim2.new(0, RightPanelX, 0, 140),
    Size = UDim2.new(0, 175, 0, 35)
})
create("UICorner", {Parent = LogBox, CornerRadius = UDim.new(0, 4)})
create("UIStroke", {Parent = LogBox, Color = Color3.fromRGB(210, 210, 210), Thickness = 1})

-- Hàm tạo Nút bấm
local function createButton(yPos, text)
    local btn = create("TextButton", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(245, 248, 250),
        Position = UDim2.new(0, RightPanelX, 0, yPos),
        Size = UDim2.new(0, 175, 0, 22),
        Font = Enum.Font.GothamBold,
        Text = text,
        TextColor3 = Color3.fromRGB(30, 30, 30),
        TextSize = 12
    })
    create("UICorner", {Parent = btn, CornerRadius = UDim.new(0, 4)})
    create("UIStroke", {Parent = btn, Color = Color3.fromRGB(200, 200, 200), Thickness = 1})
    return btn
end

createButton(185, "Click Random")
createButton(212, "Click Store")
createButton(239, "Click Info Sv")

print("Đã load UI thành công!")
