require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/menu'
require 'colorize'

class Menu

  def initialize
    @board_computer     = Board.new
    @board_player       = Board.new
    @computer_ship_1    = Ship.new("Submarine", 2)
    @computer_ship_2    = Ship.new("Cruiser", 3)
    @player_ship_1      = nil
    @player_ship_2      = nil
    @not_fired_upon     = @board_computer.cells.keys
  end

  def create_ships
    puts "You may have two ships. Each must have a length between 2 and 4"
    puts "What would you like to name your first ship?"
    print "> "
    player_ship_1_name = gets.chomp
    player_ship_1_length = 0
    loop do
      puts "How long will your ship be?"
      print "> "
      player_ship_1_length = gets.chomp.to_i
      if  player_ship_1_length < 5 && player_ship_1_length > 1
        break
      end
      puts "Your ship length must be greater than 1 and less than 5".red
    end
    @player_ship_1 = Ship.new(player_ship_1_name, player_ship_1_length)
    puts "That's a cool ship!".yellow
    puts "What would you like to name your second ship?"
    print "> "
    player_ship_2_name = gets.chomp
    player_ship_2_length = 0
    loop do
      puts "How long will your ship be?"
      print "> "
      player_ship_2_length = gets.chomp.to_i
      if player_ship_2_length < 5 && player_ship_2_length > 1
        break
      end
      puts "Your ship length must be greater than 1 and less than 5".red
    end
    @player_ship_2 = Ship.new(player_ship_2_name, player_ship_2_length)
    puts "Nice!".yellow
  end

  def computer_submarine_placement
    loop do
      coordinates = []
      until coordinates.count == @computer_ship_1.length do
        coordinates << @board_computer.cells.keys[rand(@board_computer.cells.count)]
      end
      if @board_computer.valid_placement?(@computer_ship_1, coordinates)
        @board_computer.place(@computer_ship_1, coordinates)
        break
      end
    end
  end


  def computer_cruiser_placement
    loop do
      coordinates = []
      until coordinates.count == @computer_ship_2.length do
        coordinates << @board_computer.cells.keys[rand(@board_computer.cells.count)]
      end
      if @board_computer.valid_placement?(@computer_ship_2, coordinates)
        @board_computer.place(@computer_ship_2, coordinates)
        break
      end
    end
  end

  def user_ship_placement
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "Your #{@player_ship_1.name} is #{@player_ship_1.length} units long and your #{@player_ship_2.name} is #{@player_ship_2.length} units long."
    puts @board_player.render
    puts "Enter the squares for the #{@player_ship_1.name} (#{@player_ship_1.length} spaces):"
    print "> "
    ship_1_coordinates = gets.chomp.split(" ")
      until @board_player.valid_placement?(@player_ship_1, ship_1_coordinates)
        puts "Those are invalid coordinates. Please try again:"
        print "> "
        ship_1_coordinates = gets.chomp.split(" ")
      end
    @board_player.place(@player_ship_1, ship_1_coordinates)
    puts @board_player.render(true)
    puts "Enter the squares for the #{@player_ship_2.name} (#{@player_ship_2.length} spaces):"
    print "> "
    ship_2_coordinates = gets.chomp.split(" ")
      until @board_player.valid_placement?(@player_ship_2, ship_2_coordinates)
        puts "Those are invalid coordinates. Please try again:"
        print "> "
        ship_2_coordinates = gets.chomp.split(" ")
      end
    @board_player.place(@player_ship_2, ship_2_coordinates)
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
      if @board_computer.cells[coordinate].fired_upon?
        puts "You have already fired upon that coordinate"
        puts "Please enter a new coordinate"
        print "> "
        coordinate = gets.chomp
        until @board_computer.valid_coordinate?(coordinate)
          puts "Please enter a valid coordinate"
          print "> "
          coordinate = gets.chomp
        end
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
      random_coordinate = @not_fired_upon[rand(@not_fired_upon.count)]
      @board_player.cells[random_coordinate].fire_upon
      @not_fired_upon.delete(random_coordinate)
      if @board_player.cells[random_coordinate].ship != nil && @board_player.cells[random_coordinate].ship.sunk?
        puts "My shot on #{random_coordinate} sunk your #{@board_player.cells[random_coordinate].ship.name}! Woohoo!"
      elsif @board_player.cells[random_coordinate].ship != nil
          puts "My shot on #{random_coordinate} was a hit!"
      else
        puts "My shot on #{random_coordinate} was a miss!"
      end
  end


  def start
    loop do
      puts "Welcome to BATTLESHIP\n
            Enter p to play. Enter q to quit."
      print "> "
      answer = gets.chomp
      if answer == "p"
          puts "Great! Let's play!"
          break
        elsif answer == "q"
          puts "Have a great day!"
          abort
        else
          puts "Are you sure about that?"
        end
      end
    create_ships
    computer_submarine_placement
    computer_cruiser_placement
    user_ship_placement



    until @player_ship_2.sunk? && @player_ship_1.sunk? ||
      @computer_ship_2.sunk? && @computer_ship_1.sunk?
      player_turn
      2.times do
      puts "🌊🌊🌊🌊🌊🌊🌊🌊🌊🌊"
      sleep(0.3)
      puts "🚢🌊🌊🌊"
      sleep(0.3)
      end
      computer_turn
      sleep(0.5)
      2.times do
      puts "🌊🌊🌊🌊🌊🌊🌊🌊🌊🌊"
      sleep(0.3)
      puts "🚢🌊🌊🌊"
      sleep(0.3)
      end
    end

    if @player_ship_2.sunk? && @player_ship_1.sunk?
      puts ".\n..\n....\n..\n.\n"
      puts "I won! You stink!"
      puts ".\n..\n....\n..\n.\n"
    elsif @computer_ship_2.sunk? && @computer_ship_1.sunk?
      puts ".\n..\n....\n..\n.\n"
      puts "You win! :( "
      puts ".\n..\n....\n..\n.\n"
    end

  end




end



Menu.new.start
