require 'gosu'

module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

MAP_WIDTH = 200
MAP_HEIGHT = 200
CELL_DIM = 20

class Cell
  # have a pointer to the neighbouring cells
  attr_accessor :north, :south, :east, :west, :vacant, :visited, :on_path

  def initialize()
    # Set the pointers to nil
    @north = nil
    @south = nil
    @east = nil
    @west = nil
    # record whether this cell is vacant
    # default is not vacant i.e is a wall.
    @vacant = false
    # this stops cycles - set when you travel through a cell
    @visited = false
    @on_path = false
  end

  def intialize_neighbours(column_index, row_index,grid)
    #set the neighbours for the cell by the boundaries
    # For @north
    @north = grid[column_index - 1][row_index] if column_index > 0

    #for @east
    @east = grid[column_index][row_index + 1] if row_index < grid[0].length-1

    #for #south 
    @south = grid[column_index + 1][row_index] if column_index < grid.length-1

    #for @west
    @west = grid[column_index][row_index - 1] if row_index > 0
  end
end

# Instructions:
# Left click on cells to create a maze with at least one path moving from
# left to right.  The right click on a cell for the program to find a path
# through the maze. When a path is found it will be displayed in red.
class GameWindow < Gosu::Window

  # initialize creates a window with a width an a height
  # and a caption. It also sets up any variables to be used.
  # This is procedure i.e the return value is 'undefined'
  def initialize
    super MAP_WIDTH, MAP_HEIGHT, false
    self.caption = "Map Creation"
    @path = nil

    x_cell_count = MAP_WIDTH / CELL_DIM
    y_cell_count = MAP_HEIGHT / CELL_DIM

    @columns = Array.new(x_cell_count)
    column_index = 0

    # first create cells for each position
    while (column_index < x_cell_count)
      row = Array.new(y_cell_count)
      @columns[column_index] = row
      row_index = 0
      while (row_index < y_cell_count)
        cell = Cell.new()
        @columns[column_index][row_index] = cell
        row_index += 1
      end
      column_index += 1
    end

    # now set up the neighbour links
    # You need to do this using a while loop with another
    # nested while loop inside.
    column_index = 0
    while (column_index < x_cell_count)
      row_index = 0
      while (row_index < y_cell_count)
        cell = @columns[column_index][row_index]
        cell.intialize_neighbours(column_index,row_index,@columns)
        puts "Cell x: #{column_index} y: #{row_index} north:#{cell.north.nil? ? 0:1} south: #{cell.south.nil? ? 0:1} east: #{cell.east.nil? ? 0:1} west: #{cell.west.nil? ? 0:1}"
        row_index += 1
      end
      column_index += 1
      puts "#{"-"*10} End of Column #{"-"*10}"
    end
  end

  # this is called by Gosu to see if should show the cursor (or mouse)
  def needs_cursor?
    true
  end

  # Returns an array of the cell x and y coordinates that were clicked on
  def mouse_over_cell(mouse_x, mouse_y)
    if mouse_x <= CELL_DIM
      cell_x = 0
    else
      cell_x = (mouse_x / CELL_DIM).to_i
    end

    if mouse_y <= CELL_DIM
      cell_y = 0
    else
      cell_y = (mouse_y / CELL_DIM).to_i
    end

    [cell_x, cell_y]
  end

  # start a recursive search for paths from the selected cell
  # it searches till it hits the East 'wall' then stops
  # it does not necessarily find the shortest path

  # Completing this function is NOT NECESSARY for the Maze Creation task
  # complete the following for the Maze Search task - after
  # we cover Recusion in the lectures.

  # But you DO need to complete it later for the Maze Search task
  def search(cell_x, cell_y)
    cell = @columns[cell_x][cell_y]
  
    # Return path if we reach the eastern boundary
    if cell_x == ((MAP_WIDTH / CELL_DIM) - 1)
      return [[cell_x, cell_y]]
    end
  
    # Mark cell as visited
    cell.visited = true
  
    # Store all potential paths
    paths = []
  
    # Explore all possible directions
    if cell.east && !cell.east.visited && cell.east.vacant
      east_path = search(cell_x, cell_y + 1)
      paths << east_path if east_path
    end
  
    if cell.south && !cell.south.visited && cell.south.vacant
      south_path = search(cell_x + 1, cell_y)
      paths << south_path if south_path
    end
  
    if cell.west && !cell.west.visited && cell.west.vacant
      west_path = search(cell_x, cell_y - 1)
      paths << west_path if west_path
    end
  
    if cell.north && !cell.north.visited && cell.north.vacant
      north_path = search(cell_x - 1, cell_y)
      paths << north_path if north_path
    end
  
    # Choose the shortest valid path
    valid_path = paths.min_by { |p| p.length } if paths.any?
  
    if valid_path
      return [[cell_x, cell_y]] + valid_path
    else
      return nil # Dead end
    end
  end
  

  # Reacts to button press
  # left button marks a cell vacant
  # Right button starts a path search from the clicked cell
  def button_down(id)
    case id
      when Gosu::MsLeft
        cell = mouse_over_cell(mouse_x, mouse_y)
        if (ARGV.length > 0) # debug
          puts("Cell clicked on is x: " + cell[0].to_s + " y: " + cell[1].to_s)
        end
        @columns[cell[0]][cell[1]].vacant = true
      when Gosu::MsRight
        cell = mouse_over_cell(mouse_x, mouse_y)
        @path = search(cell[0],cell[1])
      end
  end

  # This will walk along the path setting the on_path for each cell
  # to true. Then draw checks this and displays them a red colour.
  def walk(path)
      index = path.length
      count = 0
      while (count < index)
        cell = path[count]
        @columns[cell[0]][cell[1]].on_path = true
        count += 1
      end
  end

  # Put any work you want done in update
  # This is a procedure i.e the return value is 'undefined'
  def update
    if (@path != nil)
      if (ARGV.length > 0) # debug
        puts "Displaying path"
        puts @path.to_s
      end
      walk(@path)
      @path = nil
    end
  end

  # Draw (or Redraw) the window
  # This is procedure i.e the return value is 'undefined'
  def draw
    index = 0
    x_loc = 0;
    y_loc = 0;

    x_cell_count = MAP_WIDTH / CELL_DIM
    y_cell_count = MAP_HEIGHT / CELL_DIM

    column_index = 0
    while (column_index < x_cell_count)
      row_index = 0
      while (row_index < y_cell_count)

        if (@columns[column_index][row_index].vacant)
          color = Gosu::Color::YELLOW
        else
          color = Gosu::Color::GREEN
        end
        if (@columns[column_index][row_index].on_path)
          color = Gosu::Color::RED
        end

        Gosu.draw_rect(column_index * CELL_DIM, row_index * CELL_DIM, CELL_DIM, CELL_DIM, color, ZOrder::TOP, mode=:default)

        row_index += 1
      end
      column_index += 1
    end
  end
end

window = GameWindow.new
window.show