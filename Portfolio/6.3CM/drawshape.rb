require 'gosu'

class LSystemSnowflake
  attr_reader :axiom, :rules

  def initialize
    @axiom = "F--F--F"
    @rules = { "F" => "F+F--F+F" }
  end

  # Generates the L-system string after n iterations
  def generate(iterations)
    state = @axiom
    iterations.times do
      state = state.gsub(/./) { |char| @rules[char] || char }
    end
    state
  end
end

class GameWindow < Gosu::Window
  WIDTH, HEIGHT = 800, 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "L-system Snowflake"

    @angle = 60   # Angle for snowflake turns
    @length = 3   # Line length, reduced to fit the screen after iterations
    @heading = 0  # Starting direction (0 degrees is to the right)

    @snowflake = LSystemSnowflake.new
    @iterations = 4  # Adjust iterations for complexity
    @instructions = @snowflake.generate(@iterations)

    @x_offset = WIDTH / 2
    @y_offset = HEIGHT / 2
  end

  # Move forward and draw a line in the current direction
  def move_forward
    new_x = @x + Gosu.offset_x(@heading, @length)
    new_y = @y + Gosu.offset_y(@heading, @length)
    Gosu.draw_line(@x, @y, Gosu::Color::WHITE, new_x, new_y, Gosu::Color::WHITE, 1)
    @x, @y = new_x, new_y
  end

  # Interpret the L-system instructions
  def interpret_instructions
    @instructions.each_char do |char|
      case char
      when "F"
        move_forward
      when "+"
        @heading -= @angle  # Turn right
      when "-"
        @heading += @angle  # Turn left
      end
    end
  end

  def update
    # Nothing in update for this static snowflake
  end

  def draw
    background_color = Gosu::Color.new(225,198, 252, 255)
    Gosu.translate(@x_offset, @y_offset) do  # Center the drawing 
      # Reset the drawing position and heading before drawing
      @x, @y = -@length * (3 ** @iterations) / 4, 50  # Center horizontally
      @heading = 0  # Reset heading direction
      interpret_instructions  # Draw the snowflake
    end
    Gosu.draw_quad(0,0,background_color,
                  WIDTH,0,background_color,
                  WIDTH,HEIGHT,background_color,
                  0,HEIGHT,background_color)
  end
end

window = GameWindow.new
window.show
