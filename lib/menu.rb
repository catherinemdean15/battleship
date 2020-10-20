require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/menu'


class Menu
  attr_reader :computer,
              :user

  def initialize
    @computer = computer
    @user = user
    @board_computer = Board.new
    @board_player = Board.new
    @submarine_computer = Ship.new("Submarine", 2)
    @cruiser_computer = Ship.new("Cruiser", 3)
    @submarine_player = Ship.new("Submarine", 2)
    @cruiser_player= Ship.new("Cruiser", 3)
  end

  def computer_submarine_placement
    empty_cells_num = 0
    until empty_cells_num == (@board_computer.cells.count - 2)
      # require 'pry';binding.pry
    coordinate_1 = @board_computer.cells.keys[rand(@board_computer.cells.count)]
    coordinate_2 = "#{coordinate_1[0]}#{(coordinate_1[1].to_i) +1}"
    @board_computer.place(@submarine_computer, [coordinate_1, coordinate_2])
      @board_computer.cells.values.each do |cell|
        if cell.empty?
        empty_cells_num += 1
        end
      end
    end
  end


  def computer_cruiser_placement
    empty_cells_num = 0
    until empty_cells_num == (@board_computer.cells.count - 5)
    coordinate_1 = @board_computer.cells.keys[rand(@board_computer.cells.count)]
    coordinate_2 = "#{coordinate_1[0]}#{(coordinate_1[1].to_i) +1}"
    coordinate_3 = "#{coordinate_1[0]}#{(coordinate_1[1].to_i) +2}"
      if @board_computer.valid_coordinate?(coordinate_3)
        # require 'pry'; binding.pry
        @board_computer.place(@cruiser_computer, [coordinate_1, coordinate_2, coordinate_3])
      end
      @board_computer.cells.values.each do |cell|
        # require 'pry';binding.pry
        if cell.empty?
        empty_cells_num += 1
        end
      end
    end
  end

  def user_ship_placement
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @board_player.render
    puts "Enter the squares for the Cruiser (3 spaces):"
    print "> "
    cruiser_coordinates = gets.chomp.split(" ")
      until @board_player.valid_placement?(@cruiser_player, cruiser_coordinates)
        puts "Those are invalid coordinates. Please try again:"
        print "> "
        cruiser_coordinates = gets.chomp.split(" ")
      end
    @board_player.place(@cruiser_player, cruiser_coordinates)
    puts "Enter the squares for the Submarine (2 spaces):"
    print "> "
    submarine_coordinates = gets.chomp.split(" ")
      until @board_player.valid_placement?(@submarine_player, submarine_coordinates)
        puts "Those are invalid coordinates. Please try again:"
        print "> "
        submarine_coordinates = gets.chomp.split(" ")
      end
    @board_player.place(@submarine_player, submarine_coordinates)
  end



  def start
    puts "Welcome to BATTLESHIP\n
          Enter p to play. Enter q to quit."
    print "> "
    answer = gets.chomp
    if answer == "p"
        puts "Great! Let's play!"
      elsif answer == "q"
        puts "Have a great day!"
      else
        puts "Are you sure about that?"
    end
    computer_submarine_placement
    computer_cruiser_placement
    puts @board_computer.render(true)
    user_ship_placement
    puts @board_player.render(true)
    until (@sumbarine_player.sunk?) && (@cruiser_player.sunk?) ||
          (@submarine_computer.sunk) && (@cruiser_computer.sunk?)
    end 
  end




end



Menu.new.start
