Fsm = class()
Fsm.SPLASH = 1
Fsm.PLAY = 2
Fsm.DEATH = 3
function Fsm:init(splash,play,death)
    -- you can accept and set parameters here
    self.state = self.SPLASH
    self.funcs = {splash,play,death}
    self.curFunc = self.funcs[self.state]
end

function Fsm:draw()
    -- Codea does not automatically call this method
    self.curFunc:draw()
end

function Fsm:changeState(state)
    self.state = state
    self.curFunc = self.funcs[state]
end

function Fsm:touched(touch)
    -- Codea does not automatically call this method
    self.curFunc:touched(touch)
end
