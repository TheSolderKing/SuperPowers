Play = class()

function Play:init()
    -- you can accept and set parameters here
    self.w = World(1)
    self.p = Player(100,100)
    self.s = Slider(100,100)
    self.b = JumpButton(WIDTH-100,100)
    self.frame = 1
    self.moveAmount = vec2(0,0)
end

function Play:draw()
    -- Codea does not automatically call this method
    self.w:draw()
    self.p:draw(self.moveAmount,self.w)
    self.moveAmount = vec2(0,0)
    self.moveAmount.x = self.moveAmount.x + self.s:draw() * 6
    self.b:draw()
    self.frame = (self.frame + 1)%60
end

function Play:touched(touch)
    -- Codea does not automatically call this method
    self.s:touched(touch)
    if self.b:touched(touch) then
        self.p:jump()
    end
end
