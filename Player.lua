Player = class()

function Player:init(x,y)
    -- you can accept and set parameters here
    self.pos = vec2(x,y)
    self.d = vec2(WIDTH/10-10,WIDTH/10-10)
    self.vel = vec2(0,0)
    self.onwallchanged = false
    local setonwall = function() self.onWall = true self.onwallchanged = true end
    local setoffwall = function() if not self.onwallchanged then self.onWall = false end end
    self.onWall = false
    self.points = {
    {value = vec2(0,-self.d.y/2), move = vec2(0,0.1),onHit = function() self.onGround = true end, onNoHit = function() self.onGround = false end},
    {value = vec2(-self.d.x/2,-self.d.y/4), move = vec2(0.15,0),onHit = setonwall, onNoHit = setoffwall},
    {value = vec2(-self.d.x/2,self.d.y/4), move = vec2(0.15,0), onHit = setonwall, onNoHit = setoffwall},
    {value = vec2(0,self.d.y/2), move = vec2(0,-0.1)},
    {value = vec2(self.d.x/2,self.d.y/4), move = vec2(-0.15,0), onHit = setonwall, onNoHit = setoffwall},
    {value = vec2(self.d.x/2,-self.d.y/4), move = vec2(-0.15,0), onHit = setonwall, onNoHit = setoffwall},
    }
    self.state = FALLING
    self.mPoints = {}
    self.m = mesh()
    self.m.texture = readImage("Project:main_char2")
    self.index = self.m:addRect(0,0,self.d.x,self.d.y)
    self.m:setRectTex(self.index,0,0,1/6,1)
    self.facing = 1
    self.anims = {
    stand = {1},
    run = {2,3,2,4},
    slide = {5},
    fall = {6}
    }
    self.animFrame = 1
    self.onGround = false
end

function Player:draw(moveAmount,w)
    -- Codea does not automatically call this method
    noSmooth()
    noTint()
    self.onwallchanged = false
    self:handleStates()
    self:move(moveAmount)
    self.pos = self.pos + self.vel
    self:handleCollisions(w)
    self:animate()
    pushMatrix()
    translate(self.pos.x,self.pos.y)
    scale(self.facing,1)
    self.m:draw()
    popMatrix()
end

function Player:move(amount)
    amount.x = math.min(math.max(-WIDTH/75,amount.x),WIDTH/75)
    amount.y = math.min(math.max(-WIDTH/75,amount.y),WIDTH/75)
    if self.state ~= WALLJUMP and self.state ~= WALLSLIDE then
        self.vel.x = amount.x
    end
    if self.state == JUMPING or self.state == FALLING or self.state == WALLSLIDE or self.state == WALLJUMP then
        self.vel.y = self.vel.y - 0.5
    else
        self.vel.y = 0
    end
    --self.vel.x = math.min(math.max(-WIDTH/75,self.vel.x),WIDTH/75)
    --self.vel.y = math.min(math.max(-WIDTH/75,self.vel.y),WIDTH/75)
    if amount.x == 0 then 
        if self.state ~= WALLJUMP and self.state ~= JUMPING then --self.vel.x = self.vel.x * 0.2
        elseif self.state == JUMPING then
            self.vel.x = self.vel.x * 0.9 
        end
    end
    if self.state == WALLJUMP then self.vel.x = self.vel.x * 0.9 end
        --if self.state ~= JUMPING and self.state ~= FALLING then self.state = STANDING end
    if self.vel.x > 0 then self.facing = 1
        --if self.state == STANDING then self.state = RUNNING end
    elseif self.vel.x < 0 then self.facing = -1
        --if self.state == STANDING then self.state = RUNNING end
    end
    if math.abs(self.vel.x) < 0.01 then self.vel.x = 0 end
end

function Player:handleCollisions(w)
    self.pos.y = self.pos.y - 0.1
    for i,v in pairs(self.points) do
        local hit = false
        while w:getAt(self.pos + v.value) == 1 do
            self.pos = self.pos + v.move
            hit = true
        end
        if hit and v.onHit then
            v.onHit()
        elseif hit == false and v.onNoHit then
            v.onNoHit()
        end
    end
end

function Player:animate()
    local curAnim
    curAnim = self.anims.stand
    if self.state == STANDING then
        curAnim = self.anims.stand
    elseif self.state == RUNNING then
        curAnim = self.anims.run
    elseif self.state == WALLSLIDE then
        curAnim = self.anims.slide
    elseif self.state == FALLING then
        curAnim = self.anims.fall
    end
    if f.curFunc.frame%5 == 0 then
        self.animFrame = self.animFrame + 1
    end
    if self.animFrame > #curAnim then
        self.animFrame = 1
    end
    self.m:setRectTex(self.index,(curAnim[self.animFrame]-1)/6,0,1/6,1)
end

function Player:jump()
    if self.state == STANDING or self.state == RUNNING then
        self.vel.y = WIDTH/75
    elseif self.state == WALLSLIDE then
        self.vel.y = WIDTH/75
        self.onWall = false
        self.vel.x = self.facing * -15
    end
end

function Player:handleStates()
    if self.state == STANDING and math.abs(self.vel.x) > 0.5 then
        self.state = RUNNING
    elseif self.state == RUNNING and math.abs(self.vel.x) <= 0.5 then
        self.state = STANDING
    end
    if self.vel.y < 0 and self.onWall == false and (self.state == STANDING or self.state == RUNNING or self.state == JUMPING) then
        self.state = FALLING
    elseif self.vel.y > 0 and self.state ~=WALLSLIDE and self.state ~= WALLJUMP then
        self.state = JUMPING
    elseif self.vel.y > 0 and self.state == WALLSLIDE then
        self.state = WALLJUMP
    end
    if math.abs(self.vel.x) <=1 and self.state == WALLJUMP then
        self.state = FALLING
    end
    if self.onGround and (self.state == FALLING or self.state == WALLSLIDE) then
       self.state = STANDING
    elseif self.onGround == false and (self.state == STANDING or self.state == RUNNING) then
        self.state = FALLING
    end
    if not self.onGround and self.onWall then
        self.state = WALLSLIDE
    elseif not self.onGround and not self.onWall and self.state == WALLSLIDE then
        self.state = FALLING
    end
end

function Player:handleScrolling()
    
end
