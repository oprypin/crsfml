require "crsfml"


Left = SF.vector2(-1, 0)
Up =  SF.vector2(0, -1)
Right =  SF.vector2(1, 0)
Down = SF.vector2(0, 1)
Directions = [Left, Up, Right, Down]


def random_color()
  SF::Color.new(rand(128) + 128, rand(128) + 128, rand(128) + 128)
end


struct Food
  include SF::Drawable

  property position
  property color

  def initialize(@position : SF::Vector2i, @color : SF::Color)
  end

  def draw(target, states)
    circle = SF::CircleShape.new(0.45)
    circle.origin = {-0.05, -0.05}
    circle.position = position
    circle.fill_color = @color
    target.draw circle, states
  end
end

class Snake
  include SF::Drawable

  @direction : SF::Vector2i

  getter body

  def initialize(@field : Field, start : SF::Vector2i, @color : SF::Color)
    @direction = Up
    @body = Array(SF::Vector2i).new(3) { |i|
      start + {0, i}
    }
  end

  def head
    @body.first
  end

  def step()
    head = self.head + @direction
    head.x %= @field.size.x
    head.y %= @field.size.y
    @body.insert(0, head)
    @body.pop()
  end

  def turn(direction)
    @direction = direction unless @body[1] == head + direction
  end

  def grow()
    tail = @body.last
    3.times do
      @body.push tail
    end
  end

  def collides?(other : self)
    other.body.includes? head
  end

  def collides?(food : Food)
    head == food.position
  end

  def collides?()
    @body.skip(1).includes? head
  end

  def draw(target, states)
    @body.each_with_index do |current, i|
      segment = SF::CircleShape.new(0.9 / 2)
      segment.origin = {-0.05, -0.05}
      segment.position = current
      segment.fill_color = @color
      target.draw segment, states

      # The following is eye candy and may be removed
      # but change the above to RectangleShape of size (0.9, 0.9)

      # Look in 4 directions around this segment. If there is another one
      # neighboring it, draw a square between them
      Directions.each do |d|
        td = current + d
        td.x %= @field.size.x
        td.y %= @field.size.y

        if (
          (i > 0 && td == @body[i-1]) ||
          (i < @body.size-1 && td == @body[i+1])
        )
          connection = SF::RectangleShape.new({0.9, 0.9})
          connection.origin = {-0.05, -0.05}
          connection.position = current + d / 2.0
          connection.fill_color = @color
          target.draw connection, states
        end
      end

      # Draw eyes with a darkened color
      eye = SF::CircleShape.new(0.1)
      eye.fill_color = SF::Color.new(
        @color.r / 3, @color.g / 3, @color.b / 3
      )

      delta = SF.vector2(@direction.y.abs, @direction.x.abs) / 4.0
      eye.position = head
      {-1, 1}.each do |m|
        eye.origin = delta*m - {0.4, 0.4}
        target.draw eye, states
      end
    end
  end
end

class Field
  include SF::Drawable

  getter size

  def initialize(@size : SF::Vector2i)
    @snakes = [] of Snake
    @foods = [] of Food
  end

  def add(snake)
    @snakes.push snake
  end

  def step()
    while @foods.size < @snakes.size + 1
      food = Food.new(SF.vector2(rand(@size.x), rand(@size.y)), random_color())

      @foods.push food unless @snakes.any? do |snake|
        snake.body.includes? food.position
      end
    end

    @snakes.each do |snake|
      snake.step()

      @foods = @foods.reject do |food|
        if snake.collides? food
          snake.grow()
          true
        end
      end
    end

    snakes = @snakes
    @snakes = snakes.reject do |snake|
      snake.collides? ||
      snakes.any? { |snake2| snake != snake2 && snake.collides? snake2 }
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


field = Field.new(SF.vector2(40, 40))

snake1 = Snake.new(field, field.size / 2 - {5, 0}, random_color())
snake2 = Snake.new(field, field.size / 2 + {5, 0}, random_color())
field.add snake1
field.add snake2

scale = 20

window = SF::RenderWindow.new(
  SF::VideoMode.new(field.size.x*scale, field.size.y*scale), "Snakes",
  settings: SF::ContextSettings.new(depth: 24, antialiasing: 8)
)
window.framerate_limit = 10


states = SF::RenderStates.new(
  transform: SF::Transform.new.scale(scale, scale)
)

while window.open?
  while event = window.poll_event()
    if (
      event.is_a?(SF::Event::Closed) ||
      (event.is_a?(SF::Event::KeyPressed) && event.code.escape?)
    )
      window.close()
    elsif event.is_a? SF::Event::KeyPressed
      case event.code
        when .a?
          snake1.turn Left
        when .w?
          snake1.turn Up
        when .d?
          snake1.turn Right
        when .s?
          snake1.turn Down

        when .left?
          snake2.turn Left
        when .up?
          snake2.turn Up
        when .right?
          snake2.turn Right
        when .down?
          snake2.turn Down
      end
    end
  end

  field.step()

  window.clear SF::Color::Black
  window.draw field, states

  window.display()
end
