require 'colorize'

class Cell
  attr_reader :coordinates,
              :ship

  def initialize(coordinates)
    @coordinates = coordinates
    @ship        = nil
    @miss        = false
    @fired_upon  = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship == nil
       @miss = true
       @fired_upon = true
    else
      @ship.hit
      @fired_upon = true
    end
  end

  def render(show = false)
    if @ship != nil && show == true && fired_upon? == false
      "S".green
    elsif @ship == nil && @miss == true
      "M".blue
    elsif @ship != nil && @ship.sunk?
      "X".red
    elsif @ship != nil && fired_upon? == true
      "H".yellow
    else
      ".".cyan
    end
  end
end
