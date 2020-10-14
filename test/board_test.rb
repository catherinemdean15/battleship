require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
  end

  def test_it_exists
      assert_instance_of Board, @board
  end

  def test_it_has_cells
    assert_equal 16, @board.cells.count
  end

end
