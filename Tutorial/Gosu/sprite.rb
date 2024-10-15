require 'gosu'

WIDTH = 800
HEIGHT = 600
TITLE = "Sprite Movement"

class Sprite < Gosu::Window
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = TITLE

        @sprite = Gosu::Image.new("images/ruby-logo.png")
        @sprite_x = 0
        @sprite_y = 0

        @sprite_val = 5
        @sprite_xval = @sprite_val
        @sprite_yval = @sprite_val
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        end
    end

    def update
        update_sprite
    end

    def draw
        @sprite.draw(@sprite_x, @sprite_y)
    end

    def update_sprite
        @sprite_x += @sprite_xval if ((Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::KB_D)) && (@sprite_x + @sprite.width < self.width))
        @sprite_x -= @sprite_xval if ((Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::KB_A)) && (@sprite_x > 0))
        @sprite_y -= @sprite_yval if ((Gosu.button_down?(Gosu::KB_UP) || Gosu.button_down?(Gosu::KB_W)) && (@sprite_y > 0))
        @sprite_y += @sprite_yval if ((Gosu.button_down?(Gosu::KB_DOWN) || Gosu.button_down?(Gosu::KB_S)) && (@sprite_y + @sprite.height < self.height))
    end
end

Sprite.new.show