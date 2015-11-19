waxClass{"ViewController"}

local helloView = UIView:initWithFrame(CGRect(20, 20, 100, 100))
helloView:setBackgroundColor(UIColor:redColor())
print("x = " .. helloView:frame().x)

function viewDidLoad(self)
self:ORIGviewDidLoad()
print(self)
self:view():addSubview(helloView)
end

--local window = UIApplication:sharedApplication():keyWindow()
--window:addSubview(helloView)