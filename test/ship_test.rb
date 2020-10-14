require './lib/ship'
require 'MiniTest/autorun'
require 'MiniTest/pride'

class ShipTest < MiniTest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_calls_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_it_calls_length
    assert_equal 3, @cruiser.length
  end

  def test_it_checks_health
    assert_equal 3, @cruiser.health
  end

  def test_it_checks_if_sunk
    assert_equal false, @cruiser.sunk?
  end

  def test_check_it_can_take_hit
    @cruiser.hit

    assert_equal 2, @cruiser.health
  end

  def test_check_if_sunk_again
    3.times { @cruiser.hit }

    assert_equal true, @cruiser.sunk?
  end
end
