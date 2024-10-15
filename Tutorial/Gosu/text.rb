require 'gosu'

WIDTH = 800
HEIGHT = 600
TITLE = "Text Movement"

class Text < Gosu::Window
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = TITLE
        @text = Gosu::Image.from_text("Gosu",80,)
        @text_x = 0
        @text_y = 0

        @text_val = 3
        @text_xval = @text_val
        @text_yval = @text_val
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        end
    end

    def update
      update_text  
    end

    def draw
        @text.draw(@text_x, @text_y)
    end

    def update_text
        @text_x += @text_xval
        @text_y += @text_yval
        if @text_x + @text.width > self.width
            @text_xval = -@text_val
        elsif @text_x < 0
            @text_xval = @text_val
        end

        if @text_y + @text.height > self.height
            @text_yval = -@text_val
        elsif @text_y < 0
            @text_yval = @text_val
        end
    end

end
        
Text.new.show