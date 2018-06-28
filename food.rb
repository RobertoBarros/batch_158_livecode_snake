class Food
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
    @eaten = false
    @cube = Gosu::Image.new('media/red_cube.png')
  end

  def eat!
    @eaten = true
  end

  def draw
    @cube.draw(@x * 11 + 1, @y * 11 + 1, 0) unless @eaten
  end

end