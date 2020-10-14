require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < MiniTest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_if_cell_exists
    assert_instance_of Cell, @cell
  end

  def test_cell_coordinates
    assert_equal "B4", @cell.coordinates
  end

  def test_cell_has_ship
    assert_equal nil, @cell.ship
  end

  def test_cell_empty
    assert_equal true, @cell.empty?
  end

  def test_cell_places_cruiser
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)

    assert_equal cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_if_cell_is_fired_upon
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, @cell.fired_upon?
  end

  def test_cell_ship_health_when_fired_upon
    skip
    cruiser = Ship.new("Cruiser", 3)
    @cell.fire_upon
  end
end
