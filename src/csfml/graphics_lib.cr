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


require "./system_lib"
require "./window_lib"

@[Link("csfml-graphics")]

lib CSFML
  enum BlendFactor
    # Enumeration of the blending factors
    Zero, One, SrcColor, OneMinusSrcColor, DstColor, OneMinusDstColor, SrcAlpha,
    OneMinusSrcAlpha, DstAlpha, OneMinusDstAlpha
  end
  
  enum BlendEquation
    # Enumeration of the blending equations
    Add, Subtract
  end
  
  struct BlendMode
    # Blending mode for drawing
    color_src_factor: BlendFactor
    color_dst_factor: BlendFactor
    color_equation: BlendEquation
    alpha_src_factor: BlendFactor
    alpha_dst_factor: BlendFactor
    alpha_equation: BlendEquation
  end
  
  struct Color
    # Utility class for manpulating RGBA colors
    r: UInt8
    g: UInt8
    b: UInt8
    a: UInt8
  end
  
  fun color_from_rgb = sfColor_fromRGB(red: UInt8, green: UInt8, blue: UInt8): Color
    # Construct a color from its 3 RGB components
    # 
    # Arguments:
    # - red: Red component (0 .. 255)
    # - green: Green component (0 .. 255)
    # - blue: Blue component (0 .. 255)
    # 
    # Returns: Color constructed from the components
  
  fun color_from_rgba = sfColor_fromRGBA(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8): Color
    # Construct a color from its 4 RGBA components
    # 
    # Arguments:
    # - red: Red component (0 .. 255)
    # - green: Green component (0 .. 255)
    # - blue: Blue component (0 .. 255)
    # - alpha: Alpha component (0 .. 255)
    # 
    # Returns: Color constructed from the components
  
  fun color_add = sfColor_add(color1: Color, color2: Color): Color
    # Add two colors
    # 
    # Arguments:
    # - color1: First color
    # - color2: Second color
    # 
    # Returns: Component-wise saturated addition of the two colors
  
  fun color_modulate = sfColor_modulate(color1: Color, color2: Color): Color
    # Modulate two colors
    # 
    # Arguments:
    # - color1: First color
    # - color2: Second color
    # 
    # Returns: Component-wise multiplication of the two colors
  
  struct FloatRect
    left: Float32
    top: Float32
    width: Float32
    height: Float32
  end
  
  struct IntRect
    left: Int32
    top: Int32
    width: Int32
    height: Int32
  end
  
  fun float_rect_contains = sfFloatRect_contains(rect: FloatRect*, x: Float32, y: Float32): Int32
    # Check if a point is inside a rectangle's area
    # 
    # Arguments:
    # - rect: Rectangle to test
    # - x: X coordinate of the point to test
    # - y: Y coordinate of the point to test
    # 
    # Returns: True if the point is inside
  
  fun int_rect_contains = sfIntRect_contains(rect: IntRect*, x: Int32, y: Int32): Int32
  
  fun float_rect_intersects = sfFloatRect_intersects(rect1: FloatRect*, rect2: FloatRect*, intersection: FloatRect*): Int32
    # Check intersection between two rectangles
    # 
    # Arguments:
    # - rect1: First rectangle to test
    # - rect2: Second rectangle to test
    # - intersection: Rectangle to be filled with overlapping rect (can be NULL)
    # 
    # Returns: True if rectangles overlap
  
  fun int_rect_intersects = sfIntRect_intersects(rect1: IntRect*, rect2: IntRect*, intersection: IntRect*): Int32
  
  type CircleShape = Void*
  
  type ConvexShape = Void*
  
  type Font = Void*
  
  type Image = Void*
  
  type Shader = Void*
  
  type RectangleShape = Void*
  
  type RenderTexture = Void*
  
  type RenderWindow = Void*
  
  type Shape = Void*
  
  type Sprite = Void*
  
  type Text = Void*
  
  type Texture = Void*
  
  type Transformable = Void*
  
  type VertexArray = Void*
  
  type View = Void*
  
  struct Transform
    # Encapsulate a 3x3 transform matrix
    matrix: Float32[9]
  end
  
  fun transform_from_matrix = sfTransform_fromMatrix(a00: Float32, a01: Float32, a02: Float32, a10: Float32, a11: Float32, a12: Float32, a20: Float32, a21: Float32, a22: Float32): Transform
    # Create a new transform from a matrix
    # 
    # Arguments:
    # - a00: Element (0, 0) of the matrix
    # - a01: Element (0, 1) of the matrix
    # - a02: Element (0, 2) of the matrix
    # - a10: Element (1, 0) of the matrix
    # - a11: Element (1, 1) of the matrix
    # - a12: Element (1, 2) of the matrix
    # - a20: Element (2, 0) of the matrix
    # - a21: Element (2, 1) of the matrix
    # - a22: Element (2, 2) of the matrix
    # 
    # Returns: A new Transform object
  
  fun transform_get_matrix = sfTransform_getMatrix(transform: Transform*, matrix: Float32*)
    # Return the 4x4 matrix of a transform
    # 
    # This function fills an array of 16 floats with the transform
    # converted as a 4x4 matrix, which is directly compatible with
    # OpenGL functions.
    # 
    # 
    # Arguments:
    # - transform: Transform object
    # - matrix: Pointer to the 16-element array to fill with the matrix
  
  fun transform_get_inverse = sfTransform_getInverse(transform: Transform*): Transform
    # Return the inverse of a transform
    # 
    # If the inverse cannot be computed, a new identity transform
    # is returned.
    # 
    # Arguments:
    # - transform: Transform object
    # Returns: The inverse matrix
  
  fun transform_transform_point = sfTransform_transformPoint(transform: Transform*, point: Vector2f): Vector2f
    # Apply a transform to a 2D point
    # 
    # Arguments:
    # - transform: Transform object
    # - point: Point to transform
    # 
    # Returns: Transformed point
  
  fun transform_transform_rect = sfTransform_transformRect(transform: Transform*, rectangle: FloatRect): FloatRect
    # Apply a transform to a rectangle
    # 
    # Since SFML doesn't provide support for oriented rectangles,
    # the result of this function is always an axis-aligned
    # rectangle. Which means that if the transform contains a
    # rotation, the bounding rectangle of the transformed rectangle
    # is returned.
    # 
    # Arguments:
    # - transform: Transform object
    # - rectangle: Rectangle to transform
    # 
    # Returns: Transformed rectangle
  
  fun transform_combine = sfTransform_combine(transform: Transform*, other: Transform*)
    # Combine two transforms
    # 
    # The result is a transform that is equivalent to applying
    # `transform` followed by `other`. Mathematically, it is
    # equivalent to a matrix multiplication.
    # 
    # Arguments:
    # - transform: Transform object
    # - right: Transform to combine to `transform`
  
  fun transform_translate = sfTransform_translate(transform: Transform*, x: Float32, y: Float32)
    # Combine a transform with a translation
    # 
    # Arguments:
    # - transform: Transform object
    # - x: Offset to apply on X axis
    # - y: Offset to apply on Y axis
  
  fun transform_rotate = sfTransform_rotate(transform: Transform*, angle: Float32)
    # Combine the current transform with a rotation
    # 
    # Arguments:
    # - transform: Transform object
    # - angle: Rotation angle, in degrees
  
  fun transform_rotate_with_center = sfTransform_rotateWithCenter(transform: Transform*, angle: Float32, center_x: Float32, center_y: Float32)
    # Combine the current transform with a rotation
    # 
    # The center of rotation is provided for convenience as a second
    # argument, so that you can build rotations around arbitrary points
    # more easily (and efficiently) than the usual
    # [translate(-center), rotate(angle), translate(center)].
    # 
    # Arguments:
    # - transform: Transform object
    # - angle: Rotation angle, in degrees
    # - centerX: X coordinate of the center of rotation
    # - centerY: Y coordinate of the center of rotation
  
  fun transform_scale = sfTransform_scale(transform: Transform*, scale_x: Float32, scale_y: Float32)
    # Combine the current transform with a scaling
    # 
    # Arguments:
    # - transform: Transform object
    # - scaleX: Scaling factor on the X axis
    # - scaleY: Scaling factor on the Y axis
  
  fun transform_scale_with_center = sfTransform_scaleWithCenter(transform: Transform*, scale_x: Float32, scale_y: Float32, center_x: Float32, center_y: Float32)
    # Combine the current transform with a scaling
    # 
    # The center of scaling is provided for convenience as a second
    # argument, so that you can build scaling around arbitrary points
    # more easily (and efficiently) than the usual
    # [translate(-center), scale(factors), translate(center)]
    # 
    # Arguments:
    # - transform: Transform object
    # - scaleX: Scaling factor on X axis
    # - scaleY: Scaling factor on Y axis
    # - centerX: X coordinate of the center of scaling
    # - centerY: Y coordinate of the center of scaling
  
  fun circle_shape_create = sfCircleShape_create(): CircleShape
    # Create a new circle shape
    # 
    # Returns: A new CircleShape object, or NULL if it failed
  
  fun circle_shape_copy = sfCircleShape_copy(shape: CircleShape): CircleShape
    # Copy an existing circle shape
    # 
    # Arguments:
    # - shape: Shape to copy
    # 
    # Returns: Copied object
  
  fun circle_shape_destroy = sfCircleShape_destroy(shape: CircleShape)
    # Destroy an existing circle Shape
    # 
    # Arguments:
    # - Shape: Shape to delete
  
  fun circle_shape_set_position = sfCircleShape_setPosition(shape: CircleShape, position: Vector2f)
    # Set the position of a circle shape
    # 
    # This function completely overwrites the previous position.
    # See CircleShape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - position: New position
  
  fun circle_shape_set_rotation = sfCircleShape_setRotation(shape: CircleShape, angle: Float32)
    # Set the orientation of a circle shape
    # 
    # This function completely overwrites the previous rotation.
    # See CircleShape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: New rotation, in degrees
  
  fun circle_shape_set_scale = sfCircleShape_setScale(shape: CircleShape, scale: Vector2f)
    # Set the scale factors of a circle shape
    # 
    # This function completely overwrites the previous scale.
    # See CircleShape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # Arguments:
    # - shape: Shape object
    # - scale: New scale factors
  
  fun circle_shape_set_origin = sfCircleShape_setOrigin(shape: CircleShape, origin: Vector2f)
    # Set the local origin of a circle shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - origin: New origin
  
  fun circle_shape_get_position = sfCircleShape_getPosition(shape: CircleShape): Vector2f
    # Get the position of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current position
  
  fun circle_shape_get_rotation = sfCircleShape_getRotation(shape: CircleShape): Float32
    # Get the orientation of a circle shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current rotation, in degrees
  
  fun circle_shape_get_scale = sfCircleShape_getScale(shape: CircleShape): Vector2f
    # Get the current scale of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current scale factors
  
  fun circle_shape_get_origin = sfCircleShape_getOrigin(shape: CircleShape): Vector2f
    # Get the local origin of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current origin
  
  fun circle_shape_move = sfCircleShape_move(shape: CircleShape, offset: Vector2f)
    # Move a circle shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike CircleShape_setPosition which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - offset: Offset
  
  fun circle_shape_rotate = sfCircleShape_rotate(shape: CircleShape, angle: Float32)
    # Rotate a circle shape
    # 
    # This function adds to the current rotation of the object,
    # unlike CircleShape_setRotation which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: Angle of rotation, in degrees
  
  fun circle_shape_scale = sfCircleShape_scale(shape: CircleShape, factors: Vector2f)
    # Scale a circle shape
    # 
    # This function multiplies the current scale of the object,
    # unlike CircleShape_setScale which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - factors: Scale factors
  
  fun circle_shape_get_transform = sfCircleShape_getTransform(shape: CircleShape): Transform
    # Get the combined transform of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Transform combining the position/rotation/scale/origin of the object
  
  fun circle_shape_get_inverse_transform = sfCircleShape_getInverseTransform(shape: CircleShape): Transform
    # Get the inverse of the combined transform of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Inverse of the combined transformations applied to the object
  
  fun circle_shape_set_texture = sfCircleShape_setTexture(shape: CircleShape, texture: Texture, reset_rect: Int32)
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
    # Arguments:
    # - shape: Shape object
    # - texture: New texture
    # - reset_rect: Should the texture rect be reset to the size of the new texture?
  
  fun circle_shape_set_texture_rect = sfCircleShape_setTextureRect(shape: CircleShape, rect: IntRect)
    # Set the sub-rectangle of the texture that a circle shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # Arguments:
    # - shape: Shape object
    # - rect: Rectangle defining the region of the texture to display
  
  fun circle_shape_set_fill_color = sfCircleShape_setFillColor(shape: CircleShape, color: Color)
    # Set the fill color of a circle shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New color of the shape
  
  fun circle_shape_set_outline_color = sfCircleShape_setOutlineColor(shape: CircleShape, color: Color)
    # Set the outline color of a circle shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New outline color of the shape
  
  fun circle_shape_set_outline_thickness = sfCircleShape_setOutlineThickness(shape: CircleShape, thickness: Float32)
    # Set the thickness of a circle shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - thickness: New outline thickness
  
  fun circle_shape_get_texture = sfCircleShape_getTexture(shape: CircleShape): Texture
    # Get the source texture of a circle shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Pointer to the shape's texture
  
  fun circle_shape_get_texture_rect = sfCircleShape_getTextureRect(shape: CircleShape): IntRect
    # Get the sub-rectangle of the texture displayed by a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Texture rectangle of the shape
  
  fun circle_shape_get_fill_color = sfCircleShape_getFillColor(shape: CircleShape): Color
    # Get the fill color of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Fill color of the shape
  
  fun circle_shape_get_outline_color = sfCircleShape_getOutlineColor(shape: CircleShape): Color
    # Get the outline color of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline color of the shape
  
  fun circle_shape_get_outline_thickness = sfCircleShape_getOutlineThickness(shape: CircleShape): Float32
    # Get the outline thickness of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline thickness of the shape
  
  fun circle_shape_get_point_count = sfCircleShape_getPointCount(shape: CircleShape): Int32
    # Get the total number of points of a circle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Number of points of the shape
  
  fun circle_shape_get_point = sfCircleShape_getPoint(shape: CircleShape, index: Int32): Vector2f
    # Get a point of a circle shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # Arguments:
    # - shape: Shape object
    # - index: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # Returns: Index-th point of the shape
  
  fun circle_shape_set_radius = sfCircleShape_setRadius(shape: CircleShape, radius: Float32)
    # Set the radius of a circle
    # 
    # Arguments:
    # - shape: Shape object
    # - radius: New radius of the circle
  
  fun circle_shape_get_radius = sfCircleShape_getRadius(shape: CircleShape): Float32
    # Get the radius of a circle
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Radius of the circle
  
  fun circle_shape_set_point_count = sfCircleShape_setPointCount(shape: CircleShape, count: Int32)
    # Set the number of points of a circle
    # 
    # Arguments:
    # - shape: Shape object
    # - count: New number of points of the circle
  
  fun circle_shape_get_local_bounds = sfCircleShape_getLocalBounds(shape: CircleShape): FloatRect
    # Get the local bounding rectangle of a circle shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Local bounding rectangle of the entity
  
  fun circle_shape_get_global_bounds = sfCircleShape_getGlobalBounds(shape: CircleShape): FloatRect
    # Get the global bounding rectangle of a circle shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Global bounding rectangle of the entity
  
  fun convex_shape_create = sfConvexShape_create(): ConvexShape
    # Create a new convex shape
    # 
    # Returns: A new ConvexShape object, or NULL if it failed
  
  fun convex_shape_copy = sfConvexShape_copy(shape: ConvexShape): ConvexShape
    # Copy an existing convex shape
    # 
    # Arguments:
    # - shape: Shape to copy
    # 
    # Returns: Copied object
  
  fun convex_shape_destroy = sfConvexShape_destroy(shape: ConvexShape)
    # Destroy an existing convex Shape
    # 
    # Arguments:
    # - Shape: Shape to delete
  
  fun convex_shape_set_position = sfConvexShape_setPosition(shape: ConvexShape, position: Vector2f)
    # Set the position of a convex shape
    # 
    # This function completely overwrites the previous position.
    # See ConvexShape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - position: New position
  
  fun convex_shape_set_rotation = sfConvexShape_setRotation(shape: ConvexShape, angle: Float32)
    # Set the orientation of a convex shape
    # 
    # This function completely overwrites the previous rotation.
    # See ConvexShape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: New rotation, in degrees
  
  fun convex_shape_set_scale = sfConvexShape_setScale(shape: ConvexShape, scale: Vector2f)
    # Set the scale factors of a convex shape
    # 
    # This function completely overwrites the previous scale.
    # See ConvexShape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # Arguments:
    # - shape: Shape object
    # - scale: New scale factors
  
  fun convex_shape_set_origin = sfConvexShape_setOrigin(shape: ConvexShape, origin: Vector2f)
    # Set the local origin of a convex shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - origin: New origin
  
  fun convex_shape_get_position = sfConvexShape_getPosition(shape: ConvexShape): Vector2f
    # Get the position of a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current position
  
  fun convex_shape_get_rotation = sfConvexShape_getRotation(shape: ConvexShape): Float32
    # Get the orientation of a convex shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current rotation, in degrees
  
  fun convex_shape_get_scale = sfConvexShape_getScale(shape: ConvexShape): Vector2f
    # Get the current scale of a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current scale factors
  
  fun convex_shape_get_origin = sfConvexShape_getOrigin(shape: ConvexShape): Vector2f
    # Get the local origin of a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current origin
  
  fun convex_shape_move = sfConvexShape_move(shape: ConvexShape, offset: Vector2f)
    # Move a convex shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike ConvexShape_setPosition which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - offset: Offset
  
  fun convex_shape_rotate = sfConvexShape_rotate(shape: ConvexShape, angle: Float32)
    # Rotate a convex shape
    # 
    # This function adds to the current rotation of the object,
    # unlike ConvexShape_setRotation which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: Angle of rotation, in degrees
  
  fun convex_shape_scale = sfConvexShape_scale(shape: ConvexShape, factors: Vector2f)
    # Scale a convex shape
    # 
    # This function multiplies the current scale of the object,
    # unlike ConvexShape_setScale which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - factors: Scale factors
  
  fun convex_shape_get_transform = sfConvexShape_getTransform(shape: ConvexShape): Transform
    # Get the combined transform of a convex shape
    # 
    # Arguments:
    # - shape: shape object
    # 
    # Returns: Transform combining the position/rotation/scale/origin of the object
  
  fun convex_shape_get_inverse_transform = sfConvexShape_getInverseTransform(shape: ConvexShape): Transform
    # Get the inverse of the combined transform of a convex shape
    # 
    # Arguments:
    # - shape: shape object
    # 
    # Returns: Inverse of the combined transformations applied to the object
  
  fun convex_shape_set_texture = sfConvexShape_setTexture(shape: ConvexShape, texture: Texture, reset_rect: Int32)
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
    # Arguments:
    # - shape: Shape object
    # - texture: New texture
    # - reset_rect: Should the texture rect be reset to the size of the new texture?
  
  fun convex_shape_set_texture_rect = sfConvexShape_setTextureRect(shape: ConvexShape, rect: IntRect)
    # Set the sub-rectangle of the texture that a convex shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # Arguments:
    # - shape: Shape object
    # - rect: Rectangle defining the region of the texture to display
  
  fun convex_shape_set_fill_color = sfConvexShape_setFillColor(shape: ConvexShape, color: Color)
    # Set the fill color of a convex shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New color of the shape
  
  fun convex_shape_set_outline_color = sfConvexShape_setOutlineColor(shape: ConvexShape, color: Color)
    # Set the outline color of a convex shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New outline color of the shape
  
  fun convex_shape_set_outline_thickness = sfConvexShape_setOutlineThickness(shape: ConvexShape, thickness: Float32)
    # Set the thickness of a convex shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - thickness: New outline thickness
  
  fun convex_shape_get_texture = sfConvexShape_getTexture(shape: ConvexShape): Texture
    # Get the source texture of a convex shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Pointer to the shape's texture
  
  fun convex_shape_get_texture_rect = sfConvexShape_getTextureRect(shape: ConvexShape): IntRect
    # Get the sub-rectangle of the texture displayed by a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Texture rectangle of the shape
  
  fun convex_shape_get_fill_color = sfConvexShape_getFillColor(shape: ConvexShape): Color
    # Get the fill color of a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Fill color of the shape
  
  fun convex_shape_get_outline_color = sfConvexShape_getOutlineColor(shape: ConvexShape): Color
    # Get the outline color of a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline color of the shape
  
  fun convex_shape_get_outline_thickness = sfConvexShape_getOutlineThickness(shape: ConvexShape): Float32
    # Get the outline thickness of a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline thickness of the shape
  
  fun convex_shape_get_point_count = sfConvexShape_getPointCount(shape: ConvexShape): Int32
    # Get the total number of points of a convex shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Number of points of the shape
  
  fun convex_shape_get_point = sfConvexShape_getPoint(shape: ConvexShape, index: Int32): Vector2f
    # Get a point of a convex shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # Arguments:
    # - shape: Shape object
    # - index: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # Returns: Index-th point of the shape
  
  fun convex_shape_set_point_count = sfConvexShape_setPointCount(shape: ConvexShape, count: Int32)
    # Set the number of points of a convex shap
    # 
    # `count` must be greater than 2 to define a valid shape.
    # 
    # Arguments:
    # - shape: Shape object
    # - count: New number of points of the shape
  
  fun convex_shape_set_point = sfConvexShape_setPoint(shape: ConvexShape, index: Int32, point: Vector2f)
    # Set the position of a point in a convex shape
    # 
    # Don't forget that the polygon must remain convex, and
    # the points need to stay ordered!
    # set_point_count must be called first in order to set the total
    # number of points. The result is undefined if `index` is out
    # of the valid range.
    # 
    # Arguments:
    # - shape: Shape object
    # - index: Index of the point to change, in range [0 .. GetPointCount() - 1]
    # - point: New point
  
  fun convex_shape_get_local_bounds = sfConvexShape_getLocalBounds(shape: ConvexShape): FloatRect
    # Get the local bounding rectangle of a convex shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Local bounding rectangle of the entity
  
  fun convex_shape_get_global_bounds = sfConvexShape_getGlobalBounds(shape: ConvexShape): FloatRect
    # Get the global bounding rectangle of a convex shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Global bounding rectangle of the entity
  
  struct FontInfo
    family: UInt8*
  end
  
  struct Glyph
    # Glyph describes a glyph (a visual character)
    advance: Float32
    bounds: FloatRect
    texture_rect: IntRect
  end
  
  fun font_create_from_file = sfFont_createFromFile(filename: UInt8*): Font
    # Create a new font from a file
    # 
    # Arguments:
    # - filename: Path of the font file to load
    # 
    # Returns: A new Font object, or NULL if it failed
  
  fun font_create_from_memory = sfFont_createFromMemory(data: Void*, size_in_bytes: Size_t): Font
    # Create a new image font a file in memory
    # 
    # Arguments:
    # - data: Pointer to the file data in memory
    # - size_in_bytes: Size of the data to load, in bytes
    # 
    # Returns: A new Font object, or NULL if it failed
  
  fun font_create_from_stream = sfFont_createFromStream(stream: InputStream*): Font
    # Create a new image font a custom stream
    # 
    # Arguments:
    # - stream: Source stream to read from
    # 
    # Returns: A new Font object, or NULL if it failed
  
  fun font_copy = sfFont_copy(font: Font): Font
    # Copy an existing font
    # 
    # Arguments:
    # - font: Font to copy
    # 
    # Returns: Copied object
  
  fun font_destroy = sfFont_destroy(font: Font)
    # Destroy an existing font
    # 
    # Arguments:
    # - font: Font to delete
  
  fun font_get_glyph = sfFont_getGlyph(font: Font, code_point: Char, character_size: Int32, bold: Int32): Glyph
    # Get a glyph in a font
    # 
    # Arguments:
    # - font: Source font
    # - code_point: Unicode code point of the character to get
    # - character_size: Character size, in pixels
    # - bold: Retrieve the bold version or the regular one?
    # 
    # Returns: The corresponding glyph
  
  fun font_get_kerning = sfFont_getKerning(font: Font, first: Char, second: Char, character_size: Int32): Float32
    # Get the kerning value corresponding to a given pair of characters in a font
    # 
    # Arguments:
    # - font: Source font
    # - first: Unicode code point of the first character
    # - second: Unicode code point of the second character
    # - character_size: Character size, in pixels
    # 
    # Returns: Kerning offset, in pixels
  
  fun font_get_line_spacing = sfFont_getLineSpacing(font: Font, character_size: Int32): Float32
    # Get the line spacing value
    # 
    # Arguments:
    # - font: Source font
    # - character_size: Character size, in pixels
    # 
    # Returns: Line spacing, in pixels
  
  fun font_get_underline_position = sfFont_getUnderlinePosition(font: Font, character_size: Int32): Float32
    # Get the position of the underline
    # 
    # Underline position is the vertical offset to apply between the
    # baseline and the underline.
    # 
    # Arguments:
    # - font: Source font
    # - character_size: Reference character size
    # 
    # Returns: Underline position, in pixels
  
  fun font_get_underline_thickness = sfFont_getUnderlineThickness(font: Font, character_size: Int32): Float32
    # Get the thickness of the underline
    # 
    # Underline thickness is the vertical size of the underline.
    # 
    # Arguments:
    # - font: Source font
    # - character_size: Reference character size
    # 
    # Returns: Underline thickness, in pixels
  
  fun font_get_texture = sfFont_getTexture(font: Font, character_size: Int32): Texture
    # Get the texture containing the glyphs of a given size in a font
    # 
    # Arguments:
    # - font: Source font
    # - character_size: Character size, in pixels
    # 
    # Returns: Read-only pointer to the texture
  
  fun font_get_info = sfFont_getInfo(font: Font): FontInfo
    # Get the font information
    # 
    # The returned structure will remain valid only if the font
    # is still valid. If the font is invalid an invalid structure
    # is returned.
    # 
    # Arguments:
    # - font: Source font
    # 
    # Returns: A structure that holds the font information
  
  fun image_create = sfImage_create(width: Int32, height: Int32): Image
    # Create an image
    # 
    # This image is filled with black pixels.
    # 
    # Arguments:
    # - width: Width of the image
    # - height: Height of the image
    # 
    # Returns: A new Image object
  
  fun image_create_from_color = sfImage_createFromColor(width: Int32, height: Int32, color: Color): Image
    # Create an image and fill it with a unique color
    # 
    # Arguments:
    # - width: Width of the image
    # - height: Height of the image
    # - color: Fill color
    # 
    # Returns: A new Image object
  
  fun image_create_from_pixels = sfImage_createFromPixels(width: Int32, height: Int32, pixels: UInt8*): Image
    # Create an image from an array of pixels
    # 
    # The `pixel` array is assumed to contain 32-bits RGBA pixels,
    # and have the given `width` and `height`. If not, this is
    # an undefined behaviour.
    # If `pixels` is null, an empty image is created.
    # 
    # Arguments:
    # - width: Width of the image
    # - height: Height of the image
    # - pixels: Array of pixels to copy to the image
    # 
    # Returns: A new Image object
  
  fun image_create_from_file = sfImage_createFromFile(filename: UInt8*): Image
    # Create an image from a file on disk
    # 
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    # 
    # Arguments:
    # - filename: Path of the image file to load
    # 
    # Returns: A new Image object, or NULL if it failed
  
  fun image_create_from_memory = sfImage_createFromMemory(data: Void*, size: Size_t): Image
    # Create an image from a file in memory
    # 
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    # 
    # Arguments:
    # - data: Pointer to the file data in memory
    # - size: Size of the data to load, in bytes
    # 
    # Returns: A new Image object, or NULL if it failed
  
  fun image_create_from_stream = sfImage_createFromStream(stream: InputStream*): Image
    # Create an image from a custom stream
    # 
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    # 
    # Arguments:
    # - stream: Source stream to read from
    # 
    # Returns: A new Image object, or NULL if it failed
  
  fun image_copy = sfImage_copy(image: Image): Image
    # Copy an existing image
    # 
    # Arguments:
    # - image: Image to copy
    # 
    # Returns: Copied object
  
  fun image_destroy = sfImage_destroy(image: Image)
    # Destroy an existing image
    # 
    # Arguments:
    # - image: Image to delete
  
  fun image_save_to_file = sfImage_saveToFile(image: Image, filename: UInt8*): Int32
    # Save an image to a file on disk
    # 
    # The format of the image is automatically deduced from
    # the extension. The supported image formats are bmp, png,
    # tga and jpg. The destination file is overwritten
    # if it already exists. This function fails if the image is empty.
    # 
    # Arguments:
    # - image: Image object
    # - filename: Path of the file to save
    # 
    # Returns: True if saving was successful
  
  fun image_get_size = sfImage_getSize(image: Image): Vector2i
    # Return the size of an image
    # 
    # Arguments:
    # - image: Image object
    # 
    # Returns: Size in pixels
  
  fun image_create_mask_from_color = sfImage_createMaskFromColor(image: Image, color: Color, alpha: UInt8)
    # Create a transparency mask from a specified color-key
    # 
    # This function sets the alpha value of every pixel matching
    # the given color to `alpha` (0 by default), so that they
    # become transparent.
    # 
    # Arguments:
    # - image: Image object
    # - color: Color to make transparent
    # - alpha: Alpha value to assign to transparent pixels
  
  fun image_copy_image = sfImage_copyImage(image: Image, source: Image, dest_x: Int32, dest_y: Int32, source_rect: IntRect, apply_alpha: Int32)
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
    # Arguments:
    # - image: Image object
    # - source: Source image to copy
    # - destX: X coordinate of the destination position
    # - destY: Y coordinate of the destination position
    # - source_rect: Sub-rectangle of the source image to copy
    # - apply_alpha: Should the copy take in account the source transparency?
  
  fun image_set_pixel = sfImage_setPixel(image: Image, x: Int32, y: Int32, color: Color)
    # Change the color of a pixel in an image
    # 
    # This function doesn't check the validity of the pixel
    # coordinates, using out-of-range values will result in
    # an undefined behaviour.
    # 
    # Arguments:
    # - image: Image object
    # - x: X coordinate of pixel to change
    # - y: Y coordinate of pixel to change
    # - color: New color of the pixel
  
  fun image_get_pixel = sfImage_getPixel(image: Image, x: Int32, y: Int32): Color
    # Get the color of a pixel in an image
    # 
    # This function doesn't check the validity of the pixel
    # coordinates, using out-of-range values will result in
    # an undefined behaviour.
    # 
    # Arguments:
    # - image: Image object
    # - x: X coordinate of pixel to get
    # - y: Y coordinate of pixel to get
    # 
    # Returns: Color of the pixel at coordinates (x, y)
  
  fun image_get_pixels_ptr = sfImage_getPixelsPtr(image: Image): UInt8*
    # Get a read-only pointer to the array of pixels of an image
    # 
    # The returned value points to an array of RGBA pixels made of
    # 8 bits integers components. The size of the array is
    # get_width() * get_height() * 4.
    # Warning: the returned pointer may become invalid if you
    # modify the image, so you should never store it for too long.
    # If the image is empty, a null pointer is returned.
    # 
    # Arguments:
    # - image: Image object
    # 
    # Returns: Read-only pointer to the array of pixels
  
  fun image_flip_horizontally = sfImage_flipHorizontally(image: Image)
    # Flip an image horizontally (left <-> right)
    # 
    # Arguments:
    # - image: Image object
  
  fun image_flip_vertically = sfImage_flipVertically(image: Image)
    # Flip an image vertically (top <-> bottom)
    # 
    # Arguments:
    # - image: Image object
  
  enum PrimitiveType
    # Types of primitives that a sf::VertexArray can render
    # 
    # Points and lines have no area, therefore their thickness
    # will always be 1 pixel, regardless the current transform
    # and view.
    Points, Lines, LinesStrip, Triangles, TrianglesStrip, TrianglesFan, Quads
  end
  
  fun rectangle_shape_create = sfRectangleShape_create(): RectangleShape
    # Create a new rectangle shape
    # 
    # Returns: A new RectangleShape object, or NULL if it failed
  
  fun rectangle_shape_copy = sfRectangleShape_copy(shape: RectangleShape): RectangleShape
    # Copy an existing rectangle shape
    # 
    # Arguments:
    # - shape: Shape to copy
    # 
    # Returns: Copied object
  
  fun rectangle_shape_destroy = sfRectangleShape_destroy(shape: RectangleShape)
    # Destroy an existing rectangle shape
    # 
    # Arguments:
    # - Shape: Shape to delete
  
  fun rectangle_shape_set_position = sfRectangleShape_setPosition(shape: RectangleShape, position: Vector2f)
    # Set the position of a rectangle shape
    # 
    # This function completely overwrites the previous position.
    # See RectangleShape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - position: New position
  
  fun rectangle_shape_set_rotation = sfRectangleShape_setRotation(shape: RectangleShape, angle: Float32)
    # Set the orientation of a rectangle shape
    # 
    # This function completely overwrites the previous rotation.
    # See RectangleShape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: New rotation, in degrees
  
  fun rectangle_shape_set_scale = sfRectangleShape_setScale(shape: RectangleShape, scale: Vector2f)
    # Set the scale factors of a rectangle shape
    # 
    # This function completely overwrites the previous scale.
    # See RectangleShape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # Arguments:
    # - shape: Shape object
    # - scale: New scale factors
  
  fun rectangle_shape_set_origin = sfRectangleShape_setOrigin(shape: RectangleShape, origin: Vector2f)
    # Set the local origin of a rectangle shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - origin: New origin
  
  fun rectangle_shape_get_position = sfRectangleShape_getPosition(shape: RectangleShape): Vector2f
    # Get the position of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current position
  
  fun rectangle_shape_get_rotation = sfRectangleShape_getRotation(shape: RectangleShape): Float32
    # Get the orientation of a rectangle shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current rotation, in degrees
  
  fun rectangle_shape_get_scale = sfRectangleShape_getScale(shape: RectangleShape): Vector2f
    # Get the current scale of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current scale factors
  
  fun rectangle_shape_get_origin = sfRectangleShape_getOrigin(shape: RectangleShape): Vector2f
    # Get the local origin of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current origin
  
  fun rectangle_shape_move = sfRectangleShape_move(shape: RectangleShape, offset: Vector2f)
    # Move a rectangle shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike RectangleShape_setPosition which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - offset: Offset
  
  fun rectangle_shape_rotate = sfRectangleShape_rotate(shape: RectangleShape, angle: Float32)
    # Rotate a rectangle shape
    # 
    # This function adds to the current rotation of the object,
    # unlike RectangleShape_setRotation which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: Angle of rotation, in degrees
  
  fun rectangle_shape_scale = sfRectangleShape_scale(shape: RectangleShape, factors: Vector2f)
    # Scale a rectangle shape
    # 
    # This function multiplies the current scale of the object,
    # unlike RectangleShape_setScale which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - factors: Scale factors
  
  fun rectangle_shape_get_transform = sfRectangleShape_getTransform(shape: RectangleShape): Transform
    # Get the combined transform of a rectangle shape
    # 
    # Arguments:
    # - shape: shape object
    # 
    # Returns: Transform combining the position/rotation/scale/origin of the object
  
  fun rectangle_shape_get_inverse_transform = sfRectangleShape_getInverseTransform(shape: RectangleShape): Transform
    # Get the inverse of the combined transform of a rectangle shape
    # 
    # Arguments:
    # - shape: shape object
    # 
    # Returns: Inverse of the combined transformations applied to the object
  
  fun rectangle_shape_set_texture = sfRectangleShape_setTexture(shape: RectangleShape, texture: Texture, reset_rect: Int32)
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
    # Arguments:
    # - shape: Shape object
    # - texture: New texture
    # - reset_rect: Should the texture rect be reset to the size of the new texture?
  
  fun rectangle_shape_set_texture_rect = sfRectangleShape_setTextureRect(shape: RectangleShape, rect: IntRect)
    # Set the sub-rectangle of the texture that a rectangle shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # Arguments:
    # - shape: Shape object
    # - rect: Rectangle defining the region of the texture to display
  
  fun rectangle_shape_set_fill_color = sfRectangleShape_setFillColor(shape: RectangleShape, color: Color)
    # Set the fill color of a rectangle shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New color of the shape
  
  fun rectangle_shape_set_outline_color = sfRectangleShape_setOutlineColor(shape: RectangleShape, color: Color)
    # Set the outline color of a rectangle shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New outline color of the shape
  
  fun rectangle_shape_set_outline_thickness = sfRectangleShape_setOutlineThickness(shape: RectangleShape, thickness: Float32)
    # Set the thickness of a rectangle shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - thickness: New outline thickness
  
  fun rectangle_shape_get_texture = sfRectangleShape_getTexture(shape: RectangleShape): Texture
    # Get the source texture of a rectangle shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Pointer to the shape's texture
  
  fun rectangle_shape_get_texture_rect = sfRectangleShape_getTextureRect(shape: RectangleShape): IntRect
    # Get the sub-rectangle of the texture displayed by a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Texture rectangle of the shape
  
  fun rectangle_shape_get_fill_color = sfRectangleShape_getFillColor(shape: RectangleShape): Color
    # Get the fill color of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Fill color of the shape
  
  fun rectangle_shape_get_outline_color = sfRectangleShape_getOutlineColor(shape: RectangleShape): Color
    # Get the outline color of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline color of the shape
  
  fun rectangle_shape_get_outline_thickness = sfRectangleShape_getOutlineThickness(shape: RectangleShape): Float32
    # Get the outline thickness of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline thickness of the shape
  
  fun rectangle_shape_get_point_count = sfRectangleShape_getPointCount(shape: RectangleShape): Int32
    # Get the total number of points of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Number of points of the shape
  
  fun rectangle_shape_get_point = sfRectangleShape_getPoint(shape: RectangleShape, index: Int32): Vector2f
    # Get a point of a rectangle shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # Arguments:
    # - shape: Shape object
    # - index: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # Returns: Index-th point of the shape
  
  fun rectangle_shape_set_size = sfRectangleShape_setSize(shape: RectangleShape, size: Vector2f)
    # Set the size of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # - size: New size of the rectangle
  
  fun rectangle_shape_get_size = sfRectangleShape_getSize(shape: RectangleShape): Vector2f
    # Get the size of a rectangle shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: height Size of the rectangle
  
  fun rectangle_shape_get_local_bounds = sfRectangleShape_getLocalBounds(shape: RectangleShape): FloatRect
    # Get the local bounding rectangle of a rectangle shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Local bounding rectangle of the entity
  
  fun rectangle_shape_get_global_bounds = sfRectangleShape_getGlobalBounds(shape: RectangleShape): FloatRect
    # Get the global bounding rectangle of a rectangle shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Global bounding rectangle of the entity
  
  struct RenderStates
    # Define the states used for drawing to a RenderTarget
    blend_mode: BlendMode
    transform: Transform
    texture: Texture
    shader: Shader
  end
  
  struct Vertex
    position: Vector2f
    color: Color
    tex_coords: Vector2f
  end
  
  fun render_window_create = sfRenderWindow_create(mode: VideoMode, title: UInt8*, style: WindowStyle, settings: ContextSettings*): RenderWindow
    # Construct a new render window
    # 
    # Arguments:
    # - mode: Video mode to use
    # - title: Title of the window
    # - style: Window style
    # - settings: Creation settings (pass NULL to use default values)
  
  fun render_window_create_unicode = sfRenderWindow_createUnicode(mode: VideoMode, title: Char*, style: WindowStyle, settings: ContextSettings*): RenderWindow
    # Construct a new render window (with a UTF-32 title)
    # 
    # Arguments:
    # - mode: Video mode to use
    # - title: Title of the window (UTF-32)
    # - style: Window style
    # - settings: Creation settings (pass NULL to use default values)
  
  fun render_window_create_from_handle = sfRenderWindow_createFromHandle(handle: WindowHandle, settings: ContextSettings*): RenderWindow
    # Construct a render window from an existing control
    # 
    # Arguments:
    # - handle: Platform-specific handle of the control
    # - settings: Creation settings (pass NULL to use default values)
  
  fun render_window_destroy = sfRenderWindow_destroy(render_window: RenderWindow)
    # Destroy an existing render window
    # 
    # Arguments:
    # - render_window: Render window to destroy
  
  fun render_window_close = sfRenderWindow_close(render_window: RenderWindow)
    # Close a render window (but doesn't destroy the internal data)
    # 
    # Arguments:
    # - render_window: Render window to close
  
  fun render_window_is_open = sfRenderWindow_isOpen(render_window: RenderWindow): Int32
    # Tell whether or not a render window is opened
    # 
    # Arguments:
    # - render_window: Render window object
  
  fun render_window_get_settings = sfRenderWindow_getSettings(render_window: RenderWindow): ContextSettings
    # Get the creation settings of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # 
    # Returns: Settings used to create the window
  
  fun render_window_poll_event = sfRenderWindow_pollEvent(render_window: RenderWindow, event: Event*): Int32
    # Get the event on top of event queue of a render window, if any, and pop it
    # 
    # Arguments:
    # - render_window: Render window object
    # - event: Event to fill, if any
    # 
    # Returns: True if an event was returned, False if event queue was empty
  
  fun render_window_wait_event = sfRenderWindow_waitEvent(render_window: RenderWindow, event: Event*): Int32
    # Wait for an event and return it
    # 
    # Arguments:
    # - render_window: Render window object
    # - event: Event to fill
    # 
    # Returns: False if an error occured
  
  fun render_window_get_position = sfRenderWindow_getPosition(render_window: RenderWindow): Vector2i
    # Get the position of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # 
    # Returns: Position in pixels
  
  fun render_window_set_position = sfRenderWindow_setPosition(render_window: RenderWindow, position: Vector2i)
    # Change the position of a render window on screen
    # 
    # Only works for top-level windows
    # 
    # Arguments:
    # - render_window: Render window object
    # - position: New position, in pixels
  
  fun render_window_get_size = sfRenderWindow_getSize(render_window: RenderWindow): Vector2i
    # Get the size of the rendering region of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # 
    # Returns: Size in pixels
  
  fun render_window_set_size = sfRenderWindow_setSize(render_window: RenderWindow, size: Vector2i)
    # Change the size of the rendering region of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # - size: New size, in pixels
  
  fun render_window_set_title = sfRenderWindow_setTitle(render_window: RenderWindow, title: UInt8*)
    # Change the title of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # - title: New title
  
  fun render_window_set_unicode_title = sfRenderWindow_setUnicodeTitle(render_window: RenderWindow, title: Char*)
    # Change the title of a render window (with a UTF-32 string)
    # 
    # Arguments:
    # - render_window: Render window object
    # - title: New title
  
  fun render_window_set_icon = sfRenderWindow_setIcon(render_window: RenderWindow, width: Int32, height: Int32, pixels: UInt8*)
    # Change a render window's icon
    # 
    # Arguments:
    # - render_window: Render window object
    # - width: Icon's width, in pixels
    # - height: Icon's height, in pixels
    # - pixels: Pointer to the pixels in memory, format must be RGBA 32 bits
  
  fun render_window_set_visible = sfRenderWindow_setVisible(render_window: RenderWindow, visible: Int32)
    # Show or hide a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # - visible: True to show the window, False to hide it
  
  fun render_window_set_mouse_cursor_visible = sfRenderWindow_setMouseCursorVisible(render_window: RenderWindow, show: Int32)
    # Show or hide the mouse cursor on a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # - show: True to show, False to hide
  
  fun render_window_set_vertical_sync_enabled = sfRenderWindow_setVerticalSyncEnabled(render_window: RenderWindow, enabled: Int32)
    # Enable / disable vertical synchronization on a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # - enabled: True to enable v-sync, False to deactivate
  
  fun render_window_set_key_repeat_enabled = sfRenderWindow_setKeyRepeatEnabled(render_window: RenderWindow, enabled: Int32)
    # Enable or disable automatic key-repeat for keydown events
    # 
    # Automatic key-repeat is enabled by default
    # 
    # Arguments:
    # - render_window: Render window object
    # - enabled: True to enable, False to disable
  
  fun render_window_set_active = sfRenderWindow_setActive(render_window: RenderWindow, active: Int32): Int32
    # Activate or deactivate a render window as the current target for rendering
    # 
    # Arguments:
    # - render_window: Render window object
    # - active: True to activate, False to deactivate
    # 
    # Returns: True if operation was successful, false otherwise
  
  fun render_window_request_focus = sfRenderWindow_requestFocus(render_window: RenderWindow)
    # Request the current render window to be made the active
    # foreground window
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or mouse events.
    # If a window requests focus, it only hints to the operating
    # system, that it would like to be focused. The operating system
    # is free to deny the request.
    # This is not to be confused with Window_setActive().
  
  fun render_window_has_focus = sfRenderWindow_hasFocus(render_window: RenderWindow): Int32
    # Check whether the render window has the input focus
    # 
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or most mouse
    # events.
    # 
    # Returns: True if window has focus, false otherwise
  
  fun render_window_display = sfRenderWindow_display(render_window: RenderWindow)
    # Display a render window on screen
    # 
    # Arguments:
    # - render_window: Render window object
  
  fun render_window_set_framerate_limit = sfRenderWindow_setFramerateLimit(render_window: RenderWindow, limit: Int32)
    # Limit the framerate to a maximum fixed frequency for a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # - limit: Framerate limit, in frames per seconds (use 0 to disable limit)
  
  fun render_window_set_joystick_threshold = sfRenderWindow_setJoystickThreshold(render_window: RenderWindow, threshold: Float32)
    # Change the joystick threshold, ie. the value below which no move event will be generated
    # 
    # Arguments:
    # - render_window: Render window object
    # - threshold: New threshold, in range [0, 100]
  
  fun render_window_get_system_handle = sfRenderWindow_getSystemHandle(render_window: RenderWindow): WindowHandle
    # Retrieve the OS-specific handle of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # 
    # Returns: Window handle
  
  fun render_window_clear = sfRenderWindow_clear(render_window: RenderWindow, color: Color)
    # Clear a render window with the given color
    # 
    # Arguments:
    # - render_window: Render window object
    # - color: Fill color
  
  fun render_window_set_view = sfRenderWindow_setView(render_window: RenderWindow, view: View)
    # Change the current active view of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # - view: Pointer to the new view
  
  fun render_window_get_view = sfRenderWindow_getView(render_window: RenderWindow): View
    # Get the current active view of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # 
    # Returns: Current active view
  
  fun render_window_get_default_view = sfRenderWindow_getDefaultView(render_window: RenderWindow): View
    # Get the default view of a render window
    # 
    # Arguments:
    # - render_window: Render window object
    # 
    # Returns: Default view of the render window
  
  fun render_window_get_viewport = sfRenderWindow_getViewport(render_window: RenderWindow, view: View): IntRect
    # Get the viewport of a view applied to this target
    # 
    # Arguments:
    # - render_window: Render window object
    # - view: Target view
    # 
    # Returns: Viewport rectangle, expressed in pixels in the current target
  
  fun render_window_map_pixel_to_coords = sfRenderWindow_mapPixelToCoords(render_window: RenderWindow, point: Vector2i, view: View): Vector2f
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
    # Arguments:
    # - render_window: Render window object
    # - point: Pixel to convert
    # - view: The view to use for converting the point
    # 
    # Returns: The converted point, in "world" units
  
  fun render_window_map_coords_to_pixel = sfRenderWindow_mapCoordsToPixel(render_window: RenderWindow, point: Vector2f, view: View): Vector2i
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
    # Arguments:
    # - render_window: Render window object
    # - point: Point to convert
    # - view: The view to use for converting the point
    # 
    # Returns: The converted point, in target coordinates (pixels)
  
  fun render_window_draw_sprite = sfRenderWindow_drawSprite(render_window: RenderWindow, object: Sprite, states: RenderStates*)
    # Draw a drawable object to the render-target
    # 
    # Arguments:
    # - render_window: render window object
    # - object: Object to draw
    # - states: Render states to use for drawing (NULL to use the default states)
  
  fun render_window_draw_text = sfRenderWindow_drawText(render_window: RenderWindow, object: Text, states: RenderStates*)
  
  fun render_window_draw_shape = sfRenderWindow_drawShape(render_window: RenderWindow, object: Shape, states: RenderStates*)
  
  fun render_window_draw_circle_shape = sfRenderWindow_drawCircleShape(render_window: RenderWindow, object: CircleShape, states: RenderStates*)
  
  fun render_window_draw_convex_shape = sfRenderWindow_drawConvexShape(render_window: RenderWindow, object: ConvexShape, states: RenderStates*)
  
  fun render_window_draw_rectangle_shape = sfRenderWindow_drawRectangleShape(render_window: RenderWindow, object: RectangleShape, states: RenderStates*)
  
  fun render_window_draw_vertex_array = sfRenderWindow_drawVertexArray(render_window: RenderWindow, object: VertexArray, states: RenderStates*)
  
  fun render_window_draw_primitives = sfRenderWindow_drawPrimitives(render_window: RenderWindow, vertices: Vertex*, vertex_count: Int32, type: PrimitiveType, states: RenderStates*)
    # Draw primitives defined by an array of vertices to a render window
    # 
    # Arguments:
    # - render_window: render window object
    # - vertices: Pointer to the vertices
    # - vertex_count: Number of vertices in the array
    # - type: Type of primitives to draw
    # - states: Render states to use for drawing (NULL to use the default states)
  
  fun render_window_push_gl_states = sfRenderWindow_pushGLStates(render_window: RenderWindow)
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
    # Arguments:
    # - render_window: render window object
  
  fun render_window_pop_gl_states = sfRenderWindow_popGLStates(render_window: RenderWindow)
    # Restore the previously saved OpenGL render states and matrices
    # 
    # See the description of push_gl_states to get a detailed
    # description of these functions.
    # 
    # Arguments:
    # - render_window: render window object
  
  fun render_window_reset_gl_states = sfRenderWindow_resetGLStates(render_window: RenderWindow)
    # Reset the internal OpenGL states so that the target is ready for drawing
    # 
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering, if you choose not to use
    # push_gl_states/pop_gl_states. It makes sure that all OpenGL
    # states needed by SFML are set, so that subsequent RenderWindow_draw*()
    # calls will work as expected.
    # 
    # Arguments:
    # - render_window: render window object
  
  fun render_window_capture = sfRenderWindow_capture(render_window: RenderWindow): Image
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
    # Arguments:
    # - render_window: Render window object
    # 
    # Returns: New image containing the captured contents
  
  fun mouse_get_position_render_window = sfMouse_getPositionRenderWindow(relative_to: RenderWindow): Vector2i
    # Get the current position of the mouse relative to a render-window
    # 
    # This function returns the current position of the mouse
    # cursor relative to the given render-window, or desktop if NULL is passed.
    # 
    # Arguments:
    # - relative_to: Reference window
    # 
    # Returns: Position of the mouse cursor, relative to the given render window
  
  fun mouse_set_position_render_window = sfMouse_setPositionRenderWindow(position: Vector2i, relative_to: RenderWindow)
    # Set the current position of the mouse relative to a render window
    # 
    # This function sets the current position of the mouse
    # cursor relative to the given render-window, or desktop if NULL is passed.
    # 
    # Arguments:
    # - position: New position of the mouse
    # - relative_to: Reference window
  
  fun touch_get_position_render_window = sfTouch_getPositionRenderWindow(finger: Int32, relative_to: RenderWindow): Vector2i
    # Get the current position of a touch in window coordinates
    # 
    # This function returns the current touch position
    # relative to the given render window, or desktop if NULL is passed.
    # 
    # Arguments:
    # - finger: Finger index
    # - relative_to: Reference window
    # 
    # Returns: Current position of `finger`, or undefined if it's not down
  
  fun render_texture_create = sfRenderTexture_create(width: Int32, height: Int32, depth_buffer: Int32): RenderTexture
    # Construct a new render texture
    # 
    # Arguments:
    # - width: Width of the render texture
    # - height: Height of the render texture
    # - depth_buffer: Do you want a depth-buffer attached? (useful only if you're doing 3D OpenGL on the rendertexture)
    # 
    # Returns: A new RenderTexture object, or NULL if it failed
  
  fun render_texture_destroy = sfRenderTexture_destroy(render_texture: RenderTexture)
    # Destroy an existing render texture
    # 
    # Arguments:
    # - render_texture: Render texture to destroy
  
  fun render_texture_get_size = sfRenderTexture_getSize(render_texture: RenderTexture): Vector2i
    # Get the size of the rendering region of a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # 
    # Returns: Size in pixels
  
  fun render_texture_set_active = sfRenderTexture_setActive(render_texture: RenderTexture, active: Int32): Int32
    # Activate or deactivate a render texture as the current target for rendering
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - active: True to activate, False to deactivate
    # 
    # Returns: True if operation was successful, false otherwise
  
  fun render_texture_display = sfRenderTexture_display(render_texture: RenderTexture)
    # Update the contents of the target texture
    # 
    # Arguments:
    # - render_texture: Render texture object
  
  fun render_texture_clear = sfRenderTexture_clear(render_texture: RenderTexture, color: Color)
    # Clear the rendertexture with the given color
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - color: Fill color
  
  fun render_texture_set_view = sfRenderTexture_setView(render_texture: RenderTexture, view: View)
    # Change the current active view of a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - view: Pointer to the new view
  
  fun render_texture_get_view = sfRenderTexture_getView(render_texture: RenderTexture): View
    # Get the current active view of a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # 
    # Returns: Current active view
  
  fun render_texture_get_default_view = sfRenderTexture_getDefaultView(render_texture: RenderTexture): View
    # Get the default view of a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # 
    # Returns: Default view of the rendertexture
  
  fun render_texture_get_viewport = sfRenderTexture_getViewport(render_texture: RenderTexture, view: View): IntRect
    # Get the viewport of a view applied to this target
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - view: Target view
    # 
    # Returns: Viewport rectangle, expressed in pixels in the current target
  
  fun render_texture_map_pixel_to_coords = sfRenderTexture_mapPixelToCoords(render_texture: RenderTexture, point: Vector2i, view: View): Vector2f
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
    # Arguments:
    # - render_texture: Render texture object
    # - point: Pixel to convert
    # - view: The view to use for converting the point
    # 
    # Returns: The converted point, in "world" units
  
  fun render_texture_map_coords_to_pixel = sfRenderTexture_mapCoordsToPixel(render_texture: RenderTexture, point: Vector2f, view: View): Vector2i
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
    # Arguments:
    # - render_texture: Render texture object
    # - point: Point to convert
    # - view: The view to use for converting the point
    # 
    # Returns: The converted point, in target coordinates (pixels)
  
  fun render_texture_draw_sprite = sfRenderTexture_drawSprite(render_texture: RenderTexture, object: Sprite, states: RenderStates*)
    # Draw a drawable object to the render-target
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - object: Object to draw
    # - states: Render states to use for drawing (NULL to use the default states)
  
  fun render_texture_draw_text = sfRenderTexture_drawText(render_texture: RenderTexture, object: Text, states: RenderStates*)
  
  fun render_texture_draw_shape = sfRenderTexture_drawShape(render_texture: RenderTexture, object: Shape, states: RenderStates*)
  
  fun render_texture_draw_circle_shape = sfRenderTexture_drawCircleShape(render_texture: RenderTexture, object: CircleShape, states: RenderStates*)
  
  fun render_texture_draw_convex_shape = sfRenderTexture_drawConvexShape(render_texture: RenderTexture, object: ConvexShape, states: RenderStates*)
  
  fun render_texture_draw_rectangle_shape = sfRenderTexture_drawRectangleShape(render_texture: RenderTexture, object: RectangleShape, states: RenderStates*)
  
  fun render_texture_draw_vertex_array = sfRenderTexture_drawVertexArray(render_texture: RenderTexture, object: VertexArray, states: RenderStates*)
  
  fun render_texture_draw_primitives = sfRenderTexture_drawPrimitives(render_texture: RenderTexture, vertices: Vertex*, vertex_count: Int32, type: PrimitiveType, states: RenderStates*)
    # Draw primitives defined by an array of vertices to a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - vertices: Pointer to the vertices
    # - vertex_count: Number of vertices in the array
    # - type: Type of primitives to draw
    # - states: Render states to use for drawing (NULL to use the default states)
  
  fun render_texture_push_gl_states = sfRenderTexture_pushGLStates(render_texture: RenderTexture)
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
    # Arguments:
    # - render_texture: Render texture object
  
  fun render_texture_pop_gl_states = sfRenderTexture_popGLStates(render_texture: RenderTexture)
    # Restore the previously saved OpenGL render states and matrices
    # 
    # See the description of push_gl_states to get a detailed
    # description of these functions.
    # 
    # Arguments:
    # - render_texture: Render texture object
  
  fun render_texture_reset_gl_states = sfRenderTexture_resetGLStates(render_texture: RenderTexture)
    # Reset the internal OpenGL states so that the target is ready for drawing
    # 
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering, if you choose not to use
    # push_gl_states/pop_gl_states. It makes sure that all OpenGL
    # states needed by SFML are set, so that subsequent RenderTexture_draw*()
    # calls will work as expected.
    # 
    # Arguments:
    # - render_texture: Render texture object
  
  fun render_texture_get_texture = sfRenderTexture_getTexture(render_texture: RenderTexture): Texture
    # Get the target texture of a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # 
    # Returns: Pointer to the target texture
  
  fun render_texture_set_smooth = sfRenderTexture_setSmooth(render_texture: RenderTexture, smooth: Int32)
    # Enable or disable the smooth filter on a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - smooth: True to enable smoothing, False to disable it
  
  fun render_texture_is_smooth = sfRenderTexture_isSmooth(render_texture: RenderTexture): Int32
    # Tell whether the smooth filter is enabled or not for a render texture
    # 
    # Arguments:
    # - render_texture: Render texture object
    # 
    # Returns: True if smoothing is enabled, False if it is disabled
  
  fun render_texture_set_repeated = sfRenderTexture_setRepeated(render_texture: RenderTexture, repeated: Int32)
    # Enable or disable texture repeating
    # 
    # Arguments:
    # - render_texture: Render texture object
    # - repeated: True to enable repeating, False to disable it
  
  fun render_texture_is_repeated = sfRenderTexture_isRepeated(render_texture: RenderTexture): Int32
    # Tell whether the texture is repeated or not
    # 
    # Arguments:
    # - render_texture: Render texture object
    # 
    # Returns: True if repeat mode is enabled, False if it is disabled
  
  fun shader_create_from_file = sfShader_createFromFile(vertex_shader_filename: UInt8*, fragment_shader_filename: UInt8*): Shader
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
    # Arguments:
    # - vertex_shader_filename: Path of the vertex shader file to load, or NULL to skip this shader
    # - fragment_shader_filename: Path of the fragment shader file to load, or NULL to skip this shader
    # 
    # Returns: A new Shader object, or NULL if it failed
  
  fun shader_create_from_memory = sfShader_createFromMemory(vertex_shader: UInt8*, fragment_shader: UInt8*): Shader
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
    # Arguments:
    # - vertex_shader: String containing the source code of the vertex shader, or NULL to skip this shader
    # - fragment_shader: String containing the source code of the fragment shader, or NULL to skip this shader
    # 
    # Returns: A new Shader object, or NULL if it failed
  
  fun shader_create_from_stream = sfShader_createFromStream(vertex_shader_stream: InputStream*, fragment_shader_stream: InputStream*): Shader
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
    # Arguments:
    # - vertex_shader_stream: Source stream to read the vertex shader from, or NULL to skip this shader
    # - fragment_shader_stream: Source stream to read the fragment shader from, or NULL to skip this shader
    # 
    # Returns: A new Shader object, or NULL if it failed
  
  fun shader_destroy = sfShader_destroy(shader: Shader)
    # Destroy an existing shader
    # 
    # Arguments:
    # - shader: Shader to delete
  
  fun shader_set_float_parameter = sfShader_setFloatParameter(shader: Shader, name: UInt8*, x: Float32)
    # Change a float parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a float
    # (float GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - x: Value to assign
  
  fun shader_set_float2_parameter = sfShader_setFloat2Parameter(shader: Shader, name: UInt8*, x: Float32, y: Float32)
    # Change a 2-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 2x1 vector
    # (vec2 GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - x: First component of the value to assign
    # - y: Second component of the value to assign
  
  fun shader_set_float3_parameter = sfShader_setFloat3Parameter(shader: Shader, name: UInt8*, x: Float32, y: Float32, z: Float32)
    # Change a 3-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 3x1 vector
    # (vec3 GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - x: First component of the value to assign
    # - y: Second component of the value to assign
    # - z: Third component of the value to assign
  
  fun shader_set_float4_parameter = sfShader_setFloat4Parameter(shader: Shader, name: UInt8*, x: Float32, y: Float32, z: Float32, w: Float32)
    # Change a 4-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 4x1 vector
    # (vec4 GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - x: First component of the value to assign
    # - y: Second component of the value to assign
    # - z: Third component of the value to assign
    # - w: Fourth component of the value to assign
  
  fun shader_set_vector2_parameter = sfShader_setVector2Parameter(shader: Shader, name: UInt8*, vector: Vector2f)
    # Change a 2-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 2x1 vector
    # (vec2 GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - vector: Vector to assign
  
  fun shader_set_vector3_parameter = sfShader_setVector3Parameter(shader: Shader, name: UInt8*, vector: Vector3f)
    # Change a 3-components vector parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 3x1 vector
    # (vec3 GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - vector: Vector to assign
  
  fun shader_set_color_parameter = sfShader_setColorParameter(shader: Shader, name: UInt8*, color: Color)
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
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - color: Color to assign
  
  fun shader_set_transform_parameter = sfShader_setTransformParameter(shader: Shader, name: UInt8*, transform: Transform)
    # Change a matrix parameter of a shader
    # 
    # `name` is the name of the variable to change in the shader.
    # The corresponding parameter in the shader must be a 4x4 matrix
    # (mat4 GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the parameter in the shader
    # - transform: Transform to assign
  
  fun shader_set_texture_parameter = sfShader_setTextureParameter(shader: Shader, name: UInt8*, texture: Texture)
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
    # Arguments:
    # - shader: Shader object
    # - name: Name of the texture in the shader
    # - texture: Texture to assign
  
  fun shader_set_current_texture_parameter = sfShader_setCurrentTextureParameter(shader: Shader, name: UInt8*)
    # Change a texture parameter of a shader
    # 
    # This function maps a shader texture variable to the
    # texture of the object being drawn, which cannot be
    # known in advance.
    # The corresponding parameter in the shader must be a 2D texture
    # (sampler2D GLSL type).
    # 
    # 
    # Arguments:
    # - shader: Shader object
    # - name: Name of the texture in the shader
  
  fun shader_bind = sfShader_bind(shader: Shader)
    # Bind a shader for rendering (activate it)
    # 
    # This function is not part of the graphics API, it mustn't be
    # used when drawing SFML entities. It must be used only if you
    # mix Shader with OpenGL code.
    # 
    # 
    # Arguments:
    # - shader: Shader to bind, can be null to use no shader
  
  fun shader_is_available = sfShader_isAvailable(): Int32
    # Tell whether or not the system supports shaders
    # 
    # This function should always be called before using
    # the shader features. If it returns false, then
    # any attempt to use Shader will fail.
    # 
    # Returns: True if the system can use shaders, False otherwise
  
  alias ShapeGetPointCountCallback = (Void*) -> Int32
  alias ShapeGetPointCallback = (Int32, Void*) -> Vector2f
  fun shape_create = sfShape_create(get_point_count: ShapeGetPointCountCallback, get_point: ShapeGetPointCallback, user_data: Void*): Shape
    # Create a new shape
    # 
    # Arguments:
    # - get_point_count: Callback that provides the point count of the shape
    # - get_point: Callback that provides the points of the shape
    # - user_data: Data to pass to the callback functions
    # 
    # Returns: A new Shape object
  
  fun shape_destroy = sfShape_destroy(shape: Shape)
    # Destroy an existing shape
    # 
    # Arguments:
    # - Shape: Shape to delete
  
  fun shape_set_position = sfShape_setPosition(shape: Shape, position: Vector2f)
    # Set the position of a shape
    # 
    # This function completely overwrites the previous position.
    # See Shape_move to apply an offset based on the previous position instead.
    # The default position of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - position: New position
  
  fun shape_set_rotation = sfShape_setRotation(shape: Shape, angle: Float32)
    # Set the orientation of a shape
    # 
    # This function completely overwrites the previous rotation.
    # See Shape_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a circle Shape object is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: New rotation, in degrees
  
  fun shape_set_scale = sfShape_setScale(shape: Shape, scale: Vector2f)
    # Set the scale factors of a shape
    # 
    # This function completely overwrites the previous scale.
    # See Shape_scale to add a factor based on the previous scale instead.
    # The default scale of a circle Shape object is (1, 1).
    # 
    # Arguments:
    # - shape: Shape object
    # - scale: New scale factors
  
  fun shape_set_origin = sfShape_setOrigin(shape: Shape, origin: Vector2f)
    # Set the local origin of a shape
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a circle Shape object is (0, 0).
    # 
    # Arguments:
    # - shape: Shape object
    # - origin: New origin
  
  fun shape_get_position = sfShape_getPosition(shape: Shape): Vector2f
    # Get the position of a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current position
  
  fun shape_get_rotation = sfShape_getRotation(shape: Shape): Float32
    # Get the orientation of a shape
    # 
    # The rotation is always in the range [0, 360].
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current rotation, in degrees
  
  fun shape_get_scale = sfShape_getScale(shape: Shape): Vector2f
    # Get the current scale of a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current scale factors
  
  fun shape_get_origin = sfShape_getOrigin(shape: Shape): Vector2f
    # Get the local origin of a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Current origin
  
  fun shape_move = sfShape_move(shape: Shape, offset: Vector2f)
    # Move a shape by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Shape_setPosition which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - offset: Offset
  
  fun shape_rotate = sfShape_rotate(shape: Shape, angle: Float32)
    # Rotate a shape
    # 
    # This function adds to the current rotation of the object,
    # unlike Shape_setRotation which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - angle: Angle of rotation, in degrees
  
  fun shape_scale = sfShape_scale(shape: Shape, factors: Vector2f)
    # Scale a shape
    # 
    # This function multiplies the current scale of the object,
    # unlike Shape_setScale which overwrites it.
    # 
    # Arguments:
    # - shape: Shape object
    # - factors: Scale factors
  
  fun shape_get_transform = sfShape_getTransform(shape: Shape): Transform
    # Get the combined transform of a shape
    # 
    # Arguments:
    # - shape: shape object
    # 
    # Returns: Transform combining the position/rotation/scale/origin of the object
  
  fun shape_get_inverse_transform = sfShape_getInverseTransform(shape: Shape): Transform
    # Get the inverse of the combined transform of a shape
    # 
    # Arguments:
    # - shape: shape object
    # 
    # Returns: Inverse of the combined transformations applied to the object
  
  fun shape_set_texture = sfShape_setTexture(shape: Shape, texture: Texture, reset_rect: Int32)
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
    # Arguments:
    # - shape: Shape object
    # - texture: New texture
    # - reset_rect: Should the texture rect be reset to the size of the new texture?
  
  fun shape_set_texture_rect = sfShape_setTextureRect(shape: Shape, rect: IntRect)
    # Set the sub-rectangle of the texture that a shape will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # Arguments:
    # - shape: Shape object
    # - rect: Rectangle defining the region of the texture to display
  
  fun shape_set_fill_color = sfShape_setFillColor(shape: Shape, color: Color)
    # Set the fill color of a shape
    # 
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use Transparent to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New color of the shape
  
  fun shape_set_outline_color = sfShape_setOutlineColor(shape: Shape, color: Color)
    # Set the outline color of a shape
    # 
    # You can use Transparent to disable the outline.
    # By default, the shape's outline color is opaque white.
    # 
    # Arguments:
    # - shape: Shape object
    # - color: New outline color of the shape
  
  fun shape_set_outline_thickness = sfShape_setOutlineThickness(shape: Shape, thickness: Float32)
    # Set the thickness of a shape's outline
    # 
    # This number cannot be negative. Using zero disables
    # the outline.
    # By default, the outline thickness is 0.
    # 
    # Arguments:
    # - shape: Shape object
    # - thickness: New outline thickness
  
  fun shape_get_texture = sfShape_getTexture(shape: Shape): Texture
    # Get the source texture of a shape
    # 
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Pointer to the shape's texture
  
  fun shape_get_texture_rect = sfShape_getTextureRect(shape: Shape): IntRect
    # Get the sub-rectangle of the texture displayed by a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Texture rectangle of the shape
  
  fun shape_get_fill_color = sfShape_getFillColor(shape: Shape): Color
    # Get the fill color of a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Fill color of the shape
  
  fun shape_get_outline_color = sfShape_getOutlineColor(shape: Shape): Color
    # Get the outline color of a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline color of the shape
  
  fun shape_get_outline_thickness = sfShape_getOutlineThickness(shape: Shape): Float32
    # Get the outline thickness of a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Outline thickness of the shape
  
  fun shape_get_point_count = sfShape_getPointCount(shape: Shape): Int32
    # Get the total number of points of a shape
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Number of points of the shape
  
  fun shape_get_point = sfShape_getPoint(shape: Shape, index: Int32): Vector2f
    # Get a point of a shape
    # 
    # The result is undefined if `index` is out of the valid range.
    # 
    # Arguments:
    # - shape: Shape object
    # - index: Index of the point to get, in range [0 .. get_point_count() - 1]
    # 
    # Returns: Index-th point of the shape
  
  fun shape_get_local_bounds = sfShape_getLocalBounds(shape: Shape): FloatRect
    # Get the local bounding rectangle of a shape
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Local bounding rectangle of the entity
  
  fun shape_get_global_bounds = sfShape_getGlobalBounds(shape: Shape): FloatRect
    # Get the global bounding rectangle of a shape
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # Arguments:
    # - shape: Shape object
    # 
    # Returns: Global bounding rectangle of the entity
  
  fun shape_update = sfShape_update(shape: Shape)
    # Recompute the internal geometry of a shape
    # 
    # This function must be called by specialized shape objects
    # everytime their points change (ie. the result of either
    # the get_point_count or get_point callbacks is different).
  
  fun sprite_create = sfSprite_create(): Sprite
    # Create a new sprite
    # 
    # Returns: A new Sprite object, or NULL if it failed
  
  fun sprite_copy = sfSprite_copy(sprite: Sprite): Sprite
    # Copy an existing sprite
    # 
    # Arguments:
    # - sprite: Sprite to copy
    # 
    # Returns: Copied object
  
  fun sprite_destroy = sfSprite_destroy(sprite: Sprite)
    # Destroy an existing sprite
    # 
    # Arguments:
    # - sprite: Sprite to delete
  
  fun sprite_set_position = sfSprite_setPosition(sprite: Sprite, position: Vector2f)
    # Set the position of a sprite
    # 
    # This function completely overwrites the previous position.
    # See Sprite_move to apply an offset based on the previous position instead.
    # The default position of a sprite Sprite object is (0, 0).
    # 
    # Arguments:
    # - sprite: Sprite object
    # - position: New position
  
  fun sprite_set_rotation = sfSprite_setRotation(sprite: Sprite, angle: Float32)
    # Set the orientation of a sprite
    # 
    # This function completely overwrites the previous rotation.
    # See Sprite_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a sprite Sprite object is 0.
    # 
    # Arguments:
    # - sprite: Sprite object
    # - angle: New rotation, in degrees
  
  fun sprite_set_scale = sfSprite_setScale(sprite: Sprite, scale: Vector2f)
    # Set the scale factors of a sprite
    # 
    # This function completely overwrites the previous scale.
    # See Sprite_scale to add a factor based on the previous scale instead.
    # The default scale of a sprite Sprite object is (1, 1).
    # 
    # Arguments:
    # - sprite: Sprite object
    # - scale: New scale factors
  
  fun sprite_set_origin = sfSprite_setOrigin(sprite: Sprite, origin: Vector2f)
    # Set the local origin of a sprite
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a sprite Sprite object is (0, 0).
    # 
    # Arguments:
    # - sprite: Sprite object
    # - origin: New origin
  
  fun sprite_get_position = sfSprite_getPosition(sprite: Sprite): Vector2f
    # Get the position of a sprite
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Current position
  
  fun sprite_get_rotation = sfSprite_getRotation(sprite: Sprite): Float32
    # Get the orientation of a sprite
    # 
    # The rotation is always in the range [0, 360].
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Current rotation, in degrees
  
  fun sprite_get_scale = sfSprite_getScale(sprite: Sprite): Vector2f
    # Get the current scale of a sprite
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Current scale factors
  
  fun sprite_get_origin = sfSprite_getOrigin(sprite: Sprite): Vector2f
    # Get the local origin of a sprite
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Current origin
  
  fun sprite_move = sfSprite_move(sprite: Sprite, offset: Vector2f)
    # Move a sprite by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Sprite_setPosition which overwrites it.
    # 
    # Arguments:
    # - sprite: Sprite object
    # - offset: Offset
  
  fun sprite_rotate = sfSprite_rotate(sprite: Sprite, angle: Float32)
    # Rotate a sprite
    # 
    # This function adds to the current rotation of the object,
    # unlike Sprite_setRotation which overwrites it.
    # 
    # Arguments:
    # - sprite: Sprite object
    # - angle: Angle of rotation, in degrees
  
  fun sprite_scale = sfSprite_scale(sprite: Sprite, factors: Vector2f)
    # Scale a sprite
    # 
    # This function multiplies the current scale of the object,
    # unlike Sprite_setScale which overwrites it.
    # 
    # Arguments:
    # - sprite: Sprite object
    # - factors: Scale factors
  
  fun sprite_get_transform = sfSprite_getTransform(sprite: Sprite): Transform
    # Get the combined transform of a sprite
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Transform combining the position/rotation/scale/origin of the object
  
  fun sprite_get_inverse_transform = sfSprite_getInverseTransform(sprite: Sprite): Transform
    # Get the inverse of the combined transform of a sprite
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Inverse of the combined transformations applied to the object
  
  fun sprite_set_texture = sfSprite_setTexture(sprite: Sprite, texture: Texture, reset_rect: Int32)
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
    # Arguments:
    # - sprite: Sprite object
    # - texture: New texture
    # - reset_rect: Should the texture rect be reset to the size of the new texture?
  
  fun sprite_set_texture_rect = sfSprite_setTextureRect(sprite: Sprite, rectangle: IntRect)
    # Set the sub-rectangle of the texture that a sprite will display
    # 
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    # 
    # Arguments:
    # - sprite: Sprite object
    # - rectangle: Rectangle defining the region of the texture to display
  
  fun sprite_set_color = sfSprite_setColor(sprite: Sprite, color: Color)
    # Set the global color of a sprite
    # 
    # This color is modulated (multiplied) with the sprite's
    # texture. It can be used to colorize the sprite, or change
    # its global opacity.
    # By default, the sprite's color is opaque white.
    # 
    # Arguments:
    # - sprite: Sprite object
    # - color: New color of the sprite
  
  fun sprite_get_texture = sfSprite_getTexture(sprite: Sprite): Texture
    # Get the source texture of a sprite
    # 
    # If the sprite has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Pointer to the sprite's texture
  
  fun sprite_get_texture_rect = sfSprite_getTextureRect(sprite: Sprite): IntRect
    # Get the sub-rectangle of the texture displayed by a sprite
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Texture rectangle of the sprite
  
  fun sprite_get_color = sfSprite_getColor(sprite: Sprite): Color
    # Get the global color of a sprite
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Global color of the sprite
  
  fun sprite_get_local_bounds = sfSprite_getLocalBounds(sprite: Sprite): FloatRect
    # Get the local bounding rectangle of a sprite
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Local bounding rectangle of the entity
  
  fun sprite_get_global_bounds = sfSprite_getGlobalBounds(sprite: Sprite): FloatRect
    # Get the global bounding rectangle of a sprite
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    # 
    # Arguments:
    # - sprite: Sprite object
    # 
    # Returns: Global bounding rectangle of the entity
  
  enum TextStyle: UInt32
    Regular = 0, Bold = 1, Italic = 2, Underlined = 4, StrikeThrough = 8
  end
  
  fun text_create = sfText_create(): Text
    # Create a new text
    # 
    # Returns: A new Text object, or NULL if it failed
  
  fun text_copy = sfText_copy(text: Text): Text
    # Copy an existing text
    # 
    # Arguments:
    # - text: Text to copy
    # 
    # Returns: Copied object
  
  fun text_destroy = sfText_destroy(text: Text)
    # Destroy an existing text
    # 
    # Arguments:
    # - text: Text to delete
  
  fun text_set_position = sfText_setPosition(text: Text, position: Vector2f)
    # Set the position of a text
    # 
    # This function completely overwrites the previous position.
    # See Text_move to apply an offset based on the previous position instead.
    # The default position of a text Text object is (0, 0).
    # 
    # Arguments:
    # - text: Text object
    # - position: New position
  
  fun text_set_rotation = sfText_setRotation(text: Text, angle: Float32)
    # Set the orientation of a text
    # 
    # This function completely overwrites the previous rotation.
    # See Text_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a text Text object is 0.
    # 
    # Arguments:
    # - text: Text object
    # - angle: New rotation, in degrees
  
  fun text_set_scale = sfText_setScale(text: Text, scale: Vector2f)
    # Set the scale factors of a text
    # 
    # This function completely overwrites the previous scale.
    # See Text_scale to add a factor based on the previous scale instead.
    # The default scale of a text Text object is (1, 1).
    # 
    # Arguments:
    # - text: Text object
    # - scale: New scale factors
  
  fun text_set_origin = sfText_setOrigin(text: Text, origin: Vector2f)
    # Set the local origin of a text
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a text object is (0, 0).
    # 
    # Arguments:
    # - text: Text object
    # - origin: New origin
  
  fun text_get_position = sfText_getPosition(text: Text): Vector2f
    # Get the position of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Current position
  
  fun text_get_rotation = sfText_getRotation(text: Text): Float32
    # Get the orientation of a text
    # 
    # The rotation is always in the range [0, 360].
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Current rotation, in degrees
  
  fun text_get_scale = sfText_getScale(text: Text): Vector2f
    # Get the current scale of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Current scale factors
  
  fun text_get_origin = sfText_getOrigin(text: Text): Vector2f
    # Get the local origin of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Current origin
  
  fun text_move = sfText_move(text: Text, offset: Vector2f)
    # Move a text by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Text_setPosition which overwrites it.
    # 
    # Arguments:
    # - text: Text object
    # - offset: Offset
  
  fun text_rotate = sfText_rotate(text: Text, angle: Float32)
    # Rotate a text
    # 
    # This function adds to the current rotation of the object,
    # unlike Text_setRotation which overwrites it.
    # 
    # Arguments:
    # - text: Text object
    # - angle: Angle of rotation, in degrees
  
  fun text_scale = sfText_scale(text: Text, factors: Vector2f)
    # Scale a text
    # 
    # This function multiplies the current scale of the object,
    # unlike Text_setScale which overwrites it.
    # 
    # Arguments:
    # - text: Text object
    # - factors: Scale factors
  
  fun text_get_transform = sfText_getTransform(text: Text): Transform
    # Get the combined transform of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Transform combining the position/rotation/scale/origin of the object
  
  fun text_get_inverse_transform = sfText_getInverseTransform(text: Text): Transform
    # Get the inverse of the combined transform of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Inverse of the combined transformations applied to the object
  
  fun text_set_string = sfText_setString(text: Text, string: UInt8*)
    # Set the string of a text (from an ANSI string)
    # 
    # A text's string is empty by default.
    # 
    # Arguments:
    # - text: Text object
    # - string: New string
  
  fun text_set_unicode_string = sfText_setUnicodeString(text: Text, string: Char*)
    # Set the string of a text (from a unicode string)
    # 
    # Arguments:
    # - text: Text object
    # - string: New string
  
  fun text_set_font = sfText_setFont(text: Text, font: Font)
    # Set the font of a text
    # 
    # The `font` argument refers to a texture that must
    # exist as long as the text uses it. Indeed, the text
    # doesn't store its own copy of the font, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the font is destroyed and the text tries to
    # use it, the behaviour is undefined.
    # 
    # Arguments:
    # - text: Text object
    # - font: New font
  
  fun text_set_character_size = sfText_setCharacterSize(text: Text, size: Int32)
    # Set the character size of a text
    # 
    # The default size is 30.
    # 
    # Arguments:
    # - text: Text object
    # - size: New character size, in pixels
  
  fun text_set_style = sfText_setStyle(text: Text, style: TextStyle)
    # Set the style of a text
    # 
    # You can pass a combination of one or more styles, for
    # example TextBold | TextItalic.
    # The default style is TextRegular.
    # 
    # Arguments:
    # - text: Text object
    # - style: New style
  
  fun text_set_color = sfText_setColor(text: Text, color: Color)
    # Set the global color of a text
    # 
    # By default, the text's color is opaque white.
    # 
    # Arguments:
    # - text: Text object
    # - color: New color of the text
  
  fun text_get_string = sfText_getString(text: Text): UInt8*
    # Get the string of a text (returns an ANSI string)
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: String as a locale-dependant ANSI string
  
  fun text_get_unicode_string = sfText_getUnicodeString(text: Text): Char*
    # Get the string of a text (returns a unicode string)
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: String as UTF-32
  
  fun text_get_font = sfText_getFont(text: Text): Font
    # Get the font used by a text
    # 
    # If the text has no font attached, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the font when you retrieve it with this function.
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Pointer to the font
  
  fun text_get_character_size = sfText_getCharacterSize(text: Text): Int32
    # Get the size of the characters of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Size of the characters
  
  fun text_get_style = sfText_getStyle(text: Text): UInt32
    # Get the style of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Current string style (see TextStyle enum)
  
  fun text_get_color = sfText_getColor(text: Text): Color
    # Get the global color of a text
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Global color of the text
  
  fun text_find_character_pos = sfText_findCharacterPos(text: Text, index: Size_t): Vector2f
    # Return the position of the `index`-th character in a text
    # 
    # This function computes the visual position of a character
    # from its index in the string. The returned position is
    # in global coordinates (translation, rotation, scale and
    # origin are applied).
    # If `index` is out of range, the position of the end of
    # the string is returned.
    # 
    # Arguments:
    # - text: Text object
    # - index: Index of the character
    # 
    # Returns: Position of the character
  
  fun text_get_local_bounds = sfText_getLocalBounds(text: Text): FloatRect
    # Get the local bounding rectangle of a text
    # 
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Local bounding rectangle of the entity
  
  fun text_get_global_bounds = sfText_getGlobalBounds(text: Text): FloatRect
    # Get the global bounding rectangle of a text
    # 
    # The returned rectangle is in global coordinates, which means
    # that it takes in account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # text in the global 2D world's coordinate system.
    # 
    # Arguments:
    # - text: Text object
    # 
    # Returns: Global bounding rectangle of the entity
  
  fun texture_create = sfTexture_create(width: Int32, height: Int32): Texture
    # Create a new texture
    # 
    # Arguments:
    # - width: Texture width
    # - height: Texture height
    # 
    # Returns: A new Texture object, or NULL if it failed
  
  fun texture_create_from_file = sfTexture_createFromFile(filename: UInt8*, area: IntRect*): Texture
    # Create a new texture from a file
    # 
    # Arguments:
    # - filename: Path of the image file to load
    # - area: Area of the source image to load (NULL to load the entire image)
    # 
    # Returns: A new Texture object, or NULL if it failed
  
  fun texture_create_from_memory = sfTexture_createFromMemory(data: Void*, size_in_bytes: Size_t, area: IntRect*): Texture
    # Create a new texture from a file in memory
    # 
    # Arguments:
    # - data: Pointer to the file data in memory
    # - size_in_bytes: Size of the data to load, in bytes
    # - area: Area of the source image to load (NULL to load the entire image)
    # 
    # Returns: A new Texture object, or NULL if it failed
  
  fun texture_create_from_stream = sfTexture_createFromStream(stream: InputStream*, area: IntRect*): Texture
    # Create a new texture from a custom stream
    # 
    # Arguments:
    # - stream: Source stream to read from
    # - area: Area of the source image to load (NULL to load the entire image)
    # 
    # Returns: A new Texture object, or NULL if it failed
  
  fun texture_create_from_image = sfTexture_createFromImage(image: Image, area: IntRect*): Texture
    # Create a new texture from an image
    # 
    # Arguments:
    # - image: Image to upload to the texture
    # - area: Area of the source image to load (NULL to load the entire image)
    # 
    # Returns: A new Texture object, or NULL if it failed
  
  fun texture_copy = sfTexture_copy(texture: Texture): Texture
    # Copy an existing texture
    # 
    # Arguments:
    # - texture: Texture to copy
    # 
    # Returns: Copied object
  
  fun texture_destroy = sfTexture_destroy(texture: Texture)
    # Destroy an existing texture
    # 
    # Arguments:
    # - texture: Texture to delete
  
  fun texture_get_size = sfTexture_getSize(texture: Texture): Vector2i
    # Return the size of the texture
    # 
    # Arguments:
    # - texture: Texture to read
    # 
    # Returns: Size in pixels
  
  fun texture_copy_to_image = sfTexture_copyToImage(texture: Texture): Image
    # Copy a texture's pixels to an image
    # 
    # Arguments:
    # - texture: Texture to copy
    # 
    # Returns: Image containing the texture's pixels
  
  fun texture_update_from_pixels = sfTexture_updateFromPixels(texture: Texture, pixels: UInt8*, width: Int32, height: Int32, x: Int32, y: Int32)
    # Update a texture from an array of pixels
    # 
    # Arguments:
    # - texture: Texture to update
    # - pixels: Array of pixels to copy to the texture
    # - width: Width of the pixel region contained in `pixels`
    # - height: Height of the pixel region contained in `pixels`
    # - x: X offset in the texture where to copy the source pixels
    # - y: Y offset in the texture where to copy the source pixels
  
  fun texture_update_from_image = sfTexture_updateFromImage(texture: Texture, image: Image, x: Int32, y: Int32)
    # Update a texture from an image
    # 
    # Arguments:
    # - texture: Texture to update
    # - image: Image to copy to the texture
    # - x: X offset in the texture where to copy the source pixels
    # - y: Y offset in the texture where to copy the source pixels
  
  fun texture_update_from_window = sfTexture_updateFromWindow(texture: Texture, window: Window, x: Int32, y: Int32)
    # Update a texture from the contents of a window
    # 
    # Arguments:
    # - texture: Texture to update
    # - window: Window to copy to the texture
    # - x: X offset in the texture where to copy the source pixels
    # - y: Y offset in the texture where to copy the source pixels
  
  fun texture_update_from_render_window = sfTexture_updateFromRenderWindow(texture: Texture, render_window: RenderWindow, x: Int32, y: Int32)
    # Update a texture from the contents of a render-window
    # 
    # Arguments:
    # - texture: Texture to update
    # - render_window: Render-window to copy to the texture
    # - x: X offset in the texture where to copy the source pixels
    # - y: Y offset in the texture where to copy the source pixels
  
  fun texture_set_smooth = sfTexture_setSmooth(texture: Texture, smooth: Int32)
    # Enable or disable the smooth filter on a texture
    # 
    # Arguments:
    # - texture: The texture object
    # - smooth: True to enable smoothing, False to disable it
  
  fun texture_is_smooth = sfTexture_isSmooth(texture: Texture): Int32
    # Tell whether the smooth filter is enabled or not for a texture
    # 
    # Arguments:
    # - texture: The texture object
    # 
    # Returns: True if smoothing is enabled, False if it is disabled
  
  fun texture_set_repeated = sfTexture_setRepeated(texture: Texture, repeated: Int32)
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
    # Arguments:
    # - texture: The texture object
    # - repeated: True to repeat the texture, false to disable repeating
  
  fun texture_is_repeated = sfTexture_isRepeated(texture: Texture): Int32
    # Tell whether a texture is repeated or not
    # 
    # Arguments:
    # - texture: The texture object
    # 
    # Returns: True if repeat mode is enabled, False if it is disabled
  
  fun texture_bind = sfTexture_bind(texture: Texture)
    # Bind a texture for rendering
    # 
    # This function is not part of the graphics API, it mustn't be
    # used when drawing SFML entities. It must be used only if you
    # mix Texture with OpenGL code.
    # 
    # 
    # Arguments:
    # - texture: Pointer to the texture to bind, can be null to use no texture
  
  fun texture_get_maximum_size = sfTexture_getMaximumSize(): Int32
    # Get the maximum texture size allowed
    # 
    # Returns: Maximum size allowed for textures, in pixels
  
  fun transformable_create = sfTransformable_create(): Transformable
    # Create a new transformable
    # 
    # Returns: A new Transformable object
  
  fun transformable_copy = sfTransformable_copy(transformable: Transformable): Transformable
    # Copy an existing transformable
    # 
    # Arguments:
    # - transformable: Transformable to copy
    # 
    # Returns: Copied object
  
  fun transformable_destroy = sfTransformable_destroy(transformable: Transformable)
    # Destroy an existing transformable
    # 
    # Arguments:
    # - transformable: Transformable to delete
  
  fun transformable_set_position = sfTransformable_setPosition(transformable: Transformable, position: Vector2f)
    # Set the position of a transformable
    # 
    # This function completely overwrites the previous position.
    # See Transformable_move to apply an offset based on the previous position instead.
    # The default position of a transformable Transformable object is (0, 0).
    # 
    # Arguments:
    # - transformable: Transformable object
    # - position: New position
  
  fun transformable_set_rotation = sfTransformable_setRotation(transformable: Transformable, angle: Float32)
    # Set the orientation of a transformable
    # 
    # This function completely overwrites the previous rotation.
    # See Transformable_rotate to add an angle based on the previous rotation instead.
    # The default rotation of a transformable Transformable object is 0.
    # 
    # Arguments:
    # - transformable: Transformable object
    # - angle: New rotation, in degrees
  
  fun transformable_set_scale = sfTransformable_setScale(transformable: Transformable, scale: Vector2f)
    # Set the scale factors of a transformable
    # 
    # This function completely overwrites the previous scale.
    # See Transformable_scale to add a factor based on the previous scale instead.
    # The default scale of a transformable Transformable object is (1, 1).
    # 
    # Arguments:
    # - transformable: Transformable object
    # - scale: New scale factors
  
  fun transformable_set_origin = sfTransformable_setOrigin(transformable: Transformable, origin: Vector2f)
    # Set the local origin of a transformable
    # 
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a transformable Transformable object is (0, 0).
    # 
    # Arguments:
    # - transformable: Transformable object
    # - origin: New origin
  
  fun transformable_get_position = sfTransformable_getPosition(transformable: Transformable): Vector2f
    # Get the position of a transformable
    # 
    # Arguments:
    # - transformable: Transformable object
    # 
    # Returns: Current position
  
  fun transformable_get_rotation = sfTransformable_getRotation(transformable: Transformable): Float32
    # Get the orientation of a transformable
    # 
    # The rotation is always in the range [0, 360].
    # 
    # Arguments:
    # - transformable: Transformable object
    # 
    # Returns: Current rotation, in degrees
  
  fun transformable_get_scale = sfTransformable_getScale(transformable: Transformable): Vector2f
    # Get the current scale of a transformable
    # 
    # Arguments:
    # - transformable: Transformable object
    # 
    # Returns: Current scale factors
  
  fun transformable_get_origin = sfTransformable_getOrigin(transformable: Transformable): Vector2f
    # Get the local origin of a transformable
    # 
    # Arguments:
    # - transformable: Transformable object
    # 
    # Returns: Current origin
  
  fun transformable_move = sfTransformable_move(transformable: Transformable, offset: Vector2f)
    # Move a transformable by a given offset
    # 
    # This function adds to the current position of the object,
    # unlike Transformable_setPosition which overwrites it.
    # 
    # Arguments:
    # - transformable: Transformable object
    # - offset: Offset
  
  fun transformable_rotate = sfTransformable_rotate(transformable: Transformable, angle: Float32)
    # Rotate a transformable
    # 
    # This function adds to the current rotation of the object,
    # unlike Transformable_setRotation which overwrites it.
    # 
    # Arguments:
    # - transformable: Transformable object
    # - angle: Angle of rotation, in degrees
  
  fun transformable_scale = sfTransformable_scale(transformable: Transformable, factors: Vector2f)
    # Scale a transformable
    # 
    # This function multiplies the current scale of the object,
    # unlike Transformable_setScale which overwrites it.
    # 
    # Arguments:
    # - transformable: Transformable object
    # - factors: Scale factors
  
  fun transformable_get_transform = sfTransformable_getTransform(transformable: Transformable): Transform
    # Get the combined transform of a transformable
    # 
    # Arguments:
    # - transformable: Transformable object
    # 
    # Returns: Transform combining the position/rotation/scale/origin of the object
  
  fun transformable_get_inverse_transform = sfTransformable_getInverseTransform(transformable: Transformable): Transform
    # Get the inverse of the combined transform of a transformable
    # 
    # Arguments:
    # - transformable: Transformable object
    # 
    # Returns: Inverse of the combined transformations applied to the object
  
  fun vertex_array_create = sfVertexArray_create(): VertexArray
    # Create a new vertex array
    # 
    # Returns: A new VertexArray object
  
  fun vertex_array_copy = sfVertexArray_copy(vertex_array: VertexArray): VertexArray
    # Copy an existing vertex array
    # 
    # Arguments:
    # - vertex_array: Vertex array to copy
    # 
    # Returns: Copied object
  
  fun vertex_array_destroy = sfVertexArray_destroy(vertex_array: VertexArray)
    # Destroy an existing vertex array
    # 
    # Arguments:
    # - vertex_array: Vertex array to delete
  
  fun vertex_array_get_vertex_count = sfVertexArray_getVertexCount(vertex_array: VertexArray): Int32
    # Return the vertex count of a vertex array
    # 
    # Arguments:
    # - vertex_array: Vertex array object
    # 
    # Returns: Number of vertices in the array
  
  fun vertex_array_get_vertex = sfVertexArray_getVertex(vertex_array: VertexArray, index: Int32): Vertex*
    # Get access to a vertex by its index
    # 
    # This function doesn't check `index`, it must be in range
    # [0, vertex count - 1]. The behaviour is undefined
    # otherwise.
    # 
    # Arguments:
    # - vertex_array: Vertex array object
    # - index: Index of the vertex to get
    # 
    # Returns: Pointer to the index-th vertex
  
  fun vertex_array_clear = sfVertexArray_clear(vertex_array: VertexArray)
    # Clear a vertex array
    # 
    # This function removes all the vertices from the array.
    # It doesn't deallocate the corresponding memory, so that
    # adding new vertices after clearing doesn't involve
    # reallocating all the memory.
    # 
    # Arguments:
    # - vertex_array: Vertex array object
  
  fun vertex_array_resize = sfVertexArray_resize(vertex_array: VertexArray, vertex_count: Int32)
    # Resize the vertex array
    # 
    # If `vertex_count` is greater than the current size, the previous
    # vertices are kept and new (default-constructed) vertices are
    # added.
    # If `vertex_count` is less than the current size, existing vertices
    # are removed from the array.
    # 
    # Arguments:
    # - vertex_array: Vertex array objet
    # - vertex_count: New size of the array (number of vertices)
  
  fun vertex_array_append = sfVertexArray_append(vertex_array: VertexArray, vertex: Vertex)
    # Add a vertex to a vertex array array
    # 
    # Arguments:
    # - vertex_array: Vertex array objet
    # - vertex: Vertex to add
  
  fun vertex_array_set_primitive_type = sfVertexArray_setPrimitiveType(vertex_array: VertexArray, type: PrimitiveType)
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
    # Arguments:
    # - vertex_array: Vertex array objet
    # - type: Type of primitive
  
  fun vertex_array_get_primitive_type = sfVertexArray_getPrimitiveType(vertex_array: VertexArray): PrimitiveType
    # Get the type of primitives drawn by a vertex array
    # 
    # Arguments:
    # - vertex_array: Vertex array objet
    # 
    # Returns: Primitive type
  
  fun vertex_array_get_bounds = sfVertexArray_getBounds(vertex_array: VertexArray): FloatRect
    # Compute the bounding rectangle of a vertex array
    # 
    # This function returns the axis-aligned rectangle that
    # contains all the vertices of the array.
    # 
    # Arguments:
    # - vertex_array: Vertex array objet
    # 
    # Returns: Bounding rectangle of the vertex array
  
  fun view_create = sfView_create(): View
    # Create a default view
    # 
    # This function creates a default view of (0, 0, 1000, 1000)
    # 
    # Returns: A new View object
  
  fun view_create_from_rect = sfView_createFromRect(rectangle: FloatRect): View
    # Construct a view from a rectangle
    # 
    # Arguments:
    # - rectangle: Rectangle defining the zone to display
    # 
    # Returns: A new View object
  
  fun view_copy = sfView_copy(view: View): View
    # Copy an existing view
    # 
    # Arguments:
    # - view: View to copy
    # 
    # Returns: Copied object
  
  fun view_destroy = sfView_destroy(view: View)
    # Destroy an existing view
    # 
    # Arguments:
    # - view: View to destroy
  
  fun view_set_center = sfView_setCenter(view: View, center: Vector2f)
    # Set the center of a view
    # 
    # Arguments:
    # - view: View object
    # - center: New center
  
  fun view_set_size = sfView_setSize(view: View, size: Vector2f)
    # Set the size of a view
    # 
    # Arguments:
    # - view: View object
    # - size: New size of the view
  
  fun view_set_rotation = sfView_setRotation(view: View, angle: Float32)
    # Set the orientation of a view
    # 
    # The default rotation of a view is 0 degree.
    # 
    # Arguments:
    # - view: View object
    # - angle: New angle, in degrees
  
  fun view_set_viewport = sfView_setViewport(view: View, viewport: FloatRect)
    # Set the target viewport of a view
    # 
    # The viewport is the rectangle into which the contents of the
    # view are displayed, expressed as a factor (between 0 and 1)
    # of the size of the render target to which the view is applied.
    # For example, a view which takes the left side of the target would
    # be defined by a rect of (0, 0, 0.5, 1).
    # By default, a view has a viewport which covers the entire target.
    # 
    # Arguments:
    # - view: View object
    # - viewport: New viewport rectangle
  
  fun view_reset = sfView_reset(view: View, rectangle: FloatRect)
    # Reset a view to the given rectangle
    # 
    # Note that this function resets the rotation angle to 0.
    # 
    # Arguments:
    # - view: View object
    # - rectangle: Rectangle defining the zone to display
  
  fun view_get_center = sfView_getCenter(view: View): Vector2f
    # Get the center of a view
    # 
    # Arguments:
    # - view: View object
    # 
    # Returns: Center of the view
  
  fun view_get_size = sfView_getSize(view: View): Vector2f
    # Get the size of a view
    # 
    # Arguments:
    # - view: View object
    # 
    # Returns: Size of the view
  
  fun view_get_rotation = sfView_getRotation(view: View): Float32
    # Get the current orientation of a view
    # 
    # Arguments:
    # - view: View object
    # 
    # Returns: Rotation angle of the view, in degrees
  
  fun view_get_viewport = sfView_getViewport(view: View): FloatRect
    # Get the target viewport rectangle of a view
    # 
    # Arguments:
    # - view: View object
    # 
    # Returns: Viewport rectangle, expressed as a factor of the target size
  
  fun view_move = sfView_move(view: View, offset: Vector2f)
    # Move a view relatively to its current position
    # 
    # Arguments:
    # - view: View object
    # - offset: Offset
  
  fun view_rotate = sfView_rotate(view: View, angle: Float32)
    # Rotate a view relatively to its current orientation
    # 
    # Arguments:
    # - view: View object
    # - angle: Angle to rotate, in degrees
  
  fun view_zoom = sfView_zoom(view: View, factor: Float32)
    # Resize a view rectangle relatively to its current size
    # 
    # Resizing the view simulates a zoom, as the zone displayed on
    # screen grows or shrinks.
    # `factor` is a multiplier:
    # - 1 keeps the size unchanged
    # - > 1 makes the view bigger (objects appear smaller)
    # - < 1 makes the view smaller (objects appear bigger)
    # 
    # Arguments:
    # - view: View object
    # - factor: Zoom factor to apply
  
end