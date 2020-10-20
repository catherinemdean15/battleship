class Cell
  attr_reader :coordinates,
              :ship

  def initialize(coordinates)
    @coordinates = coordinates
    @ship = nil
    @miss = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @ship.health != @ship.length
  end

  def fire_upon
    if @ship == nil
       @miss = true
    else
      @ship.hit
    end
  end

  def render(show = false)
    if @ship != nil && show == true && @miss == false
      "S"
    elsif @ship == nil && @miss == true
      "M"
    elsif @ship != nil && @ship.sunk?
      "X"
    elsif @ship != nil && fired_upon? == true
      "H"
    else
      "."
    end
  end
end
