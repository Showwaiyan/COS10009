require 'gosu'

WIDTH = 800
HEIGHT = 600
TITLE = "Testing..."
class GameWindow < Gosu::Window 
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = TITLE
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        end
    end

    def update
        #Pass
    end

    def draw
        #Pass
    end

end

GameWindow.new.show