class Menu
  attr_reader :computer,
              :user,
  def initialize
    @computer = computer
    @user = user
  end

  def start
    puts "Welcome to BATTLESHIP\n
          Enter p to play. Enter q to quit."
    print "> "
    answer = gets.chomp
    if answer == "p"
      #dynamic?
      puts "Great! Let's play!"
    elsif answer == "q"
      puts "Have a great day!"
    else
      puts "Are you sure about that?"
    end
  end

  # def computer_ship_placement
  def user_ship_placement
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    # @user.place_cruiser
    # @user.place_submarine
  end
end
