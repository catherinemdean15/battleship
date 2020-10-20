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



end 
