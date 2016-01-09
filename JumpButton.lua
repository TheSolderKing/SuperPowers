JumpButton = class()

function JumpButton:init(x,y)
    -- you can accept and set parameters here
    self.pos = vec2(x,y)
    self.pressed = false
    self.d = 100
    self.img = readImage("Project:Jump")
end

function JumpButton:draw()
    -- Codea does not automatically call this method
    sprite(self.img,self.pos.x,self.pos.y,self.d,self.d)
    if self.pressed then
        --p:jump()
    end
end

function JumpButton:touched(touch)
    -- Codea does not automatically call this method
    if vec2(touch.x,touch.y):dist(self.pos) <= self.d/2 and touch.state == BEGAN then
        self.pressed = true
        self.tId = touch.id
        return true
    end
    if touch.id == self.tId and touch.state == ENDED then
        self.tId = nil
        self.pressed = false
    end
    return false
end
