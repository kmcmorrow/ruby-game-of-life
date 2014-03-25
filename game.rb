require 'gosu'
require_relative 'game_of_life'

class GameWindow < Gosu::Window
  WINDOW_WIDTH = 800 #1680
  WINDOW_HEIGHT = 600 #1050
  FULL_SCREEN = false

  #SPEED = 150
  CELL_SIZE = 5
  BG_COLOR = Gosu::Color.new(0xff222222)
  CELL_COLOR = Gosu::Color.new(0xff00ff00)
  
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT, FULL_SCREEN)
    self.caption = "Game of Life"
    @game_of_life = GameOfLife.new WINDOW_WIDTH, WINDOW_HEIGHT, CELL_SIZE
    @game_of_life.randomize
  end

  private

  def update
    #print_grid
    @game_of_life.update
  end

  def print_grid
    puts
    @game_of_life.grid.each do |row|
      row.each do |cell|
        print "#{cell}, "
      end
      puts
    end
    puts
  end

  def draw
    grid = @game_of_life.grid
    grid.each_index do |row|
      grid[row].each_with_index do |value, col|
        draw_cell col, row, CELL_COLOR if value == 1
      end
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

GameWindow.new.show
