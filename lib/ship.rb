class Ship
  attr_reader :name,
              :length

  def initialize(name, length)
    @name = name
    @length = length
  end

  def health
    @length
  end

  def sunk?
    @length == 0
  end

  def hit
    @length -= 1
  end

end
