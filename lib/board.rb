class Board
  attr_reader :cells,
              :horizontal,
              :vertical
  def initialize
    @cells = {}
    @horizontal = (1..4).to_a
    @vertical = ("A".."D")
    #    "A1" => Cell.new("A1"),
    #    "A2" => Cell.new("A2"),
    #    "A3" => Cell.new("A3"),
    #    "A4" => Cell.new("A4"),
    #    "B1" => Cell.new("B1"),
    #    "B2" => Cell.new("B2"),
    #    "B3" => Cell.new("B3"),
    #    "B4" => Cell.new("B4"),
    #    "C1" => Cell.new("C1"),
    #    "C2" => Cell.new("C2"),
    #    "C3" => Cell.new("C3"),
    #    "C4" => Cell.new("C4"),
    #    "D1" => Cell.new("D1"),
    #    "D2" => Cell.new("D2"),
    #    "D3" => Cell.new("D3"),
    #    "D4" => Cell.new("D4")
    # }
  end

  def board_size
    # @horizontal = (1..4).to_a
    # @vertical = ("A".."D").to_a
    coordinates = @vertical.map do |letter|
      @horizontal.map do |num|
        letter + num.to_s
      end
    end
    coordinates.flatten
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
