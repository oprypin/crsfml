require "./lib"
require "../common"
require "../window"
require "../system"
module SF
  extend self
  # Blending modes for drawing
  #
  # `SF::BlendMode` is a class that represents a blend mode. A blend
  # mode determines how the colors of an object you draw are
  # mixed with the colors that are already in the buffer.
  #
  # The class is composed of 6 components, each of which has its
  # own public member variable:
  # * %Color Source Factor (*color_src_factor*)
  # * %Color Destination Factor (*color_dst_factor*)
  # * %Color Blend Equation (*color_equation*)
  # * Alpha Source Factor (*alpha_src_factor*)
  # * Alpha Destination Factor (*alpha_dst_factor*)
  # * Alpha Blend Equation (*alpha_equation*)
  #
  # The source factor specifies how the pixel you are drawing contributes
  # to the final color. The destination factor specifies how the pixel
  # already drawn in the buffer contributes to the final color.
  #
  # The color channels RGB (red, green, blue; simply referred to as
  # color) and A (alpha; the transparency) can be treated separately. This
  # separation can be useful for specific blend modes, but most often you
  # won't need it and will simply treat the color as a single unit.
  #
  # The blend factors and equations correspond to their OpenGL equivalents.
  # In general, the color of the resulting pixel is calculated according
  # to the following formula (*src* is the color of the source pixel, *dst*
  # the color of the destination pixel, the other variables correspond to the
  # public members, with the equations being + or - operators):
  # ```c++
  # dst.rgb = colorSrcFactor * src.rgb (colorEquation) colorDstFactor * dst.rgb
  # dst.a   = alphaSrcFactor * src.a   (alphaEquation) alphaDstFactor * dst.a
  # ```
  # All factors and colors are represented as floating point numbers between
  # 0 and 1. Where necessary, the result is clamped to fit in that range.
  #
  # The most common blending modes are defined as constants
  # in the sf namespace:
  #
  # ```c++
  # sf::BlendMode alphaBlending          = sf::BlendAlpha;
  # sf::BlendMode additiveBlending       = sf::BlendAdd;
  # sf::BlendMode multiplicativeBlending = sf::BlendMultiply;
  # sf::BlendMode noBlending             = sf::BlendNone;
  # ```
  #
  # In SFML, a blend mode can be specified every time you draw a `SF::Drawable`
  # object to a render target. It is part of the `SF::RenderStates` compound
  # that is passed to the member function `SF::RenderTarget::draw`().
  #
  # *See also:* `SF::RenderStates`, `SF::RenderTarget`
  struct BlendMode
    @color_src_factor : BlendMode::Factor
    @color_dst_factor : BlendMode::Factor
    @color_equation : BlendMode::Equation
    @alpha_src_factor : BlendMode::Factor
    @alpha_dst_factor : BlendMode::Factor
    @alpha_equation : BlendMode::Equation
    # Enumeration of the blending factors
    #
    # The factors are mapped directly to their OpenGL equivalents,
    # specified by gl_blend_func() or gl_blend_func_separate().
    enum Factor
      # (0, 0, 0, 0)
      Zero
      # (1, 1, 1, 1)
      One
      # (src.r, src.g, src.b, src.a)
      SrcColor
      # (1, 1, 1, 1) - (src.r, src.g, src.b, src.a)
      OneMinusSrcColor
      # (dst.r, dst.g, dst.b, dst.a)
      DstColor
      # (1, 1, 1, 1) - (dst.r, dst.g, dst.b, dst.a)
      OneMinusDstColor
      # (src.a, src.a, src.a, src.a)
      SrcAlpha
      # (1, 1, 1, 1) - (src.a, src.a, src.a, src.a)
      OneMinusSrcAlpha
      # (dst.a, dst.a, dst.a, dst.a)
      DstAlpha
      # (1, 1, 1, 1) - (dst.a, dst.a, dst.a, dst.a)
      OneMinusDstAlpha
    end
    _sf_enum BlendMode::Factor
    # Enumeration of the blending equations
    #
    # The equations are mapped directly to their OpenGL equivalents,
    # specified by gl_blend_equation() or gl_blend_equation_separate().
    enum Equation
      # Pixel = Src * SrcFactor + Dst * DstFactor
      Add
      # Pixel = Src * SrcFactor - Dst * DstFactor
      Subtract
      # Pixel = Dst * DstFactor - Src * SrcFactor
      ReverseSubtract
    end
    _sf_enum BlendMode::Equation
    # Default constructor
    #
    # Constructs a blending mode that does alpha blending.
    def initialize()
      @color_src_factor = uninitialized BlendMode::Factor
      @color_dst_factor = uninitialized BlendMode::Factor
      @color_equation = uninitialized BlendMode::Equation
      @alpha_src_factor = uninitialized BlendMode::Factor
      @alpha_dst_factor = uninitialized BlendMode::Factor
      @alpha_equation = uninitialized BlendMode::Equation
      VoidCSFML.blendmode_initialize(to_unsafe)
    end
    # Construct the blend mode given the factors and equation.
    #
    # This constructor uses the same factors and equation for both
    # color and alpha components. It also defaults to the Add equation.
    #
    # * *source_factor* -      Specifies how to compute the source factor for the color and alpha channels.
    # * *destination_factor* - Specifies how to compute the destination factor for the color and alpha channels.
    # * *blend_equation* -     Specifies how to combine the source and destination colors and alpha.
    def initialize(source_factor : BlendMode::Factor, destination_factor : BlendMode::Factor, blend_equation : BlendMode::Equation = Add)
      @color_src_factor = uninitialized BlendMode::Factor
      @color_dst_factor = uninitialized BlendMode::Factor
      @color_equation = uninitialized BlendMode::Equation
      @alpha_src_factor = uninitialized BlendMode::Factor
      @alpha_dst_factor = uninitialized BlendMode::Factor
      @alpha_equation = uninitialized BlendMode::Equation
      VoidCSFML.blendmode_initialize_8xr8xrBw1(to_unsafe, source_factor, destination_factor, blend_equation)
    end
    # Construct the blend mode given the factors and equation.
    #
    # * *color_source_factor* -      Specifies how to compute the source factor for the color channels.
    # * *color_destination_factor* - Specifies how to compute the destination factor for the color channels.
    # * *color_blend_equation* -     Specifies how to combine the source and destination colors.
    # * *alpha_source_factor* -      Specifies how to compute the source factor.
    # * *alpha_destination_factor* - Specifies how to compute the destination factor.
    # * *alpha_blend_equation* -     Specifies how to combine the source and destination alphas.
    def initialize(color_source_factor : BlendMode::Factor, color_destination_factor : BlendMode::Factor, color_blend_equation : BlendMode::Equation, alpha_source_factor : BlendMode::Factor, alpha_destination_factor : BlendMode::Factor, alpha_blend_equation : BlendMode::Equation)
      @color_src_factor = uninitialized BlendMode::Factor
      @color_dst_factor = uninitialized BlendMode::Factor
      @color_equation = uninitialized BlendMode::Equation
      @alpha_src_factor = uninitialized BlendMode::Factor
      @alpha_dst_factor = uninitialized BlendMode::Factor
      @alpha_equation = uninitialized BlendMode::Equation
      VoidCSFML.blendmode_initialize_8xr8xrBw18xr8xrBw1(to_unsafe, color_source_factor, color_destination_factor, color_blend_equation, alpha_source_factor, alpha_destination_factor, alpha_blend_equation)
    end
    @color_src_factor : BlendMode::Factor
    # Source blending factor for the color channels
    def color_src_factor : BlendMode::Factor
      @color_src_factor
    end
    def color_src_factor=(color_src_factor : BlendMode::Factor)
      @color_src_factor = color_src_factor
    end
    @color_dst_factor : BlendMode::Factor
    # Destination blending factor for the color channels
    def color_dst_factor : BlendMode::Factor
      @color_dst_factor
    end
    def color_dst_factor=(color_dst_factor : BlendMode::Factor)
      @color_dst_factor = color_dst_factor
    end
    @color_equation : BlendMode::Equation
    # Blending equation for the color channels
    def color_equation : BlendMode::Equation
      @color_equation
    end
    def color_equation=(color_equation : BlendMode::Equation)
      @color_equation = color_equation
    end
    @alpha_src_factor : BlendMode::Factor
    # Source blending factor for the alpha channel
    def alpha_src_factor : BlendMode::Factor
      @alpha_src_factor
    end
    def alpha_src_factor=(alpha_src_factor : BlendMode::Factor)
      @alpha_src_factor = alpha_src_factor
    end
    @alpha_dst_factor : BlendMode::Factor
    # Destination blending factor for the alpha channel
    def alpha_dst_factor : BlendMode::Factor
      @alpha_dst_factor
    end
    def alpha_dst_factor=(alpha_dst_factor : BlendMode::Factor)
      @alpha_dst_factor = alpha_dst_factor
    end
    @alpha_equation : BlendMode::Equation
    # Blending equation for the alpha channel
    def alpha_equation : BlendMode::Equation
      @alpha_equation
    end
    def alpha_equation=(alpha_equation : BlendMode::Equation)
      @alpha_equation = alpha_equation
    end
    # Overload of the == operator
    #
    # * *left* -  Left operand
    # * *right* - Right operand
    #
    # *Returns:* True if blending modes are equal, false if they are different
    def ==(right : BlendMode) : Bool
      VoidCSFML.operator_eq_PG5PG5(to_unsafe, right, out result)
      return result
    end
    # Overload of the != operator
    #
    # * *left* -  Left operand
    # * *right* - Right operand
    #
    # *Returns:* True if blending modes are different, false if they are equal
    def !=(right : BlendMode) : Bool
      VoidCSFML.operator_ne_PG5PG5(to_unsafe, right, out result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@color_src_factor).as(Void*)
    end
    # :nodoc:
    def initialize(copy : BlendMode)
      @color_src_factor = uninitialized BlendMode::Factor
      @color_dst_factor = uninitialized BlendMode::Factor
      @color_equation = uninitialized BlendMode::Equation
      @alpha_src_factor = uninitialized BlendMode::Factor
      @alpha_dst_factor = uninitialized BlendMode::Factor
      @alpha_equation = uninitialized BlendMode::Equation
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.blendmode_initialize_PG5(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Define a 3x3 transform matrix
  #
  # A `SF::Transform` specifies how to translate, rotate, scale,
  # shear, project, whatever things. In mathematical terms, it defines
  # how to transform a coordinate system into another.
  #
  # For example, if you apply a rotation transform to a sprite, the
  # result will be a rotated sprite. And anything that is transformed
  # by this rotation transform will be rotated the same way, according
  # to its initial position.
  #
  # Transforms are typically used for drawing. But they can also be
  # used for any computation that requires to transform points between
  # the local and global coordinate systems of an entity (like collision
  # detection).
  #
  # Example:
  # ```c++
  # // define a translation transform
  # sf::Transform translation;
  # translation.translate(20, 50);
  #
  # // define a rotation transform
  # sf::Transform rotation;
  # rotation.rotate(45);
  #
  # // combine them
  # sf::Transform transform = translation * rotation;
  #
  # // use the result to transform stuff...
  # sf::Vector2f point = transform.transformPoint(10, 20);
  # sf::FloatRect rect = transform.transformRect(sf::FloatRect(0, 0, 10, 100));
  # ```
  #
  # *See also:* `SF::Transformable`, `SF::RenderStates`
  struct Transform
    @m_matrix : LibC::Float[16]
    # Default constructor
    #
    # Creates an identity transform (a transform that does nothing).
    def initialize()
      @m_matrix = uninitialized Float32[16]
      VoidCSFML.transform_initialize(to_unsafe)
    end
    # Construct a transform from a 3x3 matrix
    #
    # * *a00* - Element (0, 0) of the matrix
    # * *a01* - Element (0, 1) of the matrix
    # * *a02* - Element (0, 2) of the matrix
    # * *a10* - Element (1, 0) of the matrix
    # * *a11* - Element (1, 1) of the matrix
    # * *a12* - Element (1, 2) of the matrix
    # * *a20* - Element (2, 0) of the matrix
    # * *a21* - Element (2, 1) of the matrix
    # * *a22* - Element (2, 2) of the matrix
    def initialize(a00 : Number, a01 : Number, a02 : Number, a10 : Number, a11 : Number, a12 : Number, a20 : Number, a21 : Number, a22 : Number)
      @m_matrix = uninitialized Float32[16]
      VoidCSFML.transform_initialize_Bw9Bw9Bw9Bw9Bw9Bw9Bw9Bw9Bw9(to_unsafe, LibC::Float.new(a00), LibC::Float.new(a01), LibC::Float.new(a02), LibC::Float.new(a10), LibC::Float.new(a11), LibC::Float.new(a12), LibC::Float.new(a20), LibC::Float.new(a21), LibC::Float.new(a22))
    end
    # Return the transform as a 4x4 matrix
    #
    # This function returns a pointer to an array of 16 floats
    # containing the transform elements as a 4x4 matrix, which
    # is directly compatible with OpenGL functions.
    #
    # ```c++
    # sf::Transform transform = ...;
    # glLoadMatrixf(transform.getMatrix());
    # ```
    #
    # *Returns:* Pointer to a 4x4 matrix
    def matrix() : Float32*
      VoidCSFML.transform_getmatrix(to_unsafe, out result)
      return result
    end
    # Return the inverse of the transform
    #
    # If the inverse cannot be computed, an identity transform
    # is returned.
    #
    # *Returns:* A new transform which is the inverse of self
    def inverse() : Transform
      result = Transform.allocate
      VoidCSFML.transform_getinverse(to_unsafe, result)
      return result
    end
    # Transform a 2D point
    #
    # * *x* - X coordinate of the point to transform
    # * *y* - Y coordinate of the point to transform
    #
    # *Returns:* Transformed point
    def transform_point(x : Number, y : Number) : Vector2f
      result = Vector2f.allocate
      VoidCSFML.transform_transformpoint_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y), result)
      return result
    end
    # Transform a 2D point
    #
    # * *point* - Point to transform
    #
    # *Returns:* Transformed point
    def transform_point(point : Vector2|Tuple) : Vector2f
      result = Vector2f.allocate
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.transform_transformpoint_UU2(to_unsafe, point, result)
      return result
    end
    # Transform a rectangle
    #
    # Since SFML doesn't provide support for oriented rectangles,
    # the result of this function is always an axis-aligned
    # rectangle. Which means that if the transform contains a
    # rotation, the bounding rectangle of the transformed rectangle
    # is returned.
    #
    # * *rectangle* - Rectangle to transform
    #
    # *Returns:* Transformed rectangle
    def transform_rect(rectangle : FloatRect) : FloatRect
      result = FloatRect.allocate
      VoidCSFML.transform_transformrect_WPZ(to_unsafe, rectangle, result)
      return result
    end
    # Combine the current transform with another one
    #
    # The result is a transform that is equivalent to applying
    # *this followed by *transform.* Mathematically, it is
    # equivalent to a matrix multiplication.
    #
    # * *transform* - Transform to combine with this transform
    #
    # *Returns:* Reference to *this
    def combine(transform : Transform) : Transform
      result = Transform.allocate
      VoidCSFML.transform_combine_FPe(to_unsafe, transform, result)
      return result
    end
    # Combine the current transform with a translation
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.translate(100, 200).rotate(45);
    # ```
    #
    # * *x* - Offset to apply on X axis
    # * *y* - Offset to apply on Y axis
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `rotate`, `scale`
    def translate(x : Number, y : Number) : Transform
      result = Transform.allocate
      VoidCSFML.transform_translate_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y), result)
      return result
    end
    # Combine the current transform with a translation
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.translate(sf::Vector2f(100, 200)).rotate(45);
    # ```
    #
    # * *offset* - Translation offset to apply
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `rotate`, `scale`
    def translate(offset : Vector2|Tuple) : Transform
      result = Transform.allocate
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.transform_translate_UU2(to_unsafe, offset, result)
      return result
    end
    # Combine the current transform with a rotation
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.rotate(90).translate(50, 20);
    # ```
    #
    # * *angle* - Rotation angle, in degrees
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `translate`, `scale`
    def rotate(angle : Number) : Transform
      result = Transform.allocate
      VoidCSFML.transform_rotate_Bw9(to_unsafe, LibC::Float.new(angle), result)
      return result
    end
    # Combine the current transform with a rotation
    #
    # The center of rotation is provided for convenience as a second
    # argument, so that you can build rotations around arbitrary points
    # more easily (and efficiently) than the usual
    # translate(-center).rotate(angle).translate(center).
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.rotate(90, 8, 3).translate(50, 20);
    # ```
    #
    # * *angle* - Rotation angle, in degrees
    # * *center_x* - X coordinate of the center of rotation
    # * *center_y* - Y coordinate of the center of rotation
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `translate`, `scale`
    def rotate(angle : Number, center_x : Number, center_y : Number) : Transform
      result = Transform.allocate
      VoidCSFML.transform_rotate_Bw9Bw9Bw9(to_unsafe, LibC::Float.new(angle), LibC::Float.new(center_x), LibC::Float.new(center_y), result)
      return result
    end
    # Combine the current transform with a rotation
    #
    # The center of rotation is provided for convenience as a second
    # argument, so that you can build rotations around arbitrary points
    # more easily (and efficiently) than the usual
    # translate(-center).rotate(angle).translate(center).
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.rotate(90, sf::Vector2f(8, 3)).translate(sf::Vector2f(50, 20));
    # ```
    #
    # * *angle* - Rotation angle, in degrees
    # * *center* - Center of rotation
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `translate`, `scale`
    def rotate(angle : Number, center : Vector2|Tuple) : Transform
      result = Transform.allocate
      center = Vector2f.new(center[0].to_f32, center[1].to_f32)
      VoidCSFML.transform_rotate_Bw9UU2(to_unsafe, LibC::Float.new(angle), center, result)
      return result
    end
    # Combine the current transform with a scaling
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.scale(2, 1).rotate(45);
    # ```
    #
    # * *scale_x* - Scaling factor on the X axis
    # * *scale_y* - Scaling factor on the Y axis
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `translate`, `rotate`
    def scale(scale_x : Number, scale_y : Number) : Transform
      result = Transform.allocate
      VoidCSFML.transform_scale_Bw9Bw9(to_unsafe, LibC::Float.new(scale_x), LibC::Float.new(scale_y), result)
      return result
    end
    # Combine the current transform with a scaling
    #
    # The center of scaling is provided for convenience as a second
    # argument, so that you can build scaling around arbitrary points
    # more easily (and efficiently) than the usual
    # translate(-center).scale(factors).translate(center).
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.scale(2, 1, 8, 3).rotate(45);
    # ```
    #
    # * *scale_x* - Scaling factor on X axis
    # * *scale_y* - Scaling factor on Y axis
    # * *center_x* - X coordinate of the center of scaling
    # * *center_y* - Y coordinate of the center of scaling
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `translate`, `rotate`
    def scale(scale_x : Number, scale_y : Number, center_x : Number, center_y : Number) : Transform
      result = Transform.allocate
      VoidCSFML.transform_scale_Bw9Bw9Bw9Bw9(to_unsafe, LibC::Float.new(scale_x), LibC::Float.new(scale_y), LibC::Float.new(center_x), LibC::Float.new(center_y), result)
      return result
    end
    # Combine the current transform with a scaling
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.scale(sf::Vector2f(2, 1)).rotate(45);
    # ```
    #
    # * *factors* - Scaling factors
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `translate`, `rotate`
    def scale(factors : Vector2|Tuple) : Transform
      result = Transform.allocate
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.transform_scale_UU2(to_unsafe, factors, result)
      return result
    end
    # Combine the current transform with a scaling
    #
    # The center of scaling is provided for convenience as a second
    # argument, so that you can build scaling around arbitrary points
    # more easily (and efficiently) than the usual
    # translate(-center).scale(factors).translate(center).
    #
    # This function returns a reference to *this, so that calls
    # can be chained.
    # ```c++
    # sf::Transform transform;
    # transform.scale(sf::Vector2f(2, 1), sf::Vector2f(8, 3)).rotate(45);
    # ```
    #
    # * *factors* - Scaling factors
    # * *center* - Center of scaling
    #
    # *Returns:* Reference to *this
    #
    # *See also:* `translate`, `rotate`
    def scale(factors : Vector2|Tuple, center : Vector2|Tuple) : Transform
      result = Transform.allocate
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      center = Vector2f.new(center[0].to_f32, center[1].to_f32)
      VoidCSFML.transform_scale_UU2UU2(to_unsafe, factors, center, result)
      return result
    end
    @m_matrix : LibC::Float[16]
    # Overload of binary operator * to combine two transforms
    #
    # This call is equivalent to calling Transform(left).combine(right).
    #
    # * *left* - Left operand (the first transform)
    # * *right* - Right operand (the second transform)
    #
    # *Returns:* New combined transform
    def *(right : Transform) : Transform
      result = Transform.allocate
      VoidCSFML.operator_mul_FPeFPe(to_unsafe, right, result)
      return result
    end
    # Overload of binary operator * to transform a point
    #
    # This call is equivalent to calling left.transform_point(right).
    #
    # * *left* - Left operand (the transform)
    # * *right* - Right operand (the point to transform)
    #
    # *Returns:* New transformed point
    def *(right : Vector2|Tuple) : Vector2f
      result = Vector2f.allocate
      right = Vector2f.new(right[0].to_f32, right[1].to_f32)
      VoidCSFML.operator_mul_FPeUU2(to_unsafe, right, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@m_matrix).as(Void*)
    end
    # :nodoc:
    def initialize(copy : Transform)
      @m_matrix = uninitialized Float32[16]
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.transform_initialize_FPe(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Define the states used for drawing to a RenderTarget
  #
  # There are four global states that can be applied to
  # the drawn objects:
  # * the blend mode: how pixels of the object are blended with the background
  # * the transform: how the object is positioned/rotated/scaled
  # * the texture: what image is mapped to the object
  # * the shader: what custom effect is applied to the object
  #
  # High-level objects such as sprites or text force some of
  # these states when they are drawn. For example, a sprite
  # will set its own texture, so that you don't have to care
  # about it when drawing the sprite.
  #
  # The transform is a special case: sprites, texts and shapes
  # (and it's a good idea to do it with your own drawable classes
  # too) combine their transform with the one that is passed in the
  # RenderStates structure. So that you can use a "global" transform
  # on top of each object's transform.
  #
  # Most objects, especially high-level drawables, can be drawn
  # directly without defining render states explicitly -- the
  # default set of states is ok in most cases.
  # ```c++
  # window.draw(sprite);
  # ```
  #
  # If you want to use a single specific render state,
  # for example a shader, you can pass it directly to the Draw
  # function: `SF::RenderStates` has an implicit one-argument
  # constructor for each state.
  # ```c++
  # window.draw(sprite, shader);
  # ```
  #
  # When you're inside the Draw function of a drawable
  # object (inherited from `SF::Drawable`), you can
  # either pass the render states unmodified, or change
  # some of them.
  # For example, a transformable object will combine the
  # current transform with its own transform. A sprite will
  # set its texture. Etc.
  #
  # *See also:* `SF::RenderTarget`, `SF::Drawable`
  struct RenderStates
    @blend_mode : BlendMode
    @transform : Transform
    @texture : Void*
    @shader : Void*
    # Default constructor
    #
    # Constructing a default set of render states is equivalent
    # to using `SF::RenderStates::Default`.
    # The default set defines:
    # * the BlendAlpha blend mode
    # * the identity transform
    # * a null texture
    # * a null shader
    def initialize()
      @blend_mode = uninitialized BlendMode
      @transform = uninitialized Transform
      @texture = uninitialized Void*
      @shader = uninitialized Void*
      VoidCSFML.renderstates_initialize(to_unsafe)
    end
    # Construct a default set of render states with a custom blend mode
    #
    # * *the_blend_mode* - Blend mode to use
    def initialize(blend_mode : BlendMode)
      @blend_mode = uninitialized BlendMode
      @transform = uninitialized Transform
      @texture = uninitialized Void*
      @shader = uninitialized Void*
      VoidCSFML.renderstates_initialize_PG5(to_unsafe, blend_mode)
    end
    # Construct a default set of render states with a custom transform
    #
    # * *the_transform* - Transform to use
    def initialize(transform : Transform)
      @blend_mode = uninitialized BlendMode
      @transform = uninitialized Transform
      @texture = uninitialized Void*
      @shader = uninitialized Void*
      VoidCSFML.renderstates_initialize_FPe(to_unsafe, transform)
    end
    # Construct a default set of render states with a custom texture
    #
    # * *the_texture* - Texture to use
    def initialize(texture : Texture?)
      @blend_mode = uninitialized BlendMode
      @transform = uninitialized Transform
      @texture = uninitialized Void*
      @shader = uninitialized Void*
      @_renderstates_texture = texture
      VoidCSFML.renderstates_initialize_MXd(to_unsafe, texture)
    end
    # Construct a default set of render states with a custom shader
    #
    # * *the_shader* - Shader to use
    def initialize(shader : Shader)
      @blend_mode = uninitialized BlendMode
      @transform = uninitialized Transform
      @texture = uninitialized Void*
      @shader = uninitialized Void*
      @_renderstates_shader = shader
      VoidCSFML.renderstates_initialize_8P6(to_unsafe, shader)
    end
    # Construct a set of render states with all its attributes
    #
    # * *the_blend_mode* - Blend mode to use
    # * *the_transform* - Transform to use
    # * *the_texture* -   Texture to use
    # * *the_shader* -    Shader to use
    def initialize(blend_mode : BlendMode, transform : Transform, texture : Texture?, shader : Shader)
      @blend_mode = uninitialized BlendMode
      @transform = uninitialized Transform
      @texture = uninitialized Void*
      @shader = uninitialized Void*
      @_renderstates_texture = texture
      @_renderstates_shader = shader
      VoidCSFML.renderstates_initialize_PG5FPeMXd8P6(to_unsafe, blend_mode, transform, texture, shader)
    end
    @blend_mode : BlendMode
    # Blending mode
    def blend_mode : BlendMode
      @blend_mode
    end
    def blend_mode=(blend_mode : BlendMode)
      @blend_mode = blend_mode
    end
    @transform : Transform
    # Transform
    def transform : Transform
      @transform
    end
    def transform=(transform : Transform)
      @transform = transform
    end
    @texture : Void*
    # Texture
    def texture : Texture?
      @_renderstates_texture
    end
    def texture=(texture : Texture?)
      @_renderstates_texture = texture
      @texture = texture ? texture.to_unsafe : Pointer(Void).null
    end
    @_renderstates_texture : Texture? = nil
    @shader : Void*
    # Shader
    def shader : Shader?
      @_renderstates_shader
    end
    def shader=(shader : Shader)
      @_renderstates_shader = shader
      @shader = shader ? shader.to_unsafe : Pointer(Void).null
    end
    @_renderstates_shader : Shader? = nil
    # :nodoc:
    def to_unsafe()
      pointerof(@blend_mode).as(Void*)
    end
    # :nodoc:
    def initialize(copy : RenderStates)
      @blend_mode = uninitialized BlendMode
      @transform = uninitialized Transform
      @texture = uninitialized Void*
      @shader = uninitialized Void*
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.renderstates_initialize_mi4(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Abstract base class for objects that can be drawn
  #        to a render target
  #
  # `SF::Drawable` is a very simple base class that allows objects
  # of derived classes to be drawn to a `SF::RenderTarget`.
  #
  # All you have to do in your derived class is to override the
  # draw virtual function.
  #
  # Note that inheriting from `SF::Drawable` is not mandatory,
  # but it allows this nice syntax "window.draw(object)" rather
  # than "object.draw(window)", which is more consistent with other
  # SFML classes.
  #
  # Example:
  # ```c++
  # class MyDrawable : public sf::Drawable
  # {
  # public:
  #
  #    ...
  #
  # private:
  #
  #     virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const
  #     {
  #         // You can draw other high-level objects
  #         target.draw(m_sprite, states);
  #
  #         // ... or use the low-level API
  #         states.texture = &m_texture;
  #         target.draw(m_vertices, states);
  #
  #         // ... or draw with OpenGL directly
  #         glBegin(GL_QUADS);
  #         ...
  #         glEnd();
  #     }
  #
  #     sf::Sprite m_sprite;
  #     sf::Texture m_texture;
  #     sf::VertexArray m_vertices;
  # };
  # ```
  #
  # *See also:* `SF::RenderTarget`
  module Drawable
  end
  # Decomposed transform defined by a position, a rotation and a scale
  #
  # This class is provided for convenience, on top of `SF::Transform`.
  #
  # `SF::Transform`, as a low-level class, offers a great level of
  # flexibility but it is not always convenient to manage. Indeed,
  # one can easily combine any kind of operation, such as a translation
  # followed by a rotation followed by a scaling, but once the result
  # transform is built, there's no way to go backward and, let's say,
  # change only the rotation without modifying the translation and scaling.
  # The entire transform must be recomputed, which means that you
  # need to retrieve the initial translation and scale factors as
  # well, and combine them the same way you did before updating the
  # rotation. This is a tedious operation, and it requires to store
  # all the individual components of the final transform.
  #
  # That's exactly what `SF::Transformable` was written for: it hides
  # these variables and the composed transform behind an easy to use
  # interface. You can set or get any of the individual components
  # without worrying about the others. It also provides the composed
  # transform (as a `SF::Transform`), and keeps it up-to-date.
  #
  # In addition to the position, rotation and scale, `SF::Transformable`
  # provides an "origin" component, which represents the local origin
  # of the three other components. Let's take an example with a 10x10
  # pixels sprite. By default, the sprite is positioned/rotated/scaled
  # relatively to its top-left corner, because it is the local point
  # (0, 0). But if we change the origin to be (5, 5), the sprite will
  # be positioned/rotated/scaled around its center instead. And if
  # we set the origin to (10, 10), it will be transformed around its
  # bottom-right corner.
  #
  # To keep the `SF::Transformable` class simple, there's only one
  # origin for all the components. You cannot position the sprite
  # relatively to its top-left corner while rotating it around its
  # center, for example. To do such things, use `SF::Transform` directly.
  #
  # `SF::Transformable` can be used as a base class. It is often
  # combined with `SF::Drawable` -- that's what SFML's sprites,
  # texts and shapes do.
  # ```c++
  # class MyEntity : public sf::Transformable, public sf::Drawable
  # {
  #     virtual void draw(sf::RenderTarget& target, sf::RenderStates states) const
  #     {
  #         states.transform *= getTransform();
  #         target.draw(..., states);
  #     }
  # };
  #
  # MyEntity entity;
  # entity.setPosition(10, 20);
  # entity.setRotation(45);
  # window.draw(entity);
  # ```
  #
  # It can also be used as a member, if you don't want to use
  # its API directly (because you don't need all its functions,
  # or you have different naming conventions for example).
  # ```c++
  # class MyEntity
  # {
  # public:
  #     void SetPosition(const MyVector& v)
  #     {
  #         myTransform.setPosition(v.x(), v.y());
  #     }
  #
  #     void Draw(sf::RenderTarget& target) const
  #     {
  #         target.draw(..., myTransform.getTransform());
  #     }
  #
  # private:
  #     sf::Transformable myTransform;
  # };
  # ```
  #
  # A note on coordinates and undistorted rendering:
  # By default, SFML (or more exactly, OpenGL) may interpolate drawable objects
  # such as sprites or texts when rendering. While this allows transitions
  # like slow movements or rotations to appear smoothly, it can lead to
  # unwanted results in some cases, for example blurred or distorted objects.
  # In order to render a `SF::Drawable` object pixel-perfectly, make sure
  # the involved coordinates allow a 1:1 mapping of pixels in the window
  # to texels (pixels in the texture). More specifically, this means:
  # * The object's position, origin and scale have no fractional part
  # * The object's and the view's rotation are a multiple of 90 degrees
  # * The view's center and size have no fractional part
  #
  # *See also:* `SF::Transform`
  class Transformable
    @_transformable : VoidCSFML::Transformable_Buffer
    # Default constructor
    def initialize()
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      VoidCSFML.transformable_initialize(to_unsafe)
    end
    # Virtual destructor
    def finalize()
      VoidCSFML.transformable_finalize(to_unsafe)
    end
    # set the position of the object
    #
    # This function completely overwrites the previous position.
    # See the move function to apply an offset based on the previous position instead.
    # The default position of a transformable object is (0, 0).
    #
    # * *x* - X coordinate of the new position
    # * *y* - Y coordinate of the new position
    #
    # *See also:* `move`, `position`
    def set_position(x : Number, y : Number)
      VoidCSFML.transformable_setposition_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # set the position of the object
    #
    # This function completely overwrites the previous position.
    # See the move function to apply an offset based on the previous position instead.
    # The default position of a transformable object is (0, 0).
    #
    # * *position* - New position
    #
    # *See also:* `move`, `position`
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.transformable_setposition_UU2(to_unsafe, position)
    end
    # set the orientation of the object
    #
    # This function completely overwrites the previous rotation.
    # See the rotate function to add an angle based on the previous rotation instead.
    # The default rotation of a transformable object is 0.
    #
    # * *angle* - New rotation, in degrees
    #
    # *See also:* `rotate`, `rotation`
    def rotation=(angle : Number)
      VoidCSFML.transformable_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # set the scale factors of the object
    #
    # This function completely overwrites the previous scale.
    # See the scale function to add a factor based on the previous scale instead.
    # The default scale of a transformable object is (1, 1).
    #
    # * *factor_x* - New horizontal scale factor
    # * *factor_y* - New vertical scale factor
    #
    # *See also:* `scale`, `scale`
    def set_scale(factor_x : Number, factor_y : Number)
      VoidCSFML.transformable_setscale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # set the scale factors of the object
    #
    # This function completely overwrites the previous scale.
    # See the scale function to add a factor based on the previous scale instead.
    # The default scale of a transformable object is (1, 1).
    #
    # * *factors* - New scale factors
    #
    # *See also:* `scale`, `scale`
    def scale=(factors : Vector2|Tuple)
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.transformable_setscale_UU2(to_unsafe, factors)
    end
    # set the local origin of the object
    #
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a transformable object is (0, 0).
    #
    # * *x* - X coordinate of the new origin
    # * *y* - Y coordinate of the new origin
    #
    # *See also:* `origin`
    def set_origin(x : Number, y : Number)
      VoidCSFML.transformable_setorigin_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # set the local origin of the object
    #
    # The origin of an object defines the center point for
    # all transformations (position, scale, rotation).
    # The coordinates of this point must be relative to the
    # top-left corner of the object, and ignore all
    # transformations (position, scale, rotation).
    # The default origin of a transformable object is (0, 0).
    #
    # * *origin* - New origin
    #
    # *See also:* `origin`
    def origin=(origin : Vector2|Tuple)
      origin = Vector2f.new(origin[0].to_f32, origin[1].to_f32)
      VoidCSFML.transformable_setorigin_UU2(to_unsafe, origin)
    end
    # get the position of the object
    #
    # *Returns:* Current position
    #
    # *See also:* `position=`
    def position() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.transformable_getposition(to_unsafe, result)
      return result
    end
    # get the orientation of the object
    #
    # The rotation is always in the range [0, 360].
    #
    # *Returns:* Current rotation, in degrees
    #
    # *See also:* `rotation=`
    def rotation() : Float32
      VoidCSFML.transformable_getrotation(to_unsafe, out result)
      return result
    end
    # get the current scale of the object
    #
    # *Returns:* Current scale factors
    #
    # *See also:* `scale=`
    def scale() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.transformable_getscale(to_unsafe, result)
      return result
    end
    # get the local origin of the object
    #
    # *Returns:* Current origin
    #
    # *See also:* `origin=`
    def origin() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.transformable_getorigin(to_unsafe, result)
      return result
    end
    # Move the object by a given offset
    #
    # This function adds to the current position of the object,
    # unlike position= which overwrites it.
    # Thus, it is equivalent to the following code:
    # ```c++
    # sf::Vector2f pos = object.getPosition();
    # object.setPosition(pos.x + offsetX, pos.y + offsetY);
    # ```
    #
    # * *offset_x* - X offset
    # * *offset_y* - Y offset
    #
    # *See also:* `position=`
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.transformable_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # Move the object by a given offset
    #
    # This function adds to the current position of the object,
    # unlike position= which overwrites it.
    # Thus, it is equivalent to the following code:
    # ```c++
    # object.setPosition(object.getPosition() + offset);
    # ```
    #
    # * *offset* - Offset
    #
    # *See also:* `position=`
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.transformable_move_UU2(to_unsafe, offset)
    end
    # Rotate the object
    #
    # This function adds to the current rotation of the object,
    # unlike rotation= which overwrites it.
    # Thus, it is equivalent to the following code:
    # ```c++
    # object.setRotation(object.getRotation() + angle);
    # ```
    #
    # * *angle* - Angle of rotation, in degrees
    def rotate(angle : Number)
      VoidCSFML.transformable_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # Scale the object
    #
    # This function multiplies the current scale of the object,
    # unlike scale= which overwrites it.
    # Thus, it is equivalent to the following code:
    # ```c++
    # sf::Vector2f scale = object.getScale();
    # object.setScale(scale.x * factorX, scale.y * factorY);
    # ```
    #
    # * *factor_x* - Horizontal scale factor
    # * *factor_y* - Vertical scale factor
    #
    # *See also:* `scale=`
    def scale(factor_x : Number, factor_y : Number)
      VoidCSFML.transformable_scale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # Scale the object
    #
    # This function multiplies the current scale of the object,
    # unlike scale= which overwrites it.
    # Thus, it is equivalent to the following code:
    # ```c++
    # sf::Vector2f scale = object.getScale();
    # object.setScale(scale.x * factor.x, scale.y * factor.y);
    # ```
    #
    # * *factor* - Scale factors
    #
    # *See also:* `scale=`
    def scale(factor : Vector2|Tuple)
      factor = Vector2f.new(factor[0].to_f32, factor[1].to_f32)
      VoidCSFML.transformable_scale_UU2(to_unsafe, factor)
    end
    # get the combined transform of the object
    #
    # *Returns:* Transform combining the position/rotation/scale/origin of the object
    #
    # *See also:* `inverse_transform`
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.transformable_gettransform(to_unsafe, result)
      return result
    end
    # get the inverse of the combined transform of the object
    #
    # *Returns:* Inverse of the combined transformations applied to the object
    #
    # *See also:* `transform`
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.transformable_getinversetransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_transformable).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : Transformable)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.transformable_initialize_dkg(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Utility class for manipulating RGBA colors
  #
  # `SF::Color` is a simple color class composed of 4 components:
  # * Red
  # * Green
  # * Blue
  # * Alpha (opacity)
  #
  # Each component is a public member, an unsigned integer in
  # the range [0, 255]. Thus, colors can be constructed and
  # manipulated very easily:
  #
  # ```c++
  # sf::Color color(255, 0, 0); // red
  # color.r = 0;                // make it black
  # color.b = 128;              // make it dark blue
  # ```
  #
  # The fourth component of colors, named "alpha", represents
  # the opacity of the color. A color with an alpha value of
  # 255 will be fully opaque, while an alpha value of 0 will
  # make a color fully transparent, whatever the value of the
  # other components is.
  #
  # The most common colors are already defined as static variables:
  # ```c++
  # sf::Color black       = sf::Color::Black;
  # sf::Color white       = sf::Color::White;
  # sf::Color red         = sf::Color::Red;
  # sf::Color green       = sf::Color::Green;
  # sf::Color blue        = sf::Color::Blue;
  # sf::Color yellow      = sf::Color::Yellow;
  # sf::Color magenta     = sf::Color::Magenta;
  # sf::Color cyan        = sf::Color::Cyan;
  # sf::Color transparent = sf::Color::Transparent;
  # ```
  #
  # Colors can also be added and modulated (multiplied) using the
  # overloaded operators + and *.
  struct Color
    @r : UInt8
    @g : UInt8
    @b : UInt8
    @a : UInt8
    # Default constructor
    #
    # Constructs an opaque black color. It is equivalent to
    # `SF::Color`(0, 0, 0, 255).
    def initialize()
      @r = uninitialized UInt8
      @g = uninitialized UInt8
      @b = uninitialized UInt8
      @a = uninitialized UInt8
      VoidCSFML.color_initialize(to_unsafe)
    end
    # Construct the color from its 4 RGBA components
    #
    # * *red* -   Red component (in the range [0, 255])
    # * *green* - Green component (in the range [0, 255])
    # * *blue* -  Blue component (in the range [0, 255])
    # * *alpha* - Alpha (opacity) component (in the range [0, 255])
    def initialize(red : Int, green : Int, blue : Int, alpha : Int = 255)
      @r = uninitialized UInt8
      @g = uninitialized UInt8
      @b = uninitialized UInt8
      @a = uninitialized UInt8
      VoidCSFML.color_initialize_9yU9yU9yU9yU(to_unsafe, UInt8.new(red), UInt8.new(green), UInt8.new(blue), UInt8.new(alpha))
    end
    # Construct the color from 32-bit unsigned integer
    #
    # * *color* - Number containing the RGBA components (in that order)
    def initialize(color : Int)
      @r = uninitialized UInt8
      @g = uninitialized UInt8
      @b = uninitialized UInt8
      @a = uninitialized UInt8
      VoidCSFML.color_initialize_saL(to_unsafe, UInt32.new(color))
    end
    # Retrieve the color as a 32-bit unsigned integer
    #
    # *Returns:* Color represented as a 32-bit unsigned integer
    def to_integer() : UInt32
      VoidCSFML.color_tointeger(to_unsafe, out result)
      return result
    end
    @r : UInt8
    # Red component
    def r : UInt8
      @r
    end
    def r=(r : Int)
      @r = UInt8.new(r)
    end
    @g : UInt8
    # Green component
    def g : UInt8
      @g
    end
    def g=(g : Int)
      @g = UInt8.new(g)
    end
    @b : UInt8
    # Blue component
    def b : UInt8
      @b
    end
    def b=(b : Int)
      @b = UInt8.new(b)
    end
    @a : UInt8
    # Alpha (opacity) component
    def a : UInt8
      @a
    end
    def a=(a : Int)
      @a = UInt8.new(a)
    end
    # Overload of the == operator
    #
    # This operator compares two colors and check if they are equal.
    #
    # * *left* -  Left operand
    # * *right* - Right operand
    #
    # *Returns:* True if colors are equal, false if they are different
    def ==(right : Color) : Bool
      VoidCSFML.operator_eq_QVeQVe(to_unsafe, right, out result)
      return result
    end
    # Overload of the != operator
    #
    # This operator compares two colors and check if they are different.
    #
    # * *left* -  Left operand
    # * *right* - Right operand
    #
    # *Returns:* True if colors are different, false if they are equal
    def !=(right : Color) : Bool
      VoidCSFML.operator_ne_QVeQVe(to_unsafe, right, out result)
      return result
    end
    # Overload of the binary + operator
    #
    # This operator returns the component-wise sum of two colors.
    # Components that exceed 255 are clamped to 255.
    #
    # * *left* -  Left operand
    # * *right* - Right operand
    #
    # *Returns:* Result of *left* + *right*
    def +(right : Color) : Color
      result = Color.allocate
      VoidCSFML.operator_add_QVeQVe(to_unsafe, right, result)
      return result
    end
    # Overload of the binary - operator
    #
    # This operator returns the component-wise subtraction of two colors.
    # Components below 0 are clamped to 0.
    #
    # * *left* -  Left operand
    # * *right* - Right operand
    #
    # *Returns:* Result of *left* - *right*
    def -(right : Color) : Color
      result = Color.allocate
      VoidCSFML.operator_sub_QVeQVe(to_unsafe, right, result)
      return result
    end
    # Overload of the binary * operator
    #
    # This operator returns the component-wise multiplication
    # (also called "modulation") of two colors.
    # Components are then divided by 255 so that the result is
    # still in the range [0, 255].
    #
    # * *left* -  Left operand
    # * *right* - Right operand
    #
    # *Returns:* Result of *left* * *right*
    def *(right : Color) : Color
      result = Color.allocate
      VoidCSFML.operator_mul_QVeQVe(to_unsafe, right, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@r).as(Void*)
    end
    # :nodoc:
    def initialize(copy : Color)
      @r = uninitialized UInt8
      @g = uninitialized UInt8
      @b = uninitialized UInt8
      @a = uninitialized UInt8
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.color_initialize_QVe(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Define a point with color and texture coordinates
  #
  # A vertex is an improved point. It has a position and other
  # extra attributes that will be used for drawing: in SFML,
  # vertices also have a color and a pair of texture coordinates.
  #
  # The vertex is the building block of drawing. Everything which
  # is visible on screen is made of vertices. They are grouped
  # as 2D primitives (triangles, quads, ...), and these primitives
  # are grouped to create even more complex 2D entities such as
  # sprites, texts, etc.
  #
  # If you use the graphical entities of SFML (sprite, text, shape)
  # you won't have to deal with vertices directly. But if you want
  # to define your own 2D entities, such as tiled maps or particle
  # systems, using vertices will allow you to get maximum performances.
  #
  # Example:
  # ```c++
  # // define a 100x100 square, red, with a 10x10 texture mapped on it
  # sf::Vertex vertices[] =
  # {
  #     sf::Vertex(sf::Vector2f(  0,   0), sf::Color::Red, sf::Vector2f( 0,  0)),
  #     sf::Vertex(sf::Vector2f(  0, 100), sf::Color::Red, sf::Vector2f( 0, 10)),
  #     sf::Vertex(sf::Vector2f(100, 100), sf::Color::Red, sf::Vector2f(10, 10)),
  #     sf::Vertex(sf::Vector2f(100,   0), sf::Color::Red, sf::Vector2f(10,  0))
  # };
  #
  # // draw it
  # window.draw(vertices, 4, sf::Quads);
  # ```
  #
  # Note: although texture coordinates are supposed to be an integer
  # amount of pixels, their type is float because of some buggy graphics
  # drivers that are not able to process integer coordinates correctly.
  #
  # *See also:* `SF::VertexArray`
  struct Vertex
    @position : Vector2f
    @color : Color
    @tex_coords : Vector2f
    # Default constructor
    def initialize()
      @position = uninitialized Vector2f
      @color = uninitialized Color
      @tex_coords = uninitialized Vector2f
      VoidCSFML.vertex_initialize(to_unsafe)
    end
    # Construct the vertex from its position
    #
    # The vertex color is white and texture coordinates are (0, 0).
    #
    # * *the_position* - Vertex position
    def initialize(position : Vector2|Tuple)
      @position = uninitialized Vector2f
      @color = uninitialized Color
      @tex_coords = uninitialized Vector2f
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.vertex_initialize_UU2(to_unsafe, position)
    end
    # Construct the vertex from its position and color
    #
    # The texture coordinates are (0, 0).
    #
    # * *the_position* - Vertex position
    # * *the_color* -    Vertex color
    def initialize(position : Vector2|Tuple, color : Color)
      @position = uninitialized Vector2f
      @color = uninitialized Color
      @tex_coords = uninitialized Vector2f
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.vertex_initialize_UU2QVe(to_unsafe, position, color)
    end
    # Construct the vertex from its position and texture coordinates
    #
    # The vertex color is white.
    #
    # * *the_position* -  Vertex position
    # * *the_tex_coords* - Vertex texture coordinates
    def initialize(position : Vector2|Tuple, tex_coords : Vector2|Tuple)
      @position = uninitialized Vector2f
      @color = uninitialized Color
      @tex_coords = uninitialized Vector2f
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      tex_coords = Vector2f.new(tex_coords[0].to_f32, tex_coords[1].to_f32)
      VoidCSFML.vertex_initialize_UU2UU2(to_unsafe, position, tex_coords)
    end
    # Construct the vertex from its position, color and texture coordinates
    #
    # * *the_position* -  Vertex position
    # * *the_color* -     Vertex color
    # * *the_tex_coords* - Vertex texture coordinates
    def initialize(position : Vector2|Tuple, color : Color, tex_coords : Vector2|Tuple)
      @position = uninitialized Vector2f
      @color = uninitialized Color
      @tex_coords = uninitialized Vector2f
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      tex_coords = Vector2f.new(tex_coords[0].to_f32, tex_coords[1].to_f32)
      VoidCSFML.vertex_initialize_UU2QVeUU2(to_unsafe, position, color, tex_coords)
    end
    @position : Vector2f
    # 2D position of the vertex
    def position : Vector2f
      @position
    end
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      @position = position
    end
    @color : Color
    # Color of the vertex
    def color : Color
      @color
    end
    def color=(color : Color)
      @color = color
    end
    @tex_coords : Vector2f
    # Coordinates of the texture's pixel to map to the vertex
    def tex_coords : Vector2f
      @tex_coords
    end
    def tex_coords=(tex_coords : Vector2|Tuple)
      tex_coords = Vector2f.new(tex_coords[0].to_f32, tex_coords[1].to_f32)
      @tex_coords = tex_coords
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@position).as(Void*)
    end
    # :nodoc:
    def initialize(copy : Vertex)
      @position = uninitialized Vector2f
      @color = uninitialized Color
      @tex_coords = uninitialized Vector2f
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.vertex_initialize_Y3J(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Types of primitives that a `SF::VertexArray` can render
  #
  # Points and lines have no area, therefore their thickness
  # will always be 1 pixel, regardless the current transform
  # and view.
  enum PrimitiveType
    # List of individual points
    Points
    # List of individual lines
    Lines
    # List of connected lines, a point uses the previous point to form a line
    LineStrip
    # List of individual triangles
    Triangles
    # List of connected triangles, a point uses the two previous points to form a triangle
    TriangleStrip
    # List of connected triangles, a point uses the common center and the previous point to form a triangle
    TriangleFan
    # List of individual quads (deprecated, don't work with OpenGL ES)
    Quads
    # *Deprecated:* Use LineStrip instead
    LinesStrip = LineStrip
    # *Deprecated:* Use TriangleStrip instead
    TrianglesStrip = TriangleStrip
    # *Deprecated:* Use TriangleFan instead
    TrianglesFan = TriangleFan
  end
  _sf_enum PrimitiveType
  # Define a set of one or more 2D primitives
  #
  # `SF::VertexArray` is a very simple wrapper around a dynamic
  # array of vertices and a primitives type.
  #
  # It inherits `SF::Drawable`, but unlike other drawables it
  # is not transformable.
  #
  # Example:
  # ```c++
  # sf::VertexArray lines(sf::LineStrip, 4);
  # lines[0].position = sf::Vector2f(10, 0);
  # lines[1].position = sf::Vector2f(20, 0);
  # lines[2].position = sf::Vector2f(30, 5);
  # lines[3].position = sf::Vector2f(40, 2);
  #
  # window.draw(lines);
  # ```
  #
  # *See also:* `SF::Vertex`
  class VertexArray
    @_vertexarray : VoidCSFML::VertexArray_Buffer
    # Default constructor
    #
    # Creates an empty vertex array.
    def initialize()
      @_vertexarray = uninitialized VoidCSFML::VertexArray_Buffer
      VoidCSFML.vertexarray_initialize(to_unsafe)
    end
    # Construct the vertex array with a type and an initial number of vertices
    #
    # * *type* -        Type of primitives
    # * *vertex_count* - Initial number of vertices in the array
    def initialize(type : PrimitiveType, vertex_count : Int = 0)
      @_vertexarray = uninitialized VoidCSFML::VertexArray_Buffer
      VoidCSFML.vertexarray_initialize_u9wvgv(to_unsafe, type, LibC::SizeT.new(vertex_count))
    end
    # Return the vertex count
    #
    # *Returns:* Number of vertices in the array
    def vertex_count() : LibC::SizeT
      VoidCSFML.vertexarray_getvertexcount(to_unsafe, out result)
      return result
    end
    # Get a read-write access to a vertex by its index
    #
    # This function doesn't check *index,* it must be in range
    # [0, vertex_count() - 1]. The behavior is undefined
    # otherwise.
    #
    # * *index* - Index of the vertex to get
    #
    # *Returns:* Reference to the index-th vertex
    #
    # *See also:* `vertex_count`
    def []=(index : Int, value : Vertex)
      VoidCSFML.vertexarray_operator_indexset_vgvRos(to_unsafe, LibC::SizeT.new(index), value)
    end
    # Get a read-only access to a vertex by its index
    #
    # This function doesn't check *index,* it must be in range
    # [0, vertex_count() - 1]. The behavior is undefined
    # otherwise.
    #
    # * *index* - Index of the vertex to get
    #
    # *Returns:* Const reference to the index-th vertex
    #
    # *See also:* `vertex_count`
    def [](index : Int) : Vertex
      result = Vertex.allocate
      VoidCSFML.vertexarray_operator_index_vgv(to_unsafe, LibC::SizeT.new(index), result)
      return result
    end
    # Clear the vertex array
    #
    # This function removes all the vertices from the array.
    # It doesn't deallocate the corresponding memory, so that
    # adding new vertices after clearing doesn't involve
    # reallocating all the memory.
    def clear()
      VoidCSFML.vertexarray_clear(to_unsafe)
    end
    # Resize the vertex array
    #
    # If *vertex_count* is greater than the current size, the previous
    # vertices are kept and new (default-constructed) vertices are
    # added.
    # If *vertex_count* is less than the current size, existing vertices
    # are removed from the array.
    #
    # * *vertex_count* - New size of the array (number of vertices)
    def resize(vertex_count : Int)
      VoidCSFML.vertexarray_resize_vgv(to_unsafe, LibC::SizeT.new(vertex_count))
    end
    # Add a vertex to the array
    #
    # * *vertex* - Vertex to add
    def append(vertex : Vertex)
      VoidCSFML.vertexarray_append_Y3J(to_unsafe, vertex)
    end
    # Set the type of primitives to draw
    #
    # This function defines how the vertices must be interpreted
    # when it's time to draw them:
    # * As points
    # * As lines
    # * As triangles
    # * As quads
    # The default primitive type is `SF::Points`.
    #
    # * *type* - Type of primitive
    def primitive_type=(type : PrimitiveType)
      VoidCSFML.vertexarray_setprimitivetype_u9w(to_unsafe, type)
    end
    # Get the type of primitives drawn by the vertex array
    #
    # *Returns:* Primitive type
    def primitive_type() : PrimitiveType
      VoidCSFML.vertexarray_getprimitivetype(to_unsafe, out result)
      return PrimitiveType.new(result)
    end
    # Compute the bounding rectangle of the vertex array
    #
    # This function returns the minimal axis-aligned rectangle
    # that contains all the vertices of the array.
    #
    # *Returns:* Bounding rectangle of the vertex array
    def bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.vertexarray_getbounds(to_unsafe, result)
      return result
    end
    include Drawable
    # :nodoc:
    def to_unsafe()
      pointerof(@_vertexarray).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def draw(target : RenderTexture, states : RenderStates)
      VoidCSFML.vertexarray_draw_kb9RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderWindow, states : RenderStates)
      VoidCSFML.vertexarray_draw_fqURoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderTarget, states : RenderStates)
      VoidCSFML.vertexarray_draw_Xk1RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def initialize(copy : VertexArray)
      @_vertexarray = uninitialized VoidCSFML::VertexArray_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.vertexarray_initialize_EXB(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  VoidCSFML.shape_getpointcount_callback = ->(self : Void*, result : LibC::SizeT*) {
    output = (self - sizeof(LibC::Int)).as(Union(Shape)).point_count()
    result.value = LibC::SizeT.new(output)
  }
  VoidCSFML.shape_getpoint_callback = ->(self : Void*, index : LibC::SizeT, result : Void*) {
    output = (self - sizeof(LibC::Int)).as(Union(Shape)).get_point(index)
    result.as(Vector2f*).value = Vector2f.new(output[0].to_f32, output[1].to_f32)
  }
  # Base class for textured shapes with outline
  #
  # `SF::Shape` is a drawable class that allows to define and
  # display a custom convex shape on a render target.
  # It's only an abstract base, it needs to be specialized for
  # concrete types of shapes (circle, rectangle, convex polygon,
  # star, ...).
  #
  # In addition to the attributes provided by the specialized
  # shape classes, a shape always has the following attributes:
  # * a texture
  # * a texture rectangle
  # * a fill color
  # * an outline color
  # * an outline thickness
  #
  # Each feature is optional, and can be disabled easily:
  # * the texture can be null
  # * the fill/outline colors can be `SF::Color::Transparent`
  # * the outline thickness can be zero
  #
  # You can write your own derived shape class, there are only
  # two virtual functions to override:
  # * point_count must return the number of points of the shape
  # * point must return the points of the shape
  #
  # *See also:* `SF::RectangleShape`, `SF::CircleShape`, `SF::ConvexShape`, `SF::Transformable`
  abstract class Shape < Transformable
    @_shape : VoidCSFML::Shape_Buffer
    # Virtual destructor
    def finalize()
      VoidCSFML.shape_finalize(to_unsafe)
    end
    # Change the source texture of the shape
    #
    # The *texture* argument refers to a texture that must
    # exist as long as the shape uses it. Indeed, the shape
    # doesn't store its own copy of the texture, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the source texture is destroyed and the shape tries to
    # use it, the behavior is undefined.
    # *texture* can be NULL to disable texturing.
    # If *reset_rect* is true, the TextureRect property of
    # the shape is automatically adjusted to the size of the new
    # texture. If it is false, the texture rect is left unchanged.
    #
    # * *texture* -   New texture
    # * *reset_rect* - Should the texture rect be reset to the size of the new texture?
    #
    # *See also:* `texture`, `texture_rect=`
    def set_texture(texture : Texture?, reset_rect : Bool = false)
      @_shape_texture = texture
      VoidCSFML.shape_settexture_MXdGZq(to_unsafe, texture, reset_rect)
    end
    @_shape_texture : Texture? = nil
    # Set the sub-rectangle of the texture that the shape will display
    #
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    #
    # * *rect* - Rectangle defining the region of the texture to display
    #
    # *See also:* `texture_rect`, `texture=`
    def texture_rect=(rect : IntRect)
      VoidCSFML.shape_settexturerect_2k1(to_unsafe, rect)
    end
    # Set the fill color of the shape
    #
    # This color is modulated (multiplied) with the shape's
    # texture if any. It can be used to colorize the shape,
    # or change its global opacity.
    # You can use `SF::Color::Transparent` to make the inside of
    # the shape transparent, and have the outline alone.
    # By default, the shape's fill color is opaque white.
    #
    # * *color* - New color of the shape
    #
    # *See also:* `fill_color`, `outline_color=`
    def fill_color=(color : Color)
      VoidCSFML.shape_setfillcolor_QVe(to_unsafe, color)
    end
    # Set the outline color of the shape
    #
    # By default, the shape's outline color is opaque white.
    #
    # * *color* - New outline color of the shape
    #
    # *See also:* `outline_color`, `fill_color=`
    def outline_color=(color : Color)
      VoidCSFML.shape_setoutlinecolor_QVe(to_unsafe, color)
    end
    # Set the thickness of the shape's outline
    #
    # Note that negative values are allowed (so that the outline
    # expands towards the center of the shape), and using zero
    # disables the outline.
    # By default, the outline thickness is 0.
    #
    # * *thickness* - New outline thickness
    #
    # *See also:* `outline_thickness`
    def outline_thickness=(thickness : Number)
      VoidCSFML.shape_setoutlinethickness_Bw9(to_unsafe, LibC::Float.new(thickness))
    end
    # Get the source texture of the shape
    #
    # If the shape has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    #
    # *Returns:* Pointer to the shape's texture
    #
    # *See also:* `texture=`
    def texture() : Texture?
      return @_shape_texture
    end
    # Get the sub-rectangle of the texture displayed by the shape
    #
    # *Returns:* Texture rectangle of the shape
    #
    # *See also:* `texture_rect=`
    def texture_rect() : IntRect
      result = IntRect.allocate
      VoidCSFML.shape_gettexturerect(to_unsafe, result)
      return result
    end
    # Get the fill color of the shape
    #
    # *Returns:* Fill color of the shape
    #
    # *See also:* `fill_color=`
    def fill_color() : Color
      result = Color.allocate
      VoidCSFML.shape_getfillcolor(to_unsafe, result)
      return result
    end
    # Get the outline color of the shape
    #
    # *Returns:* Outline color of the shape
    #
    # *See also:* `outline_color=`
    def outline_color() : Color
      result = Color.allocate
      VoidCSFML.shape_getoutlinecolor(to_unsafe, result)
      return result
    end
    # Get the outline thickness of the shape
    #
    # *Returns:* Outline thickness of the shape
    #
    # *See also:* `outline_thickness=`
    def outline_thickness() : Float32
      VoidCSFML.shape_getoutlinethickness(to_unsafe, out result)
      return result
    end
    # Get the total number of points of the shape
    #
    # *Returns:* Number of points of the shape
    #
    # *See also:* `point`
    abstract def point_count() : LibC::SizeT
    # Get a point of the shape
    #
    # The returned point is in local coordinates, that is,
    # the shape's transforms (position, rotation, scale) are
    # not taken into account.
    # The result is undefined if *index* is out of the valid range.
    #
    # * *index* - Index of the point to get, in range [0 .. point_count() - 1]
    #
    # *Returns:* index-th point of the shape
    #
    # *See also:* `point_count`
    abstract def get_point(index : Int) : Vector2f
    # Get the local bounding rectangle of the entity
    #
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    #
    # *Returns:* Local bounding rectangle of the entity
    def local_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.shape_getlocalbounds(to_unsafe, result)
      return result
    end
    # Get the global (non-minimal) bounding rectangle of the entity
    #
    # The returned rectangle is in global coordinates, which means
    # that it takes into account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # shape in the global 2D world's coordinate system.
    #
    # This function does not necessarily return the *minimal*
    # bounding rectangle. It merely ensures that the returned
    # rectangle covers all the vertices (but possibly more).
    # This allows for a fast approximation of the bounds as a
    # first check; you may want to use more precise checks
    # on top of that.
    #
    # *Returns:* Global bounding rectangle of the entity
    def global_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.shape_getglobalbounds(to_unsafe, result)
      return result
    end
    # Default constructor
    protected def initialize()
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      raise "Unexpected memory layout" if as(Void*) + sizeof(LibC::Int) != to_unsafe
      VoidCSFML.shape_initialize(to_unsafe)
    end
    # Recompute the internal geometry of the shape
    #
    # This function must be called by the derived class everytime
    # the shape's points change (i.e. the result of either
    # point_count or point is different).
    def update()
      VoidCSFML.shape_update(to_unsafe)
    end
    # :nodoc:
    def texture() : Texture?
      return @_shape_texture
    end
    # :nodoc:
    def set_position(x : Number, y : Number)
      VoidCSFML.shape_setposition_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.shape_setposition_UU2(to_unsafe, position)
    end
    # :nodoc:
    def rotation=(angle : Number)
      VoidCSFML.shape_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def set_scale(factor_x : Number, factor_y : Number)
      VoidCSFML.shape_setscale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale=(factors : Vector2|Tuple)
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.shape_setscale_UU2(to_unsafe, factors)
    end
    # :nodoc:
    def set_origin(x : Number, y : Number)
      VoidCSFML.shape_setorigin_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def origin=(origin : Vector2|Tuple)
      origin = Vector2f.new(origin[0].to_f32, origin[1].to_f32)
      VoidCSFML.shape_setorigin_UU2(to_unsafe, origin)
    end
    # :nodoc:
    def position() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.shape_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def rotation() : Float32
      VoidCSFML.shape_getrotation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def scale() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.shape_getscale(to_unsafe, result)
      return result
    end
    # :nodoc:
    def origin() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.shape_getorigin(to_unsafe, result)
      return result
    end
    # :nodoc:
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.shape_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # :nodoc:
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.shape_move_UU2(to_unsafe, offset)
    end
    # :nodoc:
    def rotate(angle : Number)
      VoidCSFML.shape_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def scale(factor_x : Number, factor_y : Number)
      VoidCSFML.shape_scale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale(factor : Vector2|Tuple)
      factor = Vector2f.new(factor[0].to_f32, factor[1].to_f32)
      VoidCSFML.shape_scale_UU2(to_unsafe, factor)
    end
    # :nodoc:
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.shape_gettransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.shape_getinversetransform(to_unsafe, result)
      return result
    end
    include Drawable
    # :nodoc:
    def to_unsafe()
      pointerof(@_transformable).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def draw(target : RenderTexture, states : RenderStates)
      VoidCSFML.shape_draw_kb9RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderWindow, states : RenderStates)
      VoidCSFML.shape_draw_fqURoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderTarget, states : RenderStates)
      VoidCSFML.shape_draw_Xk1RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def initialize(copy : Shape)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      raise "Unexpected memory layout" if as(Void*) + sizeof(LibC::Int) != to_unsafe
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.shape_initialize_r5K(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Specialized shape representing a circle
  #
  # This class inherits all the functions of `SF::Transformable`
  # (position, rotation, scale, bounds, ...) as well as the
  # functions of `SF::Shape` (outline, color, texture, ...).
  #
  # Usage example:
  # ```c++
  # sf::CircleShape circle;
  # circle.setRadius(150);
  # circle.setOutlineColor(sf::Color::Red);
  # circle.setOutlineThickness(5);
  # circle.setPosition(10, 20);
  # ...
  # window.draw(circle);
  # ```
  #
  # Since the graphics card can't draw perfect circles, we have to
  # fake them with multiple triangles connected to each other. The
  # "points count" property of `SF::CircleShape` defines how many of these
  # triangles to use, and therefore defines the quality of the circle.
  #
  # The number of points can also be used for another purpose; with
  # small numbers you can create any regular polygon shape:
  # equilateral triangle, square, pentagon, hexagon, ...
  #
  # *See also:* `SF::Shape`, `SF::RectangleShape`, `SF::ConvexShape`
  class CircleShape < Shape
    @_circleshape : VoidCSFML::CircleShape_Buffer
    # Default constructor
    #
    # * *radius* -     Radius of the circle
    # * *point_count* - Number of points composing the circle
    def initialize(radius : Number = 0, point_count : Int = 30)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      @_circleshape = uninitialized VoidCSFML::CircleShape_Buffer
      VoidCSFML.circleshape_initialize_Bw9vgv(to_unsafe, LibC::Float.new(radius), LibC::SizeT.new(point_count))
    end
    # Set the radius of the circle
    #
    # * *radius* - New radius of the circle
    #
    # *See also:* `radius`
    def radius=(radius : Number)
      VoidCSFML.circleshape_setradius_Bw9(to_unsafe, LibC::Float.new(radius))
    end
    # Get the radius of the circle
    #
    # *Returns:* Radius of the circle
    #
    # *See also:* `radius=`
    def radius() : Float32
      VoidCSFML.circleshape_getradius(to_unsafe, out result)
      return result
    end
    # Set the number of points of the circle
    #
    # * *count* - New number of points of the circle
    #
    # *See also:* `point_count`
    def point_count=(count : Int)
      VoidCSFML.circleshape_setpointcount_vgv(to_unsafe, LibC::SizeT.new(count))
    end
    # Get the number of points of the circle
    #
    # *Returns:* Number of points of the circle
    #
    # *See also:* `point_count=`
    def point_count() : LibC::SizeT
      VoidCSFML.circleshape_getpointcount(to_unsafe, out result)
      return result
    end
    # Get a point of the circle
    #
    # The returned point is in local coordinates, that is,
    # the shape's transforms (position, rotation, scale) are
    # not taken into account.
    # The result is undefined if *index* is out of the valid range.
    #
    # * *index* - Index of the point to get, in range [0 .. point_count() - 1]
    #
    # *Returns:* index-th point of the shape
    def get_point(index : Int) : Vector2f
      result = Vector2f.allocate
      VoidCSFML.circleshape_getpoint_vgv(to_unsafe, LibC::SizeT.new(index), result)
      return result
    end
    # :nodoc:
    def set_texture(texture : Texture?, reset_rect : Bool = false)
      @_circleshape_texture = texture
      VoidCSFML.circleshape_settexture_MXdGZq(to_unsafe, texture, reset_rect)
    end
    @_circleshape_texture : Texture? = nil
    # :nodoc:
    def texture_rect=(rect : IntRect)
      VoidCSFML.circleshape_settexturerect_2k1(to_unsafe, rect)
    end
    # :nodoc:
    def fill_color=(color : Color)
      VoidCSFML.circleshape_setfillcolor_QVe(to_unsafe, color)
    end
    # :nodoc:
    def outline_color=(color : Color)
      VoidCSFML.circleshape_setoutlinecolor_QVe(to_unsafe, color)
    end
    # :nodoc:
    def outline_thickness=(thickness : Number)
      VoidCSFML.circleshape_setoutlinethickness_Bw9(to_unsafe, LibC::Float.new(thickness))
    end
    # :nodoc:
    def texture() : Texture?
      return @_circleshape_texture
    end
    # :nodoc:
    def texture_rect() : IntRect
      result = IntRect.allocate
      VoidCSFML.circleshape_gettexturerect(to_unsafe, result)
      return result
    end
    # :nodoc:
    def fill_color() : Color
      result = Color.allocate
      VoidCSFML.circleshape_getfillcolor(to_unsafe, result)
      return result
    end
    # :nodoc:
    def outline_color() : Color
      result = Color.allocate
      VoidCSFML.circleshape_getoutlinecolor(to_unsafe, result)
      return result
    end
    # :nodoc:
    def outline_thickness() : Float32
      VoidCSFML.circleshape_getoutlinethickness(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def local_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.circleshape_getlocalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def global_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.circleshape_getglobalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def set_position(x : Number, y : Number)
      VoidCSFML.circleshape_setposition_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.circleshape_setposition_UU2(to_unsafe, position)
    end
    # :nodoc:
    def rotation=(angle : Number)
      VoidCSFML.circleshape_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def set_scale(factor_x : Number, factor_y : Number)
      VoidCSFML.circleshape_setscale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale=(factors : Vector2|Tuple)
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.circleshape_setscale_UU2(to_unsafe, factors)
    end
    # :nodoc:
    def set_origin(x : Number, y : Number)
      VoidCSFML.circleshape_setorigin_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def origin=(origin : Vector2|Tuple)
      origin = Vector2f.new(origin[0].to_f32, origin[1].to_f32)
      VoidCSFML.circleshape_setorigin_UU2(to_unsafe, origin)
    end
    # :nodoc:
    def position() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.circleshape_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def rotation() : Float32
      VoidCSFML.circleshape_getrotation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def scale() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.circleshape_getscale(to_unsafe, result)
      return result
    end
    # :nodoc:
    def origin() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.circleshape_getorigin(to_unsafe, result)
      return result
    end
    # :nodoc:
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.circleshape_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # :nodoc:
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.circleshape_move_UU2(to_unsafe, offset)
    end
    # :nodoc:
    def rotate(angle : Number)
      VoidCSFML.circleshape_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def scale(factor_x : Number, factor_y : Number)
      VoidCSFML.circleshape_scale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale(factor : Vector2|Tuple)
      factor = Vector2f.new(factor[0].to_f32, factor[1].to_f32)
      VoidCSFML.circleshape_scale_UU2(to_unsafe, factor)
    end
    # :nodoc:
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.circleshape_gettransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.circleshape_getinversetransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_transformable).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def draw(target : RenderTexture, states : RenderStates)
      VoidCSFML.circleshape_draw_kb9RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderWindow, states : RenderStates)
      VoidCSFML.circleshape_draw_fqURoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderTarget, states : RenderStates)
      VoidCSFML.circleshape_draw_Xk1RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def initialize(copy : CircleShape)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      @_circleshape = uninitialized VoidCSFML::CircleShape_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.circleshape_initialize_Ii7(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Specialized shape representing a convex polygon
  #
  # This class inherits all the functions of `SF::Transformable`
  # (position, rotation, scale, bounds, ...) as well as the
  # functions of `SF::Shape` (outline, color, texture, ...).
  #
  # It is important to keep in mind that a convex shape must
  # always be... convex, otherwise it may not be drawn correctly.
  # Moreover, the points must be defined in order; using a random
  # order would result in an incorrect shape.
  #
  # Usage example:
  # ```c++
  # sf::ConvexShape polygon;
  # polygon.setPointCount(3);
  # polygon.setPoint(0, sf::Vector2f(0, 0));
  # polygon.setPoint(1, sf::Vector2f(0, 10));
  # polygon.setPoint(2, sf::Vector2f(25, 5));
  # polygon.setOutlineColor(sf::Color::Red);
  # polygon.setOutlineThickness(5);
  # polygon.setPosition(10, 20);
  # ...
  # window.draw(polygon);
  # ```
  #
  # *See also:* `SF::Shape`, `SF::RectangleShape`, `SF::CircleShape`
  class ConvexShape < Shape
    @_convexshape : VoidCSFML::ConvexShape_Buffer
    # Default constructor
    #
    # * *point_count* - Number of points of the polygon
    def initialize(point_count : Int = 0)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      @_convexshape = uninitialized VoidCSFML::ConvexShape_Buffer
      VoidCSFML.convexshape_initialize_vgv(to_unsafe, LibC::SizeT.new(point_count))
    end
    # Set the number of points of the polygon
    #
    # *count* must be greater than 2 to define a valid shape.
    #
    # * *count* - New number of points of the polygon
    #
    # *See also:* `point_count`
    def point_count=(count : Int)
      VoidCSFML.convexshape_setpointcount_vgv(to_unsafe, LibC::SizeT.new(count))
    end
    # Get the number of points of the polygon
    #
    # *Returns:* Number of points of the polygon
    #
    # *See also:* `point_count=`
    def point_count() : LibC::SizeT
      VoidCSFML.convexshape_getpointcount(to_unsafe, out result)
      return result
    end
    # Set the position of a point
    #
    # Don't forget that the polygon must remain convex, and
    # the points need to stay ordered!
    # point_count= must be called first in order to set the total
    # number of points. The result is undefined if *index* is out
    # of the valid range.
    #
    # * *index* - Index of the point to change, in range [0 .. point_count() - 1]
    # * *point* - New position of the point
    #
    # *See also:* `point`
    def set_point(index : Int, point : Vector2|Tuple)
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.convexshape_setpoint_vgvUU2(to_unsafe, LibC::SizeT.new(index), point)
    end
    # Get the position of a point
    #
    # The returned point is in local coordinates, that is,
    # the shape's transforms (position, rotation, scale) are
    # not taken into account.
    # The result is undefined if *index* is out of the valid range.
    #
    # * *index* - Index of the point to get, in range [0 .. point_count() - 1]
    #
    # *Returns:* Position of the index-th point of the polygon
    #
    # *See also:* `point=`
    def get_point(index : Int) : Vector2f
      result = Vector2f.allocate
      VoidCSFML.convexshape_getpoint_vgv(to_unsafe, LibC::SizeT.new(index), result)
      return result
    end
    # :nodoc:
    def set_texture(texture : Texture?, reset_rect : Bool = false)
      @_convexshape_texture = texture
      VoidCSFML.convexshape_settexture_MXdGZq(to_unsafe, texture, reset_rect)
    end
    @_convexshape_texture : Texture? = nil
    # :nodoc:
    def texture_rect=(rect : IntRect)
      VoidCSFML.convexshape_settexturerect_2k1(to_unsafe, rect)
    end
    # :nodoc:
    def fill_color=(color : Color)
      VoidCSFML.convexshape_setfillcolor_QVe(to_unsafe, color)
    end
    # :nodoc:
    def outline_color=(color : Color)
      VoidCSFML.convexshape_setoutlinecolor_QVe(to_unsafe, color)
    end
    # :nodoc:
    def outline_thickness=(thickness : Number)
      VoidCSFML.convexshape_setoutlinethickness_Bw9(to_unsafe, LibC::Float.new(thickness))
    end
    # :nodoc:
    def texture() : Texture?
      return @_convexshape_texture
    end
    # :nodoc:
    def texture_rect() : IntRect
      result = IntRect.allocate
      VoidCSFML.convexshape_gettexturerect(to_unsafe, result)
      return result
    end
    # :nodoc:
    def fill_color() : Color
      result = Color.allocate
      VoidCSFML.convexshape_getfillcolor(to_unsafe, result)
      return result
    end
    # :nodoc:
    def outline_color() : Color
      result = Color.allocate
      VoidCSFML.convexshape_getoutlinecolor(to_unsafe, result)
      return result
    end
    # :nodoc:
    def outline_thickness() : Float32
      VoidCSFML.convexshape_getoutlinethickness(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def local_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.convexshape_getlocalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def global_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.convexshape_getglobalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def set_position(x : Number, y : Number)
      VoidCSFML.convexshape_setposition_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.convexshape_setposition_UU2(to_unsafe, position)
    end
    # :nodoc:
    def rotation=(angle : Number)
      VoidCSFML.convexshape_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def set_scale(factor_x : Number, factor_y : Number)
      VoidCSFML.convexshape_setscale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale=(factors : Vector2|Tuple)
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.convexshape_setscale_UU2(to_unsafe, factors)
    end
    # :nodoc:
    def set_origin(x : Number, y : Number)
      VoidCSFML.convexshape_setorigin_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def origin=(origin : Vector2|Tuple)
      origin = Vector2f.new(origin[0].to_f32, origin[1].to_f32)
      VoidCSFML.convexshape_setorigin_UU2(to_unsafe, origin)
    end
    # :nodoc:
    def position() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.convexshape_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def rotation() : Float32
      VoidCSFML.convexshape_getrotation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def scale() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.convexshape_getscale(to_unsafe, result)
      return result
    end
    # :nodoc:
    def origin() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.convexshape_getorigin(to_unsafe, result)
      return result
    end
    # :nodoc:
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.convexshape_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # :nodoc:
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.convexshape_move_UU2(to_unsafe, offset)
    end
    # :nodoc:
    def rotate(angle : Number)
      VoidCSFML.convexshape_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def scale(factor_x : Number, factor_y : Number)
      VoidCSFML.convexshape_scale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale(factor : Vector2|Tuple)
      factor = Vector2f.new(factor[0].to_f32, factor[1].to_f32)
      VoidCSFML.convexshape_scale_UU2(to_unsafe, factor)
    end
    # :nodoc:
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.convexshape_gettransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.convexshape_getinversetransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_transformable).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def draw(target : RenderTexture, states : RenderStates)
      VoidCSFML.convexshape_draw_kb9RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderWindow, states : RenderStates)
      VoidCSFML.convexshape_draw_fqURoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderTarget, states : RenderStates)
      VoidCSFML.convexshape_draw_Xk1RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def initialize(copy : ConvexShape)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      @_convexshape = uninitialized VoidCSFML::ConvexShape_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.convexshape_initialize_Ydx(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Structure describing a glyph
  #
  # A glyph is the visual representation of a character.
  #
  # The `SF::Glyph` structure provides the information needed
  # to handle the glyph:
  # * its coordinates in the font's texture
  # * its bounding rectangle
  # * the offset to apply to get the starting position of the next glyph
  #
  # *See also:* `SF::Font`
  struct Glyph
    @advance : LibC::Float
    @bounds : FloatRect
    @texture_rect : IntRect
    # Default constructor
    def initialize()
      @advance = uninitialized Float32
      @bounds = uninitialized FloatRect
      @texture_rect = uninitialized IntRect
      VoidCSFML.glyph_initialize(to_unsafe)
    end
    @advance : LibC::Float
    # Offset to move horizontally to the next character
    def advance : Float32
      @advance
    end
    def advance=(advance : Number)
      @advance = LibC::Float.new(advance)
    end
    @bounds : FloatRect
    # Bounding rectangle of the glyph, in coordinates relative to the baseline
    def bounds : FloatRect
      @bounds
    end
    def bounds=(bounds : FloatRect)
      @bounds = bounds
    end
    @texture_rect : IntRect
    # Texture coordinates of the glyph inside the font's texture
    def texture_rect : IntRect
      @texture_rect
    end
    def texture_rect=(texture_rect : IntRect)
      @texture_rect = texture_rect
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@advance).as(Void*)
    end
    # :nodoc:
    def initialize(copy : Glyph)
      @advance = uninitialized Float32
      @bounds = uninitialized FloatRect
      @texture_rect = uninitialized IntRect
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.glyph_initialize_UlF(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Class for loading, manipulating and saving images
  #
  # `SF::Image` is an abstraction to manipulate images
  # as bidimensional arrays of pixels. The class provides
  # functions to load, read, write and save pixels, as well
  # as many other useful functions.
  #
  # `SF::Image` can handle a unique internal representation of
  # pixels, which is RGBA 32 bits. This means that a pixel
  # must be composed of 8 bits red, green, blue and alpha
  # channels -- just like a `SF::Color`.
  # All the functions that return an array of pixels follow
  # this rule, and all parameters that you pass to `SF::Image`
  # functions (such as load_from_memory) must use this
  # representation as well.
  #
  # A `SF::Image` can be copied, but it is a heavy resource and
  # if possible you should always use [const] references to
  # pass or return them to avoid useless copies.
  #
  # Usage example:
  # ```c++
  # // Load an image file from a file
  # sf::Image background;
  # if (!background.loadFromFile("background.jpg"))
  #     return -1;
  #
  # // Create a 20x20 image filled with black color
  # sf::Image image;
  # image.create(20, 20, sf::Color::Black);
  #
  # // Copy image1 on image2 at position (10, 10)
  # image.copy(background, 10, 10);
  #
  # // Make the top-left pixel transparent
  # sf::Color color = image.getPixel(0, 0);
  # color.a = 0;
  # image.setPixel(0, 0, color);
  #
  # // Save the image to a file
  # if (!image.saveToFile("result.png"))
  #     return -1;
  # ```
  #
  # *See also:* `SF::Texture`
  class Image
    @_image : VoidCSFML::Image_Buffer
    # Default constructor
    #
    # Creates an empty image.
    def initialize()
      @_image = uninitialized VoidCSFML::Image_Buffer
      VoidCSFML.image_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      VoidCSFML.image_finalize(to_unsafe)
    end
    # Create the image and fill it with a unique color
    #
    # * *width* -  Width of the image
    # * *height* - Height of the image
    # * *color* -  Fill color
    def create(width : Int, height : Int, color : Color = Color.new(0, 0, 0))
      VoidCSFML.image_create_emSemSQVe(to_unsafe, LibC::UInt.new(width), LibC::UInt.new(height), color)
    end
    # Shorthand for `image = Image.new; image.create(...); image`
    def self.new(width : Int, height : Int, color : Color = Color.new(0, 0, 0)) : self
      obj = new
      obj.create(width, height, color)
      obj
    end
    # Create the image from an array of pixels
    #
    # The *pixel* array is assumed to contain 32-bits RGBA pixels,
    # and have the given *width* and *height.* If not, this is
    # an undefined behavior.
    # If *pixels* is null, an empty image is created.
    #
    # * *width* -  Width of the image
    # * *height* - Height of the image
    # * *pixels* - Array of pixels to copy to the image
    def create(width : Int, height : Int, pixels : UInt8*)
      VoidCSFML.image_create_emSemS843(to_unsafe, LibC::UInt.new(width), LibC::UInt.new(height), pixels)
    end
    # Shorthand for `image = Image.new; image.create(...); image`
    def self.new(width : Int, height : Int, pixels : UInt8*) : self
      obj = new
      obj.create(width, height, pixels)
      obj
    end
    # Load the image from a file on disk
    #
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    #
    # * *filename* - Path of the image file to load
    #
    # *Returns:* True if loading was successful
    #
    # *See also:* `load_from_memory`, `load_from_stream`, `save_to_file`
    def load_from_file(filename : String) : Bool
      VoidCSFML.image_loadfromfile_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Shorthand for `image = Image.new; image.load_from_file(...); image`
    #
    # Raises `InitError` on failure
    def self.from_file(filename : String) : self
      obj = new
      if !obj.load_from_file(filename)
        raise InitError.new("Image.load_from_file failed")
      end
      obj
    end
    # Load the image from a file in memory
    #
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    #
    # * *data* - Pointer to the file data in memory
    # * *size* - Size of the data to load, in bytes
    #
    # *Returns:* True if loading was successful
    #
    # *See also:* `load_from_file`, `load_from_stream`
    def load_from_memory(data : Slice) : Bool
      VoidCSFML.image_loadfrommemory_5h8vgv(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Shorthand for `image = Image.new; image.load_from_memory(...); image`
    #
    # Raises `InitError` on failure
    def self.from_memory(data : Slice) : self
      obj = new
      if !obj.load_from_memory(data)
        raise InitError.new("Image.load_from_memory failed")
      end
      obj
    end
    # Load the image from a custom stream
    #
    # The supported image formats are bmp, png, tga, jpg, gif,
    # psd, hdr and pic. Some format options are not supported,
    # like progressive jpeg.
    # If this function fails, the image is left unchanged.
    #
    # * *stream* - Source stream to read from
    #
    # *Returns:* True if loading was successful
    #
    # *See also:* `load_from_file`, `load_from_memory`
    def load_from_stream(stream : InputStream) : Bool
      VoidCSFML.image_loadfromstream_PO0(to_unsafe, stream, out result)
      return result
    end
    # Shorthand for `image = Image.new; image.load_from_stream(...); image`
    #
    # Raises `InitError` on failure
    def self.from_stream(stream : InputStream) : self
      obj = new
      if !obj.load_from_stream(stream)
        raise InitError.new("Image.load_from_stream failed")
      end
      obj
    end
    # Save the image to a file on disk
    #
    # The format of the image is automatically deduced from
    # the extension. The supported image formats are bmp, png,
    # tga and jpg. The destination file is overwritten
    # if it already exists. This function fails if the image is empty.
    #
    # * *filename* - Path of the file to save
    #
    # *Returns:* True if saving was successful
    #
    # *See also:* `create`, `load_from_file`, `load_from_memory`
    def save_to_file(filename : String) : Bool
      VoidCSFML.image_savetofile_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Return the size (width and height) of the image
    #
    # *Returns:* Size of the image, in pixels
    def size() : Vector2u
      result = Vector2u.allocate
      VoidCSFML.image_getsize(to_unsafe, result)
      return result
    end
    # Create a transparency mask from a specified color-key
    #
    # This function sets the alpha value of every pixel matching
    # the given color to *alpha* (0 by default), so that they
    # become transparent.
    #
    # * *color* - Color to make transparent
    # * *alpha* - Alpha value to assign to transparent pixels
    def create_mask_from_color(color : Color, alpha : Int = 0)
      VoidCSFML.image_createmaskfromcolor_QVe9yU(to_unsafe, color, UInt8.new(alpha))
    end
    # Copy pixels from another image onto this one
    #
    # This function does a slow pixel copy and should not be
    # used intensively. It can be used to prepare a complex
    # static image from several others, but if you need this
    # kind of feature in real-time you'd better use `SF::RenderTexture`.
    #
    # If *source_rect* is empty, the whole image is copied.
    # If *apply_alpha* is set to true, the transparency of
    # source pixels is applied. If it is false, the pixels are
    # copied unchanged with their alpha value.
    #
    # * *source* -     Source image to copy
    # * *dest_x* -      X coordinate of the destination position
    # * *dest_y* -      Y coordinate of the destination position
    # * *source_rect* - Sub-rectangle of the source image to copy
    # * *apply_alpha* - Should the copy take into account the source transparency?
    def copy(source : Image, dest_x : Int, dest_y : Int, source_rect : IntRect = IntRect.new(0, 0, 0, 0), apply_alpha : Bool = false)
      VoidCSFML.image_copy_dptemSemS2k1GZq(to_unsafe, source, LibC::UInt.new(dest_x), LibC::UInt.new(dest_y), source_rect, apply_alpha)
    end
    # Change the color of a pixel
    #
    # This function doesn't check the validity of the pixel
    # coordinates, using out-of-range values will result in
    # an undefined behavior.
    #
    # * *x* -     X coordinate of pixel to change
    # * *y* -     Y coordinate of pixel to change
    # * *color* - New color of the pixel
    #
    # *See also:* `pixel`
    def set_pixel(x : Int, y : Int, color : Color)
      VoidCSFML.image_setpixel_emSemSQVe(to_unsafe, LibC::UInt.new(x), LibC::UInt.new(y), color)
    end
    # Get the color of a pixel
    #
    # This function doesn't check the validity of the pixel
    # coordinates, using out-of-range values will result in
    # an undefined behavior.
    #
    # * *x* - X coordinate of pixel to get
    # * *y* - Y coordinate of pixel to get
    #
    # *Returns:* Color of the pixel at coordinates (x, y)
    #
    # *See also:* `pixel=`
    def get_pixel(x : Int, y : Int) : Color
      result = Color.allocate
      VoidCSFML.image_getpixel_emSemS(to_unsafe, LibC::UInt.new(x), LibC::UInt.new(y), result)
      return result
    end
    # Get a read-only pointer to the array of pixels
    #
    # The returned value points to an array of RGBA pixels made of
    # 8 bits integers components. The size of the array is
    # width * height * 4 (size().x * size().y * 4).
    # Warning: the returned pointer may become invalid if you
    # modify the image, so you should never store it for too long.
    # If the image is empty, a null pointer is returned.
    #
    # *Returns:* Read-only pointer to the array of pixels
    def pixels_ptr() : UInt8*
      VoidCSFML.image_getpixelsptr(to_unsafe, out result)
      return result
    end
    # Flip the image horizontally (left &lt;-&gt; right)
    def flip_horizontally()
      VoidCSFML.image_fliphorizontally(to_unsafe)
    end
    # Flip the image vertically (top &lt;-&gt; bottom)
    def flip_vertically()
      VoidCSFML.image_flipvertically(to_unsafe)
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_image).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : Image)
      @_image = uninitialized VoidCSFML::Image_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.image_initialize_dpt(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Image living on the graphics card that can be used for drawing
  #
  # `SF::Texture` stores pixels that can be drawn, with a sprite
  # for example. A texture lives in the graphics card memory,
  # therefore it is very fast to draw a texture to a render target,
  # or copy a render target to a texture (the graphics card can
  # access both directly).
  #
  # Being stored in the graphics card memory has some drawbacks.
  # A texture cannot be manipulated as freely as a `SF::Image`,
  # you need to prepare the pixels first and then upload them
  # to the texture in a single operation (see Texture::update).
  #
  # `SF::Texture` makes it easy to convert from/to `SF::Image`, but
  # keep in mind that these calls require transfers between
  # the graphics card and the central memory, therefore they are
  # slow operations.
  #
  # A texture can be loaded from an image, but also directly
  # from a file/memory/stream. The necessary shortcuts are defined
  # so that you don't need an image first for the most common cases.
  # However, if you want to perform some modifications on the pixels
  # before creating the final texture, you can load your file to a
  # `SF::Image`, do whatever you need with the pixels, and then call
  # Texture::load_from_image.
  #
  # Since they live in the graphics card memory, the pixels of a texture
  # cannot be accessed without a slow copy first. And they cannot be
  # accessed individually. Therefore, if you need to read the texture's
  # pixels (like for pixel-perfect collisions), it is recommended to
  # store the collision information separately, for example in an array
  # of booleans.
  #
  # Like `SF::Image`, `SF::Texture` can handle a unique internal
  # representation of pixels, which is RGBA 32 bits. This means
  # that a pixel must be composed of 8 bits red, green, blue and
  # alpha channels -- just like a `SF::Color`.
  #
  # Usage example:
  # ```c++
  # // This example shows the most common use of sf::Texture:
  # // drawing a sprite
  #
  # // Load a texture from a file
  # sf::Texture texture;
  # if (!texture.loadFromFile("texture.png"))
  #     return -1;
  #
  # // Assign it to a sprite
  # sf::Sprite sprite;
  # sprite.setTexture(texture);
  #
  # // Draw the textured sprite
  # window.draw(sprite);
  # ```
  #
  # ```c++
  # // This example shows another common use of sf::Texture:
  # // streaming real-time data, like video frames
  #
  # // Create an empty texture
  # sf::Texture texture;
  # if (!texture.create(640, 480))
  #     return -1;
  #
  # // Create a sprite that will display the texture
  # sf::Sprite sprite(texture);
  #
  # while (...) // the main loop
  # {
  #     ...
  #
  #     // update the texture
  #     sf::Uint8* pixels = ...; // get a fresh chunk of pixels (the next frame of a movie, for example)
  #     texture.update(pixels);
  #
  #     // draw it
  #     window.draw(sprite);
  #
  #     ...
  # }
  #
  # ```
  #
  # Like `SF::Shader` that can be used as a raw OpenGL shader,
  # `SF::Texture` can also be used directly as a raw texture for
  # custom OpenGL geometry.
  # ```c++
  # sf::Texture::bind(&texture);
  # ... render OpenGL geometry ...
  # sf::Texture::bind(NULL);
  # ```
  #
  # *See also:* `SF::Sprite`, `SF::Image`, `SF::RenderTexture`
  class Texture
    @_texture : VoidCSFML::Texture_Buffer
    # Types of texture coordinates that can be used for rendering
    enum CoordinateType
      # Texture coordinates in range [0 .. 1]
      Normalized
      # Texture coordinates in range [0 .. size]
      Pixels
    end
    _sf_enum Texture::CoordinateType
    # Default constructor
    #
    # Creates an empty texture.
    def initialize()
      @_texture = uninitialized VoidCSFML::Texture_Buffer
      VoidCSFML.texture_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      VoidCSFML.texture_finalize(to_unsafe)
    end
    # Create the texture
    #
    # If this function fails, the texture is left unchanged.
    #
    # * *width* -  Width of the texture
    # * *height* - Height of the texture
    #
    # *Returns:* True if creation was successful
    def create(width : Int, height : Int) : Bool
      VoidCSFML.texture_create_emSemS(to_unsafe, LibC::UInt.new(width), LibC::UInt.new(height), out result)
      return result
    end
    # Shorthand for `texture = Texture.new; texture.create(...); texture`
    #
    # Raises `InitError` on failure
    def self.new(width : Int, height : Int) : self
      obj = new
      if !obj.create(width, height)
        raise InitError.new("Texture.create failed")
      end
      obj
    end
    # Load the texture from a file on disk
    #
    # This function is a shortcut for the following code:
    # ```c++
    # sf::Image image;
    # image.loadFromFile(filename);
    # texture.loadFromImage(image, area);
    # ```
    #
    # The *area* argument can be used to load only a sub-rectangle
    # of the whole image. If you want the entire image then leave
    # the default value (which is an empty IntRect).
    # If the *area* rectangle crosses the bounds of the image, it
    # is adjusted to fit the image size.
    #
    # The maximum size for a texture depends on the graphics
    # driver and can be retrieved with the maximum_size function.
    #
    # If this function fails, the texture is left unchanged.
    #
    # * *filename* - Path of the image file to load
    # * *area* -     Area of the image to load
    #
    # *Returns:* True if loading was successful
    #
    # *See also:* `load_from_memory`, `load_from_stream`, `load_from_image`
    def load_from_file(filename : String, area : IntRect = IntRect.new()) : Bool
      VoidCSFML.texture_loadfromfile_zkC2k1(to_unsafe, filename.bytesize, filename, area, out result)
      return result
    end
    # Shorthand for `texture = Texture.new; texture.load_from_file(...); texture`
    #
    # Raises `InitError` on failure
    def self.from_file(filename : String, area : IntRect = IntRect.new()) : self
      obj = new
      if !obj.load_from_file(filename, area)
        raise InitError.new("Texture.load_from_file failed")
      end
      obj
    end
    # Load the texture from a file in memory
    #
    # This function is a shortcut for the following code:
    # ```c++
    # sf::Image image;
    # image.loadFromMemory(data, size);
    # texture.loadFromImage(image, area);
    # ```
    #
    # The *area* argument can be used to load only a sub-rectangle
    # of the whole image. If you want the entire image then leave
    # the default value (which is an empty IntRect).
    # If the *area* rectangle crosses the bounds of the image, it
    # is adjusted to fit the image size.
    #
    # The maximum size for a texture depends on the graphics
    # driver and can be retrieved with the maximum_size function.
    #
    # If this function fails, the texture is left unchanged.
    #
    # * *data* - Pointer to the file data in memory
    # * *size* - Size of the data to load, in bytes
    # * *area* - Area of the image to load
    #
    # *Returns:* True if loading was successful
    #
    # *See also:* `load_from_file`, `load_from_stream`, `load_from_image`
    def load_from_memory(data : Slice, area : IntRect = IntRect.new()) : Bool
      VoidCSFML.texture_loadfrommemory_5h8vgv2k1(to_unsafe, data, data.bytesize, area, out result)
      return result
    end
    # Shorthand for `texture = Texture.new; texture.load_from_memory(...); texture`
    #
    # Raises `InitError` on failure
    def self.from_memory(data : Slice, area : IntRect = IntRect.new()) : self
      obj = new
      if !obj.load_from_memory(data, area)
        raise InitError.new("Texture.load_from_memory failed")
      end
      obj
    end
    # Load the texture from a custom stream
    #
    # This function is a shortcut for the following code:
    # ```c++
    # sf::Image image;
    # image.loadFromStream(stream);
    # texture.loadFromImage(image, area);
    # ```
    #
    # The *area* argument can be used to load only a sub-rectangle
    # of the whole image. If you want the entire image then leave
    # the default value (which is an empty IntRect).
    # If the *area* rectangle crosses the bounds of the image, it
    # is adjusted to fit the image size.
    #
    # The maximum size for a texture depends on the graphics
    # driver and can be retrieved with the maximum_size function.
    #
    # If this function fails, the texture is left unchanged.
    #
    # * *stream* - Source stream to read from
    # * *area* -   Area of the image to load
    #
    # *Returns:* True if loading was successful
    #
    # *See also:* `load_from_file`, `load_from_memory`, `load_from_image`
    def load_from_stream(stream : InputStream, area : IntRect = IntRect.new()) : Bool
      VoidCSFML.texture_loadfromstream_PO02k1(to_unsafe, stream, area, out result)
      return result
    end
    # Shorthand for `texture = Texture.new; texture.load_from_stream(...); texture`
    #
    # Raises `InitError` on failure
    def self.from_stream(stream : InputStream, area : IntRect = IntRect.new()) : self
      obj = new
      if !obj.load_from_stream(stream, area)
        raise InitError.new("Texture.load_from_stream failed")
      end
      obj
    end
    # Load the texture from an image
    #
    # The *area* argument can be used to load only a sub-rectangle
    # of the whole image. If you want the entire image then leave
    # the default value (which is an empty IntRect).
    # If the *area* rectangle crosses the bounds of the image, it
    # is adjusted to fit the image size.
    #
    # The maximum size for a texture depends on the graphics
    # driver and can be retrieved with the maximum_size function.
    #
    # If this function fails, the texture is left unchanged.
    #
    # * *image* - Image to load into the texture
    # * *area* -  Area of the image to load
    #
    # *Returns:* True if loading was successful
    #
    # *See also:* `load_from_file`, `load_from_memory`
    def load_from_image(image : Image, area : IntRect = IntRect.new()) : Bool
      VoidCSFML.texture_loadfromimage_dpt2k1(to_unsafe, image, area, out result)
      return result
    end
    # Shorthand for `texture = Texture.new; texture.load_from_image(...); texture`
    #
    # Raises `InitError` on failure
    def self.from_image(image : Image, area : IntRect = IntRect.new()) : self
      obj = new
      if !obj.load_from_image(image, area)
        raise InitError.new("Texture.load_from_image failed")
      end
      obj
    end
    # Return the size of the texture
    #
    # *Returns:* Size in pixels
    def size() : Vector2u
      result = Vector2u.allocate
      VoidCSFML.texture_getsize(to_unsafe, result)
      return result
    end
    # Copy the texture pixels to an image
    #
    # This function performs a slow operation that downloads
    # the texture's pixels from the graphics card and copies
    # them to a new image, potentially applying transformations
    # to pixels if necessary (texture may be padded or flipped).
    #
    # *Returns:* Image containing the texture's pixels
    #
    # *See also:* `load_from_image`
    def copy_to_image() : Image
      result = Image.allocate
      VoidCSFML.texture_copytoimage(to_unsafe, result)
      return result
    end
    # Update the whole texture from an array of pixels
    #
    # The *pixel* array is assumed to have the same size as
    # the *area* rectangle, and to contain 32-bits RGBA pixels.
    #
    # No additional check is performed on the size of the pixel
    # array, passing invalid arguments will lead to an undefined
    # behavior.
    #
    # This function does nothing if *pixels* is null or if the
    # texture was not previously created.
    #
    # * *pixels* - Array of pixels to copy to the texture
    def update(pixels : UInt8*)
      VoidCSFML.texture_update_843(to_unsafe, pixels)
    end
    # Update a part of the texture from an array of pixels
    #
    # The size of the *pixel* array must match the *width* and
    # *height* arguments, and it must contain 32-bits RGBA pixels.
    #
    # No additional check is performed on the size of the pixel
    # array or the bounds of the area to update, passing invalid
    # arguments will lead to an undefined behavior.
    #
    # This function does nothing if *pixels* is null or if the
    # texture was not previously created.
    #
    # * *pixels* - Array of pixels to copy to the texture
    # * *width* -  Width of the pixel region contained in *pixels*
    # * *height* - Height of the pixel region contained in *pixels*
    # * *x* -      X offset in the texture where to copy the source pixels
    # * *y* -      Y offset in the texture where to copy the source pixels
    def update(pixels : UInt8*, width : Int, height : Int, x : Int, y : Int)
      VoidCSFML.texture_update_843emSemSemSemS(to_unsafe, pixels, LibC::UInt.new(width), LibC::UInt.new(height), LibC::UInt.new(x), LibC::UInt.new(y))
    end
    # Update the texture from an image
    #
    # Although the source image can be smaller than the texture,
    # this function is usually used for updating the whole texture.
    # The other overload, which has (x, y) additional arguments,
    # is more convenient for updating a sub-area of the texture.
    #
    # No additional check is performed on the size of the image,
    # passing an image bigger than the texture will lead to an
    # undefined behavior.
    #
    # This function does nothing if the texture was not
    # previously created.
    #
    # * *image* - Image to copy to the texture
    def update(image : Image)
      VoidCSFML.texture_update_dpt(to_unsafe, image)
    end
    # Update a part of the texture from an image
    #
    # No additional check is performed on the size of the image,
    # passing an invalid combination of image size and offset
    # will lead to an undefined behavior.
    #
    # This function does nothing if the texture was not
    # previously created.
    #
    # * *image* - Image to copy to the texture
    # * *x* -     X offset in the texture where to copy the source image
    # * *y* -     Y offset in the texture where to copy the source image
    def update(image : Image, x : Int, y : Int)
      VoidCSFML.texture_update_dptemSemS(to_unsafe, image, LibC::UInt.new(x), LibC::UInt.new(y))
    end
    # Update the texture from the contents of a window
    #
    # Although the source window can be smaller than the texture,
    # this function is usually used for updating the whole texture.
    # The other overload, which has (x, y) additional arguments,
    # is more convenient for updating a sub-area of the texture.
    #
    # No additional check is performed on the size of the window,
    # passing a window bigger than the texture will lead to an
    # undefined behavior.
    #
    # This function does nothing if either the texture or the window
    # was not previously created.
    #
    # * *window* - Window to copy to the texture
    def update(window : Window)
      VoidCSFML.texture_update_JRh(to_unsafe, window)
    end
    # Update a part of the texture from the contents of a window
    #
    # No additional check is performed on the size of the window,
    # passing an invalid combination of window size and offset
    # will lead to an undefined behavior.
    #
    # This function does nothing if either the texture or the window
    # was not previously created.
    #
    # * *window* - Window to copy to the texture
    # * *x* -      X offset in the texture where to copy the source window
    # * *y* -      Y offset in the texture where to copy the source window
    def update(window : Window, x : Int, y : Int)
      VoidCSFML.texture_update_JRhemSemS(to_unsafe, window, LibC::UInt.new(x), LibC::UInt.new(y))
    end
    # Enable or disable the smooth filter
    #
    # When the filter is activated, the texture appears smoother
    # so that pixels are less noticeable. However if you want
    # the texture to look exactly the same as its source file,
    # you should leave it disabled.
    # The smooth filter is disabled by default.
    #
    # * *smooth* - True to enable smoothing, false to disable it
    #
    # *See also:* `smooth?`
    def smooth=(smooth : Bool)
      VoidCSFML.texture_setsmooth_GZq(to_unsafe, smooth)
    end
    # Tell whether the smooth filter is enabled or not
    #
    # *Returns:* True if smoothing is enabled, false if it is disabled
    #
    # *See also:* `smooth=`
    def smooth?() : Bool
      VoidCSFML.texture_issmooth(to_unsafe, out result)
      return result
    end
    # Enable or disable conversion from sRGB
    #
    # When providing texture data from an image file or memory, it can
    # either be stored in a linear color space or an sRGB color space.
    # Most digital images account for gamma correction already, so they
    # would need to be "uncorrected" back to linear color space before
    # being processed by the hardware. The hardware can automatically
    # convert it from the sRGB color space to a linear color space when
    # it gets sampled. When the rendered image gets output to the final
    # framebuffer, it gets converted back to sRGB.
    #
    # After enabling or disabling sRGB conversion, make sure to reload
    # the texture data in order for the setting to take effect.
    #
    # This option is only useful in conjunction with an sRGB capable
    # framebuffer. This can be requested during window creation.
    #
    # * *s_rgb* - True to enable sRGB conversion, false to disable it
    #
    # *See also:* `srgb?`
    def srgb=(s_rgb : Bool)
      VoidCSFML.texture_setsrgb_GZq(to_unsafe, s_rgb)
    end
    # Tell whether the texture source is converted from sRGB or not
    #
    # *Returns:* True if the texture source is converted from sRGB, false if not
    #
    # *See also:* `srgb=`
    def srgb?() : Bool
      VoidCSFML.texture_issrgb(to_unsafe, out result)
      return result
    end
    # Enable or disable repeating
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
    # * *repeated* - True to repeat the texture, false to disable repeating
    #
    # *See also:* `repeated?`
    def repeated=(repeated : Bool)
      VoidCSFML.texture_setrepeated_GZq(to_unsafe, repeated)
    end
    # Tell whether the texture is repeated or not
    #
    # *Returns:* True if repeat mode is enabled, false if it is disabled
    #
    # *See also:* `repeated=`
    def repeated?() : Bool
      VoidCSFML.texture_isrepeated(to_unsafe, out result)
      return result
    end
    # Generate a mipmap using the current texture data
    #
    # Mipmaps are pre-computed chains of optimized textures. Each
    # level of texture in a mipmap is generated by halving each of
    # the previous level's dimensions. This is done until the final
    # level has the size of 1x1. The textures generated in this process may
    # make use of more advanced filters which might improve the visual quality
    # of textures when they are applied to objects much smaller than they are.
    # This is known as minification. Because fewer texels (texture elements)
    # have to be sampled from when heavily minified, usage of mipmaps
    # can also improve rendering performance in certain scenarios.
    #
    # Mipmap generation relies on the necessary OpenGL extension being
    # available. If it is unavailable or generation fails due to another
    # reason, this function will return false. Mipmap data is only valid from
    # the time it is generated until the next time the base level image is
    # modified, at which point this function will have to be called again to
    # regenerate it.
    #
    # *Returns:* True if mipmap generation was successful, false if unsuccessful
    def generate_mipmap() : Bool
      VoidCSFML.texture_generatemipmap(to_unsafe, out result)
      return result
    end
    # Get the underlying OpenGL handle of the texture.
    #
    # You shouldn't need to use this function, unless you have
    # very specific stuff to implement that SFML doesn't support,
    # or implement a temporary workaround until a bug is fixed.
    #
    # *Returns:* OpenGL handle of the texture or 0 if not yet created
    def native_handle() : Int32
      VoidCSFML.texture_getnativehandle(to_unsafe, out result)
      return result.to_i
    end
    # Bind a texture for rendering
    #
    # This function is not part of the graphics API, it mustn't be
    # used when drawing SFML entities. It must be used only if you
    # mix `SF::Texture` with OpenGL code.
    #
    # ```c++
    # sf::Texture t1, t2;
    # ...
    # sf::Texture::bind(&t1);
    # // draw OpenGL stuff that use t1...
    # sf::Texture::bind(&t2);
    # // draw OpenGL stuff that use t2...
    # sf::Texture::bind(NULL);
    # // draw OpenGL stuff that use no texture...
    # ```
    #
    # The *coordinate_type* argument controls how texture
    # coordinates will be interpreted. If Normalized (the default), they
    # must be in range [0 .. 1], which is the default way of handling
    # texture coordinates with OpenGL. If Pixels, they must be given
    # in pixels (range [0 .. size]). This mode is used internally by
    # the graphics classes of SFML, it makes the definition of texture
    # coordinates more intuitive for the high-level API, users don't need
    # to compute normalized values.
    #
    # * *texture* - Pointer to the texture to bind, can be null to use no texture
    # * *coordinate_type* - Type of texture coordinates to use
    def self.bind(texture : Texture?, coordinate_type : Texture::CoordinateType = Normalized)
      VoidCSFML.texture_bind_MXdK9j(texture, coordinate_type)
    end
    # Get the maximum texture size allowed
    #
    # This maximum size is defined by the graphics driver.
    # You can expect a value of 512 pixels for low-end graphics
    # card, and up to 8192 pixels or more for newer hardware.
    #
    # *Returns:* Maximum size allowed for textures, in pixels
    def self.maximum_size() : Int32
      VoidCSFML.texture_getmaximumsize(out result)
      return result.to_i
    end
    include GlResource
    # :nodoc:
    def to_unsafe()
      pointerof(@_texture).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : Texture)
      @_texture = uninitialized VoidCSFML::Texture_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.texture_initialize_DJb(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Class for loading and manipulating character fonts
  #
  # Fonts can be loaded from a file, from memory or from a custom
  # stream, and supports the most common types of fonts. See
  # the load_from_file function for the complete list of supported formats.
  #
  # Once it is loaded, a `SF::Font` instance provides three
  # types of information about the font:
  # * Global metrics, such as the line spacing
  # * Per-glyph metrics, such as bounding box or kerning
  # * Pixel representation of glyphs
  #
  # Fonts alone are not very useful: they hold the font data
  # but cannot make anything useful of it. To do so you need to
  # use the `SF::Text` class, which is able to properly output text
  # with several options such as character size, style, color,
  # position, rotation, etc.
  # This separation allows more flexibility and better performances:
  # indeed a `SF::Font` is a heavy resource, and any operation on it
  # is slow (often too slow for real-time applications). On the other
  # side, a `SF::Text` is a lightweight object which can combine the
  # glyphs data and metrics of a `SF::Font` to display any text on a
  # render target.
  # Note that it is also possible to bind several `SF::Text` instances
  # to the same `SF::Font`.
  #
  # It is important to note that the `SF::Text` instance doesn't
  # copy the font that it uses, it only keeps a reference to it.
  # Thus, a `SF::Font` must not be destructed while it is
  # used by a `SF::Text` (i.e. never write a function that
  # uses a local `SF::Font` instance for creating a text).
  #
  # Usage example:
  # ```c++
  # // Declare a new font
  # sf::Font font;
  #
  # // Load it from a file
  # if (!font.loadFromFile("arial.ttf"))
  # {
  #     // error...
  # }
  #
  # // Create a text which uses our font
  # sf::Text text1;
  # text1.setFont(font);
  # text1.setCharacterSize(30);
  # text1.setStyle(sf::Text::Regular);
  #
  # // Create another text using the same font, but with different parameters
  # sf::Text text2;
  # text2.setFont(font);
  # text2.setCharacterSize(50);
  # text2.setStyle(sf::Text::Italic);
  # ```
  #
  # Apart from loading font files, and passing them to instances
  # of `SF::Text`, you should normally not have to deal directly
  # with this class. However, it may be useful to access the
  # font metrics or rasterized glyphs for advanced usage.
  #
  # Note that if the font is a bitmap font, it is not scalable,
  # thus not all requested sizes will be available to use. This
  # needs to be taken into consideration when using `SF::Text`.
  # If you need to display text of a certain size, make sure the
  # corresponding bitmap font that supports that size is used.
  #
  # *See also:* `SF::Text`
  class Font
    @_font : VoidCSFML::Font_Buffer
    # Holds various information about a font
    class Info
      @_font_info : VoidCSFML::Font_Info_Buffer
      def initialize()
        @_font_info = uninitialized VoidCSFML::Font_Info_Buffer
        VoidCSFML.font_info_initialize(to_unsafe)
      end
      # The font family
      def family() : String
        VoidCSFML.font_info_getfamily(to_unsafe, out result)
        return String.new(result)
      end
      def family=(family : String)
        VoidCSFML.font_info_setfamily_Fzm(to_unsafe, family.bytesize, family)
      end
      # :nodoc:
      def to_unsafe()
        pointerof(@_font_info).as(Void*)
      end
      # :nodoc:
      def inspect(io)
        to_s(io)
      end
      # :nodoc:
      def initialize(copy : Font::Info)
        @_font_info = uninitialized VoidCSFML::Font_Info_Buffer
        as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
        VoidCSFML.font_info_initialize_HPc(to_unsafe, copy)
      end
      def dup() : self
        return typeof(self).new(self)
      end
    end
    # Default constructor
    #
    # This constructor defines an empty font
    def initialize()
      @_font = uninitialized VoidCSFML::Font_Buffer
      VoidCSFML.font_initialize(to_unsafe)
    end
    # Destructor
    #
    # Cleans up all the internal resources used by the font
    def finalize()
      VoidCSFML.font_finalize(to_unsafe)
    end
    # Load the font from a file
    #
    # The supported font formats are: TrueType, Type 1, CFF,
    # OpenType, SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42.
    # Note that this function know nothing about the standard
    # fonts installed on the user's system, thus you can't
    # load them directly.
    #
    # *Warning:* SFML cannot preload all the font data in this
    # function, so the file has to remain accessible until
    # the `SF::Font` object loads a new font or is destroyed.
    #
    # * *filename* - Path of the font file to load
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_memory`, `load_from_stream`
    def load_from_file(filename : String) : Bool
      VoidCSFML.font_loadfromfile_zkC(to_unsafe, filename.bytesize, filename, out result)
      return result
    end
    # Shorthand for `font = Font.new; font.load_from_file(...); font`
    #
    # Raises `InitError` on failure
    def self.from_file(filename : String) : self
      obj = new
      if !obj.load_from_file(filename)
        raise InitError.new("Font.load_from_file failed")
      end
      obj
    end
    # Load the font from a file in memory
    #
    # The supported font formats are: TrueType, Type 1, CFF,
    # OpenType, SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42.
    #
    # *Warning:* SFML cannot preload all the font data in this
    # function, so the buffer pointed by *data* has to remain
    # valid until the `SF::Font` object loads a new font or
    # is destroyed.
    #
    # * *data* -        Pointer to the file data in memory
    # * *size_in_bytes* - Size of the data to load, in bytes
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_stream`
    def load_from_memory(data : Slice) : Bool
      VoidCSFML.font_loadfrommemory_5h8vgv(to_unsafe, data, data.bytesize, out result)
      return result
    end
    # Shorthand for `font = Font.new; font.load_from_memory(...); font`
    #
    # Raises `InitError` on failure
    def self.from_memory(data : Slice) : self
      obj = new
      if !obj.load_from_memory(data)
        raise InitError.new("Font.load_from_memory failed")
      end
      obj
    end
    # Load the font from a custom stream
    #
    # The supported font formats are: TrueType, Type 1, CFF,
    # OpenType, SFNT, X11 PCF, Windows FNT, BDF, PFR and Type 42.
    # Warning: SFML cannot preload all the font data in this
    # function, so the contents of *stream* have to remain
    # valid as long as the font is used.
    #
    # *Warning:* SFML cannot preload all the font data in this
    # function, so the stream has to remain accessible until
    # the `SF::Font` object loads a new font or is destroyed.
    #
    # * *stream* - Source stream to read from
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_memory`
    def load_from_stream(stream : InputStream) : Bool
      VoidCSFML.font_loadfromstream_PO0(to_unsafe, stream, out result)
      return result
    end
    # Shorthand for `font = Font.new; font.load_from_stream(...); font`
    #
    # Raises `InitError` on failure
    def self.from_stream(stream : InputStream) : self
      obj = new
      if !obj.load_from_stream(stream)
        raise InitError.new("Font.load_from_stream failed")
      end
      obj
    end
    # Get the font information
    #
    # *Returns:* A structure that holds the font information
    def info() : Font::Info
      VoidCSFML.font_getinfo(to_unsafe, out result)
      return Font::Info::Reference.new(result, self)
    end
    # Retrieve a glyph of the font
    #
    # If the font is a bitmap font, not all character sizes
    # might be available. If the glyph is not available at the
    # requested size, an empty glyph is returned.
    #
    # Be aware that using a negative value for the outline
    # thickness will cause distorted rendering.
    #
    # * *code_point* -        Unicode code point of the character to get
    # * *character_size* -    Reference character size
    # * *bold* -             Retrieve the bold version or the regular one?
    # * *outline_thickness* - Thickness of outline (when != 0 the glyph will not be filled)
    #
    # *Returns:* The glyph corresponding to *code_point* and *character_size*
    def get_glyph(code_point : Int, character_size : Int, bold : Bool, outline_thickness : Number = 0) : Glyph
      result = Glyph.allocate
      VoidCSFML.font_getglyph_saLemSGZqBw9(to_unsafe, UInt32.new(code_point), LibC::UInt.new(character_size), bold, LibC::Float.new(outline_thickness), result)
      return result
    end
    # Get the kerning offset of two glyphs
    #
    # The kerning is an extra offset (negative) to apply between two
    # glyphs when rendering them, to make the pair look more "natural".
    # For example, the pair "AV" have a special kerning to make them
    # closer than other characters. Most of the glyphs pairs have a
    # kerning offset of zero, though.
    #
    # * *first* -         Unicode code point of the first character
    # * *second* -        Unicode code point of the second character
    # * *character_size* - Reference character size
    #
    # *Returns:* Kerning value for *first* and *second,* in pixels
    def get_kerning(first : Int, second : Int, character_size : Int) : Float32
      VoidCSFML.font_getkerning_saLsaLemS(to_unsafe, UInt32.new(first), UInt32.new(second), LibC::UInt.new(character_size), out result)
      return result
    end
    # Get the line spacing
    #
    # Line spacing is the vertical offset to apply between two
    # consecutive lines of text.
    #
    # * *character_size* - Reference character size
    #
    # *Returns:* Line spacing, in pixels
    def get_line_spacing(character_size : Int) : Float32
      VoidCSFML.font_getlinespacing_emS(to_unsafe, LibC::UInt.new(character_size), out result)
      return result
    end
    # Get the position of the underline
    #
    # Underline position is the vertical offset to apply between the
    # baseline and the underline.
    #
    # * *character_size* - Reference character size
    #
    # *Returns:* Underline position, in pixels
    #
    # *See also:* `underline_thickness`
    def get_underline_position(character_size : Int) : Float32
      VoidCSFML.font_getunderlineposition_emS(to_unsafe, LibC::UInt.new(character_size), out result)
      return result
    end
    # Get the thickness of the underline
    #
    # Underline thickness is the vertical size of the underline.
    #
    # * *character_size* - Reference character size
    #
    # *Returns:* Underline thickness, in pixels
    #
    # *See also:* `underline_position`
    def get_underline_thickness(character_size : Int) : Float32
      VoidCSFML.font_getunderlinethickness_emS(to_unsafe, LibC::UInt.new(character_size), out result)
      return result
    end
    # Retrieve the texture containing the loaded glyphs of a certain size
    #
    # The contents of the returned texture changes as more glyphs
    # are requested, thus it is not very relevant. It is mainly
    # used internally by `SF::Text`.
    #
    # * *character_size* - Reference character size
    #
    # *Returns:* Texture containing the glyphs of the requested size
    def get_texture(character_size : Int) : Texture?
      result = Texture.allocate
      VoidCSFML.font_gettexture_emS(to_unsafe, LibC::UInt.new(character_size), out result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_font).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : Font)
      @_font = uninitialized VoidCSFML::Font_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.font_initialize_7CF(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # :nodoc:
  class Font::Info::Reference < Font::Info
    def initialize(@this : Void*, @parent : Font)
      @_font_info = uninitialized VoidCSFML::Font_Info_Buffer
    end
    def finalize()
    end
    def to_unsafe()
      @this
    end
  end
  # Specialized shape representing a rectangle
  #
  # This class inherits all the functions of `SF::Transformable`
  # (position, rotation, scale, bounds, ...) as well as the
  # functions of `SF::Shape` (outline, color, texture, ...).
  #
  # Usage example:
  # ```c++
  # sf::RectangleShape rectangle;
  # rectangle.setSize(sf::Vector2f(100, 50));
  # rectangle.setOutlineColor(sf::Color::Red);
  # rectangle.setOutlineThickness(5);
  # rectangle.setPosition(10, 20);
  # ...
  # window.draw(rectangle);
  # ```
  #
  # *See also:* `SF::Shape`, `SF::CircleShape`, `SF::ConvexShape`
  class RectangleShape < Shape
    @_rectangleshape : VoidCSFML::RectangleShape_Buffer
    # Default constructor
    #
    # * *size* - Size of the rectangle
    def initialize(size : Vector2|Tuple = Vector2.new(0, 0))
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      @_rectangleshape = uninitialized VoidCSFML::RectangleShape_Buffer
      size = Vector2f.new(size[0].to_f32, size[1].to_f32)
      VoidCSFML.rectangleshape_initialize_UU2(to_unsafe, size)
    end
    # Set the size of the rectangle
    #
    # * *size* - New size of the rectangle
    #
    # *See also:* `size`
    def size=(size : Vector2|Tuple)
      size = Vector2f.new(size[0].to_f32, size[1].to_f32)
      VoidCSFML.rectangleshape_setsize_UU2(to_unsafe, size)
    end
    # Get the size of the rectangle
    #
    # *Returns:* Size of the rectangle
    #
    # *See also:* `size=`
    def size() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.rectangleshape_getsize(to_unsafe, result)
      return result
    end
    # Get the number of points defining the shape
    #
    # *Returns:* Number of points of the shape. For rectangle
    #         shapes, this number is always 4.
    def point_count() : LibC::SizeT
      VoidCSFML.rectangleshape_getpointcount(to_unsafe, out result)
      return result
    end
    # Get a point of the rectangle
    #
    # The returned point is in local coordinates, that is,
    # the shape's transforms (position, rotation, scale) are
    # not taken into account.
    # The result is undefined if *index* is out of the valid range.
    #
    # * *index* - Index of the point to get, in range [0 .. 3]
    #
    # *Returns:* index-th point of the shape
    def get_point(index : Int) : Vector2f
      result = Vector2f.allocate
      VoidCSFML.rectangleshape_getpoint_vgv(to_unsafe, LibC::SizeT.new(index), result)
      return result
    end
    # :nodoc:
    def set_texture(texture : Texture?, reset_rect : Bool = false)
      @_rectangleshape_texture = texture
      VoidCSFML.rectangleshape_settexture_MXdGZq(to_unsafe, texture, reset_rect)
    end
    @_rectangleshape_texture : Texture? = nil
    # :nodoc:
    def texture_rect=(rect : IntRect)
      VoidCSFML.rectangleshape_settexturerect_2k1(to_unsafe, rect)
    end
    # :nodoc:
    def fill_color=(color : Color)
      VoidCSFML.rectangleshape_setfillcolor_QVe(to_unsafe, color)
    end
    # :nodoc:
    def outline_color=(color : Color)
      VoidCSFML.rectangleshape_setoutlinecolor_QVe(to_unsafe, color)
    end
    # :nodoc:
    def outline_thickness=(thickness : Number)
      VoidCSFML.rectangleshape_setoutlinethickness_Bw9(to_unsafe, LibC::Float.new(thickness))
    end
    # :nodoc:
    def texture() : Texture?
      return @_rectangleshape_texture
    end
    # :nodoc:
    def texture_rect() : IntRect
      result = IntRect.allocate
      VoidCSFML.rectangleshape_gettexturerect(to_unsafe, result)
      return result
    end
    # :nodoc:
    def fill_color() : Color
      result = Color.allocate
      VoidCSFML.rectangleshape_getfillcolor(to_unsafe, result)
      return result
    end
    # :nodoc:
    def outline_color() : Color
      result = Color.allocate
      VoidCSFML.rectangleshape_getoutlinecolor(to_unsafe, result)
      return result
    end
    # :nodoc:
    def outline_thickness() : Float32
      VoidCSFML.rectangleshape_getoutlinethickness(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def local_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.rectangleshape_getlocalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def global_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.rectangleshape_getglobalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def set_position(x : Number, y : Number)
      VoidCSFML.rectangleshape_setposition_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.rectangleshape_setposition_UU2(to_unsafe, position)
    end
    # :nodoc:
    def rotation=(angle : Number)
      VoidCSFML.rectangleshape_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def set_scale(factor_x : Number, factor_y : Number)
      VoidCSFML.rectangleshape_setscale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale=(factors : Vector2|Tuple)
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.rectangleshape_setscale_UU2(to_unsafe, factors)
    end
    # :nodoc:
    def set_origin(x : Number, y : Number)
      VoidCSFML.rectangleshape_setorigin_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def origin=(origin : Vector2|Tuple)
      origin = Vector2f.new(origin[0].to_f32, origin[1].to_f32)
      VoidCSFML.rectangleshape_setorigin_UU2(to_unsafe, origin)
    end
    # :nodoc:
    def position() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.rectangleshape_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def rotation() : Float32
      VoidCSFML.rectangleshape_getrotation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def scale() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.rectangleshape_getscale(to_unsafe, result)
      return result
    end
    # :nodoc:
    def origin() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.rectangleshape_getorigin(to_unsafe, result)
      return result
    end
    # :nodoc:
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.rectangleshape_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # :nodoc:
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.rectangleshape_move_UU2(to_unsafe, offset)
    end
    # :nodoc:
    def rotate(angle : Number)
      VoidCSFML.rectangleshape_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def scale(factor_x : Number, factor_y : Number)
      VoidCSFML.rectangleshape_scale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale(factor : Vector2|Tuple)
      factor = Vector2f.new(factor[0].to_f32, factor[1].to_f32)
      VoidCSFML.rectangleshape_scale_UU2(to_unsafe, factor)
    end
    # :nodoc:
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.rectangleshape_gettransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.rectangleshape_getinversetransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_transformable).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def draw(target : RenderTexture, states : RenderStates)
      VoidCSFML.rectangleshape_draw_kb9RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderWindow, states : RenderStates)
      VoidCSFML.rectangleshape_draw_fqURoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderTarget, states : RenderStates)
      VoidCSFML.rectangleshape_draw_Xk1RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def initialize(copy : RectangleShape)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_shape = uninitialized VoidCSFML::Shape_Buffer
      @_rectangleshape = uninitialized VoidCSFML::RectangleShape_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.rectangleshape_initialize_wlj(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # 2D camera that defines what region is shown on screen
  #
  # `SF::View` defines a camera in the 2D scene. This is a
  # very powerful concept: you can scroll, rotate or zoom
  # the entire scene without altering the way that your
  # drawable objects are drawn.
  #
  # A view is composed of a source rectangle, which defines
  # what part of the 2D scene is shown, and a target viewport,
  # which defines where the contents of the source rectangle
  # will be displayed on the render target (window or texture).
  #
  # The viewport allows to map the scene to a custom part
  # of the render target, and can be used for split-screen
  # or for displaying a minimap, for example. If the source
  # rectangle doesn't have the same size as the viewport, its
  # contents will be stretched to fit in.
  #
  # To apply a view, you have to assign it to the render target.
  # Then, objects drawn in this render target will be
  # affected by the view until you use another view.
  #
  # Usage example:
  # ```c++
  # sf::RenderWindow window;
  # sf::View view;
  #
  # // Initialize the view to a rectangle located at (100, 100) and with a size of 400x200
  # view.reset(sf::FloatRect(100, 100, 400, 200));
  #
  # // Rotate it by 45 degrees
  # view.rotate(45);
  #
  # // Set its target viewport to be half of the window
  # view.setViewport(sf::FloatRect(0.f, 0.f, 0.5f, 1.f));
  #
  # // Apply it
  # window.setView(view);
  #
  # // Render stuff
  # window.draw(someSprite);
  #
  # // Set the default view back
  # window.setView(window.getDefaultView());
  #
  # // Render stuff not affected by the view
  # window.draw(someText);
  # ```
  #
  # See also the note on coordinates and undistorted rendering in `SF::Transformable`.
  #
  # *See also:* `SF::RenderWindow`, `SF::RenderTexture`
  class View
    @_view : VoidCSFML::View_Buffer
    # Default constructor
    #
    # This constructor creates a default view of (0, 0, 1000, 1000)
    def initialize()
      @_view = uninitialized VoidCSFML::View_Buffer
      VoidCSFML.view_initialize(to_unsafe)
    end
    # Construct the view from a rectangle
    #
    # * *rectangle* - Rectangle defining the zone to display
    def initialize(rectangle : FloatRect)
      @_view = uninitialized VoidCSFML::View_Buffer
      VoidCSFML.view_initialize_WPZ(to_unsafe, rectangle)
    end
    # Construct the view from its center and size
    #
    # * *center* - Center of the zone to display
    # * *size* -   Size of zone to display
    def initialize(center : Vector2|Tuple, size : Vector2|Tuple)
      @_view = uninitialized VoidCSFML::View_Buffer
      center = Vector2f.new(center[0].to_f32, center[1].to_f32)
      size = Vector2f.new(size[0].to_f32, size[1].to_f32)
      VoidCSFML.view_initialize_UU2UU2(to_unsafe, center, size)
    end
    # Set the center of the view
    #
    # * *x* - X coordinate of the new center
    # * *y* - Y coordinate of the new center
    #
    # *See also:* `size=`, `center`
    def set_center(x : Number, y : Number)
      VoidCSFML.view_setcenter_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # Set the center of the view
    #
    # * *center* - New center
    #
    # *See also:* `size=`, `center`
    def center=(center : Vector2|Tuple)
      center = Vector2f.new(center[0].to_f32, center[1].to_f32)
      VoidCSFML.view_setcenter_UU2(to_unsafe, center)
    end
    # Set the size of the view
    #
    # * *width* -  New width of the view
    # * *height* - New height of the view
    #
    # *See also:* `center=`, `center`
    def set_size(width : Number, height : Number)
      VoidCSFML.view_setsize_Bw9Bw9(to_unsafe, LibC::Float.new(width), LibC::Float.new(height))
    end
    # Set the size of the view
    #
    # * *size* - New size
    #
    # *See also:* `center=`, `center`
    def size=(size : Vector2|Tuple)
      size = Vector2f.new(size[0].to_f32, size[1].to_f32)
      VoidCSFML.view_setsize_UU2(to_unsafe, size)
    end
    # Set the orientation of the view
    #
    # The default rotation of a view is 0 degree.
    #
    # * *angle* - New angle, in degrees
    #
    # *See also:* `rotation`
    def rotation=(angle : Number)
      VoidCSFML.view_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # Set the target viewport
    #
    # The viewport is the rectangle into which the contents of the
    # view are displayed, expressed as a factor (between 0 and 1)
    # of the size of the RenderTarget to which the view is applied.
    # For example, a view which takes the left side of the target would
    # be defined with View.viewport=(`SF::FloatRect`(0, 0, 0.5, 1)).
    # By default, a view has a viewport which covers the entire target.
    #
    # * *viewport* - New viewport rectangle
    #
    # *See also:* `viewport`
    def viewport=(viewport : FloatRect)
      VoidCSFML.view_setviewport_WPZ(to_unsafe, viewport)
    end
    # Reset the view to the given rectangle
    #
    # Note that this function resets the rotation angle to 0.
    #
    # * *rectangle* - Rectangle defining the zone to display
    #
    # *See also:* `center=`, `size=`, `rotation=`
    def reset(rectangle : FloatRect)
      VoidCSFML.view_reset_WPZ(to_unsafe, rectangle)
    end
    # Get the center of the view
    #
    # *Returns:* Center of the view
    #
    # *See also:* `size`, `center=`
    def center() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.view_getcenter(to_unsafe, result)
      return result
    end
    # Get the size of the view
    #
    # *Returns:* Size of the view
    #
    # *See also:* `center`, `size=`
    def size() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.view_getsize(to_unsafe, result)
      return result
    end
    # Get the current orientation of the view
    #
    # *Returns:* Rotation angle of the view, in degrees
    #
    # *See also:* `rotation=`
    def rotation() : Float32
      VoidCSFML.view_getrotation(to_unsafe, out result)
      return result
    end
    # Get the target viewport rectangle of the view
    #
    # *Returns:* Viewport rectangle, expressed as a factor of the target size
    #
    # *See also:* `viewport=`
    def viewport() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.view_getviewport(to_unsafe, result)
      return result
    end
    # Move the view relatively to its current position
    #
    # * *offset_x* - X coordinate of the move offset
    # * *offset_y* - Y coordinate of the move offset
    #
    # *See also:* `center=`, `rotate`, `zoom`
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.view_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # Move the view relatively to its current position
    #
    # * *offset* - Move offset
    #
    # *See also:* `center=`, `rotate`, `zoom`
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.view_move_UU2(to_unsafe, offset)
    end
    # Rotate the view relatively to its current orientation
    #
    # * *angle* - Angle to rotate, in degrees
    #
    # *See also:* `rotation=`, `move`, `zoom`
    def rotate(angle : Number)
      VoidCSFML.view_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # Resize the view rectangle relatively to its current size
    #
    # Resizing the view simulates a zoom, as the zone displayed on
    # screen grows or shrinks.
    # *factor* is a multiplier:
    # * 1 keeps the size unchanged
    # * &gt; 1 makes the view bigger (objects appear smaller)
    # * &lt; 1 makes the view smaller (objects appear bigger)
    #
    # * *factor* - Zoom factor to apply
    #
    # *See also:* `size=`, `move`, `rotate`
    def zoom(factor : Number)
      VoidCSFML.view_zoom_Bw9(to_unsafe, LibC::Float.new(factor))
    end
    # Get the projection transform of the view
    #
    # This function is meant for internal use only.
    #
    # *Returns:* Projection transform defining the view
    #
    # *See also:* `inverse_transform`
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.view_gettransform(to_unsafe, result)
      return result
    end
    # Get the inverse projection transform of the view
    #
    # This function is meant for internal use only.
    #
    # *Returns:* Inverse of the projection transform defining the view
    #
    # *See also:* `transform`
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.view_getinversetransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@_view).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def initialize(copy : View)
      @_view = uninitialized VoidCSFML::View_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.view_initialize_DDi(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Base class for all render targets (window, texture, ...)
  #
  # `SF::RenderTarget` defines the common behavior of all the
  # 2D render targets usable in the graphics module. It makes
  # it possible to draw 2D entities like sprites, shapes, text
  # without using any OpenGL command directly.
  #
  # A `SF::RenderTarget` is also able to use views (`SF::View`),
  # which are a kind of 2D cameras. With views you can globally
  # scroll, rotate or zoom everything that is drawn,
  # without having to transform every single entity. See the
  # documentation of `SF::View` for more details and sample pieces of
  # code about this class.
  #
  # On top of that, render targets are still able to render direct
  # OpenGL stuff. It is even possible to mix together OpenGL calls
  # and regular SFML drawing commands. When doing so, make sure that
  # OpenGL states are not messed up by calling the
  # push_gl_states/pop_gl_states functions.
  #
  # *See also:* `SF::RenderWindow`, `SF::RenderTexture`, `SF::View`
  module RenderTarget
    # Clear the entire target with a single color
    #
    # This function is usually called once every frame,
    # to clear the previous contents of the target.
    #
    # * *color* - Fill color to use to clear the render target
    def clear(color : Color = Color.new(0, 0, 0, 255))
      VoidCSFML.rendertarget_clear_QVe(to_unsafe, color)
    end
    # Change the current active view
    #
    # The view is like a 2D camera, it controls which part of
    # the 2D scene is visible, and how it is viewed in the
    # render target.
    # The new view will affect everything that is drawn, until
    # another view is set.
    # The render target keeps its own copy of the view object,
    # so it is not necessary to keep the original one alive
    # after calling this function.
    # To restore the original view of the target, you can pass
    # the result of default_view() to this function.
    #
    # * *view* - New view to use
    #
    # *See also:* `view`, `default_view`
    def view=(view : View)
      @_rendertarget_view = view
      VoidCSFML.rendertarget_setview_DDi(to_unsafe, view)
    end
    # Get the view currently in use in the render target
    #
    # *Returns:* The view object that is currently used
    #
    # *See also:* `view=`, `default_view`
    def view() : View
      VoidCSFML.rendertarget_getview(to_unsafe, out result)
      return View::Reference.new(result, self)
    end
    # Get the default view of the render target
    #
    # The default view has the initial size of the render target,
    # and never changes after the target has been created.
    #
    # *Returns:* The default view of the render target
    #
    # *See also:* `view=`, `view`
    def default_view() : View
      VoidCSFML.rendertarget_getdefaultview(to_unsafe, out result)
      return View::Reference.new(result, self)
    end
    # Get the viewport of a view, applied to this render target
    #
    # The viewport is defined in the view as a ratio, this function
    # simply applies this ratio to the current dimensions of the
    # render target to calculate the pixels rectangle that the viewport
    # actually covers in the target.
    #
    # * *view* - The view for which we want to compute the viewport
    #
    # *Returns:* Viewport rectangle, expressed in pixels
    def get_viewport(view : View) : IntRect
      result = IntRect.allocate
      VoidCSFML.rendertarget_getviewport_DDi(to_unsafe, view, result)
      return result
    end
    # Convert a point from target coordinates to world
    #        coordinates, using the current view
    #
    # This function is an overload of the map_pixel_to_coords
    # function that implicitly uses the current view.
    # It is equivalent to:
    # ```c++
    # target.mapPixelToCoords(point, target.getView());
    # ```
    #
    # * *point* - Pixel to convert
    #
    # *Returns:* The converted point, in "world" coordinates
    #
    # *See also:* `map_coords_to_pixel`
    def map_pixel_to_coords(point : Vector2|Tuple) : Vector2f
      result = Vector2f.allocate
      point = Vector2i.new(point[0].to_i32, point[1].to_i32)
      VoidCSFML.rendertarget_mappixeltocoords_ufV(to_unsafe, point, result)
      return result
    end
    # Convert a point from target coordinates to world coordinates
    #
    # This function finds the 2D position that matches the
    # given pixel of the render target. In other words, it does
    # the inverse of what the graphics card does, to find the
    # initial position of a rendered pixel.
    #
    # Initially, both coordinate systems (world units and target pixels)
    # match perfectly. But if you define a custom view or resize your
    # render target, this assertion is not true anymore, i.e. a point
    # located at (10, 50) in your render target may map to the point
    # (150, 75) in your 2D world -- if the view is translated by (140, 25).
    #
    # For render-windows, this function is typically used to find
    # which point (or object) is located below the mouse cursor.
    #
    # This version uses a custom view for calculations, see the other
    # overload of the function if you want to use the current view of the
    # render target.
    #
    # * *point* - Pixel to convert
    # * *view* - The view to use for converting the point
    #
    # *Returns:* The converted point, in "world" units
    #
    # *See also:* `map_coords_to_pixel`
    def map_pixel_to_coords(point : Vector2|Tuple, view : View) : Vector2f
      result = Vector2f.allocate
      point = Vector2i.new(point[0].to_i32, point[1].to_i32)
      VoidCSFML.rendertarget_mappixeltocoords_ufVDDi(to_unsafe, point, view, result)
      return result
    end
    # Convert a point from world coordinates to target
    #        coordinates, using the current view
    #
    # This function is an overload of the map_coords_to_pixel
    # function that implicitly uses the current view.
    # It is equivalent to:
    # ```c++
    # target.mapCoordsToPixel(point, target.getView());
    # ```
    #
    # * *point* - Point to convert
    #
    # *Returns:* The converted point, in target coordinates (pixels)
    #
    # *See also:* `map_pixel_to_coords`
    def map_coords_to_pixel(point : Vector2|Tuple) : Vector2i
      result = Vector2i.allocate
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.rendertarget_mapcoordstopixel_UU2(to_unsafe, point, result)
      return result
    end
    # Convert a point from world coordinates to target coordinates
    #
    # This function finds the pixel of the render target that matches
    # the given 2D point. In other words, it goes through the same process
    # as the graphics card, to compute the final position of a rendered point.
    #
    # Initially, both coordinate systems (world units and target pixels)
    # match perfectly. But if you define a custom view or resize your
    # render target, this assertion is not true anymore, i.e. a point
    # located at (150, 75) in your 2D world may map to the pixel
    # (10, 50) of your render target -- if the view is translated by (140, 25).
    #
    # This version uses a custom view for calculations, see the other
    # overload of the function if you want to use the current view of the
    # render target.
    #
    # * *point* - Point to convert
    # * *view* - The view to use for converting the point
    #
    # *Returns:* The converted point, in target coordinates (pixels)
    #
    # *See also:* `map_pixel_to_coords`
    def map_coords_to_pixel(point : Vector2|Tuple, view : View) : Vector2i
      result = Vector2i.allocate
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.rendertarget_mapcoordstopixel_UU2DDi(to_unsafe, point, view, result)
      return result
    end
    # Draw primitives defined by an array of vertices
    #
    # * *vertices* -    Pointer to the vertices
    # * *vertex_count* - Number of vertices in the array
    # * *type* -        Type of primitives to draw
    # * *states* -      Render states to use for drawing
    def draw(vertices : Array(Vertex) | Slice(Vertex), type : PrimitiveType, states : RenderStates = RenderStates::Default)
      VoidCSFML.rendertarget_draw_46svgvu9wmi4(to_unsafe, vertices, vertices.size, type, states)
    end
    # Return the size of the rendering region of the target
    #
    # *Returns:* Size in pixels
    abstract def size() : Vector2u
    # Save the current OpenGL render states and matrices
    #
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering. Combined with pop_gl_states,
    # it ensures that:
    # * SFML's internal states are not messed up by your OpenGL code
    # * your OpenGL states are not modified by a call to a SFML function
    #
    # More specifically, it must be used around code that
    # calls Draw functions. Example:
    # ```c++
    # // OpenGL code here...
    # window.pushGLStates();
    # window.draw(...);
    # window.draw(...);
    # window.popGLStates();
    # // OpenGL code here...
    # ```
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
    # *See also:* `pop_gl_states`
    def push_gl_states()
      VoidCSFML.rendertarget_pushglstates(to_unsafe)
    end
    # Restore the previously saved OpenGL render states and matrices
    #
    # See the description of push_gl_states to get a detailed
    # description of these functions.
    #
    # *See also:* `push_gl_states`
    def pop_gl_states()
      VoidCSFML.rendertarget_popglstates(to_unsafe)
    end
    # Reset the internal OpenGL states so that the target is ready for drawing
    #
    # This function can be used when you mix SFML drawing
    # and direct OpenGL rendering, if you choose not to use
    # push_gl_states/pop_gl_states. It makes sure that all OpenGL
    # states needed by SFML are set, so that subsequent draw()
    # calls will work as expected.
    #
    # Example:
    # ```c++
    # // OpenGL code here...
    # glPushAttrib(...);
    # window.resetGLStates();
    # window.draw(...);
    # window.draw(...);
    # glPopAttrib(...);
    # // OpenGL code here...
    # ```
    def reset_gl_states()
      VoidCSFML.rendertarget_resetglstates(to_unsafe)
    end
    include NonCopyable
  end
  # :nodoc:
  class View::Reference < View
    def initialize(@this : Void*, @parent : RenderTarget)
      @_view = uninitialized VoidCSFML::View_Buffer
    end
    def finalize()
    end
    def to_unsafe()
      @this
    end
  end
  # :nodoc:
  class View::Reference < View
    def initialize(@this : Void*, @parent : RenderTarget)
      @_view = uninitialized VoidCSFML::View_Buffer
    end
    def finalize()
    end
    def to_unsafe()
      @this
    end
  end
  # Target for off-screen 2D rendering into a texture
  #
  # `SF::RenderTexture` is the little brother of `SF::RenderWindow`.
  # It implements the same 2D drawing and OpenGL-related functions
  # (see their base class `SF::RenderTarget` for more details),
  # the difference is that the result is stored in an off-screen
  # texture rather than being show in a window.
  #
  # Rendering to a texture can be useful in a variety of situations:
  # * precomputing a complex static texture (like a level's background from multiple tiles)
  # * applying post-effects to the whole scene with shaders
  # * creating a sprite from a 3D object rendered with OpenGL
  # * etc.
  #
  # Usage example:
  #
  # ```c++
  # // Create a new render-window
  # sf::RenderWindow window(sf::VideoMode(800, 600), "SFML window");
  #
  # // Create a new render-texture
  # sf::RenderTexture texture;
  # if (!texture.create(500, 500))
  #     return -1;
  #
  # // The main loop
  # while (window.isOpen())
  # {
  #    // Event processing
  #    // ...
  #
  #    // Clear the whole texture with red color
  #    texture.clear(sf::Color::Red);
  #
  #    // Draw stuff to the texture
  #    texture.draw(sprite);  // sprite is a sf::Sprite
  #    texture.draw(shape);   // shape is a sf::Shape
  #    texture.draw(text);    // text is a sf::Text
  #
  #    // We're done drawing to the texture
  #    texture.display();
  #
  #    // Now we start rendering to the window, clear it first
  #    window.clear();
  #
  #    // Draw the texture
  #    sf::Sprite sprite(texture.getTexture());
  #    window.draw(sprite);
  #
  #    // End the current frame and display its contents on screen
  #    window.display();
  # }
  # ```
  #
  # Like `SF::RenderWindow`, `SF::RenderTexture` is still able to render direct
  # OpenGL stuff. It is even possible to mix together OpenGL calls
  # and regular SFML drawing commands. If you need a depth buffer for
  # 3D rendering, don't forget to request it when calling RenderTexture::create.
  #
  # *See also:* `SF::RenderTarget`, `SF::RenderWindow`, `SF::View`, `SF::Texture`
  class RenderTexture
    @_rendertexture : VoidCSFML::RenderTexture_Buffer
    # Default constructor
    #
    # Constructs an empty, invalid render-texture. You must
    # call create to have a valid render-texture.
    #
    # *See also:* `create`
    def initialize()
      @_rendertexture = uninitialized VoidCSFML::RenderTexture_Buffer
      VoidCSFML.rendertexture_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      VoidCSFML.rendertexture_finalize(to_unsafe)
    end
    # Create the render-texture
    #
    # Before calling this function, the render-texture is in
    # an invalid state, thus it is mandatory to call it before
    # doing anything with the render-texture.
    # The last parameter, *depth_buffer,* is useful if you want
    # to use the render-texture for 3D OpenGL rendering that requires
    # a depth buffer. Otherwise it is unnecessary, and you should
    # leave this parameter to false (which is its default value).
    #
    # * *width* -       Width of the render-texture
    # * *height* -      Height of the render-texture
    # * *depth_buffer* - Do you want this render-texture to have a depth buffer?
    #
    # *Returns:* True if creation has been successful
    def create(width : Int, height : Int, depth_buffer : Bool = false) : Bool
      VoidCSFML.rendertexture_create_emSemSGZq(to_unsafe, LibC::UInt.new(width), LibC::UInt.new(height), depth_buffer, out result)
      return result
    end
    # Shorthand for `render_texture = RenderTexture.new; render_texture.create(...); render_texture`
    #
    # Raises `InitError` on failure
    def self.new(width : Int, height : Int, depth_buffer : Bool = false) : self
      obj = new
      if !obj.create(width, height, depth_buffer)
        raise InitError.new("RenderTexture.create failed")
      end
      obj
    end
    # Enable or disable texture smoothing
    #
    # This function is similar to Texture::smooth=.
    # This parameter is disabled by default.
    #
    # * *smooth* - True to enable smoothing, false to disable it
    #
    # *See also:* `smooth?`
    def smooth=(smooth : Bool)
      VoidCSFML.rendertexture_setsmooth_GZq(to_unsafe, smooth)
    end
    # Tell whether the smooth filtering is enabled or not
    #
    # *Returns:* True if texture smoothing is enabled
    #
    # *See also:* `smooth=`
    def smooth?() : Bool
      VoidCSFML.rendertexture_issmooth(to_unsafe, out result)
      return result
    end
    # Enable or disable texture repeating
    #
    # This function is similar to Texture::repeated=.
    # This parameter is disabled by default.
    #
    # * *repeated* - True to enable repeating, false to disable it
    #
    # *See also:* `repeated?`
    def repeated=(repeated : Bool)
      VoidCSFML.rendertexture_setrepeated_GZq(to_unsafe, repeated)
    end
    # Tell whether the texture is repeated or not
    #
    # *Returns:* True if texture is repeated
    #
    # *See also:* `repeated=`
    def repeated?() : Bool
      VoidCSFML.rendertexture_isrepeated(to_unsafe, out result)
      return result
    end
    # Generate a mipmap using the current texture data
    #
    # This function is similar to Texture::generate_mipmap and operates
    # on the texture used as the target for drawing.
    # Be aware that any draw operation may modify the base level image data.
    # For this reason, calling this function only makes sense after all
    # drawing is completed and display has been called. Not calling display
    # after subsequent drawing will lead to undefined behavior if a mipmap
    # had been previously generated.
    #
    # *Returns:* True if mipmap generation was successful, false if unsuccessful
    def generate_mipmap() : Bool
      VoidCSFML.rendertexture_generatemipmap(to_unsafe, out result)
      return result
    end
    # Activate or deactivate the render-texture for rendering
    #
    # This function makes the render-texture's context current for
    # future OpenGL rendering operations (so you shouldn't care
    # about it if you're not doing direct OpenGL stuff).
    # Only one context can be current in a thread, so if you
    # want to draw OpenGL geometry to another render target
    # (like a RenderWindow) don't forget to activate it again.
    #
    # * *active* - True to activate, false to deactivate
    #
    # *Returns:* True if operation was successful, false otherwise
    def active=(active : Bool = true) : Bool
      VoidCSFML.rendertexture_setactive_GZq(to_unsafe, active, out result)
      return result
    end
    # Update the contents of the target texture
    #
    # This function updates the target texture with what
    # has been drawn so far. Like for windows, calling this
    # function is mandatory at the end of rendering. Not calling
    # it may leave the texture in an undefined state.
    def display()
      VoidCSFML.rendertexture_display(to_unsafe)
    end
    # Return the size of the rendering region of the texture
    #
    # The returned value is the size that you passed to
    # the create function.
    #
    # *Returns:* Size in pixels
    def size() : Vector2u
      result = Vector2u.allocate
      VoidCSFML.rendertexture_getsize(to_unsafe, result)
      return result
    end
    # Get a read-only reference to the target texture
    #
    # After drawing to the render-texture and calling Display,
    # you can retrieve the updated texture using this function,
    # and draw it using a sprite (for example).
    # The internal `SF::Texture` of a render-texture is always the
    # same instance, so that it is possible to call this function
    # once and keep a reference to the texture even after it is
    # modified.
    #
    # *Returns:* Const reference to the texture
    def texture() : Texture
      VoidCSFML.rendertexture_gettexture(to_unsafe, out result)
      return Texture::Reference.new(result, self)
    end
    # :nodoc:
    def clear(color : Color = Color.new(0, 0, 0, 255))
      VoidCSFML.rendertexture_clear_QVe(to_unsafe, color)
    end
    # :nodoc:
    def view=(view : View)
      @_rendertexture_view = view
      VoidCSFML.rendertexture_setview_DDi(to_unsafe, view)
    end
    @_rendertexture_view : View? = nil
    # :nodoc:
    def view() : View
      VoidCSFML.rendertexture_getview(to_unsafe, out result)
      return View::Reference.new(result, self)
    end
    # :nodoc:
    def default_view() : View
      VoidCSFML.rendertexture_getdefaultview(to_unsafe, out result)
      return View::Reference.new(result, self)
    end
    # :nodoc:
    def get_viewport(view : View) : IntRect
      result = IntRect.allocate
      VoidCSFML.rendertexture_getviewport_DDi(to_unsafe, view, result)
      return result
    end
    # :nodoc:
    def map_pixel_to_coords(point : Vector2|Tuple) : Vector2f
      result = Vector2f.allocate
      point = Vector2i.new(point[0].to_i32, point[1].to_i32)
      VoidCSFML.rendertexture_mappixeltocoords_ufV(to_unsafe, point, result)
      return result
    end
    # :nodoc:
    def map_pixel_to_coords(point : Vector2|Tuple, view : View) : Vector2f
      result = Vector2f.allocate
      point = Vector2i.new(point[0].to_i32, point[1].to_i32)
      VoidCSFML.rendertexture_mappixeltocoords_ufVDDi(to_unsafe, point, view, result)
      return result
    end
    # :nodoc:
    def map_coords_to_pixel(point : Vector2|Tuple) : Vector2i
      result = Vector2i.allocate
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.rendertexture_mapcoordstopixel_UU2(to_unsafe, point, result)
      return result
    end
    # :nodoc:
    def map_coords_to_pixel(point : Vector2|Tuple, view : View) : Vector2i
      result = Vector2i.allocate
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.rendertexture_mapcoordstopixel_UU2DDi(to_unsafe, point, view, result)
      return result
    end
    # :nodoc:
    def draw(vertices : Array(Vertex) | Slice(Vertex), type : PrimitiveType, states : RenderStates = RenderStates::Default)
      VoidCSFML.rendertexture_draw_46svgvu9wmi4(to_unsafe, vertices, vertices.size, type, states)
    end
    # :nodoc:
    def push_gl_states()
      VoidCSFML.rendertexture_pushglstates(to_unsafe)
    end
    # :nodoc:
    def pop_gl_states()
      VoidCSFML.rendertexture_popglstates(to_unsafe)
    end
    # :nodoc:
    def reset_gl_states()
      VoidCSFML.rendertexture_resetglstates(to_unsafe)
    end
    include RenderTarget
    # :nodoc:
    def to_unsafe()
      pointerof(@_rendertexture).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # :nodoc:
  class Texture::Reference < Texture
    def initialize(@this : Void*, @parent : RenderTexture)
      @_texture = uninitialized VoidCSFML::Texture_Buffer
    end
    def finalize()
    end
    def to_unsafe()
      @this
    end
  end
  # Window that can serve as a target for 2D drawing
  #
  # `SF::RenderWindow` is the main class of the Graphics module.
  # It defines an OS window that can be painted using the other
  # classes of the graphics module.
  #
  # `SF::RenderWindow` is derived from `SF::Window`, thus it inherits
  # all its features: events, window management, OpenGL rendering,
  # etc. See the documentation of `SF::Window` for a more complete
  # description of all these features, as well as code examples.
  #
  # On top of that, `SF::RenderWindow` adds more features related to
  # 2D drawing with the graphics module (see its base class
  # `SF::RenderTarget` for more details).
  # Here is a typical rendering and event loop with a `SF::RenderWindow:`
  #
  # ```c++
  # // Declare and create a new render-window
  # sf::RenderWindow window(sf::VideoMode(800, 600), "SFML window");
  #
  # // Limit the framerate to 60 frames per second (this step is optional)
  # window.setFramerateLimit(60);
  #
  # // The main loop - ends as soon as the window is closed
  # while (window.isOpen())
  # {
  #    // Event processing
  #    sf::Event event;
  #    while (window.pollEvent(event))
  #    {
  #        // Request for closing the window
  #        if (event.type == sf::Event::Closed)
  #            window.close();
  #    }
  #
  #    // Clear the whole window before rendering a new frame
  #    window.clear();
  #
  #    // Draw some graphical entities
  #    window.draw(sprite);
  #    window.draw(circle);
  #    window.draw(text);
  #
  #    // End the current frame and display its contents on screen
  #    window.display();
  # }
  # ```
  #
  # Like `SF::Window`, `SF::RenderWindow` is still able to render direct
  # OpenGL stuff. It is even possible to mix together OpenGL calls
  # and regular SFML drawing commands.
  #
  # ```c++
  # // Create the render window
  # sf::RenderWindow window(sf::VideoMode(800, 600), "SFML OpenGL");
  #
  # // Create a sprite and a text to display
  # sf::Sprite sprite;
  # sf::Text text;
  # ...
  #
  # // Perform OpenGL initializations
  # glMatrixMode(GL_PROJECTION);
  # ...
  #
  # // Start the rendering loop
  # while (window.isOpen())
  # {
  #     // Process events
  #     ...
  #
  #     // Draw a background sprite
  #     window.pushGLStates();
  #     window.draw(sprite);
  #     window.popGLStates();
  #
  #     // Draw a 3D object using OpenGL
  #     glBegin(GL_QUADS);
  #         glVertex3f(...);
  #         ...
  #     glEnd();
  #
  #     // Draw text on top of the 3D object
  #     window.pushGLStates();
  #     window.draw(text);
  #     window.popGLStates();
  #
  #     // Finally, display the rendered frame on screen
  #     window.display();
  # }
  # ```
  #
  # *See also:* `SF::Window`, `SF::RenderTarget`, `SF::RenderTexture`, `SF::View`
  class RenderWindow < Window
    @_renderwindow : VoidCSFML::RenderWindow_Buffer
    # Default constructor
    #
    # This constructor doesn't actually create the window,
    # use the other constructors or call create() to do so.
    def initialize()
      @_window = uninitialized VoidCSFML::Window_Buffer
      @_renderwindow = uninitialized VoidCSFML::RenderWindow_Buffer
      VoidCSFML.renderwindow_initialize(to_unsafe)
    end
    # Construct a new window
    #
    # This constructor creates the window with the size and pixel
    # depth defined in *mode.* An optional style can be passed to
    # customize the look and behavior of the window (borders,
    # title bar, resizable, closable, ...).
    #
    # The fourth parameter is an optional structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc. You shouldn't care about these
    # parameters for a regular usage of the graphics module.
    #
    # * *mode* -     Video mode to use (defines the width, height and depth of the rendering area of the window)
    # * *title* -    Title of the window
    # * *style* -    %Window style, a bitwise OR combination of `SF::Style` enumerators
    # * *settings* - Additional settings for the underlying OpenGL context
    def initialize(mode : VideoMode, title : String, style : Style = Style::Default, settings : ContextSettings = ContextSettings.new())
      @_window = uninitialized VoidCSFML::Window_Buffer
      @_renderwindow = uninitialized VoidCSFML::RenderWindow_Buffer
      VoidCSFML.renderwindow_initialize_wg0bQssaLFw4(to_unsafe, mode, title.size, title.chars, style, settings)
    end
    # Construct the window from an existing control
    #
    # Use this constructor if you want to create an SFML
    # rendering area into an already existing control.
    #
    # The second parameter is an optional structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc. You shouldn't care about these
    # parameters for a regular usage of the graphics module.
    #
    # * *handle* -   Platform-specific handle of the control (*hwnd* on
    #                 Windows, *%window* on Linux/FreeBSD, *ns_window* on OS X)
    # * *settings* - Additional settings for the underlying OpenGL context
    def initialize(handle : WindowHandle, settings : ContextSettings = ContextSettings.new())
      @_window = uninitialized VoidCSFML::Window_Buffer
      @_renderwindow = uninitialized VoidCSFML::RenderWindow_Buffer
      VoidCSFML.renderwindow_initialize_rLQFw4(to_unsafe, handle, settings)
    end
    # Destructor
    #
    # Closes the window and frees all the resources attached to it.
    def finalize()
      VoidCSFML.renderwindow_finalize(to_unsafe)
    end
    # Get the size of the rendering region of the window
    #
    # The size doesn't include the titlebar and borders
    # of the window.
    #
    # *Returns:* Size in pixels
    def size() : Vector2u
      result = Vector2u.allocate
      VoidCSFML.renderwindow_getsize(to_unsafe, result)
      return result
    end
    # Copy the current contents of the window to an image
    #
    # *Deprecated:*
    # Use a `SF::Texture` and its `SF::Texture::update`(const Window&)
    # function and copy its contents into an `SF::Image` instead.
    # ```c++
    # sf::Vector2u windowSize = window.getSize();
    # sf::Texture texture;
    # texture.create(windowSize.x, windowSize.y);
    # texture.update(window);
    # sf::Image screenshot = texture.copyToImage();
    # ```
    #
    # This is a slow operation, whose main purpose is to make
    # screenshots of the application. If you want to update an
    # image with the contents of the window and then use it for
    # drawing, you should rather use a `SF::Texture` and its
    # update(Window&) function.
    # You can also draw things directly to a texture with the
    # `SF::RenderTexture` class.
    #
    # *Returns:* Image containing the captured contents
    def capture() : Image
      result = Image.allocate
      VoidCSFML.renderwindow_capture(to_unsafe, result)
      return result
    end
    # :nodoc:
    def create(mode : VideoMode, title : String, style : Style = Style::Default, settings : ContextSettings = ContextSettings.new())
      VoidCSFML.renderwindow_create_wg0bQssaLFw4(to_unsafe, mode, title.size, title.chars, style, settings)
    end
    # Shorthand for `render_window = RenderWindow.new; render_window.create(...); render_window`
    def self.new(mode : VideoMode, title : String, style : Style = Style::Default, settings : ContextSettings = ContextSettings.new()) : self
      obj = new
      obj.create(mode, title, style, settings)
      obj
    end
    # :nodoc:
    def create(handle : WindowHandle, settings : ContextSettings = ContextSettings.new())
      VoidCSFML.renderwindow_create_rLQFw4(to_unsafe, handle, settings)
    end
    # Shorthand for `render_window = RenderWindow.new; render_window.create(...); render_window`
    def self.new(handle : WindowHandle, settings : ContextSettings = ContextSettings.new()) : self
      obj = new
      obj.create(handle, settings)
      obj
    end
    # :nodoc:
    def close()
      VoidCSFML.renderwindow_close(to_unsafe)
    end
    # :nodoc:
    def open?() : Bool
      VoidCSFML.renderwindow_isopen(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def settings() : ContextSettings
      result = ContextSettings.allocate
      VoidCSFML.renderwindow_getsettings(to_unsafe, result)
      return result
    end
    # :nodoc:
    def poll_event() : Event?
      event = uninitialized VoidCSFML::Event_Buffer
      VoidCSFML.renderwindow_pollevent_YJW(to_unsafe, event, out result)
      if result
        {% begin %}
        case event.to_unsafe.as(LibC::Int*).value
          {% for m, i in %w[Closed Resized LostFocus GainedFocus TextEntered KeyPressed KeyReleased MouseWheelMoved MouseWheelScrolled MouseButtonPressed MouseButtonReleased MouseMoved MouseEntered MouseLeft JoystickButtonPressed JoystickButtonReleased JoystickMoved JoystickConnected JoystickDisconnected TouchBegan TouchMoved TouchEnded SensorChanged] %}
        when {{i}}
          (event.to_unsafe.as(LibC::Int*) + 1).as(Event::{{m.id}}*).value
          {% end %}
        end .not_nil!
        {% end %}
      end
    end
    # :nodoc:
    def wait_event() : Event?
      event = uninitialized VoidCSFML::Event_Buffer
      VoidCSFML.renderwindow_waitevent_YJW(to_unsafe, event, out result)
      if result
        {% begin %}
        case event.to_unsafe.as(LibC::Int*).value
          {% for m, i in %w[Closed Resized LostFocus GainedFocus TextEntered KeyPressed KeyReleased MouseWheelMoved MouseWheelScrolled MouseButtonPressed MouseButtonReleased MouseMoved MouseEntered MouseLeft JoystickButtonPressed JoystickButtonReleased JoystickMoved JoystickConnected JoystickDisconnected TouchBegan TouchMoved TouchEnded SensorChanged] %}
        when {{i}}
          (event.to_unsafe.as(LibC::Int*) + 1).as(Event::{{m.id}}*).value
          {% end %}
        end .not_nil!
        {% end %}
      end
    end
    # :nodoc:
    def position() : Vector2i
      result = Vector2i.allocate
      VoidCSFML.renderwindow_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def position=(position : Vector2|Tuple)
      position = Vector2i.new(position[0].to_i32, position[1].to_i32)
      VoidCSFML.renderwindow_setposition_ufV(to_unsafe, position)
    end
    # :nodoc:
    def size=(size : Vector2|Tuple)
      size = Vector2u.new(size[0].to_u32, size[1].to_u32)
      VoidCSFML.renderwindow_setsize_DXO(to_unsafe, size)
    end
    # :nodoc:
    def title=(title : String)
      VoidCSFML.renderwindow_settitle_bQs(to_unsafe, title.size, title.chars)
    end
    # :nodoc:
    def set_icon(width : Int, height : Int, pixels : UInt8*)
      VoidCSFML.renderwindow_seticon_emSemS843(to_unsafe, LibC::UInt.new(width), LibC::UInt.new(height), pixels)
    end
    # :nodoc:
    def visible=(visible : Bool)
      VoidCSFML.renderwindow_setvisible_GZq(to_unsafe, visible)
    end
    # :nodoc:
    def vertical_sync_enabled=(enabled : Bool)
      VoidCSFML.renderwindow_setverticalsyncenabled_GZq(to_unsafe, enabled)
    end
    # :nodoc:
    def mouse_cursor_visible=(visible : Bool)
      VoidCSFML.renderwindow_setmousecursorvisible_GZq(to_unsafe, visible)
    end
    # :nodoc:
    def mouse_cursor_grabbed=(grabbed : Bool)
      VoidCSFML.renderwindow_setmousecursorgrabbed_GZq(to_unsafe, grabbed)
    end
    # :nodoc:
    def key_repeat_enabled=(enabled : Bool)
      VoidCSFML.renderwindow_setkeyrepeatenabled_GZq(to_unsafe, enabled)
    end
    # :nodoc:
    def framerate_limit=(limit : Int)
      VoidCSFML.renderwindow_setframeratelimit_emS(to_unsafe, LibC::UInt.new(limit))
    end
    # :nodoc:
    def joystick_threshold=(threshold : Number)
      VoidCSFML.renderwindow_setjoystickthreshold_Bw9(to_unsafe, LibC::Float.new(threshold))
    end
    # :nodoc:
    def active=(active : Bool = true) : Bool
      VoidCSFML.renderwindow_setactive_GZq(to_unsafe, active, out result)
      return result
    end
    # :nodoc:
    def request_focus()
      VoidCSFML.renderwindow_requestfocus(to_unsafe)
    end
    # :nodoc:
    def focus?() : Bool
      VoidCSFML.renderwindow_hasfocus(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def display()
      VoidCSFML.renderwindow_display(to_unsafe)
    end
    # :nodoc:
    def system_handle() : WindowHandle
      VoidCSFML.renderwindow_getsystemhandle(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def clear(color : Color = Color.new(0, 0, 0, 255))
      VoidCSFML.renderwindow_clear_QVe(to_unsafe, color)
    end
    # :nodoc:
    def view=(view : View)
      @_renderwindow_view = view
      VoidCSFML.renderwindow_setview_DDi(to_unsafe, view)
    end
    @_renderwindow_view : View? = nil
    # :nodoc:
    def view() : View
      VoidCSFML.renderwindow_getview(to_unsafe, out result)
      return View::Reference.new(result, self)
    end
    # :nodoc:
    def default_view() : View
      VoidCSFML.renderwindow_getdefaultview(to_unsafe, out result)
      return View::Reference.new(result, self)
    end
    # :nodoc:
    def get_viewport(view : View) : IntRect
      result = IntRect.allocate
      VoidCSFML.renderwindow_getviewport_DDi(to_unsafe, view, result)
      return result
    end
    # :nodoc:
    def map_pixel_to_coords(point : Vector2|Tuple) : Vector2f
      result = Vector2f.allocate
      point = Vector2i.new(point[0].to_i32, point[1].to_i32)
      VoidCSFML.renderwindow_mappixeltocoords_ufV(to_unsafe, point, result)
      return result
    end
    # :nodoc:
    def map_pixel_to_coords(point : Vector2|Tuple, view : View) : Vector2f
      result = Vector2f.allocate
      point = Vector2i.new(point[0].to_i32, point[1].to_i32)
      VoidCSFML.renderwindow_mappixeltocoords_ufVDDi(to_unsafe, point, view, result)
      return result
    end
    # :nodoc:
    def map_coords_to_pixel(point : Vector2|Tuple) : Vector2i
      result = Vector2i.allocate
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.renderwindow_mapcoordstopixel_UU2(to_unsafe, point, result)
      return result
    end
    # :nodoc:
    def map_coords_to_pixel(point : Vector2|Tuple, view : View) : Vector2i
      result = Vector2i.allocate
      point = Vector2f.new(point[0].to_f32, point[1].to_f32)
      VoidCSFML.renderwindow_mapcoordstopixel_UU2DDi(to_unsafe, point, view, result)
      return result
    end
    # :nodoc:
    def draw(vertices : Array(Vertex) | Slice(Vertex), type : PrimitiveType, states : RenderStates = RenderStates::Default)
      VoidCSFML.renderwindow_draw_46svgvu9wmi4(to_unsafe, vertices, vertices.size, type, states)
    end
    # :nodoc:
    def push_gl_states()
      VoidCSFML.renderwindow_pushglstates(to_unsafe)
    end
    # :nodoc:
    def pop_gl_states()
      VoidCSFML.renderwindow_popglstates(to_unsafe)
    end
    # :nodoc:
    def reset_gl_states()
      VoidCSFML.renderwindow_resetglstates(to_unsafe)
    end
    include RenderTarget
    # :nodoc:
    def to_unsafe()
      pointerof(@_window).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Shader class (vertex, geometry and fragment)
  #
  # RAII object to save and restore the program
  #        binding while uniforms are being set
  #
  # Implementation is private in the .cpp file.
  #
  # Shaders are programs written using a specific language,
  # executed directly by the graphics card and allowing
  # to apply real-time operations to the rendered entities.
  #
  # There are three kinds of shaders:
  # * %Vertex shaders, that process vertices
  # * Geometry shaders, that process primitives
  # * Fragment (pixel) shaders, that process pixels
  #
  # A `SF::Shader` can be composed of either a vertex shader
  # alone, a geometry shader alone, a fragment shader alone,
  # or any combination of them. (see the variants of the
  # load functions).
  #
  # Shaders are written in GLSL, which is a C-like
  # language dedicated to OpenGL shaders. You'll probably
  # need to learn its basics before writing your own shaders
  # for SFML.
  #
  # Like any C/C++ program, a GLSL shader has its own variables
  # called *uniforms* that you can set from your C++ application.
  # `SF::Shader` handles different types of uniforms:
  # * scalars: \p float, \p int, \p bool
  # * vectors (2, 3 or 4 components)
  # * matrices (3x3 or 4x4)
  # * samplers (textures)
  #
  # Some SFML-specific types can be converted:
  # * `SF::Color` as a 4D vector (\p vec4)
  # * `SF::Transform` as matrices (\p mat3 or \p mat4)
  #
  # Every uniform variable in a shader can be set through one of the
  # uniform=() or uniform_array=() overloads. For example, if you
  # have a shader with the following uniforms:
  # ```c++
  # uniform float offset;
  # uniform vec3 point;
  # uniform vec4 color;
  # uniform mat4 matrix;
  # uniform sampler2D overlay;
  # uniform sampler2D current;
  # ```
  # You can set their values from C++ code as follows, using the types
  # defined in the `SF::Glsl` namespace:
  # ```c++
  # shader.setUniform("offset", 2.f);
  # shader.setUniform("point", sf::Vector3f(0.5f, 0.8f, 0.3f));
  # shader.setUniform("color", sf::Glsl::Vec4(color));          // color is a sf::Color
  # shader.setUniform("matrix", sf::Glsl::Mat4(transform));     // transform is a sf::Transform
  # shader.setUniform("overlay", texture);                      // texture is a sf::Texture
  # shader.setUniform("current", sf::Shader::CurrentTexture);
  # ```
  #
  # The old parameter=() overloads are deprecated and will be removed in a
  # future version. You should use their uniform=() equivalents instead.
  #
  # The special Shader::CurrentTexture argument maps the
  # given \p sampler2d uniform to the current texture of the
  # object being drawn (which cannot be known in advance).
  #
  # To apply a shader to a drawable, you must pass it as an
  # additional parameter to the \ref Window::draw() draw() function:
  # ```c++
  # window.draw(sprite, &shader);
  # ```
  #
  # ... which is in fact just a shortcut for this:
  # ```c++
  # sf::RenderStates states;
  # states.shader = &shader;
  # window.draw(sprite, states);
  # ```
  #
  # In the code above we pass a pointer to the shader, because it may
  # be null (which means "no shader").
  #
  # Shaders can be used on any drawable, but some combinations are
  # not interesting. For example, using a vertex shader on a `SF::Sprite`
  # is limited because there are only 4 vertices, the sprite would
  # have to be subdivided in order to apply wave effects.
  # Another bad example is a fragment shader with `SF::Text:` the texture
  # of the text is not the actual text that you see on screen, it is
  # a big texture containing all the characters of the font in an
  # arbitrary order; thus, texture lookups on pixels other than the
  # current one may not give you the expected result.
  #
  # Shaders can also be used to apply global post-effects to the
  # current contents of the target (like the old `SF::PostFx` class
  # in SFML 1). This can be done in two different ways:
  # * draw everything to a `SF::RenderTexture`, then draw it to
  #   the main target using the shader
  # * draw everything directly to the main target, then use
  #   `SF::Texture::update`(Window&) to copy its contents to a texture
  #   and draw it to the main target using the shader
  #
  # The first technique is more optimized because it doesn't involve
  # retrieving the target's pixels to system memory, but the
  # second one doesn't impact the rendering process and can be
  # easily inserted anywhere without impacting all the code.
  #
  # Like `SF::Texture` that can be used as a raw OpenGL texture,
  # `SF::Shader` can also be used directly as a raw shader for
  # custom OpenGL geometry.
  # ```c++
  # sf::Shader::bind(&shader);
  # ... render OpenGL geometry ...
  # sf::Shader::bind(NULL);
  # ```
  #
  # *See also:* `SF::Glsl`
  class Shader
    @_shader : VoidCSFML::Shader_Buffer
    # Types of shaders
    enum Type
      # %Vertex shader
      Vertex
      # Geometry shader
      Geometry
      # Fragment (pixel) shader
      Fragment
    end
    _sf_enum Shader::Type
    # Special type that can be passed to uniform=(),
    #        and that represents the texture of the object being drawn
    #
    # *See also:* `uniform=`(`const` `std`::`string`&, `CurrentTextureType`)
    #
    # Represents the texture of the object being drawn
    #
    # *See also:* `uniform=`(`const` `std`::`string`&, `CurrentTextureType`)
    #
    # Default constructor
    #
    # This constructor creates an invalid shader.
    def initialize()
      @_shader = uninitialized VoidCSFML::Shader_Buffer
      VoidCSFML.shader_initialize(to_unsafe)
    end
    # Destructor
    def finalize()
      VoidCSFML.shader_finalize(to_unsafe)
    end
    # Load the vertex, geometry or fragment shader from a file
    #
    # This function loads a single shader, vertex, geometry or
    # fragment, identified by the second argument.
    # The source must be a text file containing a valid
    # shader in GLSL language. GLSL is a C-like language
    # dedicated to OpenGL shaders; you'll probably need to
    # read a good documentation for it before writing your
    # own shaders.
    #
    # * *filename* - Path of the vertex, geometry or fragment shader file to load
    # * *type* -     Type of shader (vertex, geometry or fragment)
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_memory`, `load_from_stream`
    def load_from_file(filename : String, type : Shader::Type) : Bool
      VoidCSFML.shader_loadfromfile_zkCqL0(to_unsafe, filename.bytesize, filename, type, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_file(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_file(filename : String, type : Shader::Type) : self
      obj = new
      if !obj.load_from_file(filename, type)
        raise InitError.new("Shader.load_from_file failed")
      end
      obj
    end
    # Load both the vertex and fragment shaders from files
    #
    # This function loads both the vertex and the fragment
    # shaders. If one of them fails to load, the shader is left
    # empty (the valid shader is unloaded).
    # The sources must be text files containing valid shaders
    # in GLSL language. GLSL is a C-like language dedicated to
    # OpenGL shaders; you'll probably need to read a good documentation
    # for it before writing your own shaders.
    #
    # * *vertex_shader_filename* -   Path of the vertex shader file to load
    # * *fragment_shader_filename* - Path of the fragment shader file to load
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_memory`, `load_from_stream`
    def load_from_file(vertex_shader_filename : String, fragment_shader_filename : String) : Bool
      VoidCSFML.shader_loadfromfile_zkCzkC(to_unsafe, vertex_shader_filename.bytesize, vertex_shader_filename, fragment_shader_filename.bytesize, fragment_shader_filename, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_file(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_file(vertex_shader_filename : String, fragment_shader_filename : String) : self
      obj = new
      if !obj.load_from_file(vertex_shader_filename, fragment_shader_filename)
        raise InitError.new("Shader.load_from_file failed")
      end
      obj
    end
    # Load the vertex, geometry and fragment shaders from files
    #
    # This function loads the vertex, geometry and fragment
    # shaders. If one of them fails to load, the shader is left
    # empty (the valid shader is unloaded).
    # The sources must be text files containing valid shaders
    # in GLSL language. GLSL is a C-like language dedicated to
    # OpenGL shaders; you'll probably need to read a good documentation
    # for it before writing your own shaders.
    #
    # * *vertex_shader_filename* -   Path of the vertex shader file to load
    # * *geometry_shader_filename* - Path of the geometry shader file to load
    # * *fragment_shader_filename* - Path of the fragment shader file to load
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_memory`, `load_from_stream`
    def load_from_file(vertex_shader_filename : String, geometry_shader_filename : String, fragment_shader_filename : String) : Bool
      VoidCSFML.shader_loadfromfile_zkCzkCzkC(to_unsafe, vertex_shader_filename.bytesize, vertex_shader_filename, geometry_shader_filename.bytesize, geometry_shader_filename, fragment_shader_filename.bytesize, fragment_shader_filename, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_file(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_file(vertex_shader_filename : String, geometry_shader_filename : String, fragment_shader_filename : String) : self
      obj = new
      if !obj.load_from_file(vertex_shader_filename, geometry_shader_filename, fragment_shader_filename)
        raise InitError.new("Shader.load_from_file failed")
      end
      obj
    end
    # Load the vertex, geometry or fragment shader from a source code in memory
    #
    # This function loads a single shader, vertex, geometry
    # or fragment, identified by the second argument.
    # The source code must be a valid shader in GLSL language.
    # GLSL is a C-like language dedicated to OpenGL shaders;
    # you'll probably need to read a good documentation for
    # it before writing your own shaders.
    #
    # * *shader* - String containing the source code of the shader
    # * *type* -   Type of shader (vertex, geometry or fragment)
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_stream`
    def load_from_memory(shader : String, type : Shader::Type) : Bool
      VoidCSFML.shader_loadfrommemory_zkCqL0(to_unsafe, shader.bytesize, shader, type, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_memory(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_memory(shader : String, type : Shader::Type) : self
      obj = new
      if !obj.load_from_memory(shader, type)
        raise InitError.new("Shader.load_from_memory failed")
      end
      obj
    end
    # Load both the vertex and fragment shaders from source codes in memory
    #
    # This function loads both the vertex and the fragment
    # shaders. If one of them fails to load, the shader is left
    # empty (the valid shader is unloaded).
    # The sources must be valid shaders in GLSL language. GLSL is
    # a C-like language dedicated to OpenGL shaders; you'll
    # probably need to read a good documentation for it before
    # writing your own shaders.
    #
    # * *vertex_shader* -   String containing the source code of the vertex shader
    # * *fragment_shader* - String containing the source code of the fragment shader
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_stream`
    def load_from_memory(vertex_shader : String, fragment_shader : String) : Bool
      VoidCSFML.shader_loadfrommemory_zkCzkC(to_unsafe, vertex_shader.bytesize, vertex_shader, fragment_shader.bytesize, fragment_shader, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_memory(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_memory(vertex_shader : String, fragment_shader : String) : self
      obj = new
      if !obj.load_from_memory(vertex_shader, fragment_shader)
        raise InitError.new("Shader.load_from_memory failed")
      end
      obj
    end
    # Load the vertex, geometry and fragment shaders from source codes in memory
    #
    # This function loads the vertex, geometry and fragment
    # shaders. If one of them fails to load, the shader is left
    # empty (the valid shader is unloaded).
    # The sources must be valid shaders in GLSL language. GLSL is
    # a C-like language dedicated to OpenGL shaders; you'll
    # probably need to read a good documentation for it before
    # writing your own shaders.
    #
    # * *vertex_shader* -   String containing the source code of the vertex shader
    # * *geometry_shader* - String containing the source code of the geometry shader
    # * *fragment_shader* - String containing the source code of the fragment shader
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_stream`
    def load_from_memory(vertex_shader : String, geometry_shader : String, fragment_shader : String) : Bool
      VoidCSFML.shader_loadfrommemory_zkCzkCzkC(to_unsafe, vertex_shader.bytesize, vertex_shader, geometry_shader.bytesize, geometry_shader, fragment_shader.bytesize, fragment_shader, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_memory(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_memory(vertex_shader : String, geometry_shader : String, fragment_shader : String) : self
      obj = new
      if !obj.load_from_memory(vertex_shader, geometry_shader, fragment_shader)
        raise InitError.new("Shader.load_from_memory failed")
      end
      obj
    end
    # Load the vertex, geometry or fragment shader from a custom stream
    #
    # This function loads a single shader, vertex, geometry
    # or fragment, identified by the second argument.
    # The source code must be a valid shader in GLSL language.
    # GLSL is a C-like language dedicated to OpenGL shaders;
    # you'll probably need to read a good documentation for it
    # before writing your own shaders.
    #
    # * *stream* - Source stream to read from
    # * *type* -   Type of shader (vertex, geometry or fragment)
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_memory`
    def load_from_stream(stream : InputStream, type : Shader::Type) : Bool
      VoidCSFML.shader_loadfromstream_PO0qL0(to_unsafe, stream, type, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_stream(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_stream(stream : InputStream, type : Shader::Type) : self
      obj = new
      if !obj.load_from_stream(stream, type)
        raise InitError.new("Shader.load_from_stream failed")
      end
      obj
    end
    # Load both the vertex and fragment shaders from custom streams
    #
    # This function loads both the vertex and the fragment
    # shaders. If one of them fails to load, the shader is left
    # empty (the valid shader is unloaded).
    # The source codes must be valid shaders in GLSL language.
    # GLSL is a C-like language dedicated to OpenGL shaders;
    # you'll probably need to read a good documentation for
    # it before writing your own shaders.
    #
    # * *vertex_shader_stream* -   Source stream to read the vertex shader from
    # * *fragment_shader_stream* - Source stream to read the fragment shader from
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_memory`
    def load_from_stream(vertex_shader_stream : InputStream, fragment_shader_stream : InputStream) : Bool
      VoidCSFML.shader_loadfromstream_PO0PO0(to_unsafe, vertex_shader_stream, fragment_shader_stream, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_stream(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_stream(vertex_shader_stream : InputStream, fragment_shader_stream : InputStream) : self
      obj = new
      if !obj.load_from_stream(vertex_shader_stream, fragment_shader_stream)
        raise InitError.new("Shader.load_from_stream failed")
      end
      obj
    end
    # Load the vertex, geometry and fragment shaders from custom streams
    #
    # This function loads the vertex, geometry and fragment
    # shaders. If one of them fails to load, the shader is left
    # empty (the valid shader is unloaded).
    # The source codes must be valid shaders in GLSL language.
    # GLSL is a C-like language dedicated to OpenGL shaders;
    # you'll probably need to read a good documentation for
    # it before writing your own shaders.
    #
    # * *vertex_shader_stream* -   Source stream to read the vertex shader from
    # * *geometry_shader_stream* - Source stream to read the geometry shader from
    # * *fragment_shader_stream* - Source stream to read the fragment shader from
    #
    # *Returns:* True if loading succeeded, false if it failed
    #
    # *See also:* `load_from_file`, `load_from_memory`
    def load_from_stream(vertex_shader_stream : InputStream, geometry_shader_stream : InputStream, fragment_shader_stream : InputStream) : Bool
      VoidCSFML.shader_loadfromstream_PO0PO0PO0(to_unsafe, vertex_shader_stream, geometry_shader_stream, fragment_shader_stream, out result)
      return result
    end
    # Shorthand for `shader = Shader.new; shader.load_from_stream(...); shader`
    #
    # Raises `InitError` on failure
    def self.from_stream(vertex_shader_stream : InputStream, geometry_shader_stream : InputStream, fragment_shader_stream : InputStream) : self
      obj = new
      if !obj.load_from_stream(vertex_shader_stream, geometry_shader_stream, fragment_shader_stream)
        raise InitError.new("Shader.load_from_stream failed")
      end
      obj
    end
    # Change a float parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, float) instead.
    def set_parameter(name : String, x : Number)
      VoidCSFML.shader_setparameter_zkCBw9(to_unsafe, name.bytesize, name, LibC::Float.new(x))
    end
    # Change a 2-components vector parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Glsl::Vec2&) instead.
    def set_parameter(name : String, x : Number, y : Number)
      VoidCSFML.shader_setparameter_zkCBw9Bw9(to_unsafe, name.bytesize, name, LibC::Float.new(x), LibC::Float.new(y))
    end
    # Change a 3-components vector parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Glsl::Vec3&) instead.
    def set_parameter(name : String, x : Number, y : Number, z : Number)
      VoidCSFML.shader_setparameter_zkCBw9Bw9Bw9(to_unsafe, name.bytesize, name, LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z))
    end
    # Change a 4-components vector parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Glsl::Vec4&) instead.
    def set_parameter(name : String, x : Number, y : Number, z : Number, w : Number)
      VoidCSFML.shader_setparameter_zkCBw9Bw9Bw9Bw9(to_unsafe, name.bytesize, name, LibC::Float.new(x), LibC::Float.new(y), LibC::Float.new(z), LibC::Float.new(w))
    end
    # Change a 2-components vector parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Glsl::Vec2&) instead.
    def set_parameter(name : String, vector : Vector2|Tuple)
      vector = Vector2f.new(vector[0].to_f32, vector[1].to_f32)
      VoidCSFML.shader_setparameter_zkCUU2(to_unsafe, name.bytesize, name, vector)
    end
    # Change a 3-components vector parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Glsl::Vec3&) instead.
    def set_parameter(name : String, vector : Vector3f)
      VoidCSFML.shader_setparameter_zkCNzM(to_unsafe, name.bytesize, name, vector)
    end
    # Change a color parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Glsl::Vec4&) instead.
    def set_parameter(name : String, color : Color)
      VoidCSFML.shader_setparameter_zkCQVe(to_unsafe, name.bytesize, name, color)
    end
    # Change a matrix parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Glsl::Mat4&) instead.
    def set_parameter(name : String, transform : Transform)
      VoidCSFML.shader_setparameter_zkCFPe(to_unsafe, name.bytesize, name, transform)
    end
    # Change a texture parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, const Texture&) instead.
    def set_parameter(name : String, texture : Texture)
      VoidCSFML.shader_setparameter_zkCDJb(to_unsafe, name.bytesize, name, texture)
    end
    # Change a texture parameter of the shader
    #
    # *Deprecated:* Use uniform=(const std::string&, CurrentTextureType) instead.
    def set_parameter(name : String, p1 : CurrentTextureType)
      VoidCSFML.shader_setparameter_zkCLcV(to_unsafe, name.bytesize, name)
    end
    # Get the underlying OpenGL handle of the shader.
    #
    # You shouldn't need to use this function, unless you have
    # very specific stuff to implement that SFML doesn't support,
    # or implement a temporary workaround until a bug is fixed.
    #
    # *Returns:* OpenGL handle of the shader or 0 if not yet loaded
    def native_handle() : Int32
      VoidCSFML.shader_getnativehandle(to_unsafe, out result)
      return result.to_i
    end
    # Bind a shader for rendering
    #
    # This function is not part of the graphics API, it mustn't be
    # used when drawing SFML entities. It must be used only if you
    # mix `SF::Shader` with OpenGL code.
    #
    # ```c++
    # sf::Shader s1, s2;
    # ...
    # sf::Shader::bind(&s1);
    # // draw OpenGL stuff that use s1...
    # sf::Shader::bind(&s2);
    # // draw OpenGL stuff that use s2...
    # sf::Shader::bind(NULL);
    # // draw OpenGL stuff that use no shader...
    # ```
    #
    # * *shader* - Shader to bind, can be null to use no shader
    def self.bind(shader : Shader?)
      VoidCSFML.shader_bind_8P6(shader)
    end
    # Tell whether or not the system supports shaders
    #
    # This function should always be called before using
    # the shader features. If it returns false, then
    # any attempt to use `SF::Shader` will fail.
    #
    # *Returns:* True if shaders are supported, false otherwise
    def self.available?() : Bool
      VoidCSFML.shader_isavailable(out result)
      return result
    end
    # Tell whether or not the system supports geometry shaders
    #
    # This function should always be called before using
    # the geometry shader features. If it returns false, then
    # any attempt to use `SF::Shader` geometry shader features will fail.
    #
    # This function can only return true if available?() would also
    # return true, since shaders in general have to be supported in
    # order for geometry shaders to be supported as well.
    #
    # Note: The first call to this function, whether by your
    # code or SFML will result in a context switch.
    #
    # *Returns:* True if geometry shaders are supported, false otherwise
    def self.geometry_available?() : Bool
      VoidCSFML.shader_isgeometryavailable(out result)
      return result
    end
    include GlResource
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      pointerof(@_shader).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Drawable representation of a texture, with its
  #        own transformations, color, etc.
  #
  # `SF::Sprite` is a drawable class that allows to easily display
  # a texture (or a part of it) on a render target.
  #
  # It inherits all the functions from `SF::Transformable:`
  # position, rotation, scale, origin. It also adds sprite-specific
  # properties such as the texture to use, the part of it to display,
  # and some convenience functions to change the overall color of the
  # sprite, or to get its bounding rectangle.
  #
  # `SF::Sprite` works in combination with the `SF::Texture` class, which
  # loads and provides the pixel data of a given texture.
  #
  # The separation of `SF::Sprite` and `SF::Texture` allows more flexibility
  # and better performances: indeed a `SF::Texture` is a heavy resource,
  # and any operation on it is slow (often too slow for real-time
  # applications). On the other side, a `SF::Sprite` is a lightweight
  # object which can use the pixel data of a `SF::Texture` and draw
  # it with its own transformation/color/blending attributes.
  #
  # It is important to note that the `SF::Sprite` instance doesn't
  # copy the texture that it uses, it only keeps a reference to it.
  # Thus, a `SF::Texture` must not be destroyed while it is
  # used by a `SF::Sprite` (i.e. never write a function that
  # uses a local `SF::Texture` instance for creating a sprite).
  #
  # See also the note on coordinates and undistorted rendering in `SF::Transformable`.
  #
  # Usage example:
  # ```c++
  # // Declare and load a texture
  # sf::Texture texture;
  # texture.loadFromFile("texture.png");
  #
  # // Create a sprite
  # sf::Sprite sprite;
  # sprite.setTexture(texture);
  # sprite.setTextureRect(sf::IntRect(10, 10, 50, 30));
  # sprite.setColor(sf::Color(255, 255, 255, 200));
  # sprite.setPosition(100, 25);
  #
  # // Draw it
  # window.draw(sprite);
  # ```
  #
  # *See also:* `SF::Texture`, `SF::Transformable`
  class Sprite < Transformable
    @_sprite : VoidCSFML::Sprite_Buffer
    # Default constructor
    #
    # Creates an empty sprite with no source texture.
    def initialize()
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_sprite = uninitialized VoidCSFML::Sprite_Buffer
      VoidCSFML.sprite_initialize(to_unsafe)
    end
    # Construct the sprite from a source texture
    #
    # * *texture* - Source texture
    #
    # *See also:* `texture=`
    def initialize(texture : Texture)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_sprite = uninitialized VoidCSFML::Sprite_Buffer
      @_sprite_texture = texture
      VoidCSFML.sprite_initialize_DJb(to_unsafe, texture)
    end
    # Construct the sprite from a sub-rectangle of a source texture
    #
    # * *texture* -   Source texture
    # * *rectangle* - Sub-rectangle of the texture to assign to the sprite
    #
    # *See also:* `texture=`, `texture_rect=`
    def initialize(texture : Texture, rectangle : IntRect)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_sprite = uninitialized VoidCSFML::Sprite_Buffer
      @_sprite_texture = texture
      VoidCSFML.sprite_initialize_DJb2k1(to_unsafe, texture, rectangle)
    end
    # Change the source texture of the sprite
    #
    # The *texture* argument refers to a texture that must
    # exist as long as the sprite uses it. Indeed, the sprite
    # doesn't store its own copy of the texture, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the source texture is destroyed and the sprite tries to
    # use it, the behavior is undefined.
    # If *reset_rect* is true, the TextureRect property of
    # the sprite is automatically adjusted to the size of the new
    # texture. If it is false, the texture rect is left unchanged.
    #
    # * *texture* -   New texture
    # * *reset_rect* - Should the texture rect be reset to the size of the new texture?
    #
    # *See also:* `texture`, `texture_rect=`
    def set_texture(texture : Texture, reset_rect : Bool = false)
      @_sprite_texture = texture
      VoidCSFML.sprite_settexture_DJbGZq(to_unsafe, texture, reset_rect)
    end
    @_sprite_texture : Texture? = nil
    # Set the sub-rectangle of the texture that the sprite will display
    #
    # The texture rect is useful when you don't want to display
    # the whole texture, but rather a part of it.
    # By default, the texture rect covers the entire texture.
    #
    # * *rectangle* - Rectangle defining the region of the texture to display
    #
    # *See also:* `texture_rect`, `texture=`
    def texture_rect=(rectangle : IntRect)
      VoidCSFML.sprite_settexturerect_2k1(to_unsafe, rectangle)
    end
    # Set the global color of the sprite
    #
    # This color is modulated (multiplied) with the sprite's
    # texture. It can be used to colorize the sprite, or change
    # its global opacity.
    # By default, the sprite's color is opaque white.
    #
    # * *color* - New color of the sprite
    #
    # *See also:* `color`
    def color=(color : Color)
      VoidCSFML.sprite_setcolor_QVe(to_unsafe, color)
    end
    # Get the source texture of the sprite
    #
    # If the sprite has no source texture, a NULL pointer is returned.
    # The returned pointer is const, which means that you can't
    # modify the texture when you retrieve it with this function.
    #
    # *Returns:* Pointer to the sprite's texture
    #
    # *See also:* `texture=`
    def texture() : Texture?
      return @_sprite_texture
    end
    # Get the sub-rectangle of the texture displayed by the sprite
    #
    # *Returns:* Texture rectangle of the sprite
    #
    # *See also:* `texture_rect=`
    def texture_rect() : IntRect
      result = IntRect.allocate
      VoidCSFML.sprite_gettexturerect(to_unsafe, result)
      return result
    end
    # Get the global color of the sprite
    #
    # *Returns:* Global color of the sprite
    #
    # *See also:* `color=`
    def color() : Color
      result = Color.allocate
      VoidCSFML.sprite_getcolor(to_unsafe, result)
      return result
    end
    # Get the local bounding rectangle of the entity
    #
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    #
    # *Returns:* Local bounding rectangle of the entity
    def local_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.sprite_getlocalbounds(to_unsafe, result)
      return result
    end
    # Get the global bounding rectangle of the entity
    #
    # The returned rectangle is in global coordinates, which means
    # that it takes into account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # sprite in the global 2D world's coordinate system.
    #
    # *Returns:* Global bounding rectangle of the entity
    def global_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.sprite_getglobalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def texture() : Texture?
      return @_sprite_texture
    end
    # :nodoc:
    def set_position(x : Number, y : Number)
      VoidCSFML.sprite_setposition_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.sprite_setposition_UU2(to_unsafe, position)
    end
    # :nodoc:
    def rotation=(angle : Number)
      VoidCSFML.sprite_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def set_scale(factor_x : Number, factor_y : Number)
      VoidCSFML.sprite_setscale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale=(factors : Vector2|Tuple)
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.sprite_setscale_UU2(to_unsafe, factors)
    end
    # :nodoc:
    def set_origin(x : Number, y : Number)
      VoidCSFML.sprite_setorigin_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def origin=(origin : Vector2|Tuple)
      origin = Vector2f.new(origin[0].to_f32, origin[1].to_f32)
      VoidCSFML.sprite_setorigin_UU2(to_unsafe, origin)
    end
    # :nodoc:
    def position() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.sprite_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def rotation() : Float32
      VoidCSFML.sprite_getrotation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def scale() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.sprite_getscale(to_unsafe, result)
      return result
    end
    # :nodoc:
    def origin() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.sprite_getorigin(to_unsafe, result)
      return result
    end
    # :nodoc:
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.sprite_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # :nodoc:
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.sprite_move_UU2(to_unsafe, offset)
    end
    # :nodoc:
    def rotate(angle : Number)
      VoidCSFML.sprite_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def scale(factor_x : Number, factor_y : Number)
      VoidCSFML.sprite_scale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale(factor : Vector2|Tuple)
      factor = Vector2f.new(factor[0].to_f32, factor[1].to_f32)
      VoidCSFML.sprite_scale_UU2(to_unsafe, factor)
    end
    # :nodoc:
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.sprite_gettransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.sprite_getinversetransform(to_unsafe, result)
      return result
    end
    include Drawable
    # :nodoc:
    def to_unsafe()
      pointerof(@_transformable).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def draw(target : RenderTexture, states : RenderStates)
      VoidCSFML.sprite_draw_kb9RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderWindow, states : RenderStates)
      VoidCSFML.sprite_draw_fqURoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderTarget, states : RenderStates)
      VoidCSFML.sprite_draw_Xk1RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def initialize(copy : Sprite)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_sprite = uninitialized VoidCSFML::Sprite_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.sprite_initialize_8xu(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  # Graphical text that can be drawn to a render target
  #
  # `SF::Text` is a drawable class that allows to easily display
  # some text with custom style and color on a render target.
  #
  # It inherits all the functions from `SF::Transformable:`
  # position, rotation, scale, origin. It also adds text-specific
  # properties such as the font to use, the character size,
  # the font style (bold, italic, underlined, strike through), the
  # global color and the text to display of course.
  # It also provides convenience functions to calculate the
  # graphical size of the text, or to get the global position
  # of a given character.
  #
  # `SF::Text` works in combination with the `SF::Font` class, which
  # loads and provides the glyphs (visual characters) of a given font.
  #
  # The separation of `SF::Font` and `SF::Text` allows more flexibility
  # and better performances: indeed a `SF::Font` is a heavy resource,
  # and any operation on it is slow (often too slow for real-time
  # applications). On the other side, a `SF::Text` is a lightweight
  # object which can combine the glyphs data and metrics of a `SF::Font`
  # to display any text on a render target.
  #
  # It is important to note that the `SF::Text` instance doesn't
  # copy the font that it uses, it only keeps a reference to it.
  # Thus, a `SF::Font` must not be destructed while it is
  # used by a `SF::Text` (i.e. never write a function that
  # uses a local `SF::Font` instance for creating a text).
  #
  # See also the note on coordinates and undistorted rendering in `SF::Transformable`.
  #
  # Usage example:
  # ```c++
  # // Declare and load a font
  # sf::Font font;
  # font.loadFromFile("arial.ttf");
  #
  # // Create a text
  # sf::Text text("hello", font);
  # text.setCharacterSize(30);
  # text.setStyle(sf::Text::Bold);
  # text.setColor(sf::Color::Red);
  #
  # // Draw it
  # window.draw(text);
  # ```
  #
  # *See also:* `SF::Font`, `SF::Transformable`
  class Text < Transformable
    @_text : VoidCSFML::Text_Buffer
    # Enumeration of the string drawing styles
    @[Flags]
    enum Style
      # Regular characters, no style
      Regular = 0
      # Bold characters
      Bold = 1 << 0
      # Italic characters
      Italic = 1 << 1
      # Underlined characters
      Underlined = 1 << 2
      # Strike through characters
      StrikeThrough = 1 << 3
    end
    _sf_enum Text::Style
    # Default constructor
    #
    # Creates an empty text.
    def initialize()
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_text = uninitialized VoidCSFML::Text_Buffer
      VoidCSFML.text_initialize(to_unsafe)
    end
    # Construct the text from a string, font and size
    #
    # Note that if the used font is a bitmap font, it is not
    # scalable, thus not all requested sizes will be available
    # to use. This needs to be taken into consideration when
    # setting the character size. If you need to display text
    # of a certain size, make sure the corresponding bitmap
    # font that supports that size is used.
    #
    # * *string* -         Text assigned to the string
    # * *font* -           Font used to draw the string
    # * *character_size* -  Base size of characters, in pixels
    def initialize(string : String, font : Font, character_size : Int = 30)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_text = uninitialized VoidCSFML::Text_Buffer
      @_text_font = font
      VoidCSFML.text_initialize_bQs7CFemS(to_unsafe, string.size, string.chars, font, LibC::UInt.new(character_size))
    end
    # Set the text's string
    #
    # The *string* argument is a `SF::String`, which can
    # automatically be constructed from standard string types.
    # So, the following calls are all valid:
    # ```c++
    # text.setString("hello");
    # text.setString(L"hello");
    # text.setString(std::string("hello"));
    # text.setString(std::wstring(L"hello"));
    # ```
    # A text's string is empty by default.
    #
    # * *string* - New string
    #
    # *See also:* `string`
    def string=(string : String)
      VoidCSFML.text_setstring_bQs(to_unsafe, string.size, string.chars)
    end
    # Set the text's font
    #
    # The *font* argument refers to a font that must
    # exist as long as the text uses it. Indeed, the text
    # doesn't store its own copy of the font, but rather keeps
    # a pointer to the one that you passed to this function.
    # If the font is destroyed and the text tries to
    # use it, the behavior is undefined.
    #
    # * *font* - New font
    #
    # *See also:* `font`
    def font=(font : Font)
      @_text_font = font
      VoidCSFML.text_setfont_7CF(to_unsafe, font)
    end
    @_text_font : Font? = nil
    # Set the character size
    #
    # The default size is 30.
    #
    # Note that if the used font is a bitmap font, it is not
    # scalable, thus not all requested sizes will be available
    # to use. This needs to be taken into consideration when
    # setting the character size. If you need to display text
    # of a certain size, make sure the corresponding bitmap
    # font that supports that size is used.
    #
    # * *size* - New character size, in pixels
    #
    # *See also:* `character_size`
    def character_size=(size : Int)
      VoidCSFML.text_setcharactersize_emS(to_unsafe, LibC::UInt.new(size))
    end
    # Set the text's style
    #
    # You can pass a combination of one or more styles, for
    # example `SF::Text::Bold` | `SF::Text::Italic`.
    # The default style is `SF::Text::Regular`.
    #
    # * *style* - New style
    #
    # *See also:* `style`
    def style=(style : Text::Style)
      VoidCSFML.text_setstyle_saL(to_unsafe, style)
    end
    # Set the fill color of the text
    #
    # By default, the text's fill color is opaque white.
    # Setting the fill color to a transparent color with an outline
    # will cause the outline to be displayed in the fill area of the text.
    #
    # * *color* - New fill color of the text
    #
    # *See also:* `fill_color`
    #
    # *Deprecated:* There is now fill and outline colors instead
    # of a single global color.
    # Use fill_color=() or outline_color=() instead.
    def color=(color : Color)
      VoidCSFML.text_setcolor_QVe(to_unsafe, color)
    end
    # Set the fill color of the text
    #
    # By default, the text's fill color is opaque white.
    # Setting the fill color to a transparent color with an outline
    # will cause the outline to be displayed in the fill area of the text.
    #
    # * *color* - New fill color of the text
    #
    # *See also:* `fill_color`
    def fill_color=(color : Color)
      VoidCSFML.text_setfillcolor_QVe(to_unsafe, color)
    end
    # Set the outline color of the text
    #
    # By default, the text's outline color is opaque black.
    #
    # * *color* - New outline color of the text
    #
    # *See also:* `outline_color`
    def outline_color=(color : Color)
      VoidCSFML.text_setoutlinecolor_QVe(to_unsafe, color)
    end
    # Set the thickness of the text's outline
    #
    # By default, the outline thickness is 0.
    #
    # Be aware that using a negative value for the outline
    # thickness will cause distorted rendering.
    #
    # * *thickness* - New outline thickness, in pixels
    #
    # *See also:* `outline_thickness`
    def outline_thickness=(thickness : Number)
      VoidCSFML.text_setoutlinethickness_Bw9(to_unsafe, LibC::Float.new(thickness))
    end
    # Get the text's string
    #
    # The returned string is a `SF::String`, which can automatically
    # be converted to standard string types. So, the following
    # lines of code are all valid:
    # ```c++
    # sf::String   s1 = text.getString();
    # std::string  s2 = text.getString();
    # std::wstring s3 = text.getString();
    # ```
    #
    # *Returns:* Text's string
    #
    # *See also:* `string=`
    def string() : String
      VoidCSFML.text_getstring(to_unsafe, out result)
      return String.build { |io| while (v = result.value) != '\0'; io << v; result += 1; end }
    end
    # Get the text's font
    #
    # If the text has no font attached, a NULL pointer is returned.
    # The returned pointer is const, which means that you
    # cannot modify the font when you get it from this function.
    #
    # *Returns:* Pointer to the text's font
    #
    # *See also:* `font=`
    def font() : Font?
      return @_text_font
    end
    # Get the character size
    #
    # *Returns:* Size of the characters, in pixels
    #
    # *See also:* `character_size=`
    def character_size() : Int32
      VoidCSFML.text_getcharactersize(to_unsafe, out result)
      return result.to_i
    end
    # Get the text's style
    #
    # *Returns:* Text's style
    #
    # *See also:* `style=`
    def style() : UInt32
      VoidCSFML.text_getstyle(to_unsafe, out result)
      return result
    end
    # Get the fill color of the text
    #
    # *Returns:* Fill color of the text
    #
    # *See also:* `fill_color=`
    #
    # *Deprecated:* There is now fill and outline colors instead
    # of a single global color.
    # Use fill_color() or outline_color() instead.
    def color() : Color
      result = Color.allocate
      VoidCSFML.text_getcolor(to_unsafe, result)
      return result
    end
    # Get the fill color of the text
    #
    # *Returns:* Fill color of the text
    #
    # *See also:* `fill_color=`
    def fill_color() : Color
      result = Color.allocate
      VoidCSFML.text_getfillcolor(to_unsafe, result)
      return result
    end
    # Get the outline color of the text
    #
    # *Returns:* Outline color of the text
    #
    # *See also:* `outline_color=`
    def outline_color() : Color
      result = Color.allocate
      VoidCSFML.text_getoutlinecolor(to_unsafe, result)
      return result
    end
    # Get the outline thickness of the text
    #
    # *Returns:* Outline thickness of the text, in pixels
    #
    # *See also:* `outline_thickness=`
    def outline_thickness() : Float32
      VoidCSFML.text_getoutlinethickness(to_unsafe, out result)
      return result
    end
    # Return the position of the *index-th* character
    #
    # This function computes the visual position of a character
    # from its index in the string. The returned position is
    # in global coordinates (translation, rotation, scale and
    # origin are applied).
    # If *index* is out of range, the position of the end of
    # the string is returned.
    #
    # * *index* - Index of the character
    #
    # *Returns:* Position of the character
    def find_character_pos(index : Int) : Vector2f
      result = Vector2f.allocate
      VoidCSFML.text_findcharacterpos_vgv(to_unsafe, LibC::SizeT.new(index), result)
      return result
    end
    # Get the local bounding rectangle of the entity
    #
    # The returned rectangle is in local coordinates, which means
    # that it ignores the transformations (translation, rotation,
    # scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # entity in the entity's coordinate system.
    #
    # *Returns:* Local bounding rectangle of the entity
    def local_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.text_getlocalbounds(to_unsafe, result)
      return result
    end
    # Get the global bounding rectangle of the entity
    #
    # The returned rectangle is in global coordinates, which means
    # that it takes into account the transformations (translation,
    # rotation, scale, ...) that are applied to the entity.
    # In other words, this function returns the bounds of the
    # text in the global 2D world's coordinate system.
    #
    # *Returns:* Global bounding rectangle of the entity
    def global_bounds() : FloatRect
      result = FloatRect.allocate
      VoidCSFML.text_getglobalbounds(to_unsafe, result)
      return result
    end
    # :nodoc:
    def font() : Font?
      return @_text_font
    end
    # :nodoc:
    def set_position(x : Number, y : Number)
      VoidCSFML.text_setposition_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def position=(position : Vector2|Tuple)
      position = Vector2f.new(position[0].to_f32, position[1].to_f32)
      VoidCSFML.text_setposition_UU2(to_unsafe, position)
    end
    # :nodoc:
    def rotation=(angle : Number)
      VoidCSFML.text_setrotation_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def set_scale(factor_x : Number, factor_y : Number)
      VoidCSFML.text_setscale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale=(factors : Vector2|Tuple)
      factors = Vector2f.new(factors[0].to_f32, factors[1].to_f32)
      VoidCSFML.text_setscale_UU2(to_unsafe, factors)
    end
    # :nodoc:
    def set_origin(x : Number, y : Number)
      VoidCSFML.text_setorigin_Bw9Bw9(to_unsafe, LibC::Float.new(x), LibC::Float.new(y))
    end
    # :nodoc:
    def origin=(origin : Vector2|Tuple)
      origin = Vector2f.new(origin[0].to_f32, origin[1].to_f32)
      VoidCSFML.text_setorigin_UU2(to_unsafe, origin)
    end
    # :nodoc:
    def position() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.text_getposition(to_unsafe, result)
      return result
    end
    # :nodoc:
    def rotation() : Float32
      VoidCSFML.text_getrotation(to_unsafe, out result)
      return result
    end
    # :nodoc:
    def scale() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.text_getscale(to_unsafe, result)
      return result
    end
    # :nodoc:
    def origin() : Vector2f
      result = Vector2f.allocate
      VoidCSFML.text_getorigin(to_unsafe, result)
      return result
    end
    # :nodoc:
    def move(offset_x : Number, offset_y : Number)
      VoidCSFML.text_move_Bw9Bw9(to_unsafe, LibC::Float.new(offset_x), LibC::Float.new(offset_y))
    end
    # :nodoc:
    def move(offset : Vector2|Tuple)
      offset = Vector2f.new(offset[0].to_f32, offset[1].to_f32)
      VoidCSFML.text_move_UU2(to_unsafe, offset)
    end
    # :nodoc:
    def rotate(angle : Number)
      VoidCSFML.text_rotate_Bw9(to_unsafe, LibC::Float.new(angle))
    end
    # :nodoc:
    def scale(factor_x : Number, factor_y : Number)
      VoidCSFML.text_scale_Bw9Bw9(to_unsafe, LibC::Float.new(factor_x), LibC::Float.new(factor_y))
    end
    # :nodoc:
    def scale(factor : Vector2|Tuple)
      factor = Vector2f.new(factor[0].to_f32, factor[1].to_f32)
      VoidCSFML.text_scale_UU2(to_unsafe, factor)
    end
    # :nodoc:
    def transform() : Transform
      result = Transform.allocate
      VoidCSFML.text_gettransform(to_unsafe, result)
      return result
    end
    # :nodoc:
    def inverse_transform() : Transform
      result = Transform.allocate
      VoidCSFML.text_getinversetransform(to_unsafe, result)
      return result
    end
    include Drawable
    # :nodoc:
    def to_unsafe()
      pointerof(@_transformable).as(Void*)
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
    # :nodoc:
    def draw(target : RenderTexture, states : RenderStates)
      VoidCSFML.text_draw_kb9RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderWindow, states : RenderStates)
      VoidCSFML.text_draw_fqURoT(to_unsafe, target, states)
    end
    # :nodoc:
    def draw(target : RenderTarget, states : RenderStates)
      VoidCSFML.text_draw_Xk1RoT(to_unsafe, target, states)
    end
    # :nodoc:
    def initialize(copy : Text)
      @_transformable = uninitialized VoidCSFML::Transformable_Buffer
      @_text = uninitialized VoidCSFML::Text_Buffer
      as(Void*).copy_from(copy.as(Void*), instance_sizeof(typeof(self)))
      VoidCSFML.text_initialize_clM(to_unsafe, copy)
    end
    def dup() : self
      return typeof(self).new(self)
    end
  end
  VoidCSFML.sfml_graphics_version(out major, out minor, out patch)
  if SFML_VERSION != (ver = "#{major}.#{minor}.#{patch}")
    STDERR.puts "Warning: CrSFML was built for SFML #{SFML_VERSION}, found SFML #{ver}"
  end
end
