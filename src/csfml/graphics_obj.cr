require "./graphics_lib"
require "./common_obj"

module SF
  extend self

  # Enumeration of the blending factors
  #
  # * BlendMode::Zero
  # * BlendMode::One
  # * BlendMode::SrcColor
  # * BlendMode::OneMinusSrcColor
  # * BlendMode::DstColor
  # * BlendMode::OneMinusDstColor
  # * BlendMode::SrcAlpha
  # * BlendMode::OneMinusSrcAlpha
  # * BlendMode::DstAlpha
  # * BlendMode::OneMinusDstAlpha
  alias BlendFactor = CSFML::BlendFactor

  struct CSFML::BlendMode
    Zero = CSFML::BlendFactor::Zero
    One = CSFML::BlendFactor::One
    SrcColor = CSFML::BlendFactor::SrcColor
    OneMinusSrcColor = CSFML::BlendFactor::OneMinusSrcColor
    DstColor = CSFML::BlendFactor::DstColor
    OneMinusDstColor = CSFML::BlendFactor::OneMinusDstColor
    SrcAlpha = CSFML::BlendFactor::SrcAlpha
    OneMinusSrcAlpha = CSFML::BlendFactor::OneMinusSrcAlpha
    DstAlpha = CSFML::BlendFactor::DstAlpha
    OneMinusDstAlpha = CSFML::BlendFactor::OneMinusDstAlpha
    Add = CSFML::BlendEquation::Add
    Subtract = CSFML::BlendEquation::Subtract
  end

  # Enumeration of the blending equations
  #
  # * BlendMode::Add
  # * BlendMode::Subtract
  alias BlendEquation = CSFML::BlendEquation

  # Blending mode for drawing
  alias BlendMode = CSFML::BlendMode

  # Utility class for manpulating RGBA colors
  alias Color = CSFML::Color

  struct Color
    # Add two colors
    # 
    # *Arguments*:
    # 
    # * `color1`: First color
    # * `color2`: Second color
    # 
    # *Returns*: Component-wise saturated addition of the two colors
    def add(color2: Color)
      CSFML.color_add(self, color2)
    end
    
    # Modulate two colors
    # 
    # *Arguments*:
    # 
    # * `color1`: First color
    # * `color2`: Second color
    # 
    # *Returns*: Component-wise multiplication of the two colors
    def modulate(color2: Color)
      CSFML.color_modulate(self, color2)
    end
    
  end

  alias FloatRect = CSFML::FloatRect

  alias IntRect = CSFML::IntRect

  struct FloatRect
    # Check if a point is inside a rectangle's area
    # 
    # *Arguments*:
    # 
    # * `rect`: Rectangle to test
    # * `x`: X coordinate of the point to test
    # * `y`: Y coordinate of the point to test
    # 
    # *Returns*: True if the point is inside
    def contains(x, y)
      x = x.to_f32
      y = y.to_f32
      cself = self
      CSFML.float_rect_contains(pointerof(cself), x, y) != 0
    end
    
    # Check intersection between two rectangles
    # 
    # *Arguments*:
    # 
    # * `rect1`: First rectangle to test
    # * `rect2`: Second rectangle to test
    # * `intersection`: Rectangle to be filled with overlapping rect (can be NULL)
    # 
    # *Returns*: True if rectangles overlap
    def intersects(rect2, intersection: FloatRect*)
      if rect2
        crect2 = rect2; prect2 = pointerof(crect2)
      else
        prect2 = nil
      end
      cself = self
      CSFML.float_rect_intersects(pointerof(cself), prect2, intersection) != 0
    end
    
  end

  struct IntRect
    def contains(x: Int32, y: Int32)
      cself = self
      CSFML.int_rect_contains(pointerof(cself), x, y) != 0
    end
    
    def intersects(rect2, intersection: IntRect*)
      if rect2
        crect2 = rect2; prect2 = pointerof(crect2)
      else
        prect2 = nil
      end
      cself = self
      CSFML.int_rect_intersects(pointerof(cself), prect2, intersection) != 0
    end
    
  end

  class CircleShape
    include Wrapper
    
    # Create a new circle shape
    # 
    # *Returns*: A new CircleShape object, or NULL if it failed
    def initialize()
      @owned = true
      @this = CSFML.circle_shape_create()
    end
    
    # Copy an existing circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = CircleShape.allocate()
      result.transfer_ptr(CSFML.circle_shape_copy(@this))
    end
    
    # Destroy an existing circle Shape
    # 
    # *Arguments*:
    # 
    # * `Shape`: Shape to delete
    def finalize()
      CSFML.circle_shape_destroy(@this) if @owned
    end
    
    # Set the position of a circle shape
    # 
    # This function completely overwrites the previous position.
    # See CircleShape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `position`: New position
    def position=(position: Vector2f)
      CSFML.circle_shape_set_position(@this, position)
    end
    
    # Set the orientation of a circle shape
    # 
    # This function completely overwrites the previous rotation.
    # See CircleShape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: New rotation, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.circle_shape_set_rotation(@this, angle)
    end
    
    # Set the scale factors of a circle shape
    # 
    # This function completely overwrites the previous scale.
    # See CircleShape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `scale`: New scale factors
    def scale=(scale: Vector2f)
      CSFML.circle_shape_set_scale(@this, scale)
    end
    
    # Set the local origin of a circle shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `origin`: New origin
    def origin=(origin: Vector2f)
      CSFML.circle_shape_set_origin(@this, origin)
    end
    
    # Get the position of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current position
    def position
      CSFML.circle_shape_get_position(@this)
    end
    
    # Get the orientation of a circle shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current rotation, in degrees
    def rotation
      CSFML.circle_shape_get_rotation(@this)
    end
    
    # Get the current scale of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current scale factors
    def scale
      CSFML.circle_shape_get_scale(@this)
    end
    
    # Get the local origin of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current origin
    def origin
      CSFML.circle_shape_get_origin(@this)
    end
    
    # Move a circle shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike CircleShape_setPosition which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.circle_shape_move(@this, offset)
    end
    
    # Rotate a circle shape
    # 
    # This function adds to the current rotation of the object,
    # unlike CircleShape_setRotation which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: Angle of rotation, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.circle_shape_rotate(@this, angle)
    end
    
    # Scale a circle shape
    # 
    # This function multiplies the current scale of the object,
    # unlike CircleShape_setScale which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `factors`: Scale factors
    def scale(factors: Vector2f)
      CSFML.circle_shape_scale(@this, factors)
    end
    
    # Get the combined transform of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Transform combining the position/rotation/scale/origin of the object
    def transform
      CSFML.circle_shape_get_transform(@this)
    end
    
    # Get the inverse of the combined transform of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Inverse of the combined transformations applied to the object
    def inverse_transform
      CSFML.circle_shape_get_inverse_transform(@this)
    end
    
    # Change the source texture of a circle shape
    # 
    # The `texture` argument refers to a texture that must
    # exist as long as the shape uses it. Indeed, the shape
    # doesn't store its own copy of the texture, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the source texture is destroyed and the shape tries to
    # use it, the behaviour is undefined.
    # `texture` can be NULL to disable texturing.
    # If `reset_rect` is true, the TextureRect property of
    # the shape is automatically adjusted to the size of the new
    # texture. If it is false, the texture rect is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `texture`: New texture
    # * `reset_rect`: Should the texture rect be reset to the size of the new texture?
    def set_texture(texture: Texture, reset_rect: Bool)
      reset_rect = reset_rect ? 1 : 0
      CSFML.circle_shape_set_texture(@this, texture, reset_rect)
    end
    
    # Set the sub-rectangle of the texture that a circle shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `rect`: Rectangle defining the region of the texture to display
    def texture_rect=(rect: IntRect)
      CSFML.circle_shape_set_texture_rect(@this, rect)
    end
    
    # Set the fill color of a circle shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New color of the shape
    def fill_color=(color: Color)
      CSFML.circle_shape_set_fill_color(@this, color)
    end
    
    # Set the outline color of a circle shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New outline color of the shape
    def outline_color=(color: Color)
      CSFML.circle_shape_set_outline_color(@this, color)
    end
    
    # Set the thickness of a circle shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `thickness`: New outline thickness
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.circle_shape_set_outline_thickness(@this, thickness)
    end
    
    # Get the source texture of a circle shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Pointer to the shape's texture
    def texture
      result = Texture.allocate()
      result.wrap_ptr(CSFML.circle_shape_get_texture(@this))
    end
    
    # Get the sub-rectangle of the texture displayed by a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Texture rectangle of the shape
    def texture_rect
      CSFML.circle_shape_get_texture_rect(@this)
    end
    
    # Get the fill color of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Fill color of the shape
    def fill_color
      CSFML.circle_shape_get_fill_color(@this)
    end
    
    # Get the outline color of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline color of the shape
    def outline_color
      CSFML.circle_shape_get_outline_color(@this)
    end
    
    # Get the outline thickness of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline thickness of the shape
    def outline_thickness
      CSFML.circle_shape_get_outline_thickness(@this)
    end
    
    # Get the total number of points of a circle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Number of points of the shape
    def point_count
      CSFML.circle_shape_get_point_count(@this)
    end
    
    # Get a point of a circle shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `index`: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # *Returns*: Index-th point of the shape
    def get_point(index: Int32)
      CSFML.circle_shape_get_point(@this, index)
    end
    
    # Set the radius of a circle
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `radius`: New radius of the circle
    def radius=(radius)
      radius = radius.to_f32
      CSFML.circle_shape_set_radius(@this, radius)
    end
    
    # Get the radius of a circle
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Radius of the circle
    def radius
      CSFML.circle_shape_get_radius(@this)
    end
    
    # Set the number of points of a circle
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `count`: New number of points of the circle
    def point_count=(count: Int32)
      CSFML.circle_shape_set_point_count(@this, count)
    end
    
    # Get the local bounding rectangle of a circle shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Local bounding rectangle of the entity
    def local_bounds
      CSFML.circle_shape_get_local_bounds(@this)
    end
    
    # Get the global bounding rectangle of a circle shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Global bounding rectangle of the entity
    def global_bounds
      CSFML.circle_shape_get_global_bounds(@this)
    end
    
  end

  class ConvexShape
    include Wrapper
    
    # Create a new convex shape
    # 
    # *Returns*: A new ConvexShape object, or NULL if it failed
    def initialize()
      @owned = true
      @this = CSFML.convex_shape_create()
    end
    
    # Copy an existing convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = ConvexShape.allocate()
      result.transfer_ptr(CSFML.convex_shape_copy(@this))
    end
    
    # Destroy an existing convex Shape
    # 
    # *Arguments*:
    # 
    # * `Shape`: Shape to delete
    def finalize()
      CSFML.convex_shape_destroy(@this) if @owned
    end
    
    # Set the position of a convex shape
    # 
    # This function completely overwrites the previous position.
    # See ConvexShape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `position`: New position
    def position=(position: Vector2f)
      CSFML.convex_shape_set_position(@this, position)
    end
    
    # Set the orientation of a convex shape
    # 
    # This function completely overwrites the previous rotation.
    # See ConvexShape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: New rotation, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.convex_shape_set_rotation(@this, angle)
    end
    
    # Set the scale factors of a convex shape
    # 
    # This function completely overwrites the previous scale.
    # See ConvexShape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `scale`: New scale factors
    def scale=(scale: Vector2f)
      CSFML.convex_shape_set_scale(@this, scale)
    end
    
    # Set the local origin of a convex shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `origin`: New origin
    def origin=(origin: Vector2f)
      CSFML.convex_shape_set_origin(@this, origin)
    end
    
    # Get the position of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current position
    def position
      CSFML.convex_shape_get_position(@this)
    end
    
    # Get the orientation of a convex shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current rotation, in degrees
    def rotation
      CSFML.convex_shape_get_rotation(@this)
    end
    
    # Get the current scale of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current scale factors
    def scale
      CSFML.convex_shape_get_scale(@this)
    end
    
    # Get the local origin of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current origin
    def origin
      CSFML.convex_shape_get_origin(@this)
    end
    
    # Move a convex shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike ConvexShape_setPosition which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.convex_shape_move(@this, offset)
    end
    
    # Rotate a convex shape
    # 
    # This function adds to the current rotation of the object,
    # unlike ConvexShape_setRotation which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: Angle of rotation, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.convex_shape_rotate(@this, angle)
    end
    
    # Scale a convex shape
    # 
    # This function multiplies the current scale of the object,
    # unlike ConvexShape_setScale which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `factors`: Scale factors
    def scale(factors: Vector2f)
      CSFML.convex_shape_scale(@this, factors)
    end
    
    # Get the combined transform of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: shape object
    # 
    # *Returns*: Transform combining the position/rotation/scale/origin of the object
    def transform
      CSFML.convex_shape_get_transform(@this)
    end
    
    # Get the inverse of the combined transform of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: shape object
    # 
    # *Returns*: Inverse of the combined transformations applied to the object
    def inverse_transform
      CSFML.convex_shape_get_inverse_transform(@this)
    end
    
    # Change the source texture of a convex shape
    # 
    # The `texture` argument refers to a texture that must
    # exist as long as the shape uses it. Indeed, the shape
    # doesn't store its own copy of the texture, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the source texture is destroyed and the shape tries to
    # use it, the behaviour is undefined.
    # `texture` can be NULL to disable texturing.
    # If `reset_rect` is true, the TextureRect property of
    # the shape is automatically adjusted to the size of the new
    # texture. If it is false, the texture rect is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `texture`: New texture
    # * `reset_rect`: Should the texture rect be reset to the size of the new texture?
    def set_texture(texture: Texture, reset_rect: Bool)
      reset_rect = reset_rect ? 1 : 0
      CSFML.convex_shape_set_texture(@this, texture, reset_rect)
    end
    
    # Set the sub-rectangle of the texture that a convex shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `rect`: Rectangle defining the region of the texture to display
    def texture_rect=(rect: IntRect)
      CSFML.convex_shape_set_texture_rect(@this, rect)
    end
    
    # Set the fill color of a convex shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New color of the shape
    def fill_color=(color: Color)
      CSFML.convex_shape_set_fill_color(@this, color)
    end
    
    # Set the outline color of a convex shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New outline color of the shape
    def outline_color=(color: Color)
      CSFML.convex_shape_set_outline_color(@this, color)
    end
    
    # Set the thickness of a convex shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `thickness`: New outline thickness
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.convex_shape_set_outline_thickness(@this, thickness)
    end
    
    # Get the source texture of a convex shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Pointer to the shape's texture
    def texture
      result = Texture.allocate()
      result.wrap_ptr(CSFML.convex_shape_get_texture(@this))
    end
    
    # Get the sub-rectangle of the texture displayed by a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Texture rectangle of the shape
    def texture_rect
      CSFML.convex_shape_get_texture_rect(@this)
    end
    
    # Get the fill color of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Fill color of the shape
    def fill_color
      CSFML.convex_shape_get_fill_color(@this)
    end
    
    # Get the outline color of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline color of the shape
    def outline_color
      CSFML.convex_shape_get_outline_color(@this)
    end
    
    # Get the outline thickness of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline thickness of the shape
    def outline_thickness
      CSFML.convex_shape_get_outline_thickness(@this)
    end
    
    # Get the total number of points of a convex shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Number of points of the shape
    def point_count
      CSFML.convex_shape_get_point_count(@this)
    end
    
    # Get a point of a convex shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `index`: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # *Returns*: Index-th point of the shape
    def get_point(index: Int32)
      CSFML.convex_shape_get_point(@this, index)
    end
    
    # Set the number of points of a convex shap
    # 
    # `count` must be greater than 2 to define a valid shape.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `count`: New number of points of the shape
    def point_count=(count: Int32)
      CSFML.convex_shape_set_point_count(@this, count)
    end
    
    # Set the position of a point in a convex shape
    # 
    # Don't forget that the polygon must remain convex, and
    # the points need to stay ordered!
    # set_point_count must be called first in order to set the total
    # number of points. The result is undefined if `index` is out
    # of the valid range.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `index`: Index of the point to change, in range [0 .. GetPointCount() - 1]
    # * `point`: New point
    def set_point(index: Int32, point: Vector2f)
      CSFML.convex_shape_set_point(@this, index, point)
    end
    
    # Get the local bounding rectangle of a convex shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Local bounding rectangle of the entity
    def local_bounds
      CSFML.convex_shape_get_local_bounds(@this)
    end
    
    # Get the global bounding rectangle of a convex shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Global bounding rectangle of the entity
    def global_bounds
      CSFML.convex_shape_get_global_bounds(@this)
    end
    
  end

  class Font
    include Wrapper
    
    # Create a new font from a file
    # 
    # *Arguments*:
    # 
    # * `filename`: Path of the font file to load
    # 
    # *Returns*: A new Font object, or NULL if it failed
    def initialize(filename: String)
      @owned = true
      @this = CSFML.font_create_from_file(filename)
    end
    
    # Create a new image font a file in memory
    # 
    # *Arguments*:
    # 
    # * `data`: Pointer to the file data in memory
    # * `size_in_bytes`: Size of the data to load, in bytes
    # 
    # *Returns*: A new Font object, or NULL if it failed
    def initialize(data: Void*, size_in_bytes: Size_t)
      @owned = true
      @this = CSFML.font_create_from_memory(data, size_in_bytes)
    end
    
    # Create a new image font a custom stream
    # 
    # *Arguments*:
    # 
    # * `stream`: Source stream to read from
    # 
    # *Returns*: A new Font object, or NULL if it failed
    def initialize(stream: InputStream*)
      @owned = true
      @this = CSFML.font_create_from_stream(stream)
    end
    
    # Copy an existing font
    # 
    # *Arguments*:
    # 
    # * `font`: Font to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = Font.allocate()
      result.transfer_ptr(CSFML.font_copy(@this))
    end
    
    # Destroy an existing font
    # 
    # *Arguments*:
    # 
    # * `font`: Font to delete
    def finalize()
      CSFML.font_destroy(@this) if @owned
    end
    
    # Get a glyph in a font
    # 
    # *Arguments*:
    # 
    # * `font`: Source font
    # * `code_point`: Unicode code point of the character to get
    # * `character_size`: Character size, in pixels
    # * `bold`: Retrieve the bold version or the regular one?
    # 
    # *Returns*: The corresponding glyph
    def get_glyph(code_point: Char, character_size: Int32, bold: Bool)
      bold = bold ? 1 : 0
      CSFML.font_get_glyph(@this, code_point, character_size, bold)
    end
    
    # Get the kerning value corresponding to a given pair of characters in a font
    # 
    # *Arguments*:
    # 
    # * `font`: Source font
    # * `first`: Unicode code point of the first character
    # * `second`: Unicode code point of the second character
    # * `character_size`: Character size, in pixels
    # 
    # *Returns*: Kerning offset, in pixels
    def get_kerning(first: Char, second: Char, character_size: Int32)
      CSFML.font_get_kerning(@this, first, second, character_size)
    end
    
    # Get the line spacing value
    # 
    # *Arguments*:
    # 
    # * `font`: Source font
    # * `character_size`: Character size, in pixels
    # 
    # *Returns*: Line spacing, in pixels
    def get_line_spacing(character_size: Int32)
      CSFML.font_get_line_spacing(@this, character_size)
    end
    
    # Get the position of the underline
    # 
    # Underline position is the vertical offset to apply between the
    # baseline and the underline.
    # 
    # *Arguments*:
    # 
    # * `font`: Source font
    # * `character_size`: Reference character size
    # 
    # *Returns*: Underline position, in pixels
    def get_underline_position(character_size: Int32)
      CSFML.font_get_underline_position(@this, character_size)
    end
    
    # Get the thickness of the underline
    # 
    # Underline thickness is the vertical size of the underline.
    # 
    # *Arguments*:
    # 
    # * `font`: Source font
    # * `character_size`: Reference character size
    # 
    # *Returns*: Underline thickness, in pixels
    def get_underline_thickness(character_size: Int32)
      CSFML.font_get_underline_thickness(@this, character_size)
    end
    
    # Get the texture containing the glyphs of a given size in a font
    # 
    # *Arguments*:
    # 
    # * `font`: Source font
    # * `character_size`: Character size, in pixels
    # 
    # *Returns*: Read-only pointer to the texture
    def get_texture(character_size: Int32)
      result = Texture.allocate()
      result.wrap_ptr(CSFML.font_get_texture(@this, character_size))
    end
    
    # Get the font information
    # 
    # The returned structure will remain valid only if the font
    # is still valid. If the font is invalid an invalid structure
    # is returned.
    # 
    # *Arguments*:
    # 
    # * `font`: Source font
    # 
    # *Returns*: A structure that holds the font information
    def info
      CSFML.font_get_info(@this)
    end
    
  end

  class Image
    include Wrapper
    
    # Create an image
    # 
    # This image is filled with black pixels.
    # 
    # *Arguments*:
    # 
    # * `width`: Width of the image
    # * `height`: Height of the image
    # 
    # *Returns*: A new Image object
    def initialize(width: Int32, height: Int32)
      @owned = true
      @this = CSFML.image_create(width, height)
    end
    
    # Create an image and fill it with a unique color
    # 
    # *Arguments*:
    # 
    # * `width`: Width of the image
    # * `height`: Height of the image
    # * `color`: Fill color
    # 
    # *Returns*: A new Image object
    def initialize(width: Int32, height: Int32, color: Color)
      @owned = true
      @this = CSFML.image_create_from_color(width, height, color)
    end
    
    # Create an image from an array of pixels
    # 
    # The `pixel` array is assumed to contain 32-bits RGBA pixels,
    # and have the given `width` and `height`. If not, this is
    # an undefined behaviour.
    # If `pixels` is null, an empty image is created.
    # 
    # *Arguments*:
    # 
    # * `width`: Width of the image
    # * `height`: Height of the image
    # * `pixels`: Array of pixels to copy to the image
    # 
    # *Returns*: A new Image object
    def initialize(width: Int32, height: Int32, pixels)
      if pixels
        cpixels = pixels; ppixels = pointerof(cpixels)
      else
        ppixels = nil
      end
      @owned = true
      @this = CSFML.image_create_from_pixels(width, height, ppixels)
    end
    
    # Create an image from a file on disk
    # 
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `filename`: Path of the image file to load
    # 
    # *Returns*: A new Image object, or NULL if it failed
    def initialize(filename: String)
      @owned = true
      @this = CSFML.image_create_from_file(filename)
    end
    
    # Create an image from a file in memory
    # 
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `data`: Pointer to the file data in memory
    # * `size`: Size of the data to load, in bytes
    # 
    # *Returns*: A new Image object, or NULL if it failed
    def initialize(data: Void*, size: Size_t)
      @owned = true
      @this = CSFML.image_create_from_memory(data, size)
    end
    
    # Create an image from a custom stream
    # 
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `stream`: Source stream to read from
    # 
    # *Returns*: A new Image object, or NULL if it failed
    def initialize(stream: InputStream*)
      @owned = true
      @this = CSFML.image_create_from_stream(stream)
    end
    
    # Copy an existing image
    # 
    # *Arguments*:
    # 
    # * `image`: Image to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = Image.allocate()
      result.transfer_ptr(CSFML.image_copy(@this))
    end
    
    # Destroy an existing image
    # 
    # *Arguments*:
    # 
    # * `image`: Image to delete
    def finalize()
      CSFML.image_destroy(@this) if @owned
    end
    
    # Save an image to a file on disk
    # 
    # The format of the image is automatically deduced from
    # the extension. The supported image formats are bmp, png,
    # tga and jpg. The destination file is overwritten
    # if it already exists. This function fails if the image is empty.
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    # * `filename`: Path of the file to save
    # 
    # *Returns*: True if saving was successful
    def save_to_file(filename: String)
      CSFML.image_save_to_file(@this, filename) != 0
    end
    
    # Return the size of an image
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    # 
    # *Returns*: Size in pixels
    def size
      CSFML.image_get_size(@this)
    end
    
    # Create a transparency mask from a specified color-key
    # 
    # This function sets the alpha value of every pixel matching
    # the given color to `alpha` (0 by default), so that they
    # become transparent.
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    # * `color`: Color to make transparent
    # * `alpha`: Alpha value to assign to transparent pixels
    def create_mask(color: Color, alpha: UInt8)
      CSFML.image_create_mask_from_color(@this, color, alpha)
    end
    
    # Copy pixels from an image onto another
    # 
    # This function does a slow pixel copy and should not be
    # used intensively. It can be used to prepare a complex
    # static image from several others, but if you need this
    # kind of feature in real-time you'd better use RenderTexture.
    # 
    # If `source_rect` is empty, the whole image is copied.
    # If `apply_alpha` is set to true, the transparency of
    # source pixels is applied. If it is false, the pixels are
    # copied unchanged with their alpha value.
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    # * `source`: Source image to copy
    # * `destX`: X coordinate of the destination position
    # * `destY`: Y coordinate of the destination position
    # * `source_rect`: Sub-rectangle of the source image to copy
    # * `apply_alpha`: Should the copy take in account the source transparency?
    def copy_image(source: Image, dest_x: Int32, dest_y: Int32, source_rect: IntRect, apply_alpha: Bool)
      apply_alpha = apply_alpha ? 1 : 0
      CSFML.image_copy_image(@this, source, dest_x, dest_y, source_rect, apply_alpha)
    end
    
    # Change the color of a pixel in an image
    # 
    # This function doesn't check the validity of the pixel
    # coordinates, using out-of-range values will result in
    # an undefined behaviour.
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    # * `x`: X coordinate of pixel to change
    # * `y`: Y coordinate of pixel to change
    # * `color`: New color of the pixel
    def set_pixel(x: Int32, y: Int32, color: Color)
      CSFML.image_set_pixel(@this, x, y, color)
    end
    
    # Get the color of a pixel in an image
    # 
    # This function doesn't check the validity of the pixel
    # coordinates, using out-of-range values will result in
    # an undefined behaviour.
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    # * `x`: X coordinate of pixel to get
    # * `y`: Y coordinate of pixel to get
    # 
    # *Returns*: Color of the pixel at coordinates (x, y)
    def get_pixel(x: Int32, y: Int32)
      CSFML.image_get_pixel(@this, x, y)
    end
    
    # Get a read-only pointer to the array of pixels of an image
    # 
    # The returned value points to an array of RGBA pixels made of
    # 8 bits integers components. The size of the array is
    # get_width() * get_height() * 4.
    # Warning: the returned pointer may become invalid if you
    # modify the image, so you should never store it for too long.
    # If the image is empty, a null pointer is returned.
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    # 
    # *Returns*: Read-only pointer to the array of pixels
    def pixels_ptr
      CSFML.image_get_pixels_ptr(@this)
    end
    
    # Flip an image horizontally (left <-> right)
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    def flip_horizontally()
      CSFML.image_flip_horizontally(@this)
    end
    
    # Flip an image vertically (top <-> bottom)
    # 
    # *Arguments*:
    # 
    # * `image`: Image object
    def flip_vertically()
      CSFML.image_flip_vertically(@this)
    end
    
  end

  class Shader
    include Wrapper
    
    # Load both the vertex and fragment shaders from files
    # 
    # This function can load both the vertex and the fragment
    # shaders, or only one of them: pass NULL if you don't want to load
    # either the vertex shader or the fragment shader.
    # The sources must be text files containing valid shaders
    # in GLSL language. GLSL is a C-like language dedicated to
    # OpenGL shaders; you'll probably need to read a good documentation
    # for it before writing your own shaders.
    # 
    # *Arguments*:
    # 
    # * `vertex_shader_filename`: Path of the vertex shader file to load, or NULL to skip this shader
    # * `fragment_shader_filename`: Path of the fragment shader file to load, or NULL to skip this shader
    # 
    # *Returns*: A new Shader object, or NULL if it failed
    def initialize(vertex_shader_filename: String, fragment_shader_filename: String)
      @owned = true
      @this = CSFML.shader_create_from_file(vertex_shader_filename, fragment_shader_filename)
    end
    
    # Load both the vertex and fragment shaders from source codes in memory
    # 
    # This function can load both the vertex and the fragment
    # shaders, or only one of them: pass NULL if you don't want to load
    # either the vertex shader or the fragment shader.
    # The sources must be valid shaders in GLSL language. GLSL is
    # a C-like language dedicated to OpenGL shaders; you'll
    # probably need to read a good documentation for it before
    # writing your own shaders.
    # 
    # *Arguments*:
    # 
    # * `vertex_shader`: String containing the source code of the vertex shader, or NULL to skip this shader
    # * `fragment_shader`: String containing the source code of the fragment shader, or NULL to skip this shader
    # 
    # *Returns*: A new Shader object, or NULL if it failed
    def initialize(vertex_shader: String, fragment_shader: String)
      @owned = true
      @this = CSFML.shader_create_from_memory(vertex_shader, fragment_shader)
    end
    
    # Load both the vertex and fragment shaders from custom streams
    # 
    # This function can load both the vertex and the fragment
    # shaders, or only one of them: pass NULL if you don't want to load
    # either the vertex shader or the fragment shader.
    # The source codes must be valid shaders in GLSL language.
    # GLSL is a C-like language dedicated to OpenGL shaders;
    # you'll probably need to read a good documentation for
    # it before writing your own shaders.
    # 
    # *Arguments*:
    # 
    # * `vertex_shader_stream`: Source stream to read the vertex shader from, or NULL to skip this shader
    # * `fragment_shader_stream`: Source stream to read the fragment shader from, or NULL to skip this shader
    # 
    # *Returns*: A new Shader object, or NULL if it failed
    def initialize(vertex_shader_stream: InputStream*, fragment_shader_stream: InputStream*)
      @owned = true
      @this = CSFML.shader_create_from_stream(vertex_shader_stream, fragment_shader_stream)
    end
    
    # Destroy an existing shader
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader to delete
    def finalize()
      CSFML.shader_destroy(@this) if @owned
    end
    
    # Change a float parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a float
    # (float GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `x`: Value to assign
    def set_parameter(name: String, x)
      x = x.to_f32
      CSFML.shader_set_float_parameter(@this, name, x)
    end
    
    # Change a 2-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 2x1 vector
    # (vec2 GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `x`: First component of the value to assign
    # * `y`: Second component of the value to assign
    def set_parameter(name: String, x, y)
      x = x.to_f32
      y = y.to_f32
      CSFML.shader_set_float2_parameter(@this, name, x, y)
    end
    
    # Change a 3-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 3x1 vector
    # (vec3 GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `x`: First component of the value to assign
    # * `y`: Second component of the value to assign
    # * `z`: Third component of the value to assign
    def set_parameter(name: String, x, y, z)
      x = x.to_f32
      y = y.to_f32
      z = z.to_f32
      CSFML.shader_set_float3_parameter(@this, name, x, y, z)
    end
    
    # Change a 4-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 4x1 vector
    # (vec4 GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `x`: First component of the value to assign
    # * `y`: Second component of the value to assign
    # * `z`: Third component of the value to assign
    # * `w`: Fourth component of the value to assign
    def set_parameter(name: String, x, y, z, w)
      x = x.to_f32
      y = y.to_f32
      z = z.to_f32
      w = w.to_f32
      CSFML.shader_set_float4_parameter(@this, name, x, y, z, w)
    end
    
    # Change a 2-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 2x1 vector
    # (vec2 GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `vector`: Vector to assign
    def set_parameter(name: String, vector: Vector2f)
      CSFML.shader_set_vector2_parameter(@this, name, vector)
    end
    
    # Change a 3-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 3x1 vector
    # (vec3 GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `vector`: Vector to assign
    def set_parameter(name: String, vector: Vector3f)
      CSFML.shader_set_vector3_parameter(@this, name, vector)
    end
    
    # Change a color parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 4x1 vector
    # (vec4 GLSL type).
    # 
    # It is important to note that the components of the color are
    # normalized before being passed to the shader. Therefore,
    # they are converted from range [0 .. 255] to range [0 .. 1].
    # For example, a sf::Color(255, 125, 0, 255) will be transformed
    # to a vec4(1.0, 0.5, 0.0, 1.0) in the shader.
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `color`: Color to assign
    def set_parameter(name: String, color: Color)
      CSFML.shader_set_color_parameter(@this, name, color)
    end
    
    # Change a matrix parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 4x4 matrix
    # (mat4 GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the parameter in the shader
    # * `transform`: Transform to assign
    def set_parameter(name: String, transform: Transform)
      CSFML.shader_set_transform_parameter(@this, name, transform)
    end
    
    # Change a texture parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 2D texture
    # (sampler2D GLSL type).
    # 
    # It is important to note that `texture` must remain alive as long
    # as the shader uses it, no copy is made internally.
    # 
    # To use the texture of the object being draw, which cannot be
    # known in advance, you can use the special function
    # Shader_setCurrentTextureParameter:
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the texture in the shader
    # * `texture`: Texture to assign
    def set_parameter(name: String, texture: Texture)
      CSFML.shader_set_texture_parameter(@this, name, texture)
    end
    
    # Change a texture parameter of a shader
    # 
    # This function maps a shader texture variable to the
    # texture of the object being drawn, which cannot be
    # known in advance.
    # The corresponding parameter in the shader must be a 2D texture
    # (sampler2D GLSL type).
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader object
    # * `name`: Name of the texture in the shader
    def current_texture_parameter=(name: String)
      CSFML.shader_set_current_texture_parameter(@this, name)
    end
    
    # Bind a shader for rendering (activate it)
    # 
    # This function is not part of the graphics API, it mustn't be
    # used when drawing SFML entities. It must be used only if you
    # mix Shader with OpenGL code.
    # 
    # 
    # *Arguments*:
    # 
    # * `shader`: Shader to bind, can be null to use no shader
    def bind()
      CSFML.shader_bind(@this)
    end
    
    # Tell whether or not the system supports shaders
    # 
    # This function should always be called before using
    # the shader features. If it returns false, then
    # any attempt to use Shader will fail.
    # 
    # *Returns*: True if the system can use shaders, False otherwise
    def self.is_available()
      CSFML.shader_is_available() != 0
    end
    
  end

  class RectangleShape
    include Wrapper
    
    # Create a new rectangle shape
    # 
    # *Returns*: A new RectangleShape object, or NULL if it failed
    def initialize()
      @owned = true
      @this = CSFML.rectangle_shape_create()
    end
    
    # Copy an existing rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = RectangleShape.allocate()
      result.transfer_ptr(CSFML.rectangle_shape_copy(@this))
    end
    
    # Destroy an existing rectangle shape
    # 
    # *Arguments*:
    # 
    # * `Shape`: Shape to delete
    def finalize()
      CSFML.rectangle_shape_destroy(@this) if @owned
    end
    
    # Set the position of a rectangle shape
    # 
    # This function completely overwrites the previous position.
    # See RectangleShape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `position`: New position
    def position=(position: Vector2f)
      CSFML.rectangle_shape_set_position(@this, position)
    end
    
    # Set the orientation of a rectangle shape
    # 
    # This function completely overwrites the previous rotation.
    # See RectangleShape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: New rotation, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.rectangle_shape_set_rotation(@this, angle)
    end
    
    # Set the scale factors of a rectangle shape
    # 
    # This function completely overwrites the previous scale.
    # See RectangleShape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `scale`: New scale factors
    def scale=(scale: Vector2f)
      CSFML.rectangle_shape_set_scale(@this, scale)
    end
    
    # Set the local origin of a rectangle shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `origin`: New origin
    def origin=(origin: Vector2f)
      CSFML.rectangle_shape_set_origin(@this, origin)
    end
    
    # Get the position of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current position
    def position
      CSFML.rectangle_shape_get_position(@this)
    end
    
    # Get the orientation of a rectangle shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current rotation, in degrees
    def rotation
      CSFML.rectangle_shape_get_rotation(@this)
    end
    
    # Get the current scale of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current scale factors
    def scale
      CSFML.rectangle_shape_get_scale(@this)
    end
    
    # Get the local origin of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current origin
    def origin
      CSFML.rectangle_shape_get_origin(@this)
    end
    
    # Move a rectangle shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike RectangleShape_setPosition which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.rectangle_shape_move(@this, offset)
    end
    
    # Rotate a rectangle shape
    # 
    # This function adds to the current rotation of the object,
    # unlike RectangleShape_setRotation which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: Angle of rotation, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.rectangle_shape_rotate(@this, angle)
    end
    
    # Scale a rectangle shape
    # 
    # This function multiplies the current scale of the object,
    # unlike RectangleShape_setScale which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `factors`: Scale factors
    def scale(factors: Vector2f)
      CSFML.rectangle_shape_scale(@this, factors)
    end
    
    # Get the combined transform of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: shape object
    # 
    # *Returns*: Transform combining the position/rotation/scale/origin of the object
    def transform
      CSFML.rectangle_shape_get_transform(@this)
    end
    
    # Get the inverse of the combined transform of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: shape object
    # 
    # *Returns*: Inverse of the combined transformations applied to the object
    def inverse_transform
      CSFML.rectangle_shape_get_inverse_transform(@this)
    end
    
    # Change the source texture of a rectangle shape
    # 
    # The `texture` argument refers to a texture that must
    # exist as long as the shape uses it. Indeed, the shape
    # doesn't store its own copy of the texture, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the source texture is destroyed and the shape tries to
    # use it, the behaviour is undefined.
    # `texture` can be NULL to disable texturing.
    # If `reset_rect` is true, the TextureRect property of
    # the shape is automatically adjusted to the size of the new
    # texture. If it is false, the texture rect is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `texture`: New texture
    # * `reset_rect`: Should the texture rect be reset to the size of the new texture?
    def set_texture(texture: Texture, reset_rect: Bool)
      reset_rect = reset_rect ? 1 : 0
      CSFML.rectangle_shape_set_texture(@this, texture, reset_rect)
    end
    
    # Set the sub-rectangle of the texture that a rectangle shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `rect`: Rectangle defining the region of the texture to display
    def texture_rect=(rect: IntRect)
      CSFML.rectangle_shape_set_texture_rect(@this, rect)
    end
    
    # Set the fill color of a rectangle shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New color of the shape
    def fill_color=(color: Color)
      CSFML.rectangle_shape_set_fill_color(@this, color)
    end
    
    # Set the outline color of a rectangle shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New outline color of the shape
    def outline_color=(color: Color)
      CSFML.rectangle_shape_set_outline_color(@this, color)
    end
    
    # Set the thickness of a rectangle shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `thickness`: New outline thickness
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.rectangle_shape_set_outline_thickness(@this, thickness)
    end
    
    # Get the source texture of a rectangle shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Pointer to the shape's texture
    def texture
      result = Texture.allocate()
      result.wrap_ptr(CSFML.rectangle_shape_get_texture(@this))
    end
    
    # Get the sub-rectangle of the texture displayed by a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Texture rectangle of the shape
    def texture_rect
      CSFML.rectangle_shape_get_texture_rect(@this)
    end
    
    # Get the fill color of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Fill color of the shape
    def fill_color
      CSFML.rectangle_shape_get_fill_color(@this)
    end
    
    # Get the outline color of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline color of the shape
    def outline_color
      CSFML.rectangle_shape_get_outline_color(@this)
    end
    
    # Get the outline thickness of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline thickness of the shape
    def outline_thickness
      CSFML.rectangle_shape_get_outline_thickness(@this)
    end
    
    # Get the total number of points of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Number of points of the shape
    def point_count
      CSFML.rectangle_shape_get_point_count(@this)
    end
    
    # Get a point of a rectangle shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `index`: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # *Returns*: Index-th point of the shape
    def get_point(index: Int32)
      CSFML.rectangle_shape_get_point(@this, index)
    end
    
    # Set the size of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `size`: New size of the rectangle
    def size=(size: Vector2f)
      CSFML.rectangle_shape_set_size(@this, size)
    end
    
    # Get the size of a rectangle shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: height Size of the rectangle
    def size
      CSFML.rectangle_shape_get_size(@this)
    end
    
    # Get the local bounding rectangle of a rectangle shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Local bounding rectangle of the entity
    def local_bounds
      CSFML.rectangle_shape_get_local_bounds(@this)
    end
    
    # Get the global bounding rectangle of a rectangle shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Global bounding rectangle of the entity
    def global_bounds
      CSFML.rectangle_shape_get_global_bounds(@this)
    end
    
  end

  class RenderTexture
    include Wrapper
    
    # Construct a new render texture
    # 
    # *Arguments*:
    # 
    # * `width`: Width of the render texture
    # * `height`: Height of the render texture
    # * `depth_buffer`: Do you want a depth-buffer attached? (useful only if you're doing 3D OpenGL on the rendertexture)
    # 
    # *Returns*: A new RenderTexture object, or NULL if it failed
    def initialize(width: Int32, height: Int32, depth_buffer: Bool)
      depth_buffer = depth_buffer ? 1 : 0
      @owned = true
      @this = CSFML.render_texture_create(width, height, depth_buffer)
    end
    
    # Destroy an existing render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture to destroy
    def finalize()
      CSFML.render_texture_destroy(@this) if @owned
    end
    
    # Get the size of the rendering region of a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # 
    # *Returns*: Size in pixels
    def size
      CSFML.render_texture_get_size(@this)
    end
    
    # Activate or deactivate a render texture as the current target for rendering
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `active`: True to activate, False to deactivate
    # 
    # *Returns*: True if operation was successful, false otherwise
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.render_texture_set_active(@this, active) != 0
    end
    
    # Update the contents of the target texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    def display()
      CSFML.render_texture_display(@this)
    end
    
    # Clear the rendertexture with the given color
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `color`: Fill color
    def clear(color: Color)
      CSFML.render_texture_clear(@this, color)
    end
    
    # Change the current active view of a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `view`: Pointer to the new view
    def view=(view: View)
      CSFML.render_texture_set_view(@this, view)
    end
    
    # Get the current active view of a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # 
    # *Returns*: Current active view
    def view
      result = View.allocate()
      result.wrap_ptr(CSFML.render_texture_get_view(@this))
    end
    
    # Get the default view of a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # 
    # *Returns*: Default view of the rendertexture
    def default_view
      result = View.allocate()
      result.wrap_ptr(CSFML.render_texture_get_default_view(@this))
    end
    
    # Get the viewport of a view applied to this target
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `view`: Target view
    # 
    # *Returns*: Viewport rectangle, expressed in pixels in the current target
    def get_viewport(view: View)
      CSFML.render_texture_get_viewport(@this, view)
    end
    
    # Convert a point from texture coordinates to world coordinates
    # 
    # This function finds the 2D position that matches the
    # given pixel of the render-texture. In other words, it does
    # the inverse of what the graphics card does, to find the
    # initial position of a rendered pixel.
    # 
    # Initially, both coordinate systems (world units and target pixels)
    # match perfectly. But if you define a custom view or resize your
    # render-texture, this assertion is not true anymore, ie. a point
    # located at (10, 50) in your render-texture may map to the point
    # (150, 75) in your 2D world -- if the view is translated by (140, 25).
    # 
    # This version uses a custom view for calculations, see the other
    # overload of the function if you want to use the current view of the
    # render-texture.
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `point`: Pixel to convert
    # * `view`: The view to use for converting the point
    # 
    # *Returns*: The converted point, in "world" units
    def map_pixel_to_coords(point: Vector2i, view: View)
      CSFML.render_texture_map_pixel_to_coords(@this, point, view)
    end
    
    # Convert a point from world coordinates to texture coordinates
    # 
    # This function finds the pixel of the render-texture that matches
    # the given 2D point. In other words, it goes through the same process
    # as the graphics card, to compute the final position of a rendered point.
    # 
    # Initially, both coordinate systems (world units and target pixels)
    # match perfectly. But if you define a custom view or resize your
    # render-texture, this assertion is not true anymore, ie. a point
    # located at (150, 75) in your 2D world may map to the pixel
    # (10, 50) of your render-texture -- if the view is translated by (140, 25).
    # 
    # This version uses a custom view for calculations, see the other
    # overload of the function if you want to use the current view of the
    # render-texture.
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `point`: Point to convert
    # * `view`: The view to use for converting the point
    # 
    # *Returns*: The converted point, in target coordinates (pixels)
    def map_coords_to_pixel(point: Vector2f, view: View)
      CSFML.render_texture_map_coords_to_pixel(@this, point, view)
    end
    
    # Draw a drawable object to the render-target
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `object`: Object to draw
    # * `states`: Render states to use for drawing (NULL to use the default states)
    def draw_sprite(object: Sprite, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_sprite(@this, object, pstates)
    end
    
    def draw_text(object: Text, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_text(@this, object, pstates)
    end
    
    def draw_shape(object: Shape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_shape(@this, object, pstates)
    end
    
    def draw_circle_shape(object: CircleShape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_circle_shape(@this, object, pstates)
    end
    
    def draw_convex_shape(object: ConvexShape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_convex_shape(@this, object, pstates)
    end
    
    def draw_rectangle_shape(object: RectangleShape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_rectangle_shape(@this, object, pstates)
    end
    
    def draw_vertex_array(object: VertexArray, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_vertex_array(@this, object, pstates)
    end
    
    # Draw primitives defined by an array of vertices to a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `vertices`: Pointer to the vertices
    # * `vertex_count`: Number of vertices in the array
    # * `type`: Type of primitives to draw
    # * `states`: Render states to use for drawing (NULL to use the default states)
    def draw_primitives(vertices, vertex_count: Int32, type: PrimitiveType, states)
      if vertices
        cvertices = vertices; pvertices = pointerof(cvertices)
      else
        pvertices = nil
      end
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_texture_draw_primitives(@this, pvertices, vertex_count, type, pstates)
    end
    
    # Save the current OpenGL render states and matrices
    # 
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering. Combined with pop_gl_states,
    # it ensures that:
    # - SFML's internal states are not messed up by your OpenGL code
    # - your OpenGL states are not modified by a call to a SFML function
    # 
    # Note that this function is quite expensive: it saves all the
    # possible OpenGL states and matrices, even the ones you
    # don't care about. Therefore it should be used wisely.
    # It is provided for convenience, but the best results will
    # be achieved if you handle OpenGL states yourself (because
    # you know which states have really changed, and need to be
    # saved and restored). Take a look at the reset_gl_states
    # function if you do so.
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    def push_gl_states()
      CSFML.render_texture_push_gl_states(@this)
    end
    
    # Restore the previously saved OpenGL render states and matrices
    # 
    # See the description of push_gl_states to get a detailed
    # description of these functions.
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    def pop_gl_states()
      CSFML.render_texture_pop_gl_states(@this)
    end
    
    # Reset the internal OpenGL states so that the target is ready for drawing
    # 
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering, if you choose not to use
    # push_gl_states/pop_gl_states. It makes sure that all OpenGL
    # states needed by SFML are set, so that subsequent RenderTexture_draw*()
    # calls will work as expected.
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    def reset_gl_states()
      CSFML.render_texture_reset_gl_states(@this)
    end
    
    # Get the target texture of a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # 
    # *Returns*: Pointer to the target texture
    def texture
      result = Texture.allocate()
      result.wrap_ptr(CSFML.render_texture_get_texture(@this))
    end
    
    # Enable or disable the smooth filter on a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `smooth`: True to enable smoothing, False to disable it
    def smooth=(smooth: Bool)
      smooth = smooth ? 1 : 0
      CSFML.render_texture_set_smooth(@this, smooth)
    end
    
    # Tell whether the smooth filter is enabled or not for a render texture
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # 
    # *Returns*: True if smoothing is enabled, False if it is disabled
    def smooth?
      CSFML.render_texture_is_smooth(@this) != 0
    end
    
    # Enable or disable texture repeating
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # * `repeated`: True to enable repeating, False to disable it
    def repeated=(repeated: Bool)
      repeated = repeated ? 1 : 0
      CSFML.render_texture_set_repeated(@this, repeated)
    end
    
    # Tell whether the texture is repeated or not
    # 
    # *Arguments*:
    # 
    # * `render_texture`: Render texture object
    # 
    # *Returns*: True if repeat mode is enabled, False if it is disabled
    def repeated?
      CSFML.render_texture_is_repeated(@this) != 0
    end
    
  end

  class RenderWindow
    include Wrapper
    
    # Construct a new render window (with a UTF-32 title)
    # 
    # *Arguments*:
    # 
    # * `mode`: Video mode to use
    # * `title`: Title of the window (UTF-32)
    # * `style`: Window style
    # * `settings`: Creation settings (pass NULL to use default values)
    def initialize(mode: VideoMode, title: String, style: WindowStyle, settings)
      title = title.chars; title << '\0'
      if settings
        csettings = settings; psettings = pointerof(csettings)
      else
        psettings = nil
      end
      @owned = true
      @this = CSFML.render_window_create_unicode(mode, title, style, psettings)
    end
    
    # Construct a render window from an existing control
    # 
    # *Arguments*:
    # 
    # * `handle`: Platform-specific handle of the control
    # * `settings`: Creation settings (pass NULL to use default values)
    def initialize(handle: WindowHandle, settings)
      if settings
        csettings = settings; psettings = pointerof(csettings)
      else
        psettings = nil
      end
      @owned = true
      @this = CSFML.render_window_create_from_handle(handle, psettings)
    end
    
    # Destroy an existing render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window to destroy
    def finalize()
      CSFML.render_window_destroy(@this) if @owned
    end
    
    # Close a render window (but doesn't destroy the internal data)
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window to close
    def close()
      CSFML.render_window_close(@this)
    end
    
    # Tell whether or not a render window is opened
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    def open?
      CSFML.render_window_is_open(@this) != 0
    end
    
    # Get the creation settings of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # 
    # *Returns*: Settings used to create the window
    def settings
      CSFML.render_window_get_settings(@this)
    end
    
    # Get the event on top of event queue of a render window, if any, and pop it
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `event`: Event to fill, if any
    # 
    # *Returns*: True if an event was returned, False if event queue was empty
    def poll_event(event: Event*)
      CSFML.render_window_poll_event(@this, event) != 0
    end
    
    # Wait for an event and return it
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `event`: Event to fill
    # 
    # *Returns*: False if an error occured
    def wait_event(event: Event*)
      CSFML.render_window_wait_event(@this, event) != 0
    end
    
    # Get the position of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # 
    # *Returns*: Position in pixels
    def position
      CSFML.render_window_get_position(@this)
    end
    
    # Change the position of a render window on screen
    # 
    # Only works for top-level windows
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `position`: New position, in pixels
    def position=(position: Vector2i)
      CSFML.render_window_set_position(@this, position)
    end
    
    # Get the size of the rendering region of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # 
    # *Returns*: Size in pixels
    def size
      CSFML.render_window_get_size(@this)
    end
    
    # Change the size of the rendering region of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `size`: New size, in pixels
    def size=(size: Vector2i)
      CSFML.render_window_set_size(@this, size)
    end
    
    # Change the title of a render window (with a UTF-32 string)
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `title`: New title
    def title=(title: String)
      title = title.chars; title << '\0'
      CSFML.render_window_set_unicode_title(@this, title)
    end
    
    # Change a render window's icon
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `width`: Icon's width, in pixels
    # * `height`: Icon's height, in pixels
    # * `pixels`: Pointer to the pixels in memory, format must be RGBA 32 bits
    def set_icon(width: Int32, height: Int32, pixels)
      if pixels
        cpixels = pixels; ppixels = pointerof(cpixels)
      else
        ppixels = nil
      end
      CSFML.render_window_set_icon(@this, width, height, ppixels)
    end
    
    # Show or hide a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `visible`: True to show the window, False to hide it
    def visible=(visible: Bool)
      visible = visible ? 1 : 0
      CSFML.render_window_set_visible(@this, visible)
    end
    
    # Show or hide the mouse cursor on a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `show`: True to show, False to hide
    def mouse_cursor_visible=(show: Bool)
      show = show ? 1 : 0
      CSFML.render_window_set_mouse_cursor_visible(@this, show)
    end
    
    # Enable / disable vertical synchronization on a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `enabled`: True to enable v-sync, False to deactivate
    def vertical_sync_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.render_window_set_vertical_sync_enabled(@this, enabled)
    end
    
    # Enable or disable automatic key-repeat for keydown events
    # 
    # Automatic key-repeat is enabled by default
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `enabled`: True to enable, False to disable
    def key_repeat_enabled=(enabled: Bool)
      enabled = enabled ? 1 : 0
      CSFML.render_window_set_key_repeat_enabled(@this, enabled)
    end
    
    # Activate or deactivate a render window as the current target for rendering
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `active`: True to activate, False to deactivate
    # 
    # *Returns*: True if operation was successful, false otherwise
    def active=(active: Bool)
      active = active ? 1 : 0
      CSFML.render_window_set_active(@this, active) != 0
    end
    
    # Request the current render window to be made the active
    # foreground window
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or mouse events.
    # If a window requests focus, it only hints to the operating
    # system, that it would like to be focused. The operating system
    # is free to deny the request.
    # This is not to be confused with Window_setActive().
    def request_focus()
      CSFML.render_window_request_focus(@this)
    end
    
    # Check whether the render window has the input focus
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or most mouse
    # events.
    # 
    # *Returns*: True if window has focus, false otherwise
    def has_focus()
      CSFML.render_window_has_focus(@this) != 0
    end
    
    # Display a render window on screen
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    def display()
      CSFML.render_window_display(@this)
    end
    
    # Limit the framerate to a maximum fixed frequency for a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `limit`: Framerate limit, in frames per seconds (use 0 to disable limit)
    def framerate_limit=(limit: Int32)
      CSFML.render_window_set_framerate_limit(@this, limit)
    end
    
    # Change the joystick threshold, ie. the value below which no move event will be generated
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `threshold`: New threshold, in range [0, 100]
    def joystick_threshold=(threshold)
      threshold = threshold.to_f32
      CSFML.render_window_set_joystick_threshold(@this, threshold)
    end
    
    # Retrieve the OS-specific handle of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # 
    # *Returns*: Window handle
    def system_handle
      CSFML.render_window_get_system_handle(@this)
    end
    
    # Clear a render window with the given color
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `color`: Fill color
    def clear(color: Color)
      CSFML.render_window_clear(@this, color)
    end
    
    # Change the current active view of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `view`: Pointer to the new view
    def view=(view: View)
      CSFML.render_window_set_view(@this, view)
    end
    
    # Get the current active view of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # 
    # *Returns*: Current active view
    def view
      result = View.allocate()
      result.wrap_ptr(CSFML.render_window_get_view(@this))
    end
    
    # Get the default view of a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # 
    # *Returns*: Default view of the render window
    def default_view
      result = View.allocate()
      result.wrap_ptr(CSFML.render_window_get_default_view(@this))
    end
    
    # Get the viewport of a view applied to this target
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `view`: Target view
    # 
    # *Returns*: Viewport rectangle, expressed in pixels in the current target
    def get_viewport(view: View)
      CSFML.render_window_get_viewport(@this, view)
    end
    
    # Convert a point from window coordinates to world coordinates
    # 
    # This function finds the 2D position that matches the
    # given pixel of the render-window. In other words, it does
    # the inverse of what the graphics card does, to find the
    # initial position of a rendered pixel.
    # 
    # Initially, both coordinate systems (world units and target pixels)
    # match perfectly. But if you define a custom view or resize your
    # render-window, this assertion is not true anymore, ie. a point
    # located at (10, 50) in your render-window may map to the point
    # (150, 75) in your 2D world -- if the view is translated by (140, 25).
    # 
    # This function is typically used to find which point (or object) is
    # located below the mouse cursor.
    # 
    # This version uses a custom view for calculations, see the other
    # overload of the function if you want to use the current view of the
    # render-window.
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `point`: Pixel to convert
    # * `view`: The view to use for converting the point
    # 
    # *Returns*: The converted point, in "world" units
    def map_pixel_to_coords(point: Vector2i, view: View)
      CSFML.render_window_map_pixel_to_coords(@this, point, view)
    end
    
    # Convert a point from world coordinates to window coordinates
    # 
    # This function finds the pixel of the render-window that matches
    # the given 2D point. In other words, it goes through the same process
    # as the graphics card, to compute the final position of a rendered point.
    # 
    # Initially, both coordinate systems (world units and target pixels)
    # match perfectly. But if you define a custom view or resize your
    # render-window, this assertion is not true anymore, ie. a point
    # located at (150, 75) in your 2D world may map to the pixel
    # (10, 50) of your render-window -- if the view is translated by (140, 25).
    # 
    # This version uses a custom view for calculations, see the other
    # overload of the function if you want to use the current view of the
    # render-window.
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # * `point`: Point to convert
    # * `view`: The view to use for converting the point
    # 
    # *Returns*: The converted point, in target coordinates (pixels)
    def map_coords_to_pixel(point: Vector2f, view: View)
      CSFML.render_window_map_coords_to_pixel(@this, point, view)
    end
    
    # Draw a drawable object to the render-target
    # 
    # *Arguments*:
    # 
    # * `render_window`: render window object
    # * `object`: Object to draw
    # * `states`: Render states to use for drawing (NULL to use the default states)
    def draw_sprite(object: Sprite, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_sprite(@this, object, pstates)
    end
    
    def draw_text(object: Text, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_text(@this, object, pstates)
    end
    
    def draw_shape(object: Shape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_shape(@this, object, pstates)
    end
    
    def draw_circle_shape(object: CircleShape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_circle_shape(@this, object, pstates)
    end
    
    def draw_convex_shape(object: ConvexShape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_convex_shape(@this, object, pstates)
    end
    
    def draw_rectangle_shape(object: RectangleShape, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_rectangle_shape(@this, object, pstates)
    end
    
    def draw_vertex_array(object: VertexArray, states)
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_vertex_array(@this, object, pstates)
    end
    
    # Draw primitives defined by an array of vertices to a render window
    # 
    # *Arguments*:
    # 
    # * `render_window`: render window object
    # * `vertices`: Pointer to the vertices
    # * `vertex_count`: Number of vertices in the array
    # * `type`: Type of primitives to draw
    # * `states`: Render states to use for drawing (NULL to use the default states)
    def draw_primitives(vertices, vertex_count: Int32, type: PrimitiveType, states)
      if vertices
        cvertices = vertices; pvertices = pointerof(cvertices)
      else
        pvertices = nil
      end
      if states
        cstates = states; pstates = pointerof(cstates)
      else
        pstates = nil
      end
      CSFML.render_window_draw_primitives(@this, pvertices, vertex_count, type, pstates)
    end
    
    # Save the current OpenGL render states and matrices
    # 
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering. Combined with pop_gl_states,
    # it ensures that:
    # - SFML's internal states are not messed up by your OpenGL code
    # - your OpenGL states are not modified by a call to a SFML function
    # 
    # Note that this function is quite expensive: it saves all the
    # possible OpenGL states and matrices, even the ones you
    # don't care about. Therefore it should be used wisely.
    # It is provided for convenience, but the best results will
    # be achieved if you handle OpenGL states yourself (because
    # you know which states have really changed, and need to be
    # saved and restored). Take a look at the reset_gl_states
    # function if you do so.
    # 
    # *Arguments*:
    # 
    # * `render_window`: render window object
    def push_gl_states()
      CSFML.render_window_push_gl_states(@this)
    end
    
    # Restore the previously saved OpenGL render states and matrices
    # 
    # See the description of push_gl_states to get a detailed
    # description of these functions.
    # 
    # *Arguments*:
    # 
    # * `render_window`: render window object
    def pop_gl_states()
      CSFML.render_window_pop_gl_states(@this)
    end
    
    # Reset the internal OpenGL states so that the target is ready for drawing
    # 
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering, if you choose not to use
    # push_gl_states/pop_gl_states. It makes sure that all OpenGL
    # states needed by SFML are set, so that subsequent RenderWindow_draw*()
    # calls will work as expected.
    # 
    # *Arguments*:
    # 
    # * `render_window`: render window object
    def reset_gl_states()
      CSFML.render_window_reset_gl_states(@this)
    end
    
    # Copy the current contents of a render window to an image
    # 
    # This is a slow operation, whose main purpose is to make
    # screenshots of the application. If you want to update an
    # image with the contents of the window and then use it for
    # drawing, you should rather use a Texture and its
    # update(Window*) function.
    # You can also draw things directly to a texture with the
    # RenderWindow class.
    # 
    # *Arguments*:
    # 
    # * `render_window`: Render window object
    # 
    # *Returns*: New image containing the captured contents
    def capture()
      result = Image.allocate()
      result.wrap_ptr(CSFML.render_window_capture(@this))
    end
    
  end

  class Shape
    include Wrapper
    
    # Create a new shape
    # 
    # *Arguments*:
    # 
    # * `get_point_count`: Callback that provides the point count of the shape
    # * `get_point`: Callback that provides the points of the shape
    # * `user_data`: Data to pass to the callback functions
    # 
    # *Returns*: A new Shape object
    def initialize(get_point_count: ShapeGetPointCountCallback, get_point: ShapeGetPointCallback, user_data: Void*)
      @owned = true
      @this = CSFML.shape_create(get_point_count, get_point, user_data)
    end
    
    # Destroy an existing shape
    # 
    # *Arguments*:
    # 
    # * `Shape`: Shape to delete
    def finalize()
      CSFML.shape_destroy(@this) if @owned
    end
    
    # Set the position of a shape
    # 
    # This function completely overwrites the previous position.
    # See Shape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `position`: New position
    def position=(position: Vector2f)
      CSFML.shape_set_position(@this, position)
    end
    
    # Set the orientation of a shape
    # 
    # This function completely overwrites the previous rotation.
    # See Shape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: New rotation, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.shape_set_rotation(@this, angle)
    end
    
    # Set the scale factors of a shape
    # 
    # This function completely overwrites the previous scale.
    # See Shape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `scale`: New scale factors
    def scale=(scale: Vector2f)
      CSFML.shape_set_scale(@this, scale)
    end
    
    # Set the local origin of a shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `origin`: New origin
    def origin=(origin: Vector2f)
      CSFML.shape_set_origin(@this, origin)
    end
    
    # Get the position of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current position
    def position
      CSFML.shape_get_position(@this)
    end
    
    # Get the orientation of a shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current rotation, in degrees
    def rotation
      CSFML.shape_get_rotation(@this)
    end
    
    # Get the current scale of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current scale factors
    def scale
      CSFML.shape_get_scale(@this)
    end
    
    # Get the local origin of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Current origin
    def origin
      CSFML.shape_get_origin(@this)
    end
    
    # Move a shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Shape_setPosition which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.shape_move(@this, offset)
    end
    
    # Rotate a shape
    # 
    # This function adds to the current rotation of the object,
    # unlike Shape_setRotation which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `angle`: Angle of rotation, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.shape_rotate(@this, angle)
    end
    
    # Scale a shape
    # 
    # This function multiplies the current scale of the object,
    # unlike Shape_setScale which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `factors`: Scale factors
    def scale(factors: Vector2f)
      CSFML.shape_scale(@this, factors)
    end
    
    # Get the combined transform of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: shape object
    # 
    # *Returns*: Transform combining the position/rotation/scale/origin of the object
    def transform
      CSFML.shape_get_transform(@this)
    end
    
    # Get the inverse of the combined transform of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: shape object
    # 
    # *Returns*: Inverse of the combined transformations applied to the object
    def inverse_transform
      CSFML.shape_get_inverse_transform(@this)
    end
    
    # Change the source texture of a shape
    # 
    # The `texture` argument refers to a texture that must
    # exist as long as the shape uses it. Indeed, the shape
    # doesn't store its own copy of the texture, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the source texture is destroyed and the shape tries to
    # use it, the behaviour is undefined.
    # `texture` can be NULL to disable texturing.
    # If `reset_rect` is true, the TextureRect property of
    # the shape is automatically adjusted to the size of the new
    # texture. If it is false, the texture rect is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `texture`: New texture
    # * `reset_rect`: Should the texture rect be reset to the size of the new texture?
    def set_texture(texture: Texture, reset_rect: Bool)
      reset_rect = reset_rect ? 1 : 0
      CSFML.shape_set_texture(@this, texture, reset_rect)
    end
    
    # Set the sub-rectangle of the texture that a shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `rect`: Rectangle defining the region of the texture to display
    def texture_rect=(rect: IntRect)
      CSFML.shape_set_texture_rect(@this, rect)
    end
    
    # Set the fill color of a shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New color of the shape
    def fill_color=(color: Color)
      CSFML.shape_set_fill_color(@this, color)
    end
    
    # Set the outline color of a shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `color`: New outline color of the shape
    def outline_color=(color: Color)
      CSFML.shape_set_outline_color(@this, color)
    end
    
    # Set the thickness of a shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `thickness`: New outline thickness
    def outline_thickness=(thickness)
      thickness = thickness.to_f32
      CSFML.shape_set_outline_thickness(@this, thickness)
    end
    
    # Get the source texture of a shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Pointer to the shape's texture
    def texture
      result = Texture.allocate()
      result.wrap_ptr(CSFML.shape_get_texture(@this))
    end
    
    # Get the sub-rectangle of the texture displayed by a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Texture rectangle of the shape
    def texture_rect
      CSFML.shape_get_texture_rect(@this)
    end
    
    # Get the fill color of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Fill color of the shape
    def fill_color
      CSFML.shape_get_fill_color(@this)
    end
    
    # Get the outline color of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline color of the shape
    def outline_color
      CSFML.shape_get_outline_color(@this)
    end
    
    # Get the outline thickness of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Outline thickness of the shape
    def outline_thickness
      CSFML.shape_get_outline_thickness(@this)
    end
    
    # Get the total number of points of a shape
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Number of points of the shape
    def point_count
      CSFML.shape_get_point_count(@this)
    end
    
    # Get a point of a shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # * `index`: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # *Returns*: Index-th point of the shape
    def get_point(index: Int32)
      CSFML.shape_get_point(@this, index)
    end
    
    # Get the local bounding rectangle of a shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Local bounding rectangle of the entity
    def local_bounds
      CSFML.shape_get_local_bounds(@this)
    end
    
    # Get the global bounding rectangle of a shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `shape`: Shape object
    # 
    # *Returns*: Global bounding rectangle of the entity
    def global_bounds
      CSFML.shape_get_global_bounds(@this)
    end
    
    # Recompute the internal geometry of a shape
    # 
    # This function must be called by specialized shape objects
    # everytime their points change (ie. the result of either
    # the get_point_count or get_point callbacks is different).
    def update()
      CSFML.shape_update(@this)
    end
    
  end

  class Sprite
    include Wrapper
    
    # Create a new sprite
    # 
    # *Returns*: A new Sprite object, or NULL if it failed
    def initialize()
      @owned = true
      @this = CSFML.sprite_create()
    end
    
    # Copy an existing sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = Sprite.allocate()
      result.transfer_ptr(CSFML.sprite_copy(@this))
    end
    
    # Destroy an existing sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite to delete
    def finalize()
      CSFML.sprite_destroy(@this) if @owned
    end
    
    # Set the position of a sprite
    # 
    # This function completely overwrites the previous position.
    # See Sprite_move to apply an offset based on the previous position instead.
    # The default position of a sprite Sprite object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `position`: New position
    def position=(position: Vector2f)
      CSFML.sprite_set_position(@this, position)
    end
    
    # Set the orientation of a sprite
    # 
    # This function completely overwrites the previous rotation.
    # See Sprite_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a sprite Sprite object is 0.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `angle`: New rotation, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.sprite_set_rotation(@this, angle)
    end
    
    # Set the scale factors of a sprite
    # 
    # This function completely overwrites the previous scale.
    # See Sprite_scale to add a factor based on the previous scale instead.
    # The default scale of a sprite Sprite object is (1, 1).
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `scale`: New scale factors
    def scale=(scale: Vector2f)
      CSFML.sprite_set_scale(@this, scale)
    end
    
    # Set the local origin of a sprite
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a sprite Sprite object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `origin`: New origin
    def origin=(origin: Vector2f)
      CSFML.sprite_set_origin(@this, origin)
    end
    
    # Get the position of a sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Current position
    def position
      CSFML.sprite_get_position(@this)
    end
    
    # Get the orientation of a sprite
    # 
    # The rotation is always in the range [0, 360].
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Current rotation, in degrees
    def rotation
      CSFML.sprite_get_rotation(@this)
    end
    
    # Get the current scale of a sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Current scale factors
    def scale
      CSFML.sprite_get_scale(@this)
    end
    
    # Get the local origin of a sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Current origin
    def origin
      CSFML.sprite_get_origin(@this)
    end
    
    # Move a sprite by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Sprite_setPosition which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.sprite_move(@this, offset)
    end
    
    # Rotate a sprite
    # 
    # This function adds to the current rotation of the object,
    # unlike Sprite_setRotation which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `angle`: Angle of rotation, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.sprite_rotate(@this, angle)
    end
    
    # Scale a sprite
    # 
    # This function multiplies the current scale of the object,
    # unlike Sprite_setScale which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `factors`: Scale factors
    def scale(factors: Vector2f)
      CSFML.sprite_scale(@this, factors)
    end
    
    # Get the combined transform of a sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Transform combining the position/rotation/scale/origin of the object
    def transform
      CSFML.sprite_get_transform(@this)
    end
    
    # Get the inverse of the combined transform of a sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Inverse of the combined transformations applied to the object
    def inverse_transform
      CSFML.sprite_get_inverse_transform(@this)
    end
    
    # Change the source texture of a sprite
    # 
    # The `texture` argument refers to a texture that must
    # exist as long as the sprite uses it. Indeed, the sprite
    # doesn't store its own copy of the texture, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the source texture is destroyed and the sprite tries to
    # use it, the behaviour is undefined.
    # If `reset_rect` is true, the TextureRect property of
    # the sprite is automatically adjusted to the size of the new
    # texture. If it is false, the texture rect is left unchanged.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `texture`: New texture
    # * `reset_rect`: Should the texture rect be reset to the size of the new texture?
    def set_texture(texture: Texture, reset_rect: Bool)
      reset_rect = reset_rect ? 1 : 0
      CSFML.sprite_set_texture(@this, texture, reset_rect)
    end
    
    # Set the sub-rectangle of the texture that a sprite will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `rectangle`: Rectangle defining the region of the texture to display
    def texture_rect=(rectangle: IntRect)
      CSFML.sprite_set_texture_rect(@this, rectangle)
    end
    
    # Set the global color of a sprite
    # 
    # This color is modulated (multiplied) with the sprite's
    # texture. It can be used to colorize the sprite, or change
    # its global opacity.
    # By default, the sprite's color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # * `color`: New color of the sprite
    def color=(color: Color)
      CSFML.sprite_set_color(@this, color)
    end
    
    # Get the source texture of a sprite
    # 
    # If the sprite has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Pointer to the sprite's texture
    def texture
      result = Texture.allocate()
      result.wrap_ptr(CSFML.sprite_get_texture(@this))
    end
    
    # Get the sub-rectangle of the texture displayed by a sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Texture rectangle of the sprite
    def texture_rect
      CSFML.sprite_get_texture_rect(@this)
    end
    
    # Get the global color of a sprite
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Global color of the sprite
    def color
      CSFML.sprite_get_color(@this)
    end
    
    # Get the local bounding rectangle of a sprite
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Local bounding rectangle of the entity
    def local_bounds
      CSFML.sprite_get_local_bounds(@this)
    end
    
    # Get the global bounding rectangle of a sprite
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `sprite`: Sprite object
    # 
    # *Returns*: Global bounding rectangle of the entity
    def global_bounds
      CSFML.sprite_get_global_bounds(@this)
    end
    
  end

  class Text
    include Wrapper
    
    Regular = CSFML::TextStyle::Regular
    Bold = CSFML::TextStyle::Bold
    Italic = CSFML::TextStyle::Italic
    Underlined = CSFML::TextStyle::Underlined
    StrikeThrough = CSFML::TextStyle::StrikeThrough
    # Create a new text
    # 
    # *Returns*: A new Text object, or NULL if it failed
    def initialize()
      @owned = true
      @this = CSFML.text_create()
    end
    
    # Copy an existing text
    # 
    # *Arguments*:
    # 
    # * `text`: Text to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = Text.allocate()
      result.transfer_ptr(CSFML.text_copy(@this))
    end
    
    # Destroy an existing text
    # 
    # *Arguments*:
    # 
    # * `text`: Text to delete
    def finalize()
      CSFML.text_destroy(@this) if @owned
    end
    
    # Set the position of a text
    # 
    # This function completely overwrites the previous position.
    # See Text_move to apply an offset based on the previous position instead.
    # The default position of a text Text object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `position`: New position
    def position=(position: Vector2f)
      CSFML.text_set_position(@this, position)
    end
    
    # Set the orientation of a text
    # 
    # This function completely overwrites the previous rotation.
    # See Text_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a text Text object is 0.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `angle`: New rotation, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.text_set_rotation(@this, angle)
    end
    
    # Set the scale factors of a text
    # 
    # This function completely overwrites the previous scale.
    # See Text_scale to add a factor based on the previous scale instead.
    # The default scale of a text Text object is (1, 1).
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `scale`: New scale factors
    def scale=(scale: Vector2f)
      CSFML.text_set_scale(@this, scale)
    end
    
    # Set the local origin of a text
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a text object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `origin`: New origin
    def origin=(origin: Vector2f)
      CSFML.text_set_origin(@this, origin)
    end
    
    # Get the position of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Current position
    def position
      CSFML.text_get_position(@this)
    end
    
    # Get the orientation of a text
    # 
    # The rotation is always in the range [0, 360].
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Current rotation, in degrees
    def rotation
      CSFML.text_get_rotation(@this)
    end
    
    # Get the current scale of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Current scale factors
    def scale
      CSFML.text_get_scale(@this)
    end
    
    # Get the local origin of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Current origin
    def origin
      CSFML.text_get_origin(@this)
    end
    
    # Move a text by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Text_setPosition which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.text_move(@this, offset)
    end
    
    # Rotate a text
    # 
    # This function adds to the current rotation of the object,
    # unlike Text_setRotation which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `angle`: Angle of rotation, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.text_rotate(@this, angle)
    end
    
    # Scale a text
    # 
    # This function multiplies the current scale of the object,
    # unlike Text_setScale which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `factors`: Scale factors
    def scale(factors: Vector2f)
      CSFML.text_scale(@this, factors)
    end
    
    # Get the combined transform of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Transform combining the position/rotation/scale/origin of the object
    def transform
      CSFML.text_get_transform(@this)
    end
    
    # Get the inverse of the combined transform of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Inverse of the combined transformations applied to the object
    def inverse_transform
      CSFML.text_get_inverse_transform(@this)
    end
    
    # Set the string of a text (from a unicode string)
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `string`: New string
    def string=(string: String)
      string = string.chars; string << '\0'
      CSFML.text_set_unicode_string(@this, string)
    end
    
    # Set the font of a text
    # 
    # The `font` argument refers to a texture that must
    # exist as long as the text uses it. Indeed, the text
    # doesn't store its own copy of the font, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the font is destroyed and the text tries to
    # use it, the behaviour is undefined.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `font`: New font
    def font=(font: Font)
      CSFML.text_set_font(@this, font)
    end
    
    # Set the character size of a text
    # 
    # The default size is 30.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `size`: New character size, in pixels
    def character_size=(size: Int32)
      CSFML.text_set_character_size(@this, size)
    end
    
    # Set the style of a text
    # 
    # You can pass a combination of one or more styles, for
    # example TextBold | TextItalic.
    # The default style is TextRegular.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `style`: New style
    def style=(style: TextStyle)
      CSFML.text_set_style(@this, style)
    end
    
    # Set the global color of a text
    # 
    # By default, the text's color is opaque white.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `color`: New color of the text
    def color=(color: Color)
      CSFML.text_set_color(@this, color)
    end
    
    # Get the string of a text (returns a unicode string)
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: String as UTF-32
    def string
      ptr = CSFML.text_get_unicode_string(@this)
      result = ""; i = 0
      while ptr[i] != '\0'
        result += ptr[i]; i += 1
      end
      result
    end
    
    # Get the font used by a text
    # 
    # If the text has no font attached, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the font when you retrieve it with this function.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Pointer to the font
    def font
      result = Font.allocate()
      result.wrap_ptr(CSFML.text_get_font(@this))
    end
    
    # Get the size of the characters of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Size of the characters
    def character_size
      CSFML.text_get_character_size(@this)
    end
    
    # Get the style of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Current string style (see TextStyle enum)
    def style
      CSFML.text_get_style(@this)
    end
    
    # Get the global color of a text
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Global color of the text
    def color
      CSFML.text_get_color(@this)
    end
    
    # Return the position of the `index`-th character in a text
    # 
    # This function computes the visual position of a character
    # from its index in the string. The returned position is
    # in global coordinates (translation, rotation, scale and
    # origin are applied).
    # If `index` is out of range, the position of the end of
    # the string is returned.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # * `index`: Index of the character
    # 
    # *Returns*: Position of the character
    def find_character_pos(index: Size_t)
      CSFML.text_find_character_pos(@this, index)
    end
    
    # Get the local bounding rectangle of a text
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Local bounding rectangle of the entity
    def local_bounds
      CSFML.text_get_local_bounds(@this)
    end
    
    # Get the global bounding rectangle of a text
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # text in the global 2D world's coordinate system.
    # 
    # *Arguments*:
    # 
    # * `text`: Text object
    # 
    # *Returns*: Global bounding rectangle of the entity
    def global_bounds
      CSFML.text_get_global_bounds(@this)
    end
    
  end

  class Texture
    include Wrapper
    
    # Create a new texture
    # 
    # *Arguments*:
    # 
    # * `width`: Texture width
    # * `height`: Texture height
    # 
    # *Returns*: A new Texture object, or NULL if it failed
    def initialize(width: Int32, height: Int32)
      @owned = true
      @this = CSFML.texture_create(width, height)
    end
    
    # Create a new texture from a file
    # 
    # *Arguments*:
    # 
    # * `filename`: Path of the image file to load
    # * `area`: Area of the source image to load (NULL to load the entire image)
    # 
    # *Returns*: A new Texture object, or NULL if it failed
    def initialize(filename: String, area)
      if area
        carea = area; parea = pointerof(carea)
      else
        parea = nil
      end
      @owned = true
      @this = CSFML.texture_create_from_file(filename, parea)
    end
    
    # Create a new texture from a file in memory
    # 
    # *Arguments*:
    # 
    # * `data`: Pointer to the file data in memory
    # * `size_in_bytes`: Size of the data to load, in bytes
    # * `area`: Area of the source image to load (NULL to load the entire image)
    # 
    # *Returns*: A new Texture object, or NULL if it failed
    def initialize(data: Void*, size_in_bytes: Size_t, area)
      if area
        carea = area; parea = pointerof(carea)
      else
        parea = nil
      end
      @owned = true
      @this = CSFML.texture_create_from_memory(data, size_in_bytes, parea)
    end
    
    # Create a new texture from a custom stream
    # 
    # *Arguments*:
    # 
    # * `stream`: Source stream to read from
    # * `area`: Area of the source image to load (NULL to load the entire image)
    # 
    # *Returns*: A new Texture object, or NULL if it failed
    def initialize(stream: InputStream*, area)
      if area
        carea = area; parea = pointerof(carea)
      else
        parea = nil
      end
      @owned = true
      @this = CSFML.texture_create_from_stream(stream, parea)
    end
    
    # Create a new texture from an image
    # 
    # *Arguments*:
    # 
    # * `image`: Image to upload to the texture
    # * `area`: Area of the source image to load (NULL to load the entire image)
    # 
    # *Returns*: A new Texture object, or NULL if it failed
    def initialize(image: Image, area)
      if area
        carea = area; parea = pointerof(carea)
      else
        parea = nil
      end
      @owned = true
      @this = CSFML.texture_create_from_image(image, parea)
    end
    
    # Copy an existing texture
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = Texture.allocate()
      result.transfer_ptr(CSFML.texture_copy(@this))
    end
    
    # Destroy an existing texture
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to delete
    def finalize()
      CSFML.texture_destroy(@this) if @owned
    end
    
    # Return the size of the texture
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to read
    # 
    # *Returns*: Size in pixels
    def size
      CSFML.texture_get_size(@this)
    end
    
    # Copy a texture's pixels to an image
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to copy
    # 
    # *Returns*: Image containing the texture's pixels
    def copy_to_image()
      result = Image.allocate()
      result.wrap_ptr(CSFML.texture_copy_to_image(@this))
    end
    
    # Update a texture from an array of pixels
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to update
    # * `pixels`: Array of pixels to copy to the texture
    # * `width`: Width of the pixel region contained in `pixels`
    # * `height`: Height of the pixel region contained in `pixels`
    # * `x`: X offset in the texture where to copy the source pixels
    # * `y`: Y offset in the texture where to copy the source pixels
    def update(pixels, width: Int32, height: Int32, x: Int32, y: Int32)
      if pixels
        cpixels = pixels; ppixels = pointerof(cpixels)
      else
        ppixels = nil
      end
      CSFML.texture_update_from_pixels(@this, ppixels, width, height, x, y)
    end
    
    # Update a texture from an image
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to update
    # * `image`: Image to copy to the texture
    # * `x`: X offset in the texture where to copy the source pixels
    # * `y`: Y offset in the texture where to copy the source pixels
    def update(image: Image, x: Int32, y: Int32)
      CSFML.texture_update_from_image(@this, image, x, y)
    end
    
    # Update a texture from the contents of a window
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to update
    # * `window`: Window to copy to the texture
    # * `x`: X offset in the texture where to copy the source pixels
    # * `y`: Y offset in the texture where to copy the source pixels
    def update(window: Window, x: Int32, y: Int32)
      CSFML.texture_update_from_window(@this, window, x, y)
    end
    
    # Update a texture from the contents of a render-window
    # 
    # *Arguments*:
    # 
    # * `texture`: Texture to update
    # * `render_window`: Render-window to copy to the texture
    # * `x`: X offset in the texture where to copy the source pixels
    # * `y`: Y offset in the texture where to copy the source pixels
    def update(render_window: RenderWindow, x: Int32, y: Int32)
      CSFML.texture_update_from_render_window(@this, render_window, x, y)
    end
    
    # Enable or disable the smooth filter on a texture
    # 
    # *Arguments*:
    # 
    # * `texture`: The texture object
    # * `smooth`: True to enable smoothing, False to disable it
    def smooth=(smooth: Bool)
      smooth = smooth ? 1 : 0
      CSFML.texture_set_smooth(@this, smooth)
    end
    
    # Tell whether the smooth filter is enabled or not for a texture
    # 
    # *Arguments*:
    # 
    # * `texture`: The texture object
    # 
    # *Returns*: True if smoothing is enabled, False if it is disabled
    def smooth?
      CSFML.texture_is_smooth(@this) != 0
    end
    
    # Enable or disable repeating for a texture
    # 
    # Repeating is involved when using texture coordinates
    # outside the texture rectangle [0, 0, width, height].
    # In this case, if repeat mode is enabled, the whole texture
    # will be repeated as many times as needed to reach the
    # coordinate (for example, if the X texture coordinate is
    # 3 * width, the texture will be repeated 3 times).
    # If repeat mode is disabled, the "extra space" will instead
    # be filled with border pixels.
    # Warning: on very old graphics cards, white pixels may appear
    # when the texture is repeated. With such cards, repeat mode
    # can be used reliably only if the texture has power-of-two
    # dimensions (such as 256x128).
    # Repeating is disabled by default.
    # 
    # *Arguments*:
    # 
    # * `texture`: The texture object
    # * `repeated`: True to repeat the texture, false to disable repeating
    def repeated=(repeated: Bool)
      repeated = repeated ? 1 : 0
      CSFML.texture_set_repeated(@this, repeated)
    end
    
    # Tell whether a texture is repeated or not
    # 
    # *Arguments*:
    # 
    # * `texture`: The texture object
    # 
    # *Returns*: True if repeat mode is enabled, False if it is disabled
    def repeated?
      CSFML.texture_is_repeated(@this) != 0
    end
    
    # Bind a texture for rendering
    # 
    # This function is not part of the graphics API, it mustn't be
    # used when drawing SFML entities. It must be used only if you
    # mix Texture with OpenGL code.
    # 
    # 
    # *Arguments*:
    # 
    # * `texture`: Pointer to the texture to bind, can be null to use no texture
    def bind()
      CSFML.texture_bind(@this)
    end
    
    # Get the maximum texture size allowed
    # 
    # *Returns*: Maximum size allowed for textures, in pixels
    def self.get_maximum_size()
      CSFML.texture_get_maximum_size()
    end
    
  end

  class Transformable
    include Wrapper
    
    # Create a new transformable
    # 
    # *Returns*: A new Transformable object
    def initialize()
      @owned = true
      @this = CSFML.transformable_create()
    end
    
    # Copy an existing transformable
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = Transformable.allocate()
      result.transfer_ptr(CSFML.transformable_copy(@this))
    end
    
    # Destroy an existing transformable
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable to delete
    def finalize()
      CSFML.transformable_destroy(@this) if @owned
    end
    
    # Set the position of a transformable
    # 
    # This function completely overwrites the previous position.
    # See Transformable_move to apply an offset based on the previous position instead.
    # The default position of a transformable Transformable object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # * `position`: New position
    def position=(position: Vector2f)
      CSFML.transformable_set_position(@this, position)
    end
    
    # Set the orientation of a transformable
    # 
    # This function completely overwrites the previous rotation.
    # See Transformable_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a transformable Transformable object is 0.
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # * `angle`: New rotation, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.transformable_set_rotation(@this, angle)
    end
    
    # Set the scale factors of a transformable
    # 
    # This function completely overwrites the previous scale.
    # See Transformable_scale to add a factor based on the previous scale instead.
    # The default scale of a transformable Transformable object is (1, 1).
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # * `scale`: New scale factors
    def scale=(scale: Vector2f)
      CSFML.transformable_set_scale(@this, scale)
    end
    
    # Set the local origin of a transformable
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a transformable Transformable object is (0, 0).
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # * `origin`: New origin
    def origin=(origin: Vector2f)
      CSFML.transformable_set_origin(@this, origin)
    end
    
    # Get the position of a transformable
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # 
    # *Returns*: Current position
    def position
      CSFML.transformable_get_position(@this)
    end
    
    # Get the orientation of a transformable
    # 
    # The rotation is always in the range [0, 360].
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # 
    # *Returns*: Current rotation, in degrees
    def rotation
      CSFML.transformable_get_rotation(@this)
    end
    
    # Get the current scale of a transformable
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # 
    # *Returns*: Current scale factors
    def scale
      CSFML.transformable_get_scale(@this)
    end
    
    # Get the local origin of a transformable
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # 
    # *Returns*: Current origin
    def origin
      CSFML.transformable_get_origin(@this)
    end
    
    # Move a transformable by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Transformable_setPosition which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.transformable_move(@this, offset)
    end
    
    # Rotate a transformable
    # 
    # This function adds to the current rotation of the object,
    # unlike Transformable_setRotation which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # * `angle`: Angle of rotation, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.transformable_rotate(@this, angle)
    end
    
    # Scale a transformable
    # 
    # This function multiplies the current scale of the object,
    # unlike Transformable_setScale which overwrites it.
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # * `factors`: Scale factors
    def scale(factors: Vector2f)
      CSFML.transformable_scale(@this, factors)
    end
    
    # Get the combined transform of a transformable
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # 
    # *Returns*: Transform combining the position/rotation/scale/origin of the object
    def transform
      CSFML.transformable_get_transform(@this)
    end
    
    # Get the inverse of the combined transform of a transformable
    # 
    # *Arguments*:
    # 
    # * `transformable`: Transformable object
    # 
    # *Returns*: Inverse of the combined transformations applied to the object
    def inverse_transform
      CSFML.transformable_get_inverse_transform(@this)
    end
    
  end

  class VertexArray
    include Wrapper
    
    # Create a new vertex array
    # 
    # *Returns*: A new VertexArray object
    def initialize()
      @owned = true
      @this = CSFML.vertex_array_create()
    end
    
    # Copy an existing vertex array
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = VertexArray.allocate()
      result.transfer_ptr(CSFML.vertex_array_copy(@this))
    end
    
    # Destroy an existing vertex array
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array to delete
    def finalize()
      CSFML.vertex_array_destroy(@this) if @owned
    end
    
    # Return the vertex count of a vertex array
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array object
    # 
    # *Returns*: Number of vertices in the array
    def vertex_count
      CSFML.vertex_array_get_vertex_count(@this)
    end
    
    # Get access to a vertex by its index
    # 
    # This function doesn't check `index`, it must be in range
    # [0, vertex count - 1]. The behaviour is undefined
    # otherwise.
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array object
    # * `index`: Index of the vertex to get
    # 
    # *Returns*: Pointer to the index-th vertex
    def get_vertex(index: Int32)
      CSFML.vertex_array_get_vertex(@this, index)
    end
    
    # Clear a vertex array
    # 
    # This function removes all the vertices from the array.
    # It doesn't deallocate the corresponding memory, so that
    # adding new vertices after clearing doesn't involve
    # reallocating all the memory.
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array object
    def clear()
      CSFML.vertex_array_clear(@this)
    end
    
    # Resize the vertex array
    # 
    # If `vertex_count` is greater than the current size, the previous
    # vertices are kept and new (default-constructed) vertices are
    # added.
    # If `vertex_count` is less than the current size, existing vertices
    # are removed from the array.
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array objet
    # * `vertex_count`: New size of the array (number of vertices)
    def resize(vertex_count: Int32)
      CSFML.vertex_array_resize(@this, vertex_count)
    end
    
    # Add a vertex to a vertex array array
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array objet
    # * `vertex`: Vertex to add
    def append(vertex: Vertex)
      CSFML.vertex_array_append(@this, vertex)
    end
    
    # Set the type of primitives of a vertex array
    # 
    # This function defines how the vertices must be interpreted
    # when it's time to draw them:
    # - As points
    # - As lines
    # - As triangles
    # - As quads
    # The default primitive type is Points.
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array objet
    # * `type`: Type of primitive
    def primitive_type=(type: PrimitiveType)
      CSFML.vertex_array_set_primitive_type(@this, type)
    end
    
    # Get the type of primitives drawn by a vertex array
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array objet
    # 
    # *Returns*: Primitive type
    def primitive_type
      CSFML.vertex_array_get_primitive_type(@this)
    end
    
    # Compute the bounding rectangle of a vertex array
    # 
    # This function returns the axis-aligned rectangle that
    # contains all the vertices of the array.
    # 
    # *Arguments*:
    # 
    # * `vertex_array`: Vertex array objet
    # 
    # *Returns*: Bounding rectangle of the vertex array
    def bounds
      CSFML.vertex_array_get_bounds(@this)
    end
    
  end

  class View
    include Wrapper
    
    # Create a default view
    # 
    # This function creates a default view of (0, 0, 1000, 1000)
    # 
    # *Returns*: A new View object
    def initialize()
      @owned = true
      @this = CSFML.view_create()
    end
    
    # Construct a view from a rectangle
    # 
    # *Arguments*:
    # 
    # * `rectangle`: Rectangle defining the zone to display
    # 
    # *Returns*: A new View object
    def initialize(rectangle: FloatRect)
      @owned = true
      @this = CSFML.view_create_from_rect(rectangle)
    end
    
    # Copy an existing view
    # 
    # *Arguments*:
    # 
    # * `view`: View to copy
    # 
    # *Returns*: Copied object
    def copy()
      result = View.allocate()
      result.transfer_ptr(CSFML.view_copy(@this))
    end
    
    # Destroy an existing view
    # 
    # *Arguments*:
    # 
    # * `view`: View to destroy
    def finalize()
      CSFML.view_destroy(@this) if @owned
    end
    
    # Set the center of a view
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `center`: New center
    def center=(center: Vector2f)
      CSFML.view_set_center(@this, center)
    end
    
    # Set the size of a view
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `size`: New size of the view
    def size=(size: Vector2f)
      CSFML.view_set_size(@this, size)
    end
    
    # Set the orientation of a view
    # 
    # The default rotation of a view is 0 degree.
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `angle`: New angle, in degrees
    def rotation=(angle)
      angle = angle.to_f32
      CSFML.view_set_rotation(@this, angle)
    end
    
    # Set the target viewport of a view
    # 
    # The viewport is the rectangle into which the contents of the
    # view are displayed, expressed as a factor (between 0 and 1)
    # of the size of the render target to which the view is applied.
    # For example, a view which takes the left side of the target would
    # be defined by a rect of (0, 0, 0.5, 1).
    # By default, a view has a viewport which covers the entire target.
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `viewport`: New viewport rectangle
    def viewport=(viewport: FloatRect)
      CSFML.view_set_viewport(@this, viewport)
    end
    
    # Reset a view to the given rectangle
    # 
    # Note that this function resets the rotation angle to 0.
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `rectangle`: Rectangle defining the zone to display
    def reset(rectangle: FloatRect)
      CSFML.view_reset(@this, rectangle)
    end
    
    # Get the center of a view
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # 
    # *Returns*: Center of the view
    def center
      CSFML.view_get_center(@this)
    end
    
    # Get the size of a view
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # 
    # *Returns*: Size of the view
    def size
      CSFML.view_get_size(@this)
    end
    
    # Get the current orientation of a view
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # 
    # *Returns*: Rotation angle of the view, in degrees
    def rotation
      CSFML.view_get_rotation(@this)
    end
    
    # Get the target viewport rectangle of a view
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # 
    # *Returns*: Viewport rectangle, expressed as a factor of the target size
    def viewport
      CSFML.view_get_viewport(@this)
    end
    
    # Move a view relatively to its current position
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `offset`: Offset
    def move(offset: Vector2f)
      CSFML.view_move(@this, offset)
    end
    
    # Rotate a view relatively to its current orientation
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `angle`: Angle to rotate, in degrees
    def rotate(angle)
      angle = angle.to_f32
      CSFML.view_rotate(@this, angle)
    end
    
    # Resize a view rectangle relatively to its current size
    # 
    # Resizing the view simulates a zoom, as the zone displayed on
    # screen grows or shrinks.
    # `factor` is a multiplier:
    # - 1 keeps the size unchanged
    # - > 1 makes the view bigger (objects appear smaller)
    # - < 1 makes the view smaller (objects appear bigger)
    # 
    # *Arguments*:
    # 
    # * `view`: View object
    # * `factor`: Zoom factor to apply
    def zoom(factor)
      factor = factor.to_f32
      CSFML.view_zoom(@this, factor)
    end
    
  end

  # Encapsulate a 3x3 transform matrix
  alias Transform = CSFML::Transform

  struct Transform
    # Return the 4x4 matrix of a transform
    # 
    # This function fills an array of 16 floats with the transform
    # converted as a 4x4 matrix, which is directly compatible with
    # OpenGL functions.
    # 
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `matrix`: Pointer to the 16-element array to fill with the matrix
    def get_matrix(matrix: Float32*)
      cself = self
      CSFML.transform_get_matrix(pointerof(cself), matrix)
    end
    
    # Return the inverse of a transform
    # 
    # If the inverse cannot be computed, a new identity transform
    # is returned.
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # *Returns*: The inverse matrix
    def inverse
      cself = self
      CSFML.transform_get_inverse(pointerof(cself))
    end
    
    # Apply a transform to a 2D point
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `point`: Point to transform
    # 
    # *Returns*: Transformed point
    def transform_point(point: Vector2f)
      cself = self
      CSFML.transform_transform_point(pointerof(cself), point)
    end
    
    # Apply a transform to a rectangle
    # 
    # Since SFML doesn't provide support for oriented rectangles,
    # the result of this function is always an axis-aligned
    # rectangle. Which means that if the transform contains a
    # rotation, the bounding rectangle of the transformed rectangle
    # is returned.
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `rectangle`: Rectangle to transform
    # 
    # *Returns*: Transformed rectangle
    def transform_rect(rectangle: FloatRect)
      cself = self
      CSFML.transform_transform_rect(pointerof(cself), rectangle)
    end
    
    # Combine two transforms
    # 
    # The result is a transform that is equivalent to applying
    # `transform` followed by `other`. Mathematically, it is
    # equivalent to a matrix multiplication.
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `right`: Transform to combine to `transform`
    def combine(other)
      if other
        cother = other; pother = pointerof(cother)
      else
        pother = nil
      end
      cself = self
      CSFML.transform_combine(pointerof(cself), pother)
      self.matrix = cself.matrix
    end
    
    # Combine a transform with a translation
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `x`: Offset to apply on X axis
    # * `y`: Offset to apply on Y axis
    def translate(x, y)
      x = x.to_f32
      y = y.to_f32
      cself = self
      CSFML.transform_translate(pointerof(cself), x, y)
      self.matrix = cself.matrix
    end
    
    # Combine the current transform with a rotation
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `angle`: Rotation angle, in degrees
    def rotate(angle)
      angle = angle.to_f32
      cself = self
      CSFML.transform_rotate(pointerof(cself), angle)
      self.matrix = cself.matrix
    end
    
    # Combine the current transform with a rotation
    # 
    # The center of rotation is provided for convenience as a second
    # argument, so that you can build rotations around arbitrary points
    # more easily (and efficiently) than the usual
    # [translate(-center), rotate(angle), translate(center)].
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `angle`: Rotation angle, in degrees
    # * `centerX`: X coordinate of the center of rotation
    # * `centerY`: Y coordinate of the center of rotation
    def rotate(angle, center_x, center_y)
      angle = angle.to_f32
      center_x = center_x.to_f32
      center_y = center_y.to_f32
      cself = self
      CSFML.transform_rotate_with_center(pointerof(cself), angle, center_x, center_y)
      self.matrix = cself.matrix
    end
    
    # Combine the current transform with a scaling
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `scaleX`: Scaling factor on the X axis
    # * `scaleY`: Scaling factor on the Y axis
    def scale(scale_x, scale_y)
      scale_x = scale_x.to_f32
      scale_y = scale_y.to_f32
      cself = self
      CSFML.transform_scale(pointerof(cself), scale_x, scale_y)
      self.matrix = cself.matrix
    end
    
    # Combine the current transform with a scaling
    # 
    # The center of scaling is provided for convenience as a second
    # argument, so that you can build scaling around arbitrary points
    # more easily (and efficiently) than the usual
    # [translate(-center), scale(factors), translate(center)]
    # 
    # *Arguments*:
    # 
    # * `transform`: Transform object
    # * `scaleX`: Scaling factor on X axis
    # * `scaleY`: Scaling factor on Y axis
    # * `centerX`: X coordinate of the center of scaling
    # * `centerY`: Y coordinate of the center of scaling
    def scale(scale_x, scale_y, center_x, center_y)
      scale_x = scale_x.to_f32
      scale_y = scale_y.to_f32
      center_x = center_x.to_f32
      center_y = center_y.to_f32
      cself = self
      CSFML.transform_scale_with_center(pointerof(cself), scale_x, scale_y, center_x, center_y)
      self.matrix = cself.matrix
    end
    
  end

  alias FontInfo = CSFML::FontInfo

  # Glyph describes a glyph (a visual character)
  alias Glyph = CSFML::Glyph

  # Types of primitives that a sf::VertexArray can render
  # 
  # Points and lines have no area, therefore their thickness
  # will always be 1 pixel, regardless the current transform
  # and view.
  #
  # * Points
  # * Lines
  # * LinesStrip
  # * Triangles
  # * TrianglesStrip
  # * TrianglesFan
  # * Quads
  alias PrimitiveType = CSFML::PrimitiveType

  # Define the states used for drawing to a RenderTarget
  alias RenderStates = CSFML::RenderStates

  alias Vertex = CSFML::Vertex

  class Mouse
    # Get the current position of the mouse relative to a render-window
    # 
    # This function returns the current position of the mouse
    # cursor relative to the given render-window, or desktop if NULL is passed.
    # 
    # *Arguments*:
    # 
    # * `relative_to`: Reference window
    # 
    # *Returns*: Position of the mouse cursor, relative to the given render window
    def self.get_position(relative_to: RenderWindow)
      CSFML.mouse_get_position_render_window(relative_to)
    end
    
    # Set the current position of the mouse relative to a render window
    # 
    # This function sets the current position of the mouse
    # cursor relative to the given render-window, or desktop if NULL is passed.
    # 
    # *Arguments*:
    # 
    # * `position`: New position of the mouse
    # * `relative_to`: Reference window
    def self.set_position(position: Vector2i, relative_to: RenderWindow)
      CSFML.mouse_set_position_render_window(position, relative_to)
    end
    
  end

  class Touch
    # Get the current position of a touch in window coordinates
    # 
    # This function returns the current touch position
    # relative to the given render window, or desktop if NULL is passed.
    # 
    # *Arguments*:
    # 
    # * `finger`: Finger index
    # * `relative_to`: Reference window
    # 
    # *Returns*: Current position of `finger`, or undefined if it's not down
    def self.get_position(finger: Int32, relative_to: RenderWindow)
      CSFML.touch_get_position_render_window(finger, relative_to)
    end
    
  end

  # * Text::Regular
  # * Text::Bold
  # * Text::Italic
  # * Text::Underlined
  # * Text::StrikeThrough
  alias TextStyle = CSFML::TextStyle

  # Construct a color from its 3 RGB components
  # 
  # *Arguments*:
  # 
  # * `red`: Red component (0 .. 255)
  # * `green`: Green component (0 .. 255)
  # * `blue`: Blue component (0 .. 255)
  # 
  # *Returns*: Color constructed from the components
  def color(red: UInt8, green: UInt8, blue: UInt8)
    CSFML.color_from_rgb(red, green, blue)
  end
  
  # Construct a color from its 4 RGBA components
  # 
  # *Arguments*:
  # 
  # * `red`: Red component (0 .. 255)
  # * `green`: Green component (0 .. 255)
  # * `blue`: Blue component (0 .. 255)
  # * `alpha`: Alpha component (0 .. 255)
  # 
  # *Returns*: Color constructed from the components
  def color(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)
    CSFML.color_from_rgba(red, green, blue, alpha)
  end
  
  # Create a new transform from a matrix
  # 
  # *Arguments*:
  # 
  # * `a00`: Element (0, 0) of the matrix
  # * `a01`: Element (0, 1) of the matrix
  # * `a02`: Element (0, 2) of the matrix
  # * `a10`: Element (1, 0) of the matrix
  # * `a11`: Element (1, 1) of the matrix
  # * `a12`: Element (1, 2) of the matrix
  # * `a20`: Element (2, 0) of the matrix
  # * `a21`: Element (2, 1) of the matrix
  # * `a22`: Element (2, 2) of the matrix
  # 
  # *Returns*: A new Transform object
  def transform(a00, a01, a02, a10, a11, a12, a20, a21, a22)
    a00 = a00.to_f32
    a01 = a01.to_f32
    a02 = a02.to_f32
    a10 = a10.to_f32
    a11 = a11.to_f32
    a12 = a12.to_f32
    a20 = a20.to_f32
    a21 = a21.to_f32
    a22 = a22.to_f32
    CSFML.transform_from_matrix(a00, a01, a02, a10, a11, a12, a20, a21, a22)
  end
  
  Points = CSFML::PrimitiveType::Points
  Lines = CSFML::PrimitiveType::Lines
  LinesStrip = CSFML::PrimitiveType::LinesStrip
  Triangles = CSFML::PrimitiveType::Triangles
  TrianglesStrip = CSFML::PrimitiveType::TrianglesStrip
  TrianglesFan = CSFML::PrimitiveType::TrianglesFan
  Quads = CSFML::PrimitiveType::Quads
end
