local OwlLib = {Content = {}};

local owlLibGui = game:GetObjects("rbxassetid://4530443679")[1];
owlLibGui.Parent = game:GetService("CoreGui");
local mainFrame = owlLibGui.mainFrame;

local tweenService = game:GetService("TweenService");
local inputService = game:GetService("UserInputService");

local firstBodyFrame;
local draggableToggle;
local draggableInput;
local draggableStart;

mainFrame.topBarFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true;
        draggableStart = input.Position;
        startPos = mainFrame.AbsolutePosition;
    end;
end);

mainFrame.topBarFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false;
    end;
end);

inputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local res = owlLibGui.AbsoluteSize;
        mainFrame.Position = UDim2.new(0, startPos.X + (input.Position.X - draggableStart.X), 0, startPos.Y + (input.Position.Y - draggableStart.Y));
    end;
end);

mainFrame.topBarFrame.exitBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        tweenService:Create(mainFrame.topBarFrame.exitBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play();
    end;
end);

mainFrame.topBarFrame.exitBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        tweenService:Create(mainFrame.topBarFrame.exitBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.2}):Play();
    end;
end);

mainFrame.topBarFrame.exitBtn.MouseButton1Click:Connect(function()
    mainFrame:TweenSize(UDim2.new(0, 387, 0, 27), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25);
    wait(0.25);
    mainFrame.topBarFrame:TweenSize(UDim2.new(0, 0, 0, 27), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25);
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 27), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25);
    wait(0.25);
    owlLibGui:Destroy();
end);

mainFrame.topBarFrame.miniBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        tweenService:Create(mainFrame.topBarFrame.miniBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play();
    end;
end);

mainFrame.topBarFrame.miniBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        tweenService:Create(mainFrame.topBarFrame.miniBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.2}):Play();
    end;
end);

mainFrame.topBarFrame.miniBtn.MouseButton1Click:Connect(function()
    if mainFrame.Size ~= UDim2.new(0, 387, 0, 27) then
        mainFrame:TweenSize(UDim2.new(0, 387, 0, 27), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true);
    else
        mainFrame:TweenSize(UDim2.new(0, 387, 0, 225), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true);
    end;
end);

inputService.InputBegan:Connect(function(input, onGui)
    if not onGui and (input.KeyCode == Enum.KeyCode.P or input.KeyCode == Enum.KeyCode.RightShift) then
        owlLibGui.Enabled = not owlLibGui.Enabled;
    end;
end);

function OwlLib:SetCategory() end;

function OwlLib.Content:Resize(scrollingFrame)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, (#scrollingFrame:GetChildren() - 1) * 36);
end;

function OwlLib.Content:Ripple(btn)
    spawn(function()
		local mouse = game:GetService("Players").LocalPlayer:GetMouse();
		local rippleEffect = Instance.new("ImageLabel", btn);
		local rippleEffectInner = Instance.new("ImageLabel", rippleEffect);
		rippleEffect.Name = "rippleEffect";
		rippleEffect.BackgroundTransparency = 1;
		rippleEffect.BorderSizePixel = 0;
		rippleEffect.Image = "rbxassetid://2708891598";
		rippleEffect.ImageColor3 = Color3.fromRGB(244, 244, 244);
		rippleEffect.ImageTransparency = 0.7;
		rippleEffect.ScaleType = Enum.ScaleType.Fit;
		rippleEffectInner.Name = "rippleEffect";
		rippleEffectInner.AnchorPoint = Vector2.new(0.5, 0.5);
		rippleEffectInner.BackgroundTransparency = 1;
		rippleEffectInner.BorderSizePixel = 0;
		rippleEffectInner.Position = UDim2.new(0.5, 0, 0.5, 0);
		rippleEffectInner.Size = UDim2.new(0.93, 0, 0.93, 0);
		rippleEffectInner.Image = "rbxassetid://2708891598";
		rippleEffectInner.ImageColor3 = Color3.fromRGB(45, 45, 45);
		rippleEffectInner.ImageTransparency = 0.7;
		rippleEffectInner.ScaleType = Enum.ScaleType.Fit;
		rippleEffect.Position = UDim2.new(0, mouse.X - rippleEffect.AbsolutePosition.X, 0, mouse.Y - rippleEffect.AbsolutePosition.Y);
		rippleEffect:TweenSizeAndPosition(UDim2.new(10, 0, 10, 0), UDim2.new(-4.5, 0, -4.5, 0), "Out", "Quad", 0.33);
		for i = 1, 10 do
			rippleEffect.ImageTransparency = rippleEffect.ImageTransparency + 0.01;
			wait();
		end;
		rippleEffect:Destroy();
	end)
end;

function OwlLib.Content:initBtnEffect(btn)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            tweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.85}):Play();
        end;
    end);

    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            tweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play();
        end;
    end);
end;

function OwlLib:new(title)
    local self = setmetatable({}, {__index = self.Content});

    self.bodyFrame = game:GetObjects("rbxassetid://4531111462")[1];
    self.bodyFrame.Parent = mainFrame;
    self.bodyFrame.Name = title .. "BodyFrame";
    self.bodyFrame.Visible = false;
	
	local tabBtn = game:GetObjects("rbxassetid://4530456835")[1];
    tabBtn.Parent = mainFrame.tabsFrame;
    tabBtn.tabLabel.Text = title;
    tabBtn.Size = UDim2.new(0, tabBtn.tabLabel.TextBounds.X + 20, 1, 0, 0);

    if not firstBodyFrame then
        firstBodyFrame = self.bodyFrame;
        self.bodyFrame.Visible = true;
		tabBtn.ImageColor3 = Color3.fromRGB(30, 30, 30);
    end;

    --[[tabBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and tabBtn.ImageColor3 ~= Color3.fromRGB(50, 50, 50) then
            tweenService:Create(tabBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play();
        end;
    end);

    tabBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and tabBtn.ImageColor3 ~= Color3.fromRGB(50, 50, 50) then
            tweenService:Create(tabBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(30, 30, 30)}):Play();
        end;
    end);]]

    tabBtn.MouseButton1Click:Connect(function()
        for i, v in pairs(mainFrame:GetChildren()) do
            if v.Name:find("BodyFrame") then
                if v ~= self.bodyFrame then
                    v.Visible = false;
                end;
            end;
        end;
        for i, v in pairs(mainFrame.tabsFrame:GetChildren()) do
            if v:IsA("ImageButton") then
                v.ImageColor3 = Color3.fromRGB(50, 50, 50);
            end;
        end;
        tabBtn.ImageColor3 = Color3.fromRGB(30, 30, 30);
        self.bodyFrame.Visible = true;
    end);

    return self;
end;

function OwlLib.Content:newBtn(title, callback, noToggle)
    self:Resize(self.bodyFrame);

    if not noToggle then
        local enabled = false;
        
        local btn = game:GetObjects("rbxassetid://4531129509")[1];
        btn.Parent = self.bodyFrame;
        btn.titleLabel.Text = title;
        btn.titleLabel.Size = UDim2.new(0, btn.titleLabel.TextBounds.X, 1, 0);
        btn.Size = UDim2.new(0, btn.titleLabel.Size.X.Offset + 50, 0, 30);

        self:initBtnEffect(btn);

        local toggle = {
            [true] = Color3.fromRGB(0, 194, 94),
            [false] = Color3.fromRGB(180, 0, 0)
        };

        btn.MouseButton1Click:Connect(function()
            self:Ripple(btn);
            enabled = not enabled;
            tweenService:Create(btn.statusFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = toggle[enabled]}):Play();
            callback(enabled);
        end);

        return {
            Set = function(self, bool) 
                enabled = bool;
                if not noToggle then
                    tweenService:Create(btn.statusFrame, TweenInfo.new(0.33, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = toggle[enabled]}):Play();
                    callback(enabled);
                end;
            end;
        };
    elseif noToggle then
        local btn = game:GetObjects("rbxassetid://4531209476")[1];
        btn.Parent = self.bodyFrame;
        btn.titleLabel.Text = title;
        btn.titleLabel.Size = UDim2.new(0, btn.titleLabel.TextBounds.X, 1, 0);
        btn.Size = UDim2.new(0, btn.titleLabel.Size.X.Offset + 17, 0, 30);

        self:initBtnEffect(btn);

        btn.MouseButton1Click:Connect(function()
            self:Ripple(btn);
            callback();
        end);

        return {
            Fire = function(self) 
                callback();
            end;
        };
    end;
end;

function OwlLib.Content:newSlider(title, callback, min, max, startPoint)
    self:Resize(self.bodyFrame);

    local dragging = false;
    
    local sliderFrame = game:GetObjects("rbxassetid://4531326550")[1];
    sliderFrame.Parent = self.bodyFrame;
    sliderFrame.titleLabel.Text = title;
    sliderFrame.titleLabel.Size = UDim2.new(0, sliderFrame.titleLabel.TextBounds.X, 1, 0);
    sliderFrame.Size = UDim2.new(0, sliderFrame.titleLabel.Size.X.Offset + 195, 0, 30);

    local sliderIndicatorFrame = sliderFrame.sliderIndicatorFrame;
    sliderIndicatorFrame.valueLabel.Text = tostring(startPoint and math.floor((startPoint / max) * (max - min) + min) or 0);

    local slidingFrame = sliderFrame.sliderIndicatorFrame.slidingFrame;
    slidingFrame.Size = UDim2.new((startPoint or 0) / max, 0, 1, 0);

    callback(startPoint and math.floor((startPoint / max) * (max - min) + min) or 0);

    local function slide(input)
        local pos = UDim2.new(math.clamp((input.Position.X - sliderIndicatorFrame.AbsolutePosition.X) / sliderIndicatorFrame.AbsoluteSize.X, 0, 1), 0, 1, 0);
        slidingFrame:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
        local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min);
        sliderIndicatorFrame.valueLabel.Text = tostring(value);
        callback(value);
    end;

    sliderIndicatorFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slide(input);
			dragging = true;
		end;
	end);
	
	sliderIndicatorFrame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false;
		end;
    end);

	inputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			slide(input);
		end;
	end);
end;

function OwlLib.Content:newTextbox(title, callback, presetText, noCallbackOnStart)
    self:Resize(self.bodyFrame);

    local btn = game:GetObjects("rbxassetid://4531463561")[1];
    btn.Parent = self.bodyFrame;
    btn.titleLabel.Text = title;
    btn.titleLabel.Size = UDim2.new(0, btn.titleLabel.TextBounds.X, 1, 0);
    btn.Size = UDim2.new(0, btn.titleLabel.Size.X.Offset + 100, 0, 30);

    btn.inputBox.Text = presetText and presetText or "";

    if not noCallbackOnStart then
        callback(presetText);
    end;

    btn.inputBox.FocusLost:Connect(function()
        callback(btn.inputBox.Text);
    end);
end;

function OwlLib.Content:newBind(title, callback, presetKeyCode)
    self:Resize(self.bodyFrame);

    local enabled = false;
    local listening = false;
    local activated = presetKeyCode and true or false;
    local keyCode = presetKeyCode;

    local btn = game:GetObjects("rbxassetid://4531229816")[1];
    btn.Parent = self.bodyFrame;
    btn.titleLabel.Text = title;
    btn.titleLabel.Size = UDim2.new(0, btn.titleLabel.TextBounds.X, 1, 0);
    btn.Size = UDim2.new(0, btn.titleLabel.Size.X.Offset + 90, 0, 30);

    btn.bindBtn.Text = presetKeyCode and string.upper(tostring(string.char(presetKeyCode.Value))) or "KEY";

    inputService.InputBegan:Connect(function(input, onGui)
        if onGui then return; end;

        if listening and not activated then
            pcall(function()
                btn.bindBtn.Text = string.upper(tostring(string.char(input.KeyCode.Value)));
                listening = false;
                keyCode = input.KeyCode;
                activated = true;
            end);
		elseif activated and not listening and input.KeyCode == keyCode then
            enabled = not enabled;
            
            callback(enabled);
        end;
    end);

    btn.bindBtn.MouseButton1Click:Connect(function()
        btn.bindBtn.Text = "...";

        activated = false;
        listening = true;
    end);
end;

function OwlLib.Content:newCBind(title, callback, presetKeyCode)
    self:Resize(self.bodyFrame);

    local enabled = false;
    local activated = presetKeyCode and true or false;
    local banned = {
        Return = true;
        Space = true;
        Tab = true;
        Unknown = true;
    }
    
    local function isreallypressed(bind, inp)
        local key = bind
        if typeof(key) == "Instance" then
            if key.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == key.KeyCode then
                return true;
            elseif tostring(key.UserInputType):find("MouseButton") and inp.UserInputType == key.UserInputType then
                return true
			end
        end
        if tostring(key):find'MouseButton' then
            return key == inp.UserInputType
        else
            return key == inp.KeyCode
        end
    end

    local shortNames = {
        RightControl = 'RightCtrl';
        LeftControl = 'LeftCtrl';
        LeftShift = 'LShift';
        RightShift = 'RShift';
        MouseButton1 = "Mouse1";
        MouseButton2 = "Mouse2";
    }
    
    local allowed = {
        MouseButton1 = true;
        MouseButton2 = true;
    }      

    local nm = (presetKeyCode and (shortNames[presetKeyCode.Name] or presetKeyCode.Name) or "None");
    local keyCode = presetKeyCode;

    local btn = game:GetObjects("rbxassetid://4531229816")[1];
    btn.Parent = self.bodyFrame;
    btn.titleLabel.Text = title;
    btn.titleLabel.Size = UDim2.new(0, btn.titleLabel.TextBounds.X, 1, 0);
    btn.Size = UDim2.new(0, btn.titleLabel.Size.X.Offset + 90, 0, 30);

    btn.bindBtn.Text = nm;

    inputService.InputBegan:Connect(function(input, onGui)
        if onGui then return; end;
        if activated and isreallypressed(keyCode, input) then
            callback(true);
        end;
    end);
    inputService.InputEnded:Connect(function(input, onGui)
        if onGui then return; end;
        if activated and not listening and isreallypressed(keyCode, input) then
            callback(false);
        end;
    end);    
    btn.bindBtn.MouseButton1Click:Connect(function()
        btn.bindBtn.Text = "...";
        activated = false;
        local input, onGui = inputService.InputBegan:Wait();
        keyCode = input;
        local name = (input.UserInputType ~= Enum.UserInputType.Keyboard and (shortNames[input.UserInputType.Name] or input.UserInputType.Name) or input.KeyCode.Name);
        btn.bindBtn.Text = name
        activated = true;
    end);
end;

function OwlLib.Content:newColorPicker(title, callback, presetColor)
    self:Resize(self.bodyFrame);

    local oldSize;
    local rainbow = false;
    local hueSatDragging = false;
    local valueDragging = false;

    local btn = game:GetObjects("rbxassetid://4531551348")[1];
    btn.Parent = self.bodyFrame;
    btn.titleLabel.Text = title;
    btn.titleLabel.Size = UDim2.new(0, btn.titleLabel.TextBounds.X, 1, 0);
    btn.Size = UDim2.new(0, btn.titleLabel.Size.X.Offset + 50, 0, 30);

    local colorFrame = btn.colorFrame;
    local colorPickingFrame = btn.colorPickingFrame;
    local rainbowBtn = colorPickingFrame.rainbowBtn;
    local hueSatFrame = colorPickingFrame.hueSatFrame;
    local valueFrame = colorPickingFrame.valueFrame;
    local hueSatIndicatorFrame = hueSatFrame.hueSatIndicatorFrame;
    local valueIndicatorFrame = valueFrame.valueIndicatorFrame;

    callback(presetColor and presetColor or Color3.fromRGB(255, 255, 255));

    self:initBtnEffect(btn);

    btn.MouseButton1Click:Connect(function()
        if not colorPickingFrame.Visible then
            oldSize = self.bodyFrame.CanvasSize;
            self.bodyFrame.CanvasSize = oldSize + UDim2.new(0, 0, 0, 170);
            colorPickingFrame.Visible = true;
            colorPickingFrame:TweenSize(UDim2.new(0, 170, 0, 120), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
        elseif colorPickingFrame.Visible then
            colorPickingFrame:TweenSize(UDim2.new(0, 170, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
            wait(0.15);
            colorPickingFrame.Visible = false;
            self.bodyFrame.CanvasSize = oldSize;
        end;
    end);

    rainbowBtn.MouseButton1Click:Connect(function()
        rainbow = true;
    end);
    
    hueSatFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hueSatDragging = true;
        end;
    end);
    
    hueSatFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hueSatDragging = false;
        end;
    end);

    valueFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            valueDragging = true;
        end;
    end)
    
    valueFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            valueDragging = false;
        end;
    end);
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if hueSatDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            rainbow = false;
            hueSatIndicatorFrame.Position = UDim2.new(math.clamp((input.Position.X - hueSatFrame.AbsolutePosition.X) / hueSatFrame.AbsoluteSize.X, 0, 1), 0, math.clamp((input.Position.Y - hueSatFrame.AbsolutePosition.Y) / hueSatFrame.AbsoluteSize.Y, 0, 1), 0);
            valueIndicatorFrame.BackgroundColor3 = Color3.fromHSV(h, 1 - (1 - hueSatIndicatorFrame.Position.Y.Scale), 1);
            colorFrame.BackgroundColor3 = Color3.fromHSV(hueSatIndicatorFrame.Position.X.Scale, 1 - hueSatIndicatorFrame.Position.Y.Scale, 1 - valueIndicatorFrame.Position.Y.Scale);
            valueFrame.ImageColor3 = Color3.fromHSV(hueSatIndicatorFrame.Position.X.Scale, 1 - hueSatIndicatorFrame.Position.Y.Scale, 1);
            callback(colorFrame.BackgroundColor3);
        elseif valueDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            rainbow = false;
            valueIndicatorFrame.Position = UDim2.new(0, 0, math.clamp((input.Position.Y - valueFrame.AbsolutePosition.Y) / valueFrame.AbsoluteSize.Y, 0, 1), 0);
            valueIndicatorFrame.BackgroundColor3 = Color3.fromHSV(h, 1 - (1 - hueSatIndicatorFrame.Position.Y.Scale), 1);
            colorFrame.BackgroundColor3 = Color3.fromHSV(hueSatIndicatorFrame.Position.X.Scale, 1 - hueSatIndicatorFrame.Position.Y.Scale, 1 - valueIndicatorFrame.Position.Y.Scale);
            valueFrame.ImageColor3 = Color3.fromHSV(hueSatIndicatorFrame.Position.X.Scale, 1 - hueSatIndicatorFrame.Position.Y.Scale, 1);
            callback(colorFrame.BackgroundColor3);
        end;
    end);

    spawn(function()
        while true do
            for i = 1, 230 do
                rainbowBtn.TextColor3 = Color3.fromHSV(i / 230, 1, 1);
                if rainbow then
                    colorFrame.BackgroundColor3 = Color3.fromHSV(i / 230, 1, 1);
                    callback(Color3.fromHSV(i / 230, 1, 1));
                end;
                wait();
            end;
            wait();
        end;
    end);
end;

function OwlLib.Content:newDropdown(title, callback, list, noCallbackOnStart)
    self:Resize(self.bodyFrame);

    local oldSize;
    local btn = game:GetObjects("rbxassetid://4531687341")[1];
    btn.Parent = self.bodyFrame;
    btn.titleLabel.Text = title;
    btn.titleLabel.Size = UDim2.new(0, btn.titleLabel.TextBounds.X, 1, 0);
    btn.Size = UDim2.new(0, btn.titleLabel.Size.X.Offset + 80, 0, 30);

    if not noCallbackOnStart then
        callback(list[1]);
    end;

    local arrowLabel = btn.arrowLabel;
    local bodyFrame = btn.bodyFrame;

    self:initBtnEffect(btn);

    for i, v in pairs(list) do
        local btn = game:GetObjects("rbxassetid://4531683854")[1];
        btn.Parent = bodyFrame;
        btn.Text = v;
        btn.ZIndex = 2;

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                tweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5}):Play();
            end;
        end);

        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                tweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play();
            end;
        end);

        btn.MouseButton1Click:Connect(function()
            callback(v);
            tweenService:Create(arrowLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
            bodyFrame:TweenSize(UDim2.new(0, 170, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
            wait(0.15);
            bodyFrame.Visible = false;
            self.bodyFrame.CanvasSize = oldSize;
        end);
    end;

    btn.MouseButton1Click:Connect(function()
        if not bodyFrame.Visible then
            oldSize = self.bodyFrame.CanvasSize;
            self.bodyFrame.CanvasSize = oldSize + UDim2.new(0, 0, 0, 170);
            bodyFrame.Visible = true;
            tweenService:Create(arrowLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play();
            bodyFrame:TweenSize(UDim2.new(0, 170, 0, (#bodyFrame:GetChildren() - 1) * 27), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
        elseif bodyFrame.Visible then
            tweenService:Create(arrowLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play();
            bodyFrame:TweenSize(UDim2.new(0, 170, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
            wait(0.15);
            bodyFrame.Visible = false;
            self.bodyFrame.CanvasSize = oldSize;
        end;
    end);
end;

return OwlLib;
