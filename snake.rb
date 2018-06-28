class Snake
  MAX_X = 57
  MAX_Y = 42

  def initialize(size, foods)
    @cube = Gosu::Image.new('media/green_cube.png')
    @segments = [{x: 28, y: 21}]
    @direction = 'left'
    @foods = foods
    size.times { grow }
  end

  def dead?
    return true if @segments.first[:x] < 0 || @segments.first[:x] > MAX_X
    return true if @segments.first[:y] < 0 || @segments.first[:y] > MAX_Y

    @segments.each_with_index do |segment, index|
      next if index.zero?
      head = @segments.first
      return true if segment[:x] == head[:x] && segment[:y] == head[:y]
    end

    return false
  end

  def move
    case @direction
    when 'up' then @segments.unshift({x: @segments.first[:x] ,y: @segments.first[:y] - 1 })
    when 'down' then @segments.unshift({x: @segments.first[:x] ,y: @segments.first[:y] + 1 })
    when 'right' then @segments.unshift({x: @segments.first[:x] + 1 ,y: @segments.first[:y] })
    when 'left' then @segments.unshift({x: @segments.first[:x] - 1 ,y: @segments.first[:y] })
    end

    @segments.pop

    @foods.each do |food|
      if food.x == @segments.first[:x] && food.y == @segments.first[:y]
        food.eat!
        3.times{ grow }
      end
    end

  end

  def change_direction(new_direction)
    return if (@direction == 'up' && new_direction == 'down' ) ||
              (@direction == 'down' && new_direction == 'up' ) ||
              (@direction == 'left' && new_direction == 'right' ) ||
              (@direction == 'right' && new_direction == 'left' )

    @direction = new_direction
  end

  def draw
    @segments.each do |segment|
      @cube.draw(segment[:x] * 11 + 1, segment[:y] * 11 +1, 0)
    end
  end

  def grow
    @segments << @segments.last.dup
  end
end