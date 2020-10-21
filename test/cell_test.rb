require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'colorize'

class CellTest < MiniTest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_if_cell_exists
    assert_instance_of Cell, @cell
  end

  def test_cell_coordinates
    assert_equal "B4", @cell.coordinates
  end

  def test_cell_has_ship
    assert_nil @cell.ship
  end

  def test_cell_empty
    assert @cell.empty?
  end

  def test_cell_places_cruiser
    @cell.place_ship(@cruiser)

    assert_equal @cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_if_cell_is_fired_upon
    @cell.place_ship(@cruiser)

    refute @cell.fired_upon?
  end

  def test_cell_ship_health_when_fired_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon

    assert_equal 2, @cruiser.health
    assert @cell.fired_upon?
  end

  def test_it_renders_when_not_fired_upon
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)

    assert_equal ".".cyan, cell_1.render
    assert_equal ".".cyan, cell_2.render
  end

  def test_it_misses_when_empty_cell
    cell_1 = Cell.new("B4")
    cell_1.fire_upon

    assert_equal "M".blue, cell_1.render
  end

  def test_it_has_been_hit
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)
    cell_2.fire_upon

    assert_equal "H".yellow, cell_2.render
  end

  def test_it_has_been_hit_and_sunk
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)
    3.times { @cruiser.hit }

    assert_equal "X".red, cell_2.render
  end

  def test_it_reveals_ship
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)

    assert_equal "S".green, cell_2.render(true)
  end

  def test_it_has_been_hit_on_only_one_cell
    cell_2 = Cell.new("C3")
    cell_3 = Cell.new("B3")
    cell_4 = Cell.new("A3")
    cell_2.place_ship(@cruiser)
    cell_3.place_ship(@cruiser)
    cell_4.place_ship(@cruiser)
    cell_2.fire_upon

    assert_equal "H".yellow, cell_2.render
    assert_equal ".".cyan, cell_3.render
    assert_equal ".".cyan, cell_4.render
  end

end
