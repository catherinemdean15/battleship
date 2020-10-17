class Board
  attr_reader :cells,
              :horizontal,
              :vertical
  def initialize
    @cells = cell_setup
    @horizontal = (1..4).to_a
    @vertical = ("A".."D").to_a
    @board_layout = board_size
  end

  def board_size
    coordinates = @vertical.map do |letter|
      @horizontal.map do |num|
        letter + num.to_s
      end
    end
    coordinates.to_s
    #remember what the heck you did to make it print 2x
  end

  def cell_setup
      # require 'pry';binding.pry
    board_size.map do |key|
      @cells = Cell.new(key)
    end
    @cells.to_h?
  end

  def valid_coordinate?(coordinates)
    @cells[coordinates] != nil
  end

  def consecutive?(coordinates)
    numbers = []
    letters = []
    coordinates.each do |coordinate|
      numbers << coordinate[1].to_i
      letters << coordinate[0].ord
    end
    ((numbers.first..numbers.last).to_a == numbers) ^
    ((letters.first..letters.last).to_a == letters)
  end

  def valid_placement?(ship, coordinates)
    if ship.name == "Cruiser" &&
      coordinates.count == 3 &&
      consecutive?(coordinates)
      true
    elsif ship.name == "Submarine" &&
      coordinates.count == 2 &&
       consecutive?(coordinates)
       true
    else
      false
    end
  end
end
