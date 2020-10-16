class Board
  attr_reader :cells,
              :horizontal,
              :vertical
  def initialize
    @cells = {}
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
    puts coordinates.to_s
  end

  def cells
    board_size.map do |key|
      @cells = Cell.new(key)
    end
    @cells
  end

  def valid_coordinate?(coordinates)
    @cells[coordinates] != nil
  end

  def valid_placement?(ship, coordinates)
    if consecutive?(coordinates) && ship.name == "Cruiser" && (coordinates.count == 3)
    else consecutive?(coordinates) && ship.name == "Submarine" && (coordinates.count == 2)
    end
  end

  def consecutive?(coordinates)
    split_letters = []
    split_numbers = []
    coordinates.each do |cell|
      split_letters << cell[0]
      split_numbers << cell[1]
    end
  # require 'pry';binding.pry
      (split_numbers.first..split_numbers.last).to_a == split_numbers ||
      (split_letters.first..split_letters.last).to_a == split_letters
  end
end
