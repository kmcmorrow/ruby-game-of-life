gem 'minitest'
require 'minitest/autorun'
require_relative 'game_of_life'

class TestGameOfLife < Minitest::Test

  EMPTY_GRID = [[0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]]

  BLINKER_1 = [[0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0],
               [0, 1, 1, 1, 0],
               [0, 0, 0, 0, 0],
               [0, 0, 0, 0, 0]]
  
  BLINKER_2 = [[0, 0, 0, 0, 0],
               [0, 0, 1, 0, 0],
               [0, 0, 1, 0, 0],
               [0, 0, 1, 0, 0],
               [0, 0, 0, 0, 0]]
  
  BEACON_1 = [[0, 0, 0, 0, 0],
              [0, 1, 1, 0, 0],
              [0, 1, 0, 0, 0],
              [0, 0, 0, 0, 1],
              [0, 0, 0, 1, 1]]

  BEACON_2  = [[0, 0, 0, 0, 0],
               [0, 1, 1, 0, 0],
               [0, 1, 1, 0, 0],
               [0, 0, 0, 1, 1],
               [0, 0, 0, 1, 1]]

  def setup
    @game = GameOfLife.new 5, 5, 1
  end

  def test_empty_grid
    assert_equal EMPTY_GRID, @game.grid
  end

  def test_blinker
    @game.grid[2][1] = 1
    @game.grid[2][2] = 1
    @game.grid[2][3] = 1
    @game.update
    assert_equal BLINKER_2, @game.grid
  end

  def test_beacon
    @game.grid[1][1] = 1
    @game.grid[1][2] = 1
    @game.grid[2][1] = 1
    @game.grid[3][4] = 1
    @game.grid[4][3] = 1
    @game.grid[4][4] = 1
    @game.update
    assert_equal BEACON_2, @game.grid
  end
end
