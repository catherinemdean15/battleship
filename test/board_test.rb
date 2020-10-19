require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
    @submarine = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists_and_has_cells
      assert_instance_of Board, @board
  end

  def test_it_has_cells
    assert_equal 16, @board.cells.count
  end

  def test_it_validates_coordinate
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_valid_placement_ship_length
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  # def test_valid_placement_is_consecutive
  #   refute @board.consecutive?(@cruiser, ["A1", "A2", "A4"])
  #   refute @board.consecutive?(@submarine, ["A1", "C1"])
  #   refute @board.consecutive?(@cruiser, ["A3", "A2", "A1"])
  #   refute @board.consecutive?(@submarine, ["C1", "B1"])
  # end

  def test_valid_placement_diagonal
    #use uniq function
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_placement
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_it_places_ship
    assert @board.place(@cruiser, ["A1", "A2", "A3"])
  end
end
