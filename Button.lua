Button = class()

function Button:init(x,y,w,h,txt,cb)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    self.w,self.h = w,h
    self.callBack = cb
    self.txt = txt
end

function Button:draw()
    -- Codea does not automatically call this method
    noStroke()
    fill(251, 255, 0, 255)
    rect(self.x,self.y,self.w,self.h)
    fill(0)
    text(self.txt,self.x+self.w/2,self.y+self.h/2)
end

function Button:touched(touch)
    -- Codea does not automatically call this method
    if touch.x > self.x and touch.x < self.x + self.w and touch.y > self.y and touch.y < self.h + self.y and touch.state == BEGAN then
        self.touch = true
        self.touchId = touch.id
    end
    if touch.id == self.touchId and touch.state == ENDED then
        self.touch = false
        self.callBack()
    end
end
