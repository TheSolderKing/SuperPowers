Slider = class()

function Slider:init(x,y)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    self.originX = x
    self.img = readImage("Project:Slider")
end

function Slider:draw()
    -- Codea does not automatically call this method
    stroke(127, 127, 127, 138)
    strokeWidth(5)
    line(self.originX-50,self.y,self.originX+50,self.y)
    noStroke()
    sprite(self.img,self.x,self.y,50,50)
    return (self.x - self.originX)/50
end

function Slider:touched(touch)
    -- Codea does not automatically call this method
    if not self.tId and vec2(self.x,self.y):dist(vec2(touch.x,touch.y))<25 then
        if touch.state ~=ENDED then
            self.tId = touch.id
        end
    else
        if touch.state ~= ENDED and self.tId == touch.id then
            self.x = math.min(self.originX+50,math.max(self.originX-50,touch.x))
        elseif touch.state == ENDED and self.tId == touch.id then
            self.x = self.originX
            self.tId = nil
        end
    end
end
