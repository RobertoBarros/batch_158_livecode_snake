require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window

  def initialize
    super(639, 474)
    @background = Gosu::Image.new('media/bg.png')

    @foods = []
    10.times do
      @foods << Food.new(rand(57) + 1, rand(42)+1)
    end

    @snake = Snake.new(10, @foods)
    @last_update = Time.now
  end

  def update
    get_key()
    return if (Time.now - @last_update) < 0.15

    @snake.move
    if @snake.dead?
      puts "GAME OVER!"
      exit
    end

    @last_update = Time.now
  end

  def draw
    @background.draw(0,0,0)
    @snake.draw
    @foods.each {|food| food.draw}
  end

  def get_key
    @snake.change_direction('left') if Gosu.button_down?(Gosu::KB_LEFT)
    @snake.change_direction('up') if Gosu.button_down?(Gosu::KB_UP)
    @snake.change_direction('down') if Gosu.button_down?(Gosu::KB_DOWN)
    @snake.change_direction('right') if Gosu.button_down?(Gosu::KB_RIGHT)
  end

end