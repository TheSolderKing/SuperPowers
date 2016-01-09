--Platformer

-- Use this function to perform your initial setup
    STANDING = 0
    JUMPING = 1
    FALLING = 2
    RUNNING = 3
    WALLSLIDE = 4
    WALLJUMP = 5
function setup()
    f = Fsm(Splash(), Play(), nil)
    print(WIDTH..","..HEIGHT)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(40, 40, 50)

    -- This sets the line thickness

    -- Do your drawing here
    f:draw()
end

function touched(t)
    f:touched(t)
end
