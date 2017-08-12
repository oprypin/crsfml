require "crsfml"


Left = SF.vector2(-1, 0)
Up = SF.vector2(0, -1)
Right = SF.vector2(1, 0)
Down = SF.vector2(0, 1)
Directions = [Left, Up, Right, Down]


def random_color()
  SF::Color.new(rand(128) + 128, rand(128) + 128, rand(128) + 128)
end


struct SF::Rect
  def center
    SF::Vector2.new(left + width/2, top + height/2)
  end
end

class SF::Transformable
  def center!
    self.origin = local_bounds.center
    self
  end
end


struct Food
  include SF::Drawable

  property position
  property color

  def initialize(@position : SF::Vector2i, @color : SF::Color)
  end

  def draw(target, states)
    circle = SF::CircleShape.new(0.9 / 2).center!
    circle.position = position
    circle.fill_color = @color
    target.draw circle, states
  end
end

class Snake
  include SF::Drawable

  getter body
  @direction : SF::Vector2i

  def initialize(@field : Field, start : SF::Vector2i, @color : SF::Color)
    @direction = Up
    @body = Deque(SF::Vector2i).new(3) { |i| start + {0, i} }
  end

  def head
    @body.first
  end

  # Warp any position out of bounds to the other edge of the field
  private def warp(pos)
    pos.x %= @field.size.x
    pos.y %= @field.size.y
    pos
  end

  def step()
    @body.unshift warp(head + @direction)
    @body.pop()
  end

  def turn(direction)
    @direction = direction unless head + direction == @body[1]?
  end

  def grow()
    tail = @body.last
    3.times do
      @body.push tail
    end
  end

  def collides?(other : self)
    other != self && other.body.includes? head
  end

  def collides?(food : Food)
    head == food.position
  end

  def collides?()
    @body.skip(1).includes? head
  end

  def draw(target, states)
    @body.each_with_index do |current, i|
      segment = SF::CircleShape.new(0.9 / 2).center!
      segment.position = current
      segment.fill_color = @color
      target.draw segment, states

      # Look in 4 directions around this segment. If there is another one
      # neighboring it, draw a square between them
      Directions.each do |offset|
        look = warp(current + offset)
        if (
          (i - 1 >= 0 && @body[i - 1] == look) ||
          (i + 1 < @body.size && @body[i + 1] == look)
        )
          connection = SF::RectangleShape.new({0.9, 0.9}).center!
          connection.position = current + offset / 2.0
          connection.fill_color = @color
          target.draw connection, states
        end
      end
    end

    # Draw eyes with a darkened color
    eye = SF::CircleShape.new(0.1)
    eye.position = head
    eye.fill_color = SF::Color.new(
      @color.r / 3, @color.g / 3, @color.b / 3
    )

    offset = SF.vector2(@direction.y, -@direction.x) / 4.0
    # Left eye
    eye.center!.origin -= offset
    target.draw eye, states
    # Right eye
    eye.center!.origin += offset
    target.draw eye, states
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
    @snakes << snake
  end

  def step()
    while @foods.size < @snakes.size + 1
      food = Food.new(SF.vector2(rand(@size.x), rand(@size.y)), random_color())
      next if @snakes.any?(&.body.includes? food.position)
      @foods << food
    end

    @snakes.each do |snake|
      snake.step()

      if (food = @foods.find &->snake.collides?(Food))
        @foods.delete food
        snake.grow()
      end
    end

    @snakes = @snakes.reject do |snake|
      snake.collides? || @snakes.any? &.collides? snake
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


field.add (snake1 = Snake.new(field, field.size / 2 - {5, 0}, random_color()))
field.add (snake2 = Snake.new(field, field.size / 2 + {5, 0}, random_color()))

scale = 20

window = SF::RenderWindow.new(
  SF::VideoMode.new(field.size.x*scale, field.size.y*scale), "Snakes",
  settings: SF::ContextSettings.new(depth: 24, antialiasing: 8)
)
window.framerate_limit = 10


states = SF::RenderStates.new(
  transform: SF::Transform.new
    .scale(scale, scale)  # Allow all operations to use 1 as the size of the grid
    .translate(0.5, 0.5)  # Move the reference point to centers of grid squares
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
