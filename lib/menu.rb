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
    loop do
      coordinates = []
      until coordinates.count == @submarine_computer.length do
        coordinates << @board_computer.cells.keys[rand(@board_computer.cells.count)]
      end
      if @board_computer.valid_placement?(@submarine_computer, coordinates)
        @board_computer.place(@submarine_computer, coordinates)
        break
      end
    end
  end


  def computer_cruiser_placement
    loop do
      coordinates = []
      until coordinates.count == @cruiser_computer.length do
        coordinates << @board_computer.cells.keys[rand(@board_computer.cells.count)]
      end
      if @board_computer.valid_placement?(@cruiser_computer, coordinates)
        @board_computer.place(@cruiser_computer, coordinates)
        break
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
    puts @board_player.render(true)
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

  def player_turn
    puts "=============COMPUTER BOARD============="
    puts @board_computer.render
    puts "==============PLAYER BOARD=============="
    puts @board_player.render(true)
    puts "Enter the coordinate for your shot"
    print "> "
    coordinate = gets.chomp
      until @board_computer.valid_coordinate?(coordinate)
        puts "Please enter a valid coordinate"
        print "> "
        coordinate = gets.chomp
      end
    @board_computer.cells[coordinate].fire_upon
    if @board_computer.cells[coordinate].ship != nil && @board_computer.cells[coordinate].ship.sunk?
      puts "Your shot on #{coordinate} sunk my #{@board_computer.cells[coordinate].ship.name}! Aw man!"
    elsif @board_computer.cells[coordinate].ship != nil
        puts "Your shot on #{coordinate} was a hit!"
    else
      puts "Your shot on #{coordinate} was a miss!"
    end
  end


  def computer_turn
      not_fired_upon = @board_computer.cells.keys
      random_coordinate = not_fired_upon[rand(not_fired_upon.count)]
      @board_player.cells[random_coordinate].fire_upon
      not_fired_upon.delete(random_coordinate)
      if @board_player.cells[random_coordinate].ship != nil && @board_player.cells[random_coordinate].ship.sunk?
        puts "My shot on #{random_coordinate} sunk your #{@board_player.cells[random_coordinate].ship.name}! Woohoo!"
      elsif @board_player.cells[random_coordinate].ship != nil
          puts "My shot on #{random_coordinate} was a hit!"
      else
        puts "My shot on #{random_coordinate} was a miss!"
      end
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
    user_ship_placement



    until @cruiser_player.sunk? && @submarine_player.sunk? ||
      @cruiser_computer.sunk? && @submarine_computer.sunk?
      player_turn
      sleep(1)
      computer_turn
      sleep(0.5)
    end
  end




end



Menu.new.start
