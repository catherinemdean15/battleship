require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/menu'

class MenuTest < MiniTest::Test

  def setup
    @menu = Menu.new
  end

  def test_it_exists
    assert_instance_of Menu, @menu
  end

  # def test_it_starts
  #   assert_equal nil, @menu.start
  # end

  # def test_computer_places_ships
  #   assert_equal 5,
  # end

end
