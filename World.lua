World = class()

function World:init(lvlnum)
    -- you can accept and set parameters here
    self.currentLevelNumber = lvlnum
    self.blockSizeX,self.blockSizeY = bsx,bsy
    --Load the level data from the hard drive
    self.levels = json.decode(readText("Project:leveldat"))
    --Put the data for the current level into a table
    self.currentLevel = self.levels[self.currentLevelNumber]
    print(self.currentLevel)
    --readText("Project:leveldat")
    print(json.encode({
    {
    {1,1,1,1,1,1,1,1,1,1,1,1},
    {1,0,0,0,1,0,1,1,1,1,1,1},
    {1,0,0,1,1,0,1,1,1,1,1,1},
    {1,0,0,0,0,0,0,0,0,1,1,1},
    {1,0,0,0,0,0,0,0,0,1,1,1},
    {1,0,0,0,0,0,1,0,0,1,1,1},
    {1,0,0,0,0,0,1,0,0,1,1,1},
    {1,1,1,0,0,0,1,0,0,1,1,1},
    {1,4,0,0,0,0,0,0,0,1,1,1},
    {1,0,0,0,0,0,0,0,0,1,1,1},
    {1,0,0,0,0,0,1,1,1,1,1,1},
    {1,1,1,1,1,1,1,1,1,1,1,1}
    }
    }))
    self.mesh = mesh()
    self.mesh.texture = readImage("Project:blocks")
    self.blocksize = vec2(WIDTH/#self.levels[1][1],WIDTH/#self.levels[1])
    self:start()
end

function World:start()
    self.levelStartTime = os.clock()
    for y,v in pairs(self.currentLevel) do
        for x,val in pairs(v) do
            local i = self.mesh:addRect((x-1)*self.blocksize.x + self.blocksize.x/2,(y-1)*self.blocksize.y + self.blocksize.y/2,self.blocksize.x,self.blocksize.y)
            --[[if val == 1 then
                self.mesh:setRectTex(i,0,0,0.49,1)
            else
                self.mesh:setRectTex(i,0.51,0,0.48,1)
            end]]
        self.mesh:setRectTex(i,val/5+0.001,0,0.199,1)
        end
    end
end

function World:getAt(pos)
    local bx, by = math.ceil((pos.x)/(self.blocksize.x)),math.ceil((pos.y)/(self.blocksize.y))
    if by <= #self.currentLevel and bx <= #self.currentLevel[1] then return self.currentLevel[by][bx] end
end

function World:draw()
    -- Codea does not automatically call this method
    self.mesh:draw()
end

function World:touched(touch)
    -- Codea does not automatically call this method
end
