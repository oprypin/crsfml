require "csfml/system"
require "csfml/window"
require "csfml/graphics"

window = SF::RenderWindow.new(
  SF.video_mode(800, 800), "Snakes",
  settings: SF.context_settings(depth: 32, antialiasing: 8)
)
window.vertical_sync_enabled = true
window.framerate_limit = 10

Left = {-1, 0}
Up = {0, -1}
Right = {1, 0}
Down = {0, 1}
Directions = [Left, Up, Right, Down]


# https://github.com/manastech/crystal/issues/559
def modulo(a: Int, b: Int)
  (a % b + b) % b
end

# Missing functionality from Ruby
module Enumerable
  def drop(n)
    self[n...length]
  end
end

def random_color()
  SF.color(rand(128) + 128, rand(128) + 128, rand(128) + 128)
end


struct Food
  property position
  property color
  
  def initialize(@position, @color)
  end
  
  def draw(target, states)
    circle = SF::CircleShape.new(0.9/2)
    circle.position = SF.vector2f(@position[0] + 0.05, @position[1] + 0.05)
    circle.fill_color = @color
    target.draw circle, states
  end
end

class Snake
  getter body
  
  def initialize(@field, start, @color)
    @direction = Up
    @body = [] of {Int32, Int32}
    (0...3).each do |i|
      @body.push({start[0], start[1] + i})
    end
  end
  
  def step()
    head = {@body[0][0] + @direction[0], @body[0][1] + @direction[1]}
    head = {modulo(head[0], @field.size[0]), modulo(head[1], @field.size[1])}
    @body.insert(0, head)
    @body.pop()
  end
  
  def turn(direction)
    if @body[1] != {@body[0][0] + direction[0], @body[0][1] + direction[1]}
      @direction = direction
    end
  end
  
  def grow()
    tail = @body[-1]
    3.times do |i|
      @body.push tail
    end
  end
  
  def collide(other: self)
    other.body.any? { |part| @body[0] == part }
  end
  
  def collide(food: Food)
    @body[0] == food.position
  end
  
  def collide()
    @body.drop(1).any? { |part| @body[0] == part }
  end
  
  def draw(target, states)
    @body.each_with_index do |current, i|
      segment = SF::CircleShape.new(0.9 / 2)
      segment.position = SF.vector2f(current[0] + 0.05, current[1] + 0.05)
      segment.fill_color = @color
      target.draw segment, states
      
      # The following is eye candy and may be removed
      # but change the above to RectangleShape of size (0.9, 0.9)
      
      # Look in 4 directions around this segment. If there is another one
      # neighboring it, draw a square between them
      Directions.each do |d|
        td = {
          modulo((current[0] + d[0]), @field.size[0]),
          modulo((current[1] + d[1]), @field.size[1])
        }
          
        if (i > 0 && td == @body[i-1]) ||\
        (i < @body.length-1 && td == @body[i+1])
          connection = SF::RectangleShape.new(SF.vector2f(0.9, 0.9))
          connection.position = SF.vector2f(
            current[0] + d[0] / 2.0 + 0.05,
            current[1] + d[1] / 2.0 + 0.05
          )
          connection.fill_color = @color
          target.draw connection, states
        end
      end
      
      # Draw eyes with a darkened color
      eye = SF::CircleShape.new(0.2/2)
      eye.fill_color = SF.color(
        @color.r / 3, @color.g / 3, @color.b / 3
      )

      delta = {
        @direction[1].abs / 4.0,
        @direction[0].abs / 4.0
      }
      eye.position = SF.vector2f(
        @body[0][0] + 0.4 + delta[0],
        @body[0][1] + 0.4 + delta[1]
      )
      target.draw eye, states
      eye.position = SF.vector2f(
        @body[0][0] + 0.4 - delta[0],
        @body[0][1] + 0.4 - delta[1]
      )
      target.draw eye, states
    end
  end
end

class Field
  getter size
  
  def initialize(@size)
    @snakes = [] of Snake
    @foods = [] of Food
  end
  
  def add(snake)
    @snakes.push snake
  end
  
  def step()
    while @foods.length < @snakes.length + 1
      food = Food.new({rand(@size[0]), rand(@size[1])}, random_color())
      
      @foods.push food unless @snakes.any? { |snake| snake.collide food }
    end
    
    @snakes.each do |snake|
      snake.step()
      
      @foods = @foods.reject do |food|
        if snake.collide food
          snake.grow()
          true
        end
      end
    end
    
    snakes = @snakes
    @snakes = snakes.reject do |snake|
      snake.collide ||\
      snakes.any? { |snake2| snake != snake2 && snake.collide snake2 }
    end
  end
  
  def draw(target, states)
    @snakes.each do |snake|
      target.draw snake, states
    end
    @foods.each do |food|
      target.draw food, states
    end
  end
end


field = Field.new({40, 40})

snake1 = Snake.new(field, {field.size[0] / 2 - 5, field.size[1] / 2}, random_color())
snake2 = Snake.new(field, {field.size[0] / 2 + 5, field.size[1] / 2}, random_color())
field.add snake1
field.add snake2

transform = SF::Transform::Identity
transform.scale 20, 20

states = SF.render_states(transform: transform)

while window.open
  while event = window.poll_event()
    if event.type == SF::Event::Closed ||\
    (event.type == SF::Event::KeyPressed && event.key.code == SF::Keyboard::Escape)
      window.close()
    elsif event.type == SF::Event::KeyPressed
      case event.key.code
        when SF::Keyboard::A
          snake1.turn Left
        when SF::Keyboard::W
          snake1.turn Up
        when SF::Keyboard::D
          snake1.turn Right
        when SF::Keyboard::S
          snake1.turn Down

        when SF::Keyboard::Left
          snake2.turn Left
        when SF::Keyboard::Up
          snake2.turn Up
        when SF::Keyboard::Right
          snake2.turn Right
        when SF::Keyboard::Down
          snake2.turn Down
      end
    end
  end
  
  field.step()
  
  window.clear SF::Color::Black
  window.draw field, states
  
  window.display()
end