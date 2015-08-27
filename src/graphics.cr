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

  def color(red: Number, green: Number, blue: Number, alpha=255: Number)
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
    
    def ==(other: self)
      r == other.r && g == other.g && b == other.b && a == other.a
    end
    def +(other: self)
      add other
    end
    def *(other: self)
      modulate other
    end
    def -(other: self)
      subtract other
    end
  end
  
  def float_rect(left: Number, top: Number, width: Number, height: Number)
    FloatRect.new(left: left.to_f32, top: top.to_f32, width: width.to_f32, height: height.to_f32)
  end
  def int_rect(left: Number, top: Number, width: Number, height: Number)
    IntRect.new(left: left.to_i32, top: top.to_i32, width: width.to_i32, height: height.to_i32)
  end

  struct CSFML::FloatRect
    def contains(point)
      x, y = point
      contains(x, y)
    end
    def intersects(other: FloatRect)
      intersection = FloatRect.new()
      intersects(other, pointerof(intersection)) ? intersection : nil
    end
  end
  
  struct CSFML::IntRect
    def contains(point)
      x, y = point
      contains(x, y)
    end
    def intersects(other: IntRect)
      intersection = IntRect.new()
      intersects(other, pointerof(intersection)) ? intersection : nil
    end
  end
    
  
  def transform()
    transform(1.0, 0.0, 0.0,  0.0, 1.0, 0.0,  0.0, 0.0, 1.0)
  end
  struct CSFML::Transform
    Identity = SF.transform()
    
    def transform_point(x, y)
      transform_point(SF.vector2f(x, y))
    end
    def translate(offset)
      x, y = offset
      translate(x, y)
    end
    def rotate(angle: Number, center)
      cx, cy = center
      rotate(angle, cx, cy)
    end
    def scale(factors)
      x, y = factors
      scale(x, y)
    end
    def scale(factors, center: Number)
      x, y = factors
      cx, cy = center
      scale(x, y, cx, cy)
    end
    
    def *(other: self)
      out = self
      out.combine(other)
      out
    end
    def *(point)
      transform_point(point)
    end
    
    def get_matrix()
      cself = self
      CSFML.transform_get_matrix(pointerof(cself), out matrix)
      matrix
    end
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
    result.texture = texture
    result.shader = shader
    result
  end
  
  struct CSFML::RenderStates
    Default = SF.render_states()
  end
  
  class CircleShape
    def initialize(radius: Number, point_count=30: Int)
      initialize()
      self.radius = radius
      self.point_count = point_count
    end
    
    def draw(target, states: RenderStates)
      target.draw_circle_shape(self, states)
    end
  end
  
  class RectangleShape
    def initialize(size)
      initialize()
      self.size = size
    end

    def draw(target, states: RenderStates)
      target.draw_rectangle_shape(self, states)
    end
  end
  
  class ConvexShape
    def initialize(point_count: Int)
      initialize()
      self.point_count = point_count
    end
    
    def [](index)
      get_point(index)
    end
    def []=(index, point)
      set_point(index, point)
    end
    
    def draw(target, states: RenderStates)
      target.draw_convex_shape(self, states)
    end
  end
  
  abstract class Shape < SF::ConvexShape
    def initialize()
      super
      update
    end
    
    def update
      self.point_count = n = point_count
      (0...n).each do |i|
        set_point(i, get_point(i))
      end
    end
    
    abstract def point_count: Int
    abstract def get_point(index: Int): SF::Vector2
  end
  
  class Texture
    def self.from_file(filename: String)
      self.from_file(filename, nil)
    end
    
    def self.bind(texture: Texture?)
      CSFML.texture_bind(texture)
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
    def initialize(string: String, font: Font, character_size=30: Int)
      initialize()
      self.string = string
      self.font = font
      self.character_size = character_size
    end
    
    def draw(target, states: RenderStates)
      target.draw_text(self, states)
    end
  end
  
  class Shader
    enum Type
      Vertex, Fragment
    end
    Vertex = Type::Vertex
    Fragment = Type::Fragment
    
    def self.from_file(filename: String, type: Type)
      Shader.transfer_ptr(CSFML.shader_create_from_file(
        type == Vertex ? filename.to_unsafe : Pointer(UInt8).null,
        type == Fragment ? filename.to_unsafe : Pointer(UInt8).null
      ))
    end
    
    def self.from_memory(shader: String, type: Type)
      Shader.transfer_ptr(CSFML.shader_create_from_memory(
        type == Vertex ? shader.to_unsafe : Pointer(UInt8).null,
        type == Fragment ? shader.to_unsafe : Pointer(UInt8).null
      ))
    end
    
    struct CurrentTextureType
    end
    
    CurrentTexture = CurrentTextureType.new()
    
    def set_parameter(name: String, current_texture: CurrentTextureType)
      CSFML.shader_set_current_texture_parameter(@this, name)
    end
    
    def self.bind(shader: Shader?)
      CSFML.shader_bind(shader)
    end
  end
  
  def vertex(position=SF.vector2(0.0, 0.0), color=Color::White, tex_coords=SF.vector2(0.0, 0.0))
    Vertex.new(position_: SF.vector2f(position), color: color, tex_coords_: SF.vector2f(tex_coords))
  end
  
  class VertexArray
    def initialize(primitive_type: PrimitiveType, vertex_count=0)
      initialize()
      self.primitive_type = primitive_type
      self.resize(vertex_count)
    end
    
    def [](index)
      get_vertex(index)[0]
    end
    def []=(index, vertex)
      get_vertex(index)[0] = vertex
    end

    def draw(target, states: RenderStates)
      target.draw_vertex_array(self, states)
    end
  end
  
  class View
    def initialize(center, size)
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
    def draw(vertices, type: PrimitiveType, states=CSFML::RenderStates::Default)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_primitives(@this, vertices, LibC::SizeT.cast(vertices.length), type, pstates)
    end
    
    def map_pixel_to_coords(point)
      point = SF.vector2i(point) unless point.is_a? Vector2i
      SF.vector2(CSFML.render_texture_map_pixel_to_coords(@this, point, nil))
    end
    def map_coords_to_pixel(point)
      point = SF.vector2f(point) unless point.is_a? Vector2f
      SF.vector2(CSFML.render_texture_map_coords_to_pixel(@this, point, nil))
    end
  end
  
  class RenderWindow
    def initialize(mode: VideoMode, title: String, style=CSFML::WindowStyle::Default, settings=SF.context_settings())
      initialize(mode, title, style, settings)
    end
    
    def draw(drawable, states=CSFML::RenderStates::Default)
      drawable.draw(self, states)
    end
    def draw(vertices, type: PrimitiveType, states=CSFML::RenderStates::Default)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_primitives(@this, vertices, LibC::SizeT.cast(vertices.length), type, pstates)
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
    
    def map_pixel_to_coords(point)
      point = SF.vector2i(point) unless point.is_a? Vector2i
      SF.vector2(CSFML.render_window_map_pixel_to_coords(@this, point, nil))
    end
    def map_coords_to_pixel(point)
      point = SF.vector2f(point) unless point.is_a? Vector2f
      SF.vector2(CSFML.render_window_map_coords_to_pixel(@this, point, nil))
    end
  end
end

require "./graphics_obj"

private macro delegate_to_transformable(*signatures)
  {% for signature in signatures %}
    def {{signature.id}}
      (@transformable ||= SF::Transformable.new()).{{signature.id}}
    end
  {% end %}
end

module SF
  # Include this module to get all methods of a `Transformable`
  
  module TransformableM
    delegate_to_transformable(
      "position=(position)",
      "rotation=(angle)",
      "scale=(scale)",
      "origin=(origin)",
      "position",
      "rotation",
      "scale",
      "origin",
      "move(offset)",
      "rotate(angle)",
      "scale(factors)",
      "transform",
      "inverse_transform"
    )
  end
end
