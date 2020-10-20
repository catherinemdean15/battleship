class Board
  attr_reader :cells
  def initialize
    @cells = {
       "A1" => Cell.new("A1"),
       "A2" => Cell.new("A2"),
       "A3" => Cell.new("A3"),
       "A4" => Cell.new("A4"),
       "B1" => Cell.new("B1"),
       "B2" => Cell.new("B2"),
       "B3" => Cell.new("B3"),
       "B4" => Cell.new("B4"),
       "C1" => Cell.new("C1"),
       "C2" => Cell.new("C2"),
       "C3" => Cell.new("C3"),
       "C4" => Cell.new("C4"),
       "D1" => Cell.new("D1"),
       "D2" => Cell.new("D2"),
       "D3" => Cell.new("D3"),
       "D4" => Cell.new("D4")
    }
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
      consecutive?(coordinates) &&
      coordinates.all? do |coordinate|
        @cells[coordinate].empty?
      end
      true
    elsif ship.name == "Submarine" &&
      coordinates.count == 2 &&
       consecutive?(coordinates)&&
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
    output_string = " "
      horizontal.each do |number|
        output_string += number.to_s + " "
      end
      vertical.each do |letter|
        require 'pry'; binding.pry
        output_string += "\nA"
        if @cells.values[0][0] == letter
          @cells.values.each do |cell|
            cell.render(true)
            output_string += "#{cell.render(true)} "
          end
        end
        output_string += "\nB"
        if @cells.values[1][0] == letter
          @cells.values.each do |cell|
            cell.render(true)
            output_string += "#{cell.render(true)} "
          end
        end
      end
      output_string
    end
      #   output_string += "\n#{letter} . . . ."

      # @cells.values.each do |cell|
      #   require 'pry'; binding.pry
      #   output_string += "\nA "
      #   4.times do |cell|
      #     if
      #     output_string += "#{cell.render(true)} "
      #   end
      #   output_string += "\nB "
      #   4.times do |cell|
      #     output_string += "#{cell.render(true)} "
      #   end
          # horizontal.each do |number|
          # coordinate = vertical[letter] + number.to_s
    #       # output_string += @cells[coordinate].render(show_ships) + " "
    #   end
    #
    #   output_string + " \n"
    #   # require 'pry'; binding.pry
    # end

end
