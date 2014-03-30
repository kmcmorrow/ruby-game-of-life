class GameOfLife
  attr_reader :grid
  
  def initialize(width, height, cell_size)
    @grid_width = width / cell_size
    @grid_height = height / cell_size
    @grid = Array.new(@grid_height) { Array.new(@grid_width, 0) }
  end

  # updates the game state by one iteration
  def update
    update_grid = Array.new(@grid_height) { Array.new(@grid_width, 0) }
    update_grid.each_index do |row|
      update_grid[row].each_index do |col|
        num_neighbours = get_num_neighbours col, row
        if (@grid[row][col] == 1 && num_neighbours.between?(2, 3)) ||
            (@grid[row][col] == 0 && num_neighbours == 3)
          update_grid[row][col] = 1
        end
      end
    end
    @grid = update_grid
  end

  # turns on some random cells in the grid
  def randomize
    (@grid_height * @grid_width / 5).times do
      @grid[rand(@grid_height)][rand(@grid_width)] = 1
    end
  end

  private

  # returns the number of neighbours to a given cell
  def get_num_neighbours(x, y)
    neighbours = 0
    (x-1..x+1).each do |col|
      (y-1..y+1).each do |row|
        if in_bounds?(col, row) && !(col == x && row == y) &&
            @grid[row][col] == 1
          neighbours += 1
        end
      end
    end
    neighbours
  end

  # returns true if a given coord is within the grid
  def in_bounds?(x, y)
    x >= 0 && x < @grid_width && y >= 0 && y < @grid_height
  end

end

