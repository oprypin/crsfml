# Copyright (C) 2015 Oleh Prypin <blaxpirit@gmail.com>
# 
# This file is part of CrSFML.
# 
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
# 
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
# 
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

require "./graphics_lib"

module SF
  extend self

  def color(red, green, blue, alpha=255)
    Color.new(r: red.to_u8, g: green.to_u8, b: blue.to_u8, a: alpha.to_u8)
  end
  struct CSFML::Color
    Black = SF.color(0, 0, 0)
    White = SF.color(255, 255, 255)
    Red = SF.color(255, 0, 0)
    Green = SF.color(0, 255, 0)
    Blue = SF.color(0, 0, 255)
    Yellow = SF.color(255, 255, 0)
    Magenta = SF.color(255, 0, 255)
    Cyan = SF.color(0, 255, 255)
    Transparent = SF.color(0, 0, 0, 0)
  end
  
  def float_rect(left, top, width, height)
    FloatRect.new(left: left.to_f32, top: top.to_f32, width: width.to_f32, height: height.to_f32)
  end
  def int_rect(left, top, width, height)
    IntRect.new(left: left.to_i32, top: top.to_i32, width: width.to_i32, height: height.to_i32)
  end

  struct CSFML::FloatRect
    def intersects(other: self)
      intersection = FloatRect.new()
      float_rect_intersects(@self, other, pointerof(intersection)) ? intersection : nil
    end
  end
  
  struct CSFML::IntRect
    def intersects(other: self)
      intersection = IntRect.new()
      int_rect_intersects(@self, other, pointerof(intersection)) ? intersection : nil
    end
  end
    
  
  def transform()
    transform(1.0, 0.0, 0.0,  0.0, 1.0, 0.0,  0.0, 0.0, 1.0)
  end
  struct CSFML::Transform
    Identity = SF.transform()
  end
  
  def self.get_matrix(transform: Transform)
    CSFML.transform_get_matrix(pointerof(transform), out result)
    result
  end
  
  def blend_mode(color_source_factor: BlendFactor, color_destination_factor: BlendFactor, color_blend_equation: BlendEquation, alpha_source_factor: BlendFactor, alpha_destination_factor: BlendFactor, alpha_blend_equation: BlendEquation)
    BlendMode.new(
      color_src_factor: color_source_factor,
      color_dst_factor: color_destination_factor,
      color_equation: color_blend_equation,
      alpha_src_factor: alpha_source_factor,
      alpha_dst_factor: alpha_destination_factor,
      alpha_equation: alpha_blend_equation
    )
  end
  
  def blend_mode(source_factor: BlendFactor, destination_factor: BlendFactor, blend_equation=CSFML::BlendEquation::Add)
    blend_mode(
      source_factor, destination_factor, blend_equation,
      source_factor, destination_factor, blend_equation
    )
  end
  
  BlendAlpha = blend_mode(
    CSFML::BlendFactor::SrcAlpha, CSFML::BlendFactor::OneMinusSrcAlpha, CSFML::BlendEquation::Add,
    CSFML::BlendFactor::One, CSFML::BlendFactor::OneMinusSrcAlpha, CSFML::BlendEquation::Add
  )
  BlendAdd = blend_mode(
    CSFML::BlendFactor::SrcAlpha, CSFML::BlendFactor::One, CSFML::BlendEquation::Add,
    CSFML::BlendFactor::One, CSFML::BlendFactor::One, CSFML::BlendEquation::Add
  )
  BlendMultiply = blend_mode(CSFML::BlendFactor::DstColor, CSFML::BlendFactor::Zero)
  BlendNone = blend_mode(CSFML::BlendFactor::One, CSFML::BlendFactor::Zero)
  
  def blend_mode()
    BlendAlpha
  end
  
  def render_states(blend_mode=BlendAlpha, transform=Transform::Identity, texture=nil, shader=nil)
    result = RenderStates.new()
    result.blend_mode = blend_mode
    result.transform = transform
    result.texture = texture.to_unsafe if texture
    result.shader = shader.to_unsafe if shader
    result
  end
  
  struct CSFML::RenderStates
    Default = render_states()
  end
  
  class CircleShape
    def initialize(radius, point_count=30)
      initialize()
      self.radius = radius
      self.point_count = point_count
    end
    
    def draw(target, states: RenderStates)
      target.draw_circle_shape(self, states)
    end
  end
  
  class RectangleShape
    def initialize(size: Vector2f)
      initialize()
      self.size = size
    end

    def draw(target, states: RenderStates)
      target.draw_rectangle_shape(self, states)
    end
  end
  
  class ConvexShape
    def initialize(point_count)
      initialize()
      self.point_count = point_count
    end
    
    def [](index)
      get_point(index)
    end
    def []=(index, point: Vector2f)
      set_point(index, point)
    end
    
    def draw(target, states: RenderStates)
      target.draw_convex_shape(self, states)
    end
  end
  
  class Texture
    def initialize(filename: String)
      initialize(filename, nil)
    end
  end
  
  class Sprite
    def initialize(texture: Texture)
      initialize()
      set_texture(texture, true)
    end
    def initialize(texture: Texture, rectangle: IntRect)
      initialize()
      self.texture = texture
      self.texture_rect = rectangle
    end
    
    def texture=(texture: Texture)
      set_texture(texture, false)
    end
    
    def draw(target, states: RenderStates)
      target.draw_sprite(self, states)
    end
  end
  
  class Text
    def initialize(string: String, font: Font, character_size=30)
      initialize()
      self.string = string
      self.font = font
      self.character_size = character_size
    end
    
    def draw(target, states: RenderStates)
      target.draw_text(self, states)
    end
  end
  
  def vertex(position=SF.vector2f(0, 0), color=Color::White, tex_coords=SF.vector2f(0, 0))
    Vertex.new(position: position, color: color, tex_coords: tex_coords)
  end
  
  class VertexArray
    def draw(target, states: RenderStates)
      target.draw_vertex_array(self, states)
    end
  end
  
  class View
    def initialize(center: Vector2f, size: Vector2f)
      initialize()
      self.center = center
      self.size = size
    end
  end
  
  class RenderTexture
    def initialize(width, height)
      initialize(width, height, false)
    end
    
    def draw(drawable, states=CSFML::RenderStates::Default)
      drawable.draw(self, states)
    end
  end
  
  class RenderWindow
    def initialize(mode: VideoMode, title: String, style=CSFML::WindowStyle::Default, settings=SF.context_settings())
      initialize(mode, title, style, settings)
    end
    
    def draw(drawable, states=SF.render_states())
      drawable.draw(self, states)
    end
    
    def poll_event()
      if CSFML.render_window_poll_event(@this, out event) != 0
        event
      end
    end
    def wait_event()
      if CSFML.render_window_wait_event(@this, out event) != 0
        event
      end
    end
    
    def clear()
      clear(Color::Black)
    end
  end
end

require "./graphics_obj"

module SF
  # Include this module to get all methods of a `Transformable`
  module TransformableM
    def position=(position: Vector2f)
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).position = position
    end
    def rotation=(angle)
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).rotation = angle
    end
    def scale=(scale: Vector2f)
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).scale = scale
    end
    def origin=(origin: Vector2f)
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).origin = origin
    end
    def position
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).position
    end
    def rotation
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).rotation
    end
    def scale
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).scale
    end
    def origin
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).origin
    end
    def move(offset: Vector2f)
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).move(offset)
    end
    def rotate(angle)
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).rotate(angle)
    end
    def scale(factors: Vector2f)
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).scale(factors)
    end
    def transform
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).transform
    end
    def inverse_transform
      @transformable = SF::Transformable.new() unless @transformable
      (@transformable || SF::Transformable.new()).inverse_transform
    end
  end
end
