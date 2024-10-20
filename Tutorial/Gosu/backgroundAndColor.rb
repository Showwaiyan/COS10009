require 'gosu'

WIDTH = 800
HEIGHT = 600
TITLE = "Background And Color"

class GameWindow < Gosu::Window
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = TITLE
        
        @bg_image = Gosu::Image.new("images/background.png")
        @bg_color = Gosu::Color.new(255,255,0,0)
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        when Gosu::KB_SPACE
            random_color
        end
    end
        
    def update
        
    end
    
    def draw
        Gosu.draw_rect(0, 0, self.width, self.height, @bg_color) 
        @bg_image.draw(0, 0)
    end

    def random_color
        @bg_color.red = rand(256)
        @bg_color.green = rand(256)
        @bg_color.blue = rand(256)
    end

end
       
GameWindow.new.show