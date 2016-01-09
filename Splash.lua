Splash = class()

function Splash:init()
    -- you can accept and set parameters here
    self.title = "SUPER POWER STUFF"
    self.titleImage = readImage("Project:splash")
    self.playButton = Button(WIDTH/4-100, HEIGHT/2-150, 200, 100,  
                             "PLAY",function() f:changeState(2) 
                             return true end)
    self.lvlButton =  Button(3*WIDTH/4-100,HEIGHT/2-150,200,100,
                             "DEV STUFF",function() f:changeState(2)
                              return true end)
end

function Splash:draw()
    noSmooth()
    -- Codea does not automatically call this method
    sprite(self.titleImage,WIDTH/2,HEIGHT/2,WIDTH,HEIGHT)
    fontSize(50)
    font("Futura-CondensedExtraBold")
    fill(40, 57, 109, 255)
    text(self.title,WIDTH/2,4*HEIGHT/5)
    fill(0, 48, 255, 255)
    text(self.title,WIDTH/2-3,4*HEIGHT/5-3)
    self.playButton:draw()
    self.lvlButton:draw()
end

function Splash:touched(touch)
    -- Codea does not automatically call this method
    self.playButton:touched(touch)
    self.lvlButton:touched(touch)
end
