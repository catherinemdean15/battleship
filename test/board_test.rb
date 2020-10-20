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

  def test_consecutive?
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
  end

  def test_valid_placement_ship_length
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_valid_placement_is_consecutive
    refute @board.consecutive?(["A1", "A2", "A4"])
    refute @board.consecutive?(["A1", "C1"])
    refute @board.consecutive?(["A3", "A2", "A1"])
    refute @board.consecutive?(["C1", "B1"])
  end

  def test_valid_placement_diagonal
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_placements
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_it_places_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert @board.cells["A1"].ship != nil
    assert @board.cells["A2"].ship != nil
    assert @board.cells["A3"].ship != nil
  end

  def test_cells_have_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    assert cell_1.ship
    assert cell_2.ship
    assert cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

  def test_valid_placement_again
    @board.place(@cruiser, ["A1", "A2", "A3"])
    refute @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_board_renders_cells
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n",
    @board.render
  end

  def test_board_renders_cells_when_true
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal " 1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n",
    @board.render(true)
  end
end
