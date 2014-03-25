class GameOfLife
  attr_reader :grid
  
  def initialize(width, height, cell_size)
    @grid_width = width / cell_size
    @grid_height = height / cell_size
    @grid = Array.new(@grid_height) { Array.new(@grid_width, 0) }
  end

  def update
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

  def randomize
    (@grid_height * @grid_width / 5).times do
      @grid[rand(@grid_height)][rand(@grid_width)] = 1
    end
  end

  private

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

end

