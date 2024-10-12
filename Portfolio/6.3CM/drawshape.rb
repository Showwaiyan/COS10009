require 'gosu'

# Constants for L-system tree
AXIOM = "F"
RULES = { "F" => "FF+[+F-F-F]-[-F+F+F]" }
ANGLE = 25.0 # degrees
ITERATIONS = 4

class LSystemTree
  attr_reader :system

  def initialize(axiom, rules)
    @axiom = axiom
    @rules = rules
    @system = axiom
  end

  # Apply L-system rules for a given number of iterations
  def generate(iterations)
    iterations.times do
      @system = @system.chars.map { |char| @rules[char] || char }.join
    end
  end
end

class Scenario < Gosu::Window
  WIDTH, HEIGHT = 800, 600

  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Scenario"

    @tree = LSystemTree.new(AXIOM, RULES)
    @tree.generate(ITERATIONS)

    @angle = ANGLE
    @length = 5.0
  end

  # Draw the tree using L-system rules
  def draw
    draw_linear_gradient_background
    draw_tree(@tree.system, 188, 348, 0)
    draw_ground
    draw_sun
  end

  def draw_tree(system, x, y, angle)
    stack = []
    
    system.each_char do |char|
      case char
      when "F"
        # Move forward and draw a line segment
        x_new = x + Gosu.offset_x(angle, @length)
        y_new = y + Gosu.offset_y(angle, @length)
        draw_line(x, y, Gosu::Color::BLACK, x_new, y_new, Gosu::Color::BLACK)
        x, y = x_new, y_new
      when "+"
        # Turn right
        angle += @angle
      when "-"
        # Turn left
        angle -= @angle
      when "["
        # Save the current state
        stack.push([x, y, angle])
      when "]"
        # Restore the saved state
        x, y, angle = stack.pop
      end
    end
  end

  def draw_ground
    ground_color = Gosu::Color::BLACK

    x1, y1 = 0, 359
    x2, y2 = 259, 344
    x3, y3 = 150, 445
    x4, y4 = 0, 481

    # Draw the ground
    Gosu.draw_quad(x1, y1, ground_color,  
                   x2, y2, ground_color,  
                   x3, y3, ground_color,
                   x4, y4, ground_color)  
  end

  def draw_sun
    sun_color = Gosu::Color.argb(0xff_ffd700)

    x, y = 700, 50
    r = 30
   
    segments = 64  # The higher the number, the smoother the circle
    angle_step = 2 * Math::PI / segments  # Full circle (2π radians)

    # Iterate through each segment to create the circle
    (0..segments).each do |i|
      angle1 = i * angle_step
      angle2 = (i + 1) * angle_step
      x1 = x + r * Math.cos(angle1)
      y1 = y + r * Math.sin(angle1)
      x2 = x + r * Math.cos(angle2)
      y2 = y + r * Math.sin(angle2)
      Gosu.draw_line(x1, y1, sun_color, x2, y2, sun_color, 1)

      # Filling color inside the sun
      Gosu.draw_triangle(x, y, sun_color,   
      x1, y1, sun_color, 
      x2, y2, sun_color)
    end
  end
  
  def draw_linear_gradient_background
    top_color = Gosu::Color.new(255, 255, 215, 0)     # Golden Yellow
    mid_color = Gosu::Color.new(255, 255, 69, 0)  # Orange/Red
    horizon_color = Gosu::Color.new(255, 255, 107, 138) # Warm Pink
    bottom_color = Gosu::Color.new(255, 46, 43, 95) # Deep Purple

    HEIGHT.times do |y|
      if y < HEIGHT / 2
        # Blend from top to middle
        factor = y.to_f / (HEIGHT / 2)
        r = interpolate(top_color.red, mid_color.red, factor)
        g = interpolate(top_color.green, mid_color.green, factor)
        b = interpolate(top_color.blue, mid_color.blue, factor)
      else
        # Blend from middle to bottom
        factor = (y - HEIGHT / 2).to_f / (HEIGHT / 2)
        r = interpolate(mid_color.red, bottom_color.red, factor)
        g = interpolate(mid_color.green, bottom_color.green, factor)
        b = interpolate(mid_color.blue, bottom_color.blue, factor)
      end

      current_color = Gosu::Color.new(255, r, g, b)
      Gosu.draw_line(0, y, current_color, WIDTH, y, current_color)
    end
  end

  # Helper method to interpolate between two values based on the factor
  def interpolate(start_value, end_value, factor)
    start_value + (end_value - start_value) * factor
  end

end

Scenario.new.show