class Board
  attr_reader :cells

  def initialize
      @cells = {}
      create_board
  end

  def create_board
    letters = ["A", "B", "C", "D"]
    numbers = [1, 2, 3, 4]
    letters.each do |letter|
    numbers.each do |number|
      @cells["#{letter}#{number}"] = Cell.new("#{letter}#{number}")
    end
    end
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
    (((numbers.first..numbers.last).to_a == numbers) &&
        (letters.all? do |letter|
          letter == letters[0]
        end)) ^
    (((letters.first..letters.last).to_a == letters) &&
        (numbers.all? do |number|
          number == numbers[0]
        end))
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.count &&
      consecutive?(coordinates)         &&
      coordinates.all? do |coordinate|
        @cells[coordinate].empty?
      end
      true
    elsif ship.length == coordinates.count &&
       consecutive?(coordinates)           &&
       coordinates.all? do |coordinate|
         @cells[coordinate].empty?
       end
       true
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end


  def render(show = false)
    horizontal = [1, 2, 3, 4]
    vertical = ["A", "B", "C", "D"]
    output_string = "  "
      horizontal.each do |number|
        output_string += number.to_s + " "
      end
    vertical.each do |letter|
      output_string += "\n#{letter} "
      horizontal.each do |number|
          output_string += "#{@cells["#{letter}#{number}"].render(show)} "
      end
    end
    output_string + "\n"
  end


end
