-- Khởi tạo các thành phần giao diện
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local IDInput = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local PreviewImage = Instance.new("ImageLabel")
local Status = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")

-- Thiết lập ScreenGui (Dùng CoreGui để tránh bị mất khi chết/reset)
ScreenGui.Name = "RobloxImageChecker"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Khung chính
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- Có thể nắm kéo bảng đi

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 10)

-- Tiêu đề
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "IMAGE CHECKER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

-- Ô nhập ID
IDInput.Parent = MainFrame
IDInput.Name = "IDInput"
IDInput.Position = UDim2.new(0.1, 0, 0.12, 0)
IDInput.Size = UDim2.new(0.8, 0, 0, 35)
IDInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
IDInput.PlaceholderText = "Nhập ID Image/Decal..."
IDInput.Text = ""
IDInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", IDInput)

-- Nút Nhập
SubmitBtn.Parent = MainFrame
SubmitBtn.Name = "SubmitBtn"
SubmitBtn.Position = UDim2.new(0.1, 0, 0.27, 0)
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 30)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SubmitBtn.Text = "NHẬP"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
Instance.new("UICorner", SubmitBtn)

-- Khung hiển thị hình ảnh
PreviewImage.Parent = MainFrame
PreviewImage.Position = UDim2.new(0.1, 0, 0.4, 0)
PreviewImage.Size = UDim2.new(0.8, 0, 0.45, 0)
PreviewImage.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PreviewImage.Image = ""
PreviewImage.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", PreviewImage)

-- Trạng thái
Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.88, 0)
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Text = "Chờ nhập ID..."
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Gotham
Status.TextSize = 12

-- Chức năng xử lý khi bấm nút "NHẬP"
SubmitBtn.MouseButton1Click:Connect(function()
    local id = IDInput.Text
    
    if id == "" or not tonumber(id) then
        Status.Text = "Lỗi: ID phải là số!"
        Status.TextColor3 = Color3.fromRGB(255, 85, 85)
        return
    end
    
    Status.Text = "Đang kiểm tra..."
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Gán ID vào ImageLabel
    local assetUrl = "rbxassetid://" .. id
    PreviewImage.Image = assetUrl
    
    -- Kiểm tra tải ảnh
    task.spawn(function()
        local ContentProvider = game:GetService("ContentProvider")
        pcall(function()
            ContentProvider:PreloadAsync({PreviewImage})
        end)
        
        if PreviewImage.IsLoaded then
            Status.Text = "Đã tìm thấy hình ảnh!"
            Status.TextColor3 = Color3.fromRGB(85, 255, 127)
        else
            Status.Text = "Không tải được (ID sai/bị chặn)"
            Status.TextColor3 = Color3.fromRGB(255, 170, 0)
        end
    end)
end)

-- Hiệu ứng nút bấm
SubmitBtn.MouseEnter:Connect(function() SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 210) end)
SubmitBtn.MouseLeave:Connect(function() SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255) end)
