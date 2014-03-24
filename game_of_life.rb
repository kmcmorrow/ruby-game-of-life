require 'gosu'

class GameOfLife < Gosu::Window

  WIDTH = 1920
  HEIGHT = 1080
  CELL_SIZE = 5
  #SPEED = 150
  BG_COLOR = Gosu::Color.new(0xff222222)
  CELL_COLOR = Gosu::Color.new(0xff00ff00)
  
  def initialize
    super(WIDTH, HEIGHT, true)
    self.caption = "Game of Life"
    @grid_width = WIDTH / CELL_SIZE
    @grid_height = HEIGHT / CELL_SIZE
    @grid = Array.new(@grid_height) { Array.new(@grid_width, 0) }

    randomize_grid
  end

  private

  def update
    #print_grid
    
    update_grid = Array.new(@grid_height) { Array.new(@grid_width, 0) }
    update_grid.each_index do |row|
      update_grid[row].each_index do |col|
        num_neighbours = get_num_neighbours col, row
        if @grid[row][col] == 1 # alive
          if num_neighbours < 2 || num_neighbours > 3
            update_grid[row][col] = 0
          else
            update_grid[row][col] = 1
          end
        else # dead
          if num_neighbours == 3
            update_grid[row][col] = 1
          else
            update_grid[row][col] = 0
          end
        end
      end
    end
    @grid = update_grid

  end

  def print_grid
    puts
    @grid.each do |row|
      row.each do |cell|
        print "#{cell}, "
      end
      puts
    end
    puts
  end

  def get_num_neighbours(x, y)
    neighbours = 0
    (x-1..x+1).each do |col|
      (y-1..y+1).each do |row|
        if col >= 0 && col < @grid_width && row >= 0 && row < @grid_height &&
            !(col == x && row == y) && @grid[row][col] == 1
          neighbours += 1
        end
      end
    end
    neighbours
  end

  def draw
    @grid.each_index do |row|
      @grid[row].each_with_index do |value, col|
        draw_cell col, row, CELL_COLOR if value == 1
      end
    end
  end

  def randomize_grid
    (@grid_height * @grid_width / 5).times do
      @grid[rand(@grid_height)][rand(@grid_width)] = 1
    end
  end

  def draw_cell(x, y, c)
    x = x * CELL_SIZE
    y = y * CELL_SIZE
    draw_quad(x, y, c,
              x + CELL_SIZE, y, c,
              x, y + CELL_SIZE, c,
              x + CELL_SIZE, y + CELL_SIZE, c)
  end
end


GameOfLife.new.show
