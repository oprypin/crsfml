require "./graphics_lib"

module SF
  extend self

  alias BlendFactor = CSFML::BlendFactor
     
  alias BlendEquation = CSFML::BlendEquation
     
  alias BlendMode = CSFML::BlendMode
     
  alias Color = CSFML::Color
     
  alias FloatRect = CSFML::FloatRect
     
  alias IntRect = CSFML::IntRect
     
  class CircleShape
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.circle_shape_create()
    end
    def copy()
      self.wrap_ptr(CSFML.circle_shape_copy(@this))
    end
    def finalize()
      CSFML.circle_shape_destroy(@this) if @owned
    end
    def position=(position: Vector2f)
      CSFML.circle_shape_set_position(@this, position)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.circle_shape_set_rotation(@this, angle)
    end
    def scale=(scale: Vector2f)
      CSFML.circle_shape_set_scale(@this, scale)
    end
    def origin=(origin: Vector2f)
      CSFML.circle_shape_set_origin(@this, origin)
    end
    def position()
      CSFML.circle_shape_get_position(@this)
    end
    def rotation()
      CSFML.circle_shape_get_rotation(@this)
    end
    def scale()
      CSFML.circle_shape_get_scale(@this)
    end
    def origin()
      CSFML.circle_shape_get_origin(@this)
    end
    def move(offset: Vector2f)
      CSFML.circle_shape_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.circle_shape_rotate(@this, angle)
    end
    def scale(factors: Vector2f)
      CSFML.circle_shape_scale(@this, factors)
    end
    def transform()
      CSFML.circle_shape_get_transform(@this)
    end
    def inverse_transform()
      CSFML.circle_shape_get_inverse_transform(@this)
    end
    def set_texture(texture: Texture, reset_rect: Int32)
      CSFML.circle_shape_set_texture(@this, texture, reset_rect)
    end
    def texture_rect=(rect: IntRect)
      CSFML.circle_shape_set_texture_rect(@this, rect)
    end
    def fill_color=(color: Color)
      CSFML.circle_shape_set_fill_color(@this, color)
    end
    def outline_color=(color: Color)
      CSFML.circle_shape_set_outline_color(@this, color)
    end
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.circle_shape_set_outline_thickness(@this, thickness)
    end
    def texture()
      self.wrap_ptr(CSFML.circle_shape_get_texture(@this))
    end
    def texture_rect()
      CSFML.circle_shape_get_texture_rect(@this)
    end
    def fill_color()
      CSFML.circle_shape_get_fill_color(@this)
    end
    def outline_color()
      CSFML.circle_shape_get_outline_color(@this)
    end
    def outline_thickness()
      CSFML.circle_shape_get_outline_thickness(@this)
    end
    def point_count()
      CSFML.circle_shape_get_point_count(@this)
    end
    def get_point(index: Int32)
      CSFML.circle_shape_get_point(@this, index)
    end
    def radius=(radius)
      radius = radius.to_f32
      CSFML.circle_shape_set_radius(@this, radius)
    end
    def radius()
      CSFML.circle_shape_get_radius(@this)
    end
    def point_count=(count: Int32)
      CSFML.circle_shape_set_point_count(@this, count)
    end
    def local_bounds()
      CSFML.circle_shape_get_local_bounds(@this)
    end
    def global_bounds()
      CSFML.circle_shape_get_global_bounds(@this)
    end
  end

  class ConvexShape
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.convex_shape_create()
    end
    def copy()
      self.wrap_ptr(CSFML.convex_shape_copy(@this))
    end
    def finalize()
      CSFML.convex_shape_destroy(@this) if @owned
    end
    def position=(position: Vector2f)
      CSFML.convex_shape_set_position(@this, position)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.convex_shape_set_rotation(@this, angle)
    end
    def scale=(scale: Vector2f)
      CSFML.convex_shape_set_scale(@this, scale)
    end
    def origin=(origin: Vector2f)
      CSFML.convex_shape_set_origin(@this, origin)
    end
    def position()
      CSFML.convex_shape_get_position(@this)
    end
    def rotation()
      CSFML.convex_shape_get_rotation(@this)
    end
    def scale()
      CSFML.convex_shape_get_scale(@this)
    end
    def origin()
      CSFML.convex_shape_get_origin(@this)
    end
    def move(offset: Vector2f)
      CSFML.convex_shape_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.convex_shape_rotate(@this, angle)
    end
    def scale(factors: Vector2f)
      CSFML.convex_shape_scale(@this, factors)
    end
    def transform()
      CSFML.convex_shape_get_transform(@this)
    end
    def inverse_transform()
      CSFML.convex_shape_get_inverse_transform(@this)
    end
    def set_texture(texture: Texture, reset_rect: Int32)
      CSFML.convex_shape_set_texture(@this, texture, reset_rect)
    end
    def texture_rect=(rect: IntRect)
      CSFML.convex_shape_set_texture_rect(@this, rect)
    end
    def fill_color=(color: Color)
      CSFML.convex_shape_set_fill_color(@this, color)
    end
    def outline_color=(color: Color)
      CSFML.convex_shape_set_outline_color(@this, color)
    end
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.convex_shape_set_outline_thickness(@this, thickness)
    end
    def texture()
      self.wrap_ptr(CSFML.convex_shape_get_texture(@this))
    end
    def texture_rect()
      CSFML.convex_shape_get_texture_rect(@this)
    end
    def fill_color()
      CSFML.convex_shape_get_fill_color(@this)
    end
    def outline_color()
      CSFML.convex_shape_get_outline_color(@this)
    end
    def outline_thickness()
      CSFML.convex_shape_get_outline_thickness(@this)
    end
    def point_count()
      CSFML.convex_shape_get_point_count(@this)
    end
    def get_point(index: Int32)
      CSFML.convex_shape_get_point(@this, index)
    end
    def point_count=(count: Int32)
      CSFML.convex_shape_set_point_count(@this, count)
    end
    def set_point(index: Int32, point: Vector2f)
      CSFML.convex_shape_set_point(@this, index, point)
    end
    def local_bounds()
      CSFML.convex_shape_get_local_bounds(@this)
    end
    def global_bounds()
      CSFML.convex_shape_get_global_bounds(@this)
    end
  end

  class Font
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(filename: String)
      @owned = true
      @this = CSFML.font_create_from_file(filename)
    end
    def initialize(data: Void*, size_in_bytes: Size_t)
      @owned = true
      @this = CSFML.font_create_from_memory(data, size_in_bytes)
    end
    def initialize(stream: InputStream*)
      @owned = true
      @this = CSFML.font_create_from_stream(stream)
    end
    def copy()
      self.wrap_ptr(CSFML.font_copy(@this))
    end
    def finalize()
      CSFML.font_destroy(@this) if @owned
    end
    def get_glyph(code_point: Char, character_size: Int32, bold: Int32)
      CSFML.font_get_glyph(@this, code_point, character_size, bold)
    end
    def get_kerning(first: Char, second: Char, character_size: Int32)
      CSFML.font_get_kerning(@this, first, second, character_size)
    end
    def get_line_spacing(character_size: Int32)
      CSFML.font_get_line_spacing(@this, character_size)
    end
    def get_underline_position(character_size: Int32)
      CSFML.font_get_underline_position(@this, character_size)
    end
    def get_underline_thickness(character_size: Int32)
      CSFML.font_get_underline_thickness(@this, character_size)
    end
    def get_texture(character_size: Int32)
      self.wrap_ptr(CSFML.font_get_texture(@this, character_size))
    end
    def info()
      CSFML.font_get_info(@this)
    end
  end

  class Image
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(width: Int32, height: Int32)
      @owned = true
      @this = CSFML.image_create(width, height)
    end
    def initialize(width: Int32, height: Int32, color: Color)
      @owned = true
      @this = CSFML.image_create_from_color(width, height, color)
    end
    def initialize(width: Int32, height: Int32, pixels)
      pixels = pointerof(pixels) if pixels
      @owned = true
      @this = CSFML.image_create_from_pixels(width, height, pixels)
    end
    def initialize(filename: String)
      @owned = true
      @this = CSFML.image_create_from_file(filename)
    end
    def initialize(data: Void*, size: Size_t)
      @owned = true
      @this = CSFML.image_create_from_memory(data, size)
    end
    def initialize(stream: InputStream*)
      @owned = true
      @this = CSFML.image_create_from_stream(stream)
    end
    def copy()
      self.wrap_ptr(CSFML.image_copy(@this))
    end
    def finalize()
      CSFML.image_destroy(@this) if @owned
    end
    def save_to_file(filename: String)
      CSFML.image_save_to_file(@this, filename)
    end
    def size()
      CSFML.image_get_size(@this)
    end
    def create_mask(color: Color, alpha: UInt8)
      CSFML.image_create_mask_from_color(@this, color, alpha)
    end
    def copy_image(source: Image, dest_x: Int32, dest_y: Int32, source_rect: IntRect, apply_alpha: Int32)
      CSFML.image_copy_image(@this, source, dest_x, dest_y, source_rect, apply_alpha)
    end
    def set_pixel(x: Int32, y: Int32, color: Color)
      CSFML.image_set_pixel(@this, x, y, color)
    end
    def get_pixel(x: Int32, y: Int32)
      CSFML.image_get_pixel(@this, x, y)
    end
    def pixels_ptr()
      CSFML.image_get_pixels_ptr(@this)
    end
    def flip_horizontally()
      CSFML.image_flip_horizontally(@this)
    end
    def flip_vertically()
      CSFML.image_flip_vertically(@this)
    end
  end

  class Shader
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(vertex_shader_filename: String, fragment_shader_filename: String)
      @owned = true
      @this = CSFML.shader_create_from_file(vertex_shader_filename, fragment_shader_filename)
    end
    def initialize(vertex_shader: String, fragment_shader: String)
      @owned = true
      @this = CSFML.shader_create_from_memory(vertex_shader, fragment_shader)
    end
    def initialize(vertex_shader_stream: InputStream*, fragment_shader_stream: InputStream*)
      @owned = true
      @this = CSFML.shader_create_from_stream(vertex_shader_stream, fragment_shader_stream)
    end
    def finalize()
      CSFML.shader_destroy(@this) if @owned
    end
    def set_parameter(name: String, x)
      x = x.to_f32
      CSFML.shader_set_float_parameter(@this, name, x)
    end
    def set_parameter(name: String, x, y)
      x = x.to_f32
      y = y.to_f32
      CSFML.shader_set_float2_parameter(@this, name, x, y)
    end
    def set_parameter(name: String, x, y, z)
      x = x.to_f32
      y = y.to_f32
      z = z.to_f32
      CSFML.shader_set_float3_parameter(@this, name, x, y, z)
    end
    def set_parameter(name: String, x, y, z, w)
      x = x.to_f32
      y = y.to_f32
      z = z.to_f32
      w = w.to_f32
      CSFML.shader_set_float4_parameter(@this, name, x, y, z, w)
    end
    def set_parameter(name: String, vector: Vector2f)
      CSFML.shader_set_vector2_parameter(@this, name, vector)
    end
    def set_parameter(name: String, vector: Vector3f)
      CSFML.shader_set_vector3_parameter(@this, name, vector)
    end
    def set_parameter(name: String, color: Color)
      CSFML.shader_set_color_parameter(@this, name, color)
    end
    def set_parameter(name: String, transform: Transform)
      CSFML.shader_set_transform_parameter(@this, name, transform)
    end
    def set_parameter(name: String, texture: Texture)
      CSFML.shader_set_texture_parameter(@this, name, texture)
    end
    def current_texture_parameter=(name: String)
      CSFML.shader_set_current_texture_parameter(@this, name)
    end
    def bind()
      CSFML.shader_bind(@this)
    end
  end

  class RectangleShape
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.rectangle_shape_create()
    end
    def copy()
      self.wrap_ptr(CSFML.rectangle_shape_copy(@this))
    end
    def finalize()
      CSFML.rectangle_shape_destroy(@this) if @owned
    end
    def position=(position: Vector2f)
      CSFML.rectangle_shape_set_position(@this, position)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.rectangle_shape_set_rotation(@this, angle)
    end
    def scale=(scale: Vector2f)
      CSFML.rectangle_shape_set_scale(@this, scale)
    end
    def origin=(origin: Vector2f)
      CSFML.rectangle_shape_set_origin(@this, origin)
    end
    def position()
      CSFML.rectangle_shape_get_position(@this)
    end
    def rotation()
      CSFML.rectangle_shape_get_rotation(@this)
    end
    def scale()
      CSFML.rectangle_shape_get_scale(@this)
    end
    def origin()
      CSFML.rectangle_shape_get_origin(@this)
    end
    def move(offset: Vector2f)
      CSFML.rectangle_shape_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.rectangle_shape_rotate(@this, angle)
    end
    def scale(factors: Vector2f)
      CSFML.rectangle_shape_scale(@this, factors)
    end
    def transform()
      CSFML.rectangle_shape_get_transform(@this)
    end
    def inverse_transform()
      CSFML.rectangle_shape_get_inverse_transform(@this)
    end
    def set_texture(texture: Texture, reset_rect: Int32)
      CSFML.rectangle_shape_set_texture(@this, texture, reset_rect)
    end
    def texture_rect=(rect: IntRect)
      CSFML.rectangle_shape_set_texture_rect(@this, rect)
    end
    def fill_color=(color: Color)
      CSFML.rectangle_shape_set_fill_color(@this, color)
    end
    def outline_color=(color: Color)
      CSFML.rectangle_shape_set_outline_color(@this, color)
    end
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.rectangle_shape_set_outline_thickness(@this, thickness)
    end
    def texture()
      self.wrap_ptr(CSFML.rectangle_shape_get_texture(@this))
    end
    def texture_rect()
      CSFML.rectangle_shape_get_texture_rect(@this)
    end
    def fill_color()
      CSFML.rectangle_shape_get_fill_color(@this)
    end
    def outline_color()
      CSFML.rectangle_shape_get_outline_color(@this)
    end
    def outline_thickness()
      CSFML.rectangle_shape_get_outline_thickness(@this)
    end
    def point_count()
      CSFML.rectangle_shape_get_point_count(@this)
    end
    def get_point(index: Int32)
      CSFML.rectangle_shape_get_point(@this, index)
    end
    def size=(size: Vector2f)
      CSFML.rectangle_shape_set_size(@this, size)
    end
    def size()
      CSFML.rectangle_shape_get_size(@this)
    end
    def local_bounds()
      CSFML.rectangle_shape_get_local_bounds(@this)
    end
    def global_bounds()
      CSFML.rectangle_shape_get_global_bounds(@this)
    end
  end

  class RenderTexture
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(width: Int32, height: Int32, depth_buffer: Int32)
      @owned = true
      @this = CSFML.render_texture_create(width, height, depth_buffer)
    end
    def finalize()
      CSFML.render_texture_destroy(@this) if @owned
    end
    def size()
      CSFML.render_texture_get_size(@this)
    end
    def active=(active: Int32)
      CSFML.render_texture_set_active(@this, active)
    end
    def display()
      CSFML.render_texture_display(@this)
    end
    def clear(color: Color)
      CSFML.render_texture_clear(@this, color)
    end
    def view=(view: View)
      CSFML.render_texture_set_view(@this, view)
    end
    def view()
      self.wrap_ptr(CSFML.render_texture_get_view(@this))
    end
    def default_view()
      self.wrap_ptr(CSFML.render_texture_get_default_view(@this))
    end
    def get_viewport(view: View)
      CSFML.render_texture_get_viewport(@this, view)
    end
    def map_pixel_to_coords(point: Vector2i, view: View)
      CSFML.render_texture_map_pixel_to_coords(@this, point, view)
    end
    def map_coords_to_pixel(point: Vector2f, view: View)
      CSFML.render_texture_map_coords_to_pixel(@this, point, view)
    end
    def draw_sprite(object: Sprite, states)
      states = pointerof(states) if states
      CSFML.render_texture_draw_sprite(@this, object, states)
    end
    def draw_text(object: Text, states)
      states = pointerof(states) if states
      CSFML.render_texture_draw_text(@this, object, states)
    end
    def draw_shape(object: Shape, states)
      states = pointerof(states) if states
      CSFML.render_texture_draw_shape(@this, object, states)
    end
    def draw_circle_shape(object: CircleShape, states)
      states = pointerof(states) if states
      CSFML.render_texture_draw_circle_shape(@this, object, states)
    end
    def draw_convex_shape(object: ConvexShape, states)
      states = pointerof(states) if states
      CSFML.render_texture_draw_convex_shape(@this, object, states)
    end
    def draw_rectangle_shape(object: RectangleShape, states)
      states = pointerof(states) if states
      CSFML.render_texture_draw_rectangle_shape(@this, object, states)
    end
    def draw_vertex_array(object: VertexArray, states)
      states = pointerof(states) if states
      CSFML.render_texture_draw_vertex_array(@this, object, states)
    end
    def draw_primitives(vertices, vertex_count: Int32, type: PrimitiveType, states)
      vertices = pointerof(vertices) if vertices
      states = pointerof(states) if states
      CSFML.render_texture_draw_primitives(@this, vertices, vertex_count, type, states)
    end
    def push_gl_states()
      CSFML.render_texture_push_gl_states(@this)
    end
    def pop_gl_states()
      CSFML.render_texture_pop_gl_states(@this)
    end
    def reset_gl_states()
      CSFML.render_texture_reset_gl_states(@this)
    end
    def texture()
      self.wrap_ptr(CSFML.render_texture_get_texture(@this))
    end
    def smooth=(smooth: Int32)
      CSFML.render_texture_set_smooth(@this, smooth)
    end
    def smooth()
      CSFML.render_texture_is_smooth(@this)
    end
    def repeated=(repeated: Int32)
      CSFML.render_texture_set_repeated(@this, repeated)
    end
    def repeated()
      CSFML.render_texture_is_repeated(@this)
    end
  end

  class RenderWindow
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(mode: VideoMode, title: String, style: WindowStyle, settings)
      title = title.chars; title << '\0'
      settings = pointerof(settings) if settings
      @owned = true
      @this = CSFML.render_window_create_unicode(mode, title, style, settings)
    end
    def initialize(handle: WindowHandle, settings)
      settings = pointerof(settings) if settings
      @owned = true
      @this = CSFML.render_window_create_from_handle(handle, settings)
    end
    def finalize()
      CSFML.render_window_destroy(@this) if @owned
    end
    def close()
      CSFML.render_window_close(@this)
    end
    def open()
      CSFML.render_window_is_open(@this)
    end
    def settings()
      CSFML.render_window_get_settings(@this)
    end
    def poll_event(event: Event*)
      CSFML.render_window_poll_event(@this, event)
    end
    def wait_event(event: Event*)
      CSFML.render_window_wait_event(@this, event)
    end
    def position()
      CSFML.render_window_get_position(@this)
    end
    def position=(position: Vector2i)
      CSFML.render_window_set_position(@this, position)
    end
    def size()
      CSFML.render_window_get_size(@this)
    end
    def size=(size: Vector2i)
      CSFML.render_window_set_size(@this, size)
    end
    def title=(title: String)
      title = title.chars; title << '\0'
      CSFML.render_window_set_unicode_title(@this, title)
    end
    def set_icon(width: Int32, height: Int32, pixels)
      pixels = pointerof(pixels) if pixels
      CSFML.render_window_set_icon(@this, width, height, pixels)
    end
    def visible=(visible: Int32)
      CSFML.render_window_set_visible(@this, visible)
    end
    def mouse_cursor_visible=(show: Int32)
      CSFML.render_window_set_mouse_cursor_visible(@this, show)
    end
    def vertical_sync_enabled=(enabled: Int32)
      CSFML.render_window_set_vertical_sync_enabled(@this, enabled)
    end
    def key_repeat_enabled=(enabled: Int32)
      CSFML.render_window_set_key_repeat_enabled(@this, enabled)
    end
    def active=(active: Int32)
      CSFML.render_window_set_active(@this, active)
    end
    def request_focus()
      CSFML.render_window_request_focus(@this)
    end
    def has_focus()
      CSFML.render_window_has_focus(@this)
    end
    def display()
      CSFML.render_window_display(@this)
    end
    def framerate_limit=(limit: Int32)
      CSFML.render_window_set_framerate_limit(@this, limit)
    end
    def joystick_threshold=(threshold)
      threshold = threshold.to_f32
      CSFML.render_window_set_joystick_threshold(@this, threshold)
    end
    def system_handle()
      CSFML.render_window_get_system_handle(@this)
    end
    def clear(color: Color)
      CSFML.render_window_clear(@this, color)
    end
    def view=(view: View)
      CSFML.render_window_set_view(@this, view)
    end
    def view()
      self.wrap_ptr(CSFML.render_window_get_view(@this))
    end
    def default_view()
      self.wrap_ptr(CSFML.render_window_get_default_view(@this))
    end
    def get_viewport(view: View)
      CSFML.render_window_get_viewport(@this, view)
    end
    def map_pixel_to_coords(point: Vector2i, view: View)
      CSFML.render_window_map_pixel_to_coords(@this, point, view)
    end
    def map_coords_to_pixel(point: Vector2f, view: View)
      CSFML.render_window_map_coords_to_pixel(@this, point, view)
    end
    def draw_sprite(object: Sprite, states)
      states = pointerof(states) if states
      CSFML.render_window_draw_sprite(@this, object, states)
    end
    def draw_text(object: Text, states)
      states = pointerof(states) if states
      CSFML.render_window_draw_text(@this, object, states)
    end
    def draw_shape(object: Shape, states)
      states = pointerof(states) if states
      CSFML.render_window_draw_shape(@this, object, states)
    end
    def draw_circle_shape(object: CircleShape, states)
      states = pointerof(states) if states
      CSFML.render_window_draw_circle_shape(@this, object, states)
    end
    def draw_convex_shape(object: ConvexShape, states)
      states = pointerof(states) if states
      CSFML.render_window_draw_convex_shape(@this, object, states)
    end
    def draw_rectangle_shape(object: RectangleShape, states)
      states = pointerof(states) if states
      CSFML.render_window_draw_rectangle_shape(@this, object, states)
    end
    def draw_vertex_array(object: VertexArray, states)
      states = pointerof(states) if states
      CSFML.render_window_draw_vertex_array(@this, object, states)
    end
    def draw_primitives(vertices, vertex_count: Int32, type: PrimitiveType, states)
      vertices = pointerof(vertices) if vertices
      states = pointerof(states) if states
      CSFML.render_window_draw_primitives(@this, vertices, vertex_count, type, states)
    end
    def push_gl_states()
      CSFML.render_window_push_gl_states(@this)
    end
    def pop_gl_states()
      CSFML.render_window_pop_gl_states(@this)
    end
    def reset_gl_states()
      CSFML.render_window_reset_gl_states(@this)
    end
    def capture()
      self.wrap_ptr(CSFML.render_window_capture(@this))
    end
  end

  class Shape
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(get_point_count: ShapeGetPointCountCallback, get_point: ShapeGetPointCallback, user_data: Void*)
      @owned = true
      @this = CSFML.shape_create(get_point_count, get_point, user_data)
    end
    def finalize()
      CSFML.shape_destroy(@this) if @owned
    end
    def position=(position: Vector2f)
      CSFML.shape_set_position(@this, position)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.shape_set_rotation(@this, angle)
    end
    def scale=(scale: Vector2f)
      CSFML.shape_set_scale(@this, scale)
    end
    def origin=(origin: Vector2f)
      CSFML.shape_set_origin(@this, origin)
    end
    def position()
      CSFML.shape_get_position(@this)
    end
    def rotation()
      CSFML.shape_get_rotation(@this)
    end
    def scale()
      CSFML.shape_get_scale(@this)
    end
    def origin()
      CSFML.shape_get_origin(@this)
    end
    def move(offset: Vector2f)
      CSFML.shape_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.shape_rotate(@this, angle)
    end
    def scale(factors: Vector2f)
      CSFML.shape_scale(@this, factors)
    end
    def transform()
      CSFML.shape_get_transform(@this)
    end
    def inverse_transform()
      CSFML.shape_get_inverse_transform(@this)
    end
    def set_texture(texture: Texture, reset_rect: Int32)
      CSFML.shape_set_texture(@this, texture, reset_rect)
    end
    def texture_rect=(rect: IntRect)
      CSFML.shape_set_texture_rect(@this, rect)
    end
    def fill_color=(color: Color)
      CSFML.shape_set_fill_color(@this, color)
    end
    def outline_color=(color: Color)
      CSFML.shape_set_outline_color(@this, color)
    end
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.shape_set_outline_thickness(@this, thickness)
    end
    def texture()
      self.wrap_ptr(CSFML.shape_get_texture(@this))
    end
    def texture_rect()
      CSFML.shape_get_texture_rect(@this)
    end
    def fill_color()
      CSFML.shape_get_fill_color(@this)
    end
    def outline_color()
      CSFML.shape_get_outline_color(@this)
    end
    def outline_thickness()
      CSFML.shape_get_outline_thickness(@this)
    end
    def point_count()
      CSFML.shape_get_point_count(@this)
    end
    def get_point(index: Int32)
      CSFML.shape_get_point(@this, index)
    end
    def local_bounds()
      CSFML.shape_get_local_bounds(@this)
    end
    def global_bounds()
      CSFML.shape_get_global_bounds(@this)
    end
    def update()
      CSFML.shape_update(@this)
    end
  end

  class Sprite
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.sprite_create()
    end
    def copy()
      self.wrap_ptr(CSFML.sprite_copy(@this))
    end
    def finalize()
      CSFML.sprite_destroy(@this) if @owned
    end
    def position=(position: Vector2f)
      CSFML.sprite_set_position(@this, position)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.sprite_set_rotation(@this, angle)
    end
    def scale=(scale: Vector2f)
      CSFML.sprite_set_scale(@this, scale)
    end
    def origin=(origin: Vector2f)
      CSFML.sprite_set_origin(@this, origin)
    end
    def position()
      CSFML.sprite_get_position(@this)
    end
    def rotation()
      CSFML.sprite_get_rotation(@this)
    end
    def scale()
      CSFML.sprite_get_scale(@this)
    end
    def origin()
      CSFML.sprite_get_origin(@this)
    end
    def move(offset: Vector2f)
      CSFML.sprite_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.sprite_rotate(@this, angle)
    end
    def scale(factors: Vector2f)
      CSFML.sprite_scale(@this, factors)
    end
    def transform()
      CSFML.sprite_get_transform(@this)
    end
    def inverse_transform()
      CSFML.sprite_get_inverse_transform(@this)
    end
    def set_texture(texture: Texture, reset_rect: Int32)
      CSFML.sprite_set_texture(@this, texture, reset_rect)
    end
    def texture_rect=(rectangle: IntRect)
      CSFML.sprite_set_texture_rect(@this, rectangle)
    end
    def color=(color: Color)
      CSFML.sprite_set_color(@this, color)
    end
    def texture()
      self.wrap_ptr(CSFML.sprite_get_texture(@this))
    end
    def texture_rect()
      CSFML.sprite_get_texture_rect(@this)
    end
    def color()
      CSFML.sprite_get_color(@this)
    end
    def local_bounds()
      CSFML.sprite_get_local_bounds(@this)
    end
    def global_bounds()
      CSFML.sprite_get_global_bounds(@this)
    end
  end

  class Text
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.text_create()
    end
    def copy()
      self.wrap_ptr(CSFML.text_copy(@this))
    end
    def finalize()
      CSFML.text_destroy(@this) if @owned
    end
    def position=(position: Vector2f)
      CSFML.text_set_position(@this, position)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.text_set_rotation(@this, angle)
    end
    def scale=(scale: Vector2f)
      CSFML.text_set_scale(@this, scale)
    end
    def origin=(origin: Vector2f)
      CSFML.text_set_origin(@this, origin)
    end
    def position()
      CSFML.text_get_position(@this)
    end
    def rotation()
      CSFML.text_get_rotation(@this)
    end
    def scale()
      CSFML.text_get_scale(@this)
    end
    def origin()
      CSFML.text_get_origin(@this)
    end
    def move(offset: Vector2f)
      CSFML.text_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.text_rotate(@this, angle)
    end
    def scale(factors: Vector2f)
      CSFML.text_scale(@this, factors)
    end
    def transform()
      CSFML.text_get_transform(@this)
    end
    def inverse_transform()
      CSFML.text_get_inverse_transform(@this)
    end
    def string=(string: String)
      CSFML.text_set_string(@this, string)
    end
    def string=(string: String)
      string = string.chars; string << '\0'
      CSFML.text_set_unicode_string(@this, string)
    end
    def font=(font: Font)
      CSFML.text_set_font(@this, font)
    end
    def character_size=(size: Int32)
      CSFML.text_set_character_size(@this, size)
    end
    def style=(style: TextStyle)
      CSFML.text_set_style(@this, style)
    end
    def color=(color: Color)
      CSFML.text_set_color(@this, color)
    end
    def string()
      CSFML.text_get_string(@this)
    end
    def string()
      CSFML.text_get_unicode_string(@this)
    end
    def font()
      self.wrap_ptr(CSFML.text_get_font(@this))
    end
    def character_size()
      CSFML.text_get_character_size(@this)
    end
    def style()
      CSFML.text_get_style(@this)
    end
    def color()
      CSFML.text_get_color(@this)
    end
    def find_character_pos(index: Size_t)
      CSFML.text_find_character_pos(@this, index)
    end
    def local_bounds()
      CSFML.text_get_local_bounds(@this)
    end
    def global_bounds()
      CSFML.text_get_global_bounds(@this)
    end
  end

  class Texture
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize(width: Int32, height: Int32)
      @owned = true
      @this = CSFML.texture_create(width, height)
    end
    def initialize(filename: String, area)
      area = pointerof(area) if area
      @owned = true
      @this = CSFML.texture_create_from_file(filename, area)
    end
    def initialize(data: Void*, size_in_bytes: Size_t, area)
      area = pointerof(area) if area
      @owned = true
      @this = CSFML.texture_create_from_memory(data, size_in_bytes, area)
    end
    def initialize(stream: InputStream*, area)
      area = pointerof(area) if area
      @owned = true
      @this = CSFML.texture_create_from_stream(stream, area)
    end
    def initialize(image: Image, area)
      area = pointerof(area) if area
      @owned = true
      @this = CSFML.texture_create_from_image(image, area)
    end
    def copy()
      self.wrap_ptr(CSFML.texture_copy(@this))
    end
    def finalize()
      CSFML.texture_destroy(@this) if @owned
    end
    def size()
      CSFML.texture_get_size(@this)
    end
    def copy_to_image()
      self.wrap_ptr(CSFML.texture_copy_to_image(@this))
    end
    def update(pixels, width: Int32, height: Int32, x: Int32, y: Int32)
      pixels = pointerof(pixels) if pixels
      CSFML.texture_update_from_pixels(@this, pixels, width, height, x, y)
    end
    def update(image: Image, x: Int32, y: Int32)
      CSFML.texture_update_from_image(@this, image, x, y)
    end
    def update(window: Window, x: Int32, y: Int32)
      CSFML.texture_update_from_window(@this, window, x, y)
    end
    def update(render_window: RenderWindow, x: Int32, y: Int32)
      CSFML.texture_update_from_render_window(@this, render_window, x, y)
    end
    def smooth=(smooth: Int32)
      CSFML.texture_set_smooth(@this, smooth)
    end
    def smooth()
      CSFML.texture_is_smooth(@this)
    end
    def repeated=(repeated: Int32)
      CSFML.texture_set_repeated(@this, repeated)
    end
    def repeated()
      CSFML.texture_is_repeated(@this)
    end
    def bind()
      CSFML.texture_bind(@this)
    end
  end

  class Transformable
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.transformable_create()
    end
    def copy()
      self.wrap_ptr(CSFML.transformable_copy(@this))
    end
    def finalize()
      CSFML.transformable_destroy(@this) if @owned
    end
    def position=(position: Vector2f)
      CSFML.transformable_set_position(@this, position)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.transformable_set_rotation(@this, angle)
    end
    def scale=(scale: Vector2f)
      CSFML.transformable_set_scale(@this, scale)
    end
    def origin=(origin: Vector2f)
      CSFML.transformable_set_origin(@this, origin)
    end
    def position()
      CSFML.transformable_get_position(@this)
    end
    def rotation()
      CSFML.transformable_get_rotation(@this)
    end
    def scale()
      CSFML.transformable_get_scale(@this)
    end
    def origin()
      CSFML.transformable_get_origin(@this)
    end
    def move(offset: Vector2f)
      CSFML.transformable_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.transformable_rotate(@this, angle)
    end
    def scale(factors: Vector2f)
      CSFML.transformable_scale(@this, factors)
    end
    def transform()
      CSFML.transformable_get_transform(@this)
    end
    def inverse_transform()
      CSFML.transformable_get_inverse_transform(@this)
    end
  end

  class VertexArray
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.vertex_array_create()
    end
    def copy()
      self.wrap_ptr(CSFML.vertex_array_copy(@this))
    end
    def finalize()
      CSFML.vertex_array_destroy(@this) if @owned
    end
    def vertex_count()
      CSFML.vertex_array_get_vertex_count(@this)
    end
    def get_vertex(index: Int32)
      CSFML.vertex_array_get_vertex(@this, index)
    end
    def clear()
      CSFML.vertex_array_clear(@this)
    end
    def resize(vertex_count: Int32)
      CSFML.vertex_array_resize(@this, vertex_count)
    end
    def append(vertex: Vertex)
      CSFML.vertex_array_append(@this, vertex)
    end
    def primitive_type=(type: PrimitiveType)
      CSFML.vertex_array_set_primitive_type(@this, type)
    end
    def primitive_type()
      CSFML.vertex_array_get_primitive_type(@this)
    end
    def bounds()
      CSFML.vertex_array_get_bounds(@this)
    end
  end

  class View
    def self.wrap_ptr(p)
      result = self.allocate()
      result.this = p
    end
    def to_unsafe
      @this
    end
    def initialize()
      @owned = true
      @this = CSFML.view_create()
    end
    def initialize(rectangle: FloatRect)
      @owned = true
      @this = CSFML.view_create_from_rect(rectangle)
    end
    def copy()
      self.wrap_ptr(CSFML.view_copy(@this))
    end
    def finalize()
      CSFML.view_destroy(@this) if @owned
    end
    def center=(center: Vector2f)
      CSFML.view_set_center(@this, center)
    end
    def size=(size: Vector2f)
      CSFML.view_set_size(@this, size)
    end
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.view_set_rotation(@this, angle)
    end
    def viewport=(viewport: FloatRect)
      CSFML.view_set_viewport(@this, viewport)
    end
    def reset(rectangle: FloatRect)
      CSFML.view_reset(@this, rectangle)
    end
    def center()
      CSFML.view_get_center(@this)
    end
    def size()
      CSFML.view_get_size(@this)
    end
    def rotation()
      CSFML.view_get_rotation(@this)
    end
    def viewport()
      CSFML.view_get_viewport(@this)
    end
    def move(offset: Vector2f)
      CSFML.view_move(@this, offset)
    end
    def rotate(angle)
      angle = angle.to_f32
      CSFML.view_rotate(@this, angle)
    end
    def zoom(factor)
      factor = factor.to_f32
      CSFML.view_zoom(@this, factor)
    end
  end

  alias Transform = CSFML::Transform
     
  alias FontInfo = CSFML::FontInfo
     
  alias Glyph = CSFML::Glyph
     
  alias PrimitiveType = CSFML::PrimitiveType
     
  alias RenderStates = CSFML::RenderStates
     
  alias Vertex = CSFML::Vertex
     
  alias TextStyle = CSFML::TextStyle
     
  def color_from_rgb(green: UInt8, blue: UInt8)
    CSFML.color_from_rgb(@this, green, blue)
  end
  def color_from_rgba(green: UInt8, blue: UInt8, alpha: UInt8)
    CSFML.color_from_rgba(@this, green, blue, alpha)
  end
  def add(color2: Color)
    CSFML.color_add(@this, color2)
  end
  def modulate(color2: Color)
    CSFML.color_modulate(@this, color2)
  end
  def float_rect_contains(x, y)
    x = x.to_f32
    y = y.to_f32
    CSFML.float_rect_contains(@this, x, y)
  end
  def int_rect_contains(x: Int32, y: Int32)
    CSFML.int_rect_contains(@this, x, y)
  end
  def float_rect_intersects(rect2, intersection: FloatRect*)
    rect2 = pointerof(rect2) if rect2
    CSFML.float_rect_intersects(@this, rect2, intersection)
  end
  def int_rect_intersects(rect2, intersection: IntRect*)
    rect2 = pointerof(rect2) if rect2
    CSFML.int_rect_intersects(@this, rect2, intersection)
  end
  def transform_from_matrix(a01, a02, a10, a11, a12, a20, a21, a22)
    a01 = a01.to_f32
    a02 = a02.to_f32
    a10 = a10.to_f32
    a11 = a11.to_f32
    a12 = a12.to_f32
    a20 = a20.to_f32
    a21 = a21.to_f32
    a22 = a22.to_f32
    CSFML.transform_from_matrix(@this, a01, a02, a10, a11, a12, a20, a21, a22)
  end
  def transform_get_matrix(matrix: Float32*)
    CSFML.transform_get_matrix(@this, matrix)
  end
  def transform_get_inverse()
    CSFML.transform_get_inverse(@this)
  end
  def transform_transform_point(point: Vector2f)
    CSFML.transform_transform_point(@this, point)
  end
  def transform_transform_rect(rectangle: FloatRect)
    CSFML.transform_transform_rect(@this, rectangle)
  end
  def transform_combine(other)
    other = pointerof(other) if other
    CSFML.transform_combine(@this, other)
  end
  def transform_translate(x, y)
    x = x.to_f32
    y = y.to_f32
    CSFML.transform_translate(@this, x, y)
  end
  def transform_rotate(angle)
    angle = angle.to_f32
    CSFML.transform_rotate(@this, angle)
  end
  def transform_rotate(angle, center_x, center_y)
    angle = angle.to_f32
    center_x = center_x.to_f32
    center_y = center_y.to_f32
    CSFML.transform_rotate_with_center(@this, angle, center_x, center_y)
  end
  def transform_scale(scale_x, scale_y)
    scale_x = scale_x.to_f32
    scale_y = scale_y.to_f32
    CSFML.transform_scale(@this, scale_x, scale_y)
  end
  def transform_scale(scale_x, scale_y, center_x, center_y)
    scale_x = scale_x.to_f32
    scale_y = scale_y.to_f32
    center_x = center_x.to_f32
    center_y = center_y.to_f32
    CSFML.transform_scale_with_center(@this, scale_x, scale_y, center_x, center_y)
  end
  def mouse_get_position()
    CSFML.mouse_get_position_render_window(@this)
  end
  def mouse_set_position(relative_to: RenderWindow)
    CSFML.mouse_set_position_render_window(@this, relative_to)
  end
  def touch_get_position(relative_to: RenderWindow)
    CSFML.touch_get_position_render_window(@this, relative_to)
  end
  def shader_is_available()
    CSFML.shader_is_available()
  end
  def texture_get_maximum_size()
    CSFML.texture_get_maximum_size()
  end
end