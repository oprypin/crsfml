require "./lib"
require "../common"
require "../system"
module SF
  extend self
  # Give access to the system clipboard
  #
  # `SF::Clipboard` provides an interface for getting and
  # setting the contents of the system clipboard.
  #
  # It is important to note that due to limitations on some
  # operating systems, setting the clipboard contents is
  # only guaranteed to work if there is currently an open
  # window for which events are being handled.
  #
  # Usage example:
  # ```c++
  # // get the clipboard content as a string
  # sf::String string = sf::Clipboard::getString();
  #
  # // or use it in the event loop
  # sf::Event event;
  # while(window.pollEvent(event))
  # {
  #     if(event.type == sf::Event::Closed)
  #         window.close();
  #     if(event.type == sf::Event::KeyPressed)
  #     {
  #         // Using Ctrl + V to paste a string into SFML
  #         if(event.key.control && event.key.code == sf::Keyboard::V)
  #             string = sf::Clipboard::getString();
  #
  #         // Using Ctrl + C to copy a string out of SFML
  #         if(event.key.control && event.key.code == sf::Keyboard::C)
  #             sf::Clipboard::setString("Hello World!");
  #     }
  # }
  # ```
  #
  # *See also:* `SF::String`, `SF::Event`
  module Clipboard
    # Get the content of the clipboard as string data
    #
    # This function returns the content of the clipboard
    # as a string. If the clipboard does not contain string
    # it returns an empty `SF::String` object.
    #
    # *Returns:* Clipboard contents as `SF::String` object
    def self.string() : String
      SFMLExt.sfml_clipboard_getstring(out result)
      return String.build { |io| while (v = result.value) != '\0'; io << v; result += 1; end }
    end
    # Set the content of the clipboard as string data
    #
    # This function sets the content of the clipboard as a
    # string.
    #
    # WARNING: Due to limitations on some operating systems,
    # setting the clipboard contents is only
    # guaranteed to work if there is currently an
    # open window for which events are being handled.
    #
    # * *text* - `SF::String` containing the data to be sent
    # to the clipboard
    def self.string=(text : String)
      SFMLExt.sfml_clipboard_setstring_bQs(text.size, text.chars)
    end
  end
  # Empty module that indicates the class requires an OpenGL context
  module GlResource
  end
  # Structure defining the settings of the OpenGL
  # context attached to a window
  #
  # ContextSettings allows to define several advanced settings
  # of the OpenGL context attached to a window. All these
  # settings with the exception of the compatibility flag
  # and anti-aliasing level have no impact on the regular
  # SFML rendering (graphics module), so you may need to use
  # this structure only if you're using SFML as a windowing
  # system for custom OpenGL rendering.
  #
  # The depth_bits and stencil_bits members define the number
  # of bits per pixel requested for the (respectively) depth
  # and stencil buffers.
  #
  # antialiasing_level represents the requested number of
  # multisampling levels for anti-aliasing.
  #
  # major_version and minor_version define the version of the
  # OpenGL context that you want. Only versions greater or
  # equal to 3.0 are relevant; versions lesser than 3.0 are
  # all handled the same way (i.e. you can use any version
  # &lt; 3.0 if you don't want an OpenGL 3 context).
  #
  # When requesting a context with a version greater or equal
  # to 3.2, you have the option of specifying whether the
  # context should follow the core or compatibility profile
  # of all newer (>= 3.2) OpenGL specifications. For versions 3.0
  # and 3.1 there is only the core profile. By default a
  # compatibility context is created. You only need to specify
  # the core flag if you want a core profile context to use with
  # your own OpenGL rendering.
  #
  # WARNING: The graphics module will not function if you
  # request a core profile context. Make sure the attributes are
  # set to Default if you want to use the graphics module.
  #
  # Setting the debug attribute flag will request a context with
  # additional debugging features enabled. Depending on the
  # system, this might be required for advanced OpenGL debugging.
  # OpenGL debugging is disabled by default.
  #
  # **Special Note for OS X:**
  # Apple only supports choosing between either a legacy context
  # (OpenGL 2.1) or a core context (OpenGL version depends on the
  # operating system version but is at least 3.2). Compatibility
  # contexts are not supported. Further information is available on the
  # [OpenGL Capabilities Tables](https://developer.apple.com/opengl/capabilities/index.html)
  # page. OS X also currently does not support debug contexts.
  #
  # Please note that these values are only a hint.
  # No failure will be reported if one or more of these values
  # are not supported by the system; instead, SFML will try to
  # find the closest valid match. You can then retrieve the
  # settings that the window actually used to create its context,
  # with Window.settings().
  struct ContextSettings
    @depth_bits : LibC::UInt
    @stencil_bits : LibC::UInt
    @antialiasing_level : LibC::UInt
    @major_version : LibC::UInt
    @minor_version : LibC::UInt
    @attribute_flags : UInt32
    @s_rgb_capable : Bool
    # Enumeration of the context attribute flags
    @[Flags]
    enum Attribute
      # Non-debug, compatibility context (this and the core attribute are mutually exclusive)
      Default = 0
      # Core attribute
      Core = 1 << 0
      # Debug attribute
      Debug = 1 << 2
    end
    Util.extract ContextSettings::Attribute
    # Default constructor
    #
    # * *depth* - Depth buffer bits
    # * *stencil* - Stencil buffer bits
    # * *antialiasing* - Antialiasing level
    # * *major* - Major number of the context version
    # * *minor* - Minor number of the context version
    # * *attributes* - Attribute flags of the context
    # * *s_rgb* - sRGB capable framebuffer
    def initialize(depth : Int = 0, stencil : Int = 0, antialiasing : Int = 0, major : Int = 1, minor : Int = 1, attributes : Attribute = Default, s_rgb : Bool = false)
      @depth_bits = uninitialized UInt32
      @stencil_bits = uninitialized UInt32
      @antialiasing_level = uninitialized UInt32
      @major_version = uninitialized UInt32
      @minor_version = uninitialized UInt32
      @attribute_flags = uninitialized UInt32
      @s_rgb_capable = uninitialized Bool
      SFMLExt.sfml_contextsettings_initialize_emSemSemSemSemSemSGZq(to_unsafe, LibC::UInt.new(depth), LibC::UInt.new(stencil), LibC::UInt.new(antialiasing), LibC::UInt.new(major), LibC::UInt.new(minor), attributes, s_rgb)
    end
    @depth_bits : LibC::UInt
    # Bits of the depth buffer
    def depth_bits : UInt32
      @depth_bits
    end
    def depth_bits=(depth_bits : Int)
      @depth_bits = LibC::UInt.new(depth_bits)
    end
    @stencil_bits : LibC::UInt
    # Bits of the stencil buffer
    def stencil_bits : UInt32
      @stencil_bits
    end
    def stencil_bits=(stencil_bits : Int)
      @stencil_bits = LibC::UInt.new(stencil_bits)
    end
    @antialiasing_level : LibC::UInt
    # Level of antialiasing
    def antialiasing_level : UInt32
      @antialiasing_level
    end
    def antialiasing_level=(antialiasing_level : Int)
      @antialiasing_level = LibC::UInt.new(antialiasing_level)
    end
    @major_version : LibC::UInt
    # Major number of the context version to create
    def major_version : UInt32
      @major_version
    end
    def major_version=(major_version : Int)
      @major_version = LibC::UInt.new(major_version)
    end
    @minor_version : LibC::UInt
    # Minor number of the context version to create
    def minor_version : UInt32
      @minor_version
    end
    def minor_version=(minor_version : Int)
      @minor_version = LibC::UInt.new(minor_version)
    end
    @attribute_flags : UInt32
    # The attribute flags to create the context with
    def attribute_flags : UInt32
      @attribute_flags
    end
    def attribute_flags=(attribute_flags : Int)
      @attribute_flags = UInt32.new(attribute_flags)
    end
    @s_rgb_capable : Bool
    # Whether the context framebuffer is sRGB capable
    def s_rgb_capable : Bool
      @s_rgb_capable
    end
    def s_rgb_capable=(s_rgb_capable : Bool)
      @s_rgb_capable = s_rgb_capable
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@depth_bits).as(Void*)
    end
    # :nodoc:
    def initialize(copy : ContextSettings)
      @depth_bits = uninitialized UInt32
      @stencil_bits = uninitialized UInt32
      @antialiasing_level = uninitialized UInt32
      @major_version = uninitialized UInt32
      @minor_version = uninitialized UInt32
      @attribute_flags = uninitialized UInt32
      @s_rgb_capable = uninitialized Bool
      SFMLExt.sfml_contextsettings_initialize_Fw4(to_unsafe, copy)
    end
    def dup() : ContextSettings
      return ContextSettings.new(self)
    end
  end
  # Class holding a valid drawing context
  #
  # If you need to make OpenGL calls without having an
  # active window (like in a thread), you can use an
  # instance of this class to get a valid context.
  #
  # Having a valid context is necessary for *every* OpenGL call.
  #
  # Note that a context is only active in its current thread,
  # if you create a new thread it will have no valid context
  # by default.
  #
  # To use a `SF::Context` instance, just construct it and let it
  # live as long as you need a valid context. No explicit activation
  # is needed, all it has to do is to exist. Its destructor
  # will take care of deactivating and freeing all the attached
  # resources.
  #
  # Usage example:
  # ```c++
  # void threadFunction(void*)
  #    SF::Context context
  #    # from now on, you have a valid context
  #
  #    # you can make OpenGL calls
  #    glClear(GL_DEPTH_BUFFER_BIT)
  # end
  # # the context is automatically deactivated and destroyed
  # # by the SF::Context destructor
  # ```
  class Context
    @this : Void*
    # Default constructor
    #
    # The constructor creates and activates the context
    def initialize()
      SFMLExt.sfml_context_allocate(out @this)
      SFMLExt.sfml_context_initialize(to_unsafe)
    end
    # Destructor
    #
    # The destructor deactivates and destroys the context
    def finalize()
      SFMLExt.sfml_context_finalize(to_unsafe)
      SFMLExt.sfml_context_free(@this)
    end
    # Activate or deactivate explicitly the context
    #
    # * *active* - True to activate, false to deactivate
    #
    # *Returns:* True on success, false on failure
    def active=(active : Bool) : Bool
      SFMLExt.sfml_context_setactive_GZq(to_unsafe, active, out result)
      return result
    end
    # Get the settings of the context
    #
    # Note that these settings may be different than the ones
    # passed to the constructor; they are indeed adjusted if the
    # original settings are not directly supported by the system.
    #
    # *Returns:* Structure containing the settings
    def settings() : ContextSettings
      result = ContextSettings.allocate
      SFMLExt.sfml_context_getsettings(to_unsafe, result)
      return result
    end
    # Check whether a given OpenGL extension is available
    #
    # * *name* - Name of the extension to check for
    #
    # *Returns:* True if available, false if unavailable
    def self.extension_available?(name : String) : Bool
      SFMLExt.sfml_context_isextensionavailable_Yy6(name, out result)
      return result
    end
    # Get the currently active context
    #
    # This function will only return `SF::Context` objects.
    # Contexts created e.g. by RenderTargets or for internal
    # use will not be returned by this function.
    #
    # *Returns:* The currently active context or NULL if none is active
    def self.active_context() : Context?
      return @_context_active_context
    end
    # Get the currently active context's ID
    #
    # The context ID is used to identify contexts when
    # managing unshareable OpenGL resources.
    #
    # *Returns:* The active context's ID or 0 if no context is currently active
    def self.active_context_id() : UInt64
      SFMLExt.sfml_context_getactivecontextid(out result)
      return result
    end
    # Construct a in-memory context
    #
    # This constructor is for internal use, you don't need
    # to bother with it.
    #
    # * *settings* - Creation parameters
    # * *width* - Back buffer width
    # * *height* - Back buffer height
    def initialize(settings : ContextSettings, width : Int, height : Int)
      SFMLExt.sfml_context_allocate(out @this)
      SFMLExt.sfml_context_initialize_Fw4emSemS(to_unsafe, settings, LibC::UInt.new(width), LibC::UInt.new(height))
    end
    # :nodoc:
    def self.active_context() : Context?
      return @_context_active_context
    end
    include GlResource
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Cursor defines the appearance of a system cursor
  #
  # WARNING: Features related to Cursor are not supported on
  # iOS and Android.
  #
  # This class abstracts the operating system resources
  # associated with either a native system cursor or a custom
  # cursor.
  #
  # After loading the cursor the graphical appearance
  # with either `load_from_pixels()` or load_from_system(), the
  # cursor can be changed with `SF::Window.mouse_cursor=()`.
  #
  # The behaviour is undefined if the cursor is destroyed while
  # in use by the window.
  #
  # Usage example:
  # ```c++
  # sf::Window window;
  #
  # // ... create window as usual ...
  #
  # sf::Cursor cursor;
  # if (cursor.loadFromSystem(sf::Cursor::Hand))
  #     window.setMouseCursor(cursor);
  # ```
  #
  # *See also:* `SF::Window.mouse_cursor=`
  class Cursor
    @this : Void*
    # Enumeration of the native system cursor types
    #
    # Refer to the following table to determine which cursor
    # is available on which platform.
    #
    #  Type                               | Linux | Mac OS X | Windows  |
    # ------------------------------------|:-----:|:--------:|:--------:|
    #  `SF::Cursor::Arrow`                  |  yes  |    yes   |   yes    |
    #  `SF::Cursor::ArrowWait`              |  no   |    no    |   yes    |
    #  `SF::Cursor::Wait`                   |  yes  |    no    |   yes    |
    #  `SF::Cursor::Text`                   |  yes  |    yes   |   yes    |
    #  `SF::Cursor::Hand`                   |  yes  |    yes   |   yes    |
    #  `SF::Cursor::SizeHorizontal`         |  yes  |    yes   |   yes    |
    #  `SF::Cursor::SizeVertical`           |  yes  |    yes   |   yes    |
    #  `SF::Cursor::SizeTopLeftBottomRight` |  no   |    yes*  |   yes    |
    #  `SF::Cursor::SizeBottomLeftTopRight` |  no   |    yes*  |   yes    |
    #  `SF::Cursor::SizeAll`                |  yes  |    no    |   yes    |
    #  `SF::Cursor::Cross`                  |  yes  |    yes   |   yes    |
    #  `SF::Cursor::Help`                   |  yes  |    yes*  |   yes    |
    #  `SF::Cursor::NotAllowed`             |  yes  |    yes   |   yes    |
    #
    # \* These cursor types are undocumented so may not
    #    be available on all versions, but have been tested on 10.13
    enum Type
      # Arrow cursor (default)
      Arrow
      # Busy arrow cursor
      ArrowWait
      # Busy cursor
      Wait
      # I-beam, cursor when hovering over a field allowing text entry
      Text
      # Pointing hand cursor
      Hand
      # Horizontal double arrow cursor
      SizeHorizontal
      # Vertical double arrow cursor
      SizeVertical
      # Double arrow cursor going from top-left to bottom-right
      SizeTopLeftBottomRight
      # Double arrow cursor going from bottom-left to top-right
      SizeBottomLeftTopRight
      # Combination of SizeHorizontal and SizeVertical
      SizeAll
      # Crosshair cursor
      Cross
      # Help cursor
      Help
      # Action not allowed cursor
      NotAllowed
    end
    Util.extract Cursor::Type
    # Default constructor
    #
    # This constructor doesn't actually create the cursor;
    # initially the new instance is invalid and must not be
    # used until either `load_from_pixels()` or load_from_system()
    # is called and successfully created a cursor.
    def initialize()
      SFMLExt.sfml_cursor_allocate(out @this)
      SFMLExt.sfml_cursor_initialize(to_unsafe)
    end
    # Destructor
    #
    # This destructor releases the system resources
    # associated with this cursor, if any.
    def finalize()
      SFMLExt.sfml_cursor_finalize(to_unsafe)
      SFMLExt.sfml_cursor_free(@this)
    end
    # Create a cursor with the provided image
    #
    # *pixels* must be an array of *width* by *height* pixels
    # in 32-bit RGBA format. If not, this will cause undefined behavior.
    #
    # If *pixels* is null or either *width* or *height* are 0,
    # the current cursor is left unchanged and the function will
    # return false.
    #
    # In addition to specifying the pixel data, you can also
    # specify the location of the hotspot of the cursor. The
    # hotspot is the pixel coordinate within the cursor image
    # which will be located exactly where the mouse pointer
    # position is. Any mouse actions that are performed will
    # return the window/screen location of the hotspot.
    #
    # WARNING: On Unix, the pixels are mapped into a monochrome
    # bitmap: pixels with an alpha channel to 0 are
    # transparent, black if the RGB channel are close
    # to zero, and white otherwise.
    #
    # * *pixels* - Array of pixels of the image
    # * *size* - Width and height of the image
    # * *hotspot* - (x,y) location of the hotspot
    #
    # *Returns:* true if the cursor was successfully loaded;
    # false otherwise
    def load_from_pixels(pixels : UInt8*, size : Vector2|Tuple, hotspot : Vector2|Tuple) : Bool
      size = SF.vector2u(size[0], size[1])
      hotspot = SF.vector2u(hotspot[0], hotspot[1])
      SFMLExt.sfml_cursor_loadfrompixels_843t9zt9z(to_unsafe, pixels, size, hotspot, out result)
      return result
    end
    # Shorthand for `cursor = Cursor.new; cursor.load_from_pixels(...); cursor`
    #
    # Raises `InitError` on failure
    def self.from_pixels(*args, **kwargs) : self
      obj = new
      if !obj.load_from_pixels(*args, **kwargs)
        raise InitError.new("Cursor.load_from_pixels failed")
      end
      obj
    end
    # Create a native system cursor
    #
    # Refer to the list of cursor available on each system
    # (see `SF::Cursor::Type`) to know whether a given cursor is
    # expected to load successfully or is not supported by
    # the operating system.
    #
    # * *type* - Native system cursor type
    #
    # *Returns:* true if and only if the corresponding cursor is
    # natively supported by the operating system;
    # false otherwise
    def load_from_system(type : Cursor::Type) : Bool
      SFMLExt.sfml_cursor_loadfromsystem_yAZ(to_unsafe, type, out result)
      return result
    end
    # Shorthand for `cursor = Cursor.new; cursor.load_from_system(...); cursor`
    #
    # Raises `InitError` on failure
    def self.from_system(*args, **kwargs) : self
      obj = new
      if !obj.load_from_system(*args, **kwargs)
        raise InitError.new("Cursor.load_from_system failed")
      end
      obj
    end
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  # Give access to the real-time state of the joysticks
  #
  # `SF::Joystick` provides an interface to the state of the
  # joysticks. It only contains static functions, so it's not
  # meant to be instantiated. Instead, each joystick is identified
  # by an index that is passed to the functions of this module.
  #
  # This module allows users to query the state of joysticks at any
  # time and directly, without having to deal with a window and
  # its events. Compared to the `JoystickMoved`, `JoystickButtonPressed`
  # and `JoystickButtonReleased` events, `SF::Joystick` can retrieve the
  # state of axes and buttons of joysticks at any time
  # (you don't need to store and update a boolean on your side
  # in order to know if a button is pressed or released), and you
  # always get the real state of joysticks, even if they are
  # moved, pressed or released when your window is out of focus
  # and no event is triggered.
  #
  # SFML supports:
  #
  # * 8 joysticks (`SF::Joystick::Count`)
  # * 32 buttons per joystick (`SF::Joystick::ButtonCount`)
  # * 8 axes per joystick (`SF::Joystick::AxisCount`)
  #
  # Unlike the keyboard or mouse, the state of joysticks is sometimes
  # not directly available (depending on the OS), therefore an `update()`
  # function must be called in order to update the current state of
  # joysticks. When you have a window with event handling, this is done
  # automatically, you don't need to call anything. But if you have no
  # window, or if you want to check joysticks state before creating one,
  # you must call `SF::Joystick.update` explicitly.
  #
  # Usage example:
  # ```crystal
  # # Is joystick #0 connected?
  # connected = SF::Joystick.connected?(0)
  #
  # # How many buttons does joystick #0 support?
  # buttons = SF::Joystick.get_button_count(0)
  #
  # # Does joystick #0 define a X axis?
  # has_x = SF::Joystick.axis?(0, SF::Joystick::X)
  #
  # # Is button #2 pressed on joystick #0?
  # pressed = SF::Joystick.button_pressed?(0, 2)
  #
  # # What's the current position of the Y axis on joystick #0?
  # position = SF::Joystick.get_axis_position(0, SF::Joystick::Y)
  # ```
  #
  # *See also:* `SF::Keyboard`, `SF::Mouse`
  module Joystick
    # Maximum number of supported joysticks
    Count = 8
    # Maximum number of supported buttons
    ButtonCount = 32
    # Maximum number of supported axes
    AxisCount = 8
    # Axes supported by SFML joysticks
    enum Axis
      # The X axis
      X
      # The Y axis
      Y
      # The Z axis
      Z
      # The R axis
      R
      # The U axis
      U
      # The V axis
      V
      # The X axis of the point-of-view hat
      PovX
      # The Y axis of the point-of-view hat
      PovY
    end
    Util.extract Joystick::Axis
    # Structure holding a joystick's identification
    class Identification
      @this : Void*
      def finalize()
        SFMLExt.sfml_joystick_identification_finalize(to_unsafe)
        SFMLExt.sfml_joystick_identification_free(@this)
      end
      def initialize()
        SFMLExt.sfml_joystick_identification_allocate(out @this)
        SFMLExt.sfml_joystick_identification_initialize(to_unsafe)
      end
      # Name of the joystick
      def name() : String
        SFMLExt.sfml_joystick_identification_getname(to_unsafe, out result)
        return String.build { |io| while (v = result.value) != '\0'; io << v; result += 1; end }
      end
      def name=(name : String)
        SFMLExt.sfml_joystick_identification_setname_Lnu(to_unsafe, name.size, name.chars)
      end
      # Manufacturer identifier
      def vendor_id() : Int32
        SFMLExt.sfml_joystick_identification_getvendorid(to_unsafe, out result)
        return result.to_i
      end
      def vendor_id=(vendor_id : Int)
        SFMLExt.sfml_joystick_identification_setvendorid_emS(to_unsafe, LibC::UInt.new(vendor_id))
      end
      # Product identifier
      def product_id() : Int32
        SFMLExt.sfml_joystick_identification_getproductid(to_unsafe, out result)
        return result.to_i
      end
      def product_id=(product_id : Int)
        SFMLExt.sfml_joystick_identification_setproductid_emS(to_unsafe, LibC::UInt.new(product_id))
      end
      # :nodoc:
      def to_unsafe()
        @this
      end
      # :nodoc:
      def inspect(io)
        to_s(io)
      end
      # :nodoc:
      def initialize(copy : Joystick::Identification)
        SFMLExt.sfml_joystick_identification_allocate(out @this)
        SFMLExt.sfml_joystick_identification_initialize_ISj(to_unsafe, copy)
      end
      def dup() : Identification
        return Identification.new(self)
      end
    end
    # Check if a joystick is connected
    #
    # * *joystick* - Index of the joystick to check
    #
    # *Returns:* True if the joystick is connected, false otherwise
    def self.connected?(joystick : Int) : Bool
      SFMLExt.sfml_joystick_isconnected_emS(LibC::UInt.new(joystick), out result)
      return result
    end
    # Return the number of buttons supported by a joystick
    #
    # If the joystick is not connected, this function returns 0.
    #
    # * *joystick* - Index of the joystick
    #
    # *Returns:* Number of buttons supported by the joystick
    def self.get_button_count(joystick : Int) : Int32
      SFMLExt.sfml_joystick_getbuttoncount_emS(LibC::UInt.new(joystick), out result)
      return result.to_i
    end
    # Check if a joystick supports a given axis
    #
    # If the joystick is not connected, this function returns false.
    #
    # * *joystick* - Index of the joystick
    # * *axis* - Axis to check
    #
    # *Returns:* True if the joystick supports the axis, false otherwise
    def self.axis?(joystick : Int, axis : Joystick::Axis) : Bool
      SFMLExt.sfml_joystick_hasaxis_emSHdj(LibC::UInt.new(joystick), axis, out result)
      return result
    end
    # Check if a joystick button is pressed
    #
    # If the joystick is not connected, this function returns false.
    #
    # * *joystick* - Index of the joystick
    # * *button* - Button to check
    #
    # *Returns:* True if the button is pressed, false otherwise
    def self.button_pressed?(joystick : Int, button : Int) : Bool
      SFMLExt.sfml_joystick_isbuttonpressed_emSemS(LibC::UInt.new(joystick), LibC::UInt.new(button), out result)
      return result
    end
    # Get the current position of a joystick axis
    #
    # If the joystick is not connected, this function returns 0.
    #
    # * *joystick* - Index of the joystick
    # * *axis* - Axis to check
    #
    # *Returns:* Current position of the axis, in range `-100 .. 100`
    def self.get_axis_position(joystick : Int, axis : Joystick::Axis) : Float32
      SFMLExt.sfml_joystick_getaxisposition_emSHdj(LibC::UInt.new(joystick), axis, out result)
      return result
    end
    # Get the joystick information
    #
    # * *joystick* - Index of the joystick
    #
    # *Returns:* Structure containing joystick information.
    def self.get_identification(joystick : Int) : Joystick::Identification
      result = Joystick::Identification.new
      SFMLExt.sfml_joystick_getidentification_emS(LibC::UInt.new(joystick), result)
      return result
    end
    # Update the states of all joysticks
    #
    # This function is used internally by SFML, so you normally
    # don't have to call it explicitly. However, you may need to
    # call it if you have no window yet (or no window at all):
    # in this case the joystick states are not updated automatically.
    def self.update()
      SFMLExt.sfml_joystick_update()
    end
  end
  # Give access to the real-time state of the keyboard
  #
  # `SF::Keyboard` provides an interface to the state of the
  # keyboard. It only contains static functions (a single
  # keyboard is assumed), so it's not meant to be instantiated.
  #
  # This module allows users to query the keyboard state at any
  # time and directly, without having to deal with a window and
  # its events. Compared to the `KeyPressed` and `KeyReleased` events,
  # `SF::Keyboard` can retrieve the state of a key at any time
  # (you don't need to store and update a boolean on your side
  # in order to know if a key is pressed or released), and you
  # always get the real state of the keyboard, even if keys are
  # pressed or released when your window is out of focus and no
  # event is triggered.
  #
  # Usage example:
  # ```crystal
  # if SF::Keyboard.key_pressed?(SF::Keyboard::Left)
  #   # move left...
  # elsif SF::Keyboard.key_pressed?(SF::Keyboard::Right)
  #   # move right...
  # elsif SF::Keyboard.key_pressed?(SF::Keyboard::Escape)
  #   # quit...
  # end
  # ```
  #
  # *See also:* `SF::Joystick`, `SF::Mouse`, `SF::Touch`
  module Keyboard
    # Key codes
    enum Key
      # Unhandled key
      Unknown = -1
      # The A key
      A = 0
      # The B key
      B
      # The C key
      C
      # The D key
      D
      # The E key
      E
      # The F key
      F
      # The G key
      G
      # The H key
      H
      # The I key
      I
      # The J key
      J
      # The K key
      K
      # The L key
      L
      # The M key
      M
      # The N key
      N
      # The O key
      O
      # The P key
      P
      # The Q key
      Q
      # The R key
      R
      # The S key
      S
      # The T key
      T
      # The U key
      U
      # The V key
      V
      # The W key
      W
      # The X key
      X
      # The Y key
      Y
      # The Z key
      Z
      # The 0 key
      Num0
      # The 1 key
      Num1
      # The 2 key
      Num2
      # The 3 key
      Num3
      # The 4 key
      Num4
      # The 5 key
      Num5
      # The 6 key
      Num6
      # The 7 key
      Num7
      # The 8 key
      Num8
      # The 9 key
      Num9
      # The Escape key
      Escape
      # The left Control key
      LControl
      # The left Shift key
      LShift
      # The left Alt key
      LAlt
      # The left OS specific key: window (Windows and Linux), apple (MacOS X), ...
      LSystem
      # The right Control key
      RControl
      # The right Shift key
      RShift
      # The right Alt key
      RAlt
      # The right OS specific key: window (Windows and Linux), apple (MacOS X), ...
      RSystem
      # The Menu key
      Menu
      # The [ key
      LBracket
      # The ] key
      RBracket
      # The ; key
      Semicolon
      # The , key
      Comma
      # The . key
      Period
      # The ' key
      Quote
      # The / key
      Slash
      # The \ key
      Backslash
      # The ~ key
      Tilde
      # The = key
      Equal
      # The - key (hyphen)
      Hyphen
      # The Space key
      Space
      # The Enter/Return keys
      Enter
      # The Backspace key
      Backspace
      # The Tabulation key
      Tab
      # The Page up key
      PageUp
      # The Page down key
      PageDown
      # The End key
      End
      # The Home key
      Home
      # The Insert key
      Insert
      # The Delete key
      Delete
      # The + key
      Add
      # The - key (minus, usually from numpad)
      Subtract
      # The * key
      Multiply
      # The / key
      Divide
      # Left arrow
      Left
      # Right arrow
      Right
      # Up arrow
      Up
      # Down arrow
      Down
      # The numpad 0 key
      Numpad0
      # The numpad 1 key
      Numpad1
      # The numpad 2 key
      Numpad2
      # The numpad 3 key
      Numpad3
      # The numpad 4 key
      Numpad4
      # The numpad 5 key
      Numpad5
      # The numpad 6 key
      Numpad6
      # The numpad 7 key
      Numpad7
      # The numpad 8 key
      Numpad8
      # The numpad 9 key
      Numpad9
      # The F1 key
      F1
      # The F2 key
      F2
      # The F3 key
      F3
      # The F4 key
      F4
      # The F5 key
      F5
      # The F6 key
      F6
      # The F7 key
      F7
      # The F8 key
      F8
      # The F9 key
      F9
      # The F10 key
      F10
      # The F11 key
      F11
      # The F12 key
      F12
      # The F13 key
      F13
      # The F14 key
      F14
      # The F15 key
      F15
      # The Pause key
      Pause
      # Keep last -- the total number of keyboard keys
      KeyCount
      # DEPRECATED: Use `Hyphen` instead
      Dash = Hyphen
      # DEPRECATED: Use `Backspace` instead
      BackSpace = Backspace
      # DEPRECATED: Use `Backslash` instead
      BackSlash = Backslash
      # DEPRECATED: Use `Semicolon` instead
      SemiColon = Semicolon
      # DEPRECATED: Use `Enter` instead
      Return = Enter
    end
    Util.extract Keyboard::Key
    # Check if a key is pressed
    #
    # * *key* - Key to check
    #
    # *Returns:* True if the key is pressed, false otherwise
    def self.key_pressed?(key : Keyboard::Key) : Bool
      SFMLExt.sfml_keyboard_iskeypressed_cKW(key, out result)
      return result
    end
    # Show or hide the virtual keyboard
    #
    # WARNING: The virtual keyboard is not supported on all
    # systems. It will typically be implemented on mobile OSes
    # (Android, iOS) but not on desktop OSes (Windows, Linux, ...).
    #
    # If the virtual keyboard is not available, this function does
    # nothing.
    #
    # * *visible* - True to show, false to hide
    def self.virtual_keyboard_visible=(visible : Bool)
      SFMLExt.sfml_keyboard_setvirtualkeyboardvisible_GZq(visible)
    end
  end
  # Give access to the real-time state of the mouse
  #
  # `SF::Mouse` provides an interface to the state of the
  # mouse. It only contains static functions (a single
  # mouse is assumed), so it's not meant to be instantiated.
  #
  # This module allows users to query the mouse state at any
  # time and directly, without having to deal with a window and
  # its events. Compared to the `MouseMoved`, `MouseButtonPressed`
  # and `MouseButtonReleased` events, `SF::Mouse` can retrieve the
  # state of the cursor and the buttons at any time
  # (you don't need to store and update a boolean on your side
  # in order to know if a button is pressed or released), and you
  # always get the real state of the mouse, even if it is
  # moved, pressed or released when your window is out of focus
  # and no event is triggered.
  #
  # The position= and position functions can be used to change
  # or retrieve the current position of the mouse pointer. There are
  # two versions: one that operates in global coordinates (relative
  # to the desktop) and one that operates in window coordinates
  # (relative to a specific window).
  #
  # Usage example:
  # ```crystal
  # if SF::Mouse.button_pressed?(SF::Mouse::Left)
  #   # left click...
  # end
  #
  # # get global mouse position
  # position = SF::Mouse.position
  #
  # # set mouse position relative to a window
  # SF::Mouse.set_position(SF.vector2i(100, 200), window)
  # ```
  #
  # *See also:* `SF::Joystick`, `SF::Keyboard`, `SF::Touch`
  module Mouse
    # Mouse buttons
    enum Button
      # The left mouse button
      Left
      # The right mouse button
      Right
      # The middle (wheel) mouse button
      Middle
      # The first extra mouse button
      XButton1
      # The second extra mouse button
      XButton2
      # Keep last -- the total number of mouse buttons
      ButtonCount
    end
    Util.extract Mouse::Button
    # Mouse wheels
    enum Wheel
      # The vertical mouse wheel
      VerticalWheel
      # The horizontal mouse wheel
      HorizontalWheel
    end
    Util.extract Mouse::Wheel
    # Check if a mouse button is pressed
    #
    # * *button* - Button to check
    #
    # *Returns:* True if the button is pressed, false otherwise
    def self.button_pressed?(button : Mouse::Button) : Bool
      SFMLExt.sfml_mouse_isbuttonpressed_Zxg(button, out result)
      return result
    end
    # Get the current position of the mouse in desktop coordinates
    #
    # This function returns the global position of the mouse
    # cursor on the desktop.
    #
    # *Returns:* Current position of the mouse
    def self.position() : Vector2i
      result = Vector2i.allocate
      SFMLExt.sfml_mouse_getposition(result)
      return result
    end
    # Get the current position of the mouse in window coordinates
    #
    # This function returns the current position of the mouse
    # cursor, relative to the given window.
    #
    # * *relative_to* - Reference window
    #
    # *Returns:* Current position of the mouse
    def self.get_position(relative_to : Window) : Vector2i
      result = Vector2i.allocate
      SFMLExt.sfml_mouse_getposition_JRh(relative_to, result)
      return result
    end
    # Set the current position of the mouse in desktop coordinates
    #
    # This function sets the global position of the mouse
    # cursor on the desktop.
    #
    # * *position* - New position of the mouse
    def self.position=(position : Vector2|Tuple)
      position = SF.vector2i(position[0], position[1])
      SFMLExt.sfml_mouse_setposition_ufV(position)
    end
    # Set the current position of the mouse in window coordinates
    #
    # This function sets the current position of the mouse
    # cursor, relative to the given window.
    #
    # * *position* - New position of the mouse
    # * *relative_to* - Reference window
    def self.set_position(position : Vector2|Tuple, relative_to : Window)
      position = SF.vector2i(position[0], position[1])
      SFMLExt.sfml_mouse_setposition_ufVJRh(position, relative_to)
    end
  end
  # Give access to the real-time state of the sensors
  #
  # `SF::Sensor` provides an interface to the state of the
  # various sensors that a device provides. It only contains static
  # functions, so it's not meant to be instantiated.
  #
  # This module allows users to query the sensors values at any
  # time and directly, without having to deal with a window and
  # its events. Compared to the `Event::SensorChanged` event, `SF::Sensor`
  # can retrieve the state of a sensor at any time (you don't need to
  # store and update its current value on your side).
  #
  # Depending on the OS and hardware of the device (phone, tablet, ...),
  # some sensor types may not be available. You should always check
  # the availability of a sensor before trying to read it, with the
  # `SF::Sensor.available?` function.
  #
  # You may wonder why some sensor types look so similar, for example
  # `Type::Accelerometer` and `Type::Gravity` / `Type::UserAcceleration`. The first one
  # is the raw measurement of the acceleration, and takes into account
  # both the earth gravity and the user movement. The others are
  # more precise: they provide these components separately, which is
  # usually more useful. In fact they are not direct sensors, they
  # are computed internally based on the raw acceleration and other sensors.
  # This is exactly the same for Gyroscope vs Orientation.
  #
  # Because sensors consume a non-negligible amount of current, they are
  # all disabled by default. You must call `SF::Sensor.set_enabled` for each
  # sensor in which you are interested.
  #
  # Usage example:
  # ```crystal
  # if SF::Sensor.available?(SF::Sensor::Gravity)
  #   # gravity sensor is available
  # end
  #
  # # enable the gravity sensor
  # SF::Sensor.set_enabled(SF::Sensor::Gravity, true)
  #
  # # get the current value of gravity
  # gravity = SF::Sensor.get_value(SF::Sensor::Gravity)
  # ```
  module Sensor
    # Sensor type
    enum Type
      # Measures the raw acceleration (m/s^2)
      Accelerometer
      # Measures the raw rotation rates (degrees/s)
      Gyroscope
      # Measures the ambient magnetic field (micro-teslas)
      Magnetometer
      # Measures the direction and intensity of gravity, independent of device acceleration (m/s^2)
      Gravity
      # Measures the direction and intensity of device acceleration, independent of the gravity (m/s^2)
      UserAcceleration
      # Measures the absolute 3D orientation (degrees)
      Orientation
      # Keep last -- the total number of sensor types
      Count
    end
    Util.extract Sensor::Type
    # Check if a sensor is available on the underlying platform
    #
    # * *sensor* - Sensor to check
    #
    # *Returns:* True if the sensor is available, false otherwise
    def self.available?(sensor : Sensor::Type) : Bool
      SFMLExt.sfml_sensor_isavailable_jRE(sensor, out result)
      return result
    end
    # Enable or disable a sensor
    #
    # All sensors are disabled by default, to avoid consuming too
    # much battery power. Once a sensor is enabled, it starts
    # sending events of the corresponding type.
    #
    # This function does nothing if the sensor is unavailable.
    #
    # * *sensor* - Sensor to enable
    # * *enabled* - True to enable, false to disable
    def self.set_enabled(sensor : Sensor::Type, enabled : Bool)
      SFMLExt.sfml_sensor_setenabled_jREGZq(sensor, enabled)
    end
    # Get the current sensor value
    #
    # * *sensor* - Sensor to read
    #
    # *Returns:* The current sensor value
    def self.get_value(sensor : Sensor::Type) : Vector3f
      result = Vector3f.allocate
      SFMLExt.sfml_sensor_getvalue_jRE(sensor, result)
      return result
    end
  end
  # Defines a system event and its parameters
  #
  # `SF::Event` holds all the informations about a system event
  # that just happened. Events are retrieved using the
  # `SF::Window.poll_event` and `SF::Window.wait_event` functions.
  #
  # A `SF::Event` instance contains the type of the event
  # (mouse moved, key pressed, window closed, ...) as well
  # as the details about this particular event. Please note that
  # the event parameters are defined in a union, which means that
  # only the member matching the type of the event will be properly
  # filled; all other members will have undefined values and must not
  # be read if the type of the event doesn't match. For example,
  # if you received a KeyPressed event, then you must read the
  # event.key member, all other members such as event.mouse_move
  # or event.text will have undefined values.
  #
  # Usage example:
  # ```crystal
  # while (event = window.poll_event)
  #   case event
  #   when SF::Event::Closed # Request for closing the window
  #     window.close
  #   when SF::Event::KeyPressed # The escape key was pressed
  #     if event.code == SF::Keyboard::Escape
  #       window.close
  #     end
  #   when SF::Event::Resized # The window was resized
  #     do_something(event.width, event.height)
  #     # etc ...
  #   end
  # end
  # ```
  abstract struct Event
    @_type = uninitialized EventType
    # :nodoc:
    def to_unsafe()
      pointerof(@_type)
    end
    # Size events parameters (see `Resized`)
    abstract struct SizeEvent < Event
      def initialize()
        @width = uninitialized UInt32
        @height = uninitialized UInt32
        SFMLExt.sfml_event_sizeevent_initialize(to_unsafe)
      end
      @width : LibC::UInt
      @height : LibC::UInt
      @width : LibC::UInt
      # New width, in pixels
      def width : UInt32
        @width
      end
      def width=(width : Int)
        @width = LibC::UInt.new(width)
      end
      @height : LibC::UInt
      # New height, in pixels
      def height : UInt32
        @height
      end
      def height=(height : Int)
        @height = LibC::UInt.new(height)
      end
      # :nodoc:
      def initialize(copy : Event::SizeEvent)
        @width = uninitialized UInt32
        @height = uninitialized UInt32
        SFMLExt.sfml_event_sizeevent_initialize_isq(to_unsafe, copy)
      end
      def dup() : SizeEvent
        return SizeEvent.new(self)
      end
    end
    # Keyboard event parameters (see `KeyPressed`, `KeyReleased`)
    abstract struct KeyEvent < Event
      def initialize()
        @code = uninitialized Keyboard::Key
        @alt = uninitialized Bool
        @control = uninitialized Bool
        @shift = uninitialized Bool
        @system = uninitialized Bool
        SFMLExt.sfml_event_keyevent_initialize(to_unsafe)
      end
      @code : Keyboard::Key
      @alt : Bool
      @control : Bool
      @shift : Bool
      @system : Bool
      @code : Keyboard::Key
      # Code of the key that has been pressed
      def code : Keyboard::Key
        @code
      end
      def code=(code : Keyboard::Key)
        @code = code
      end
      @alt : Bool
      # Is the Alt key pressed?
      def alt : Bool
        @alt
      end
      def alt=(alt : Bool)
        @alt = alt
      end
      @control : Bool
      # Is the Control key pressed?
      def control : Bool
        @control
      end
      def control=(control : Bool)
        @control = control
      end
      @shift : Bool
      # Is the Shift key pressed?
      def shift : Bool
        @shift
      end
      def shift=(shift : Bool)
        @shift = shift
      end
      @system : Bool
      # Is the System key pressed?
      def system : Bool
        @system
      end
      def system=(system : Bool)
        @system = system
      end
      # :nodoc:
      def initialize(copy : Event::KeyEvent)
        @code = uninitialized Keyboard::Key
        @alt = uninitialized Bool
        @control = uninitialized Bool
        @shift = uninitialized Bool
        @system = uninitialized Bool
        SFMLExt.sfml_event_keyevent_initialize_wJ8(to_unsafe, copy)
      end
      def dup() : KeyEvent
        return KeyEvent.new(self)
      end
    end
    # Text event parameters (see `TextEntered`)
    abstract struct TextEvent < Event
      def initialize()
        @unicode = uninitialized UInt32
        SFMLExt.sfml_event_textevent_initialize(to_unsafe)
      end
      @unicode : UInt32
      @unicode : UInt32
      # UTF-32 Unicode value of the character
      def unicode : UInt32
        @unicode
      end
      def unicode=(unicode : Int)
        @unicode = UInt32.new(unicode)
      end
      # :nodoc:
      def initialize(copy : Event::TextEvent)
        @unicode = uninitialized UInt32
        SFMLExt.sfml_event_textevent_initialize_uku(to_unsafe, copy)
      end
      def dup() : TextEvent
        return TextEvent.new(self)
      end
    end
    # Mouse move event parameters (see `MouseMoved`)
    abstract struct MouseMoveEvent < Event
      def initialize()
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousemoveevent_initialize(to_unsafe)
      end
      @x : LibC::Int
      @y : LibC::Int
      @x : LibC::Int
      # X position of the mouse pointer, relative to the left of the owner window
      def x : Int32
        @x
      end
      def x=(x : Int)
        @x = LibC::Int.new(x)
      end
      @y : LibC::Int
      # Y position of the mouse pointer, relative to the top of the owner window
      def y : Int32
        @y
      end
      def y=(y : Int)
        @y = LibC::Int.new(y)
      end
      # :nodoc:
      def initialize(copy : Event::MouseMoveEvent)
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousemoveevent_initialize_1i3(to_unsafe, copy)
      end
      def dup() : MouseMoveEvent
        return MouseMoveEvent.new(self)
      end
    end
    # Mouse buttons events parameters
    # (see `MouseButtonPressed`, `MouseButtonReleased`)
    abstract struct MouseButtonEvent < Event
      def initialize()
        @button = uninitialized Mouse::Button
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousebuttonevent_initialize(to_unsafe)
      end
      @button : Mouse::Button
      @x : LibC::Int
      @y : LibC::Int
      @button : Mouse::Button
      # Code of the button that has been pressed
      def button : Mouse::Button
        @button
      end
      def button=(button : Mouse::Button)
        @button = button
      end
      @x : LibC::Int
      # X position of the mouse pointer, relative to the left of the owner window
      def x : Int32
        @x
      end
      def x=(x : Int)
        @x = LibC::Int.new(x)
      end
      @y : LibC::Int
      # Y position of the mouse pointer, relative to the top of the owner window
      def y : Int32
        @y
      end
      def y=(y : Int)
        @y = LibC::Int.new(y)
      end
      # :nodoc:
      def initialize(copy : Event::MouseButtonEvent)
        @button = uninitialized Mouse::Button
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousebuttonevent_initialize_Tjo(to_unsafe, copy)
      end
      def dup() : MouseButtonEvent
        return MouseButtonEvent.new(self)
      end
    end
    # Mouse wheel events parameters (see `MouseWheelMoved`)
    #
    # DEPRECATED: This event is deprecated and potentially inaccurate.
    # Use `MouseWheelScrollEvent` instead.
    abstract struct MouseWheelEvent < Event
      def initialize()
        @delta = uninitialized Int32
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousewheelevent_initialize(to_unsafe)
      end
      @delta : LibC::Int
      @x : LibC::Int
      @y : LibC::Int
      @delta : LibC::Int
      # Number of ticks the wheel has moved (positive is up, negative is down)
      def delta : Int32
        @delta
      end
      def delta=(delta : Int)
        @delta = LibC::Int.new(delta)
      end
      @x : LibC::Int
      # X position of the mouse pointer, relative to the left of the owner window
      def x : Int32
        @x
      end
      def x=(x : Int)
        @x = LibC::Int.new(x)
      end
      @y : LibC::Int
      # Y position of the mouse pointer, relative to the top of the owner window
      def y : Int32
        @y
      end
      def y=(y : Int)
        @y = LibC::Int.new(y)
      end
      # :nodoc:
      def initialize(copy : Event::MouseWheelEvent)
        @delta = uninitialized Int32
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousewheelevent_initialize_Wk7(to_unsafe, copy)
      end
      def dup() : MouseWheelEvent
        return MouseWheelEvent.new(self)
      end
    end
    # Mouse wheel events parameters (see `MouseWheelScrolled`)
    abstract struct MouseWheelScrollEvent < Event
      def initialize()
        @wheel = uninitialized Mouse::Wheel
        @delta = uninitialized Float32
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousewheelscrollevent_initialize(to_unsafe)
      end
      @wheel : Mouse::Wheel
      @delta : LibC::Float
      @x : LibC::Int
      @y : LibC::Int
      @wheel : Mouse::Wheel
      # Which wheel (for mice with multiple ones)
      def wheel : Mouse::Wheel
        @wheel
      end
      def wheel=(wheel : Mouse::Wheel)
        @wheel = wheel
      end
      @delta : LibC::Float
      # Wheel offset (positive is up/left, negative is down/right). High-precision mice may use non-integral offsets.
      def delta : Float32
        @delta
      end
      def delta=(delta : Number)
        @delta = LibC::Float.new(delta)
      end
      @x : LibC::Int
      # X position of the mouse pointer, relative to the left of the owner window
      def x : Int32
        @x
      end
      def x=(x : Int)
        @x = LibC::Int.new(x)
      end
      @y : LibC::Int
      # Y position of the mouse pointer, relative to the top of the owner window
      def y : Int32
        @y
      end
      def y=(y : Int)
        @y = LibC::Int.new(y)
      end
      # :nodoc:
      def initialize(copy : Event::MouseWheelScrollEvent)
        @wheel = uninitialized Mouse::Wheel
        @delta = uninitialized Float32
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_mousewheelscrollevent_initialize_Am0(to_unsafe, copy)
      end
      def dup() : MouseWheelScrollEvent
        return MouseWheelScrollEvent.new(self)
      end
    end
    # Joystick connection events parameters
    # (see `JoystickConnected`, `JoystickDisconnected`)
    abstract struct JoystickConnectEvent < Event
      def initialize()
        @joystick_id = uninitialized UInt32
        SFMLExt.sfml_event_joystickconnectevent_initialize(to_unsafe)
      end
      @joystick_id : LibC::UInt
      @joystick_id : LibC::UInt
      # Index of the joystick (in range `0 ... Joystick::Count`)
      def joystick_id : UInt32
        @joystick_id
      end
      def joystick_id=(joystick_id : Int)
        @joystick_id = LibC::UInt.new(joystick_id)
      end
      # :nodoc:
      def initialize(copy : Event::JoystickConnectEvent)
        @joystick_id = uninitialized UInt32
        SFMLExt.sfml_event_joystickconnectevent_initialize_rYL(to_unsafe, copy)
      end
      def dup() : JoystickConnectEvent
        return JoystickConnectEvent.new(self)
      end
    end
    # Joystick axis move event parameters (see `JoystickMoved`)
    abstract struct JoystickMoveEvent < Event
      def initialize()
        @joystick_id = uninitialized UInt32
        @axis = uninitialized Joystick::Axis
        @position = uninitialized Float32
        SFMLExt.sfml_event_joystickmoveevent_initialize(to_unsafe)
      end
      @joystick_id : LibC::UInt
      @axis : Joystick::Axis
      @position : LibC::Float
      @joystick_id : LibC::UInt
      # Index of the joystick (in range `0 ... Joystick::Count`)
      def joystick_id : UInt32
        @joystick_id
      end
      def joystick_id=(joystick_id : Int)
        @joystick_id = LibC::UInt.new(joystick_id)
      end
      @axis : Joystick::Axis
      # Axis on which the joystick moved
      def axis : Joystick::Axis
        @axis
      end
      def axis=(axis : Joystick::Axis)
        @axis = axis
      end
      @position : LibC::Float
      # New position on the axis (in range `-100 .. 100`)
      def position : Float32
        @position
      end
      def position=(position : Number)
        @position = LibC::Float.new(position)
      end
      # :nodoc:
      def initialize(copy : Event::JoystickMoveEvent)
        @joystick_id = uninitialized UInt32
        @axis = uninitialized Joystick::Axis
        @position = uninitialized Float32
        SFMLExt.sfml_event_joystickmoveevent_initialize_S8f(to_unsafe, copy)
      end
      def dup() : JoystickMoveEvent
        return JoystickMoveEvent.new(self)
      end
    end
    # Joystick buttons events parameters
    # (see `JoystickButtonPressed`, `JoystickButtonReleased`)
    abstract struct JoystickButtonEvent < Event
      def initialize()
        @joystick_id = uninitialized UInt32
        @button = uninitialized UInt32
        SFMLExt.sfml_event_joystickbuttonevent_initialize(to_unsafe)
      end
      @joystick_id : LibC::UInt
      @button : LibC::UInt
      @joystick_id : LibC::UInt
      # Index of the joystick (in range `0 ... Joystick::Count`)
      def joystick_id : UInt32
        @joystick_id
      end
      def joystick_id=(joystick_id : Int)
        @joystick_id = LibC::UInt.new(joystick_id)
      end
      @button : LibC::UInt
      # Index of the button that has been pressed (in range `0 ... Joystick::ButtonCount`)
      def button : UInt32
        @button
      end
      def button=(button : Int)
        @button = LibC::UInt.new(button)
      end
      # :nodoc:
      def initialize(copy : Event::JoystickButtonEvent)
        @joystick_id = uninitialized UInt32
        @button = uninitialized UInt32
        SFMLExt.sfml_event_joystickbuttonevent_initialize_V0a(to_unsafe, copy)
      end
      def dup() : JoystickButtonEvent
        return JoystickButtonEvent.new(self)
      end
    end
    # Touch events parameters (see `TouchBegan`, `TouchMoved`, `TouchEnded`)
    abstract struct TouchEvent < Event
      def initialize()
        @finger = uninitialized UInt32
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_touchevent_initialize(to_unsafe)
      end
      @finger : LibC::UInt
      @x : LibC::Int
      @y : LibC::Int
      @finger : LibC::UInt
      # Index of the finger in case of multi-touch events
      def finger : UInt32
        @finger
      end
      def finger=(finger : Int)
        @finger = LibC::UInt.new(finger)
      end
      @x : LibC::Int
      # X position of the touch, relative to the left of the owner window
      def x : Int32
        @x
      end
      def x=(x : Int)
        @x = LibC::Int.new(x)
      end
      @y : LibC::Int
      # Y position of the touch, relative to the top of the owner window
      def y : Int32
        @y
      end
      def y=(y : Int)
        @y = LibC::Int.new(y)
      end
      # :nodoc:
      def initialize(copy : Event::TouchEvent)
        @finger = uninitialized UInt32
        @x = uninitialized Int32
        @y = uninitialized Int32
        SFMLExt.sfml_event_touchevent_initialize_1F1(to_unsafe, copy)
      end
      def dup() : TouchEvent
        return TouchEvent.new(self)
      end
    end
    # Sensor event parameters (see `SensorChanged`)
    abstract struct SensorEvent < Event
      def initialize()
        @type = uninitialized Sensor::Type
        @x = uninitialized Float32
        @y = uninitialized Float32
        @z = uninitialized Float32
        SFMLExt.sfml_event_sensorevent_initialize(to_unsafe)
      end
      @type : Sensor::Type
      @x : LibC::Float
      @y : LibC::Float
      @z : LibC::Float
      @type : Sensor::Type
      # Type of the sensor
      def type : Sensor::Type
        @type
      end
      def type=(type : Sensor::Type)
        @type = type
      end
      @x : LibC::Float
      # Current value of the sensor on X axis
      def x : Float32
        @x
      end
      def x=(x : Number)
        @x = LibC::Float.new(x)
      end
      @y : LibC::Float
      # Current value of the sensor on Y axis
      def y : Float32
        @y
      end
      def y=(y : Number)
        @y = LibC::Float.new(y)
      end
      @z : LibC::Float
      # Current value of the sensor on Z axis
      def z : Float32
        @z
      end
      def z=(z : Number)
        @z = LibC::Float.new(z)
      end
      # :nodoc:
      def initialize(copy : Event::SensorEvent)
        @type = uninitialized Sensor::Type
        @x = uninitialized Float32
        @y = uninitialized Float32
        @z = uninitialized Float32
        SFMLExt.sfml_event_sensorevent_initialize_0L9(to_unsafe, copy)
      end
      def dup() : SensorEvent
        return SensorEvent.new(self)
      end
    end
    # :nodoc:
    # Enumeration of the different types of events
    enum EventType
      # The window requested to be closed (no data)
      Closed
      # The window was resized (data in event.size)
      Resized
      # The window lost the focus (no data)
      LostFocus
      # The window gained the focus (no data)
      GainedFocus
      # A character was entered (data in event.text)
      TextEntered
      # A key was pressed (data in event.key)
      KeyPressed
      # A key was released (data in event.key)
      KeyReleased
      # The mouse wheel was scrolled (data in event.mouse_wheel) (deprecated)
      MouseWheelMoved
      # The mouse wheel was scrolled (data in event.mouse_wheel_scroll)
      MouseWheelScrolled
      # A mouse button was pressed (data in event.mouse_button)
      MouseButtonPressed
      # A mouse button was released (data in event.mouse_button)
      MouseButtonReleased
      # The mouse cursor moved (data in event.mouse_move)
      MouseMoved
      # The mouse cursor entered the area of the window (no data)
      MouseEntered
      # The mouse cursor left the area of the window (no data)
      MouseLeft
      # A joystick button was pressed (data in event.joystick_button)
      JoystickButtonPressed
      # A joystick button was released (data in event.joystick_button)
      JoystickButtonReleased
      # The joystick moved along an axis (data in event.joystick_move)
      JoystickMoved
      # A joystick was connected (data in event.joystick_connect)
      JoystickConnected
      # A joystick was disconnected (data in event.joystick_connect)
      JoystickDisconnected
      # A touch event began (data in event.touch)
      TouchBegan
      # A touch moved (data in event.touch)
      TouchMoved
      # A touch event ended (data in event.touch)
      TouchEnded
      # A sensor value changed (data in event.sensor)
      SensorChanged
      # Keep last -- the total number of event types
      Count
    end
    # The window requested to be closed (no data)
    struct Closed < Event
      @_type = Event::EventType::Closed
    end
    # The window was resized (subtype of `SizeEvent`)
    struct Resized < SizeEvent
      @_type = Event::EventType::Resized
    end
    # The window lost the focus (no data)
    struct LostFocus < Event
      @_type = Event::EventType::LostFocus
    end
    # The window gained the focus (no data)
    struct GainedFocus < Event
      @_type = Event::EventType::GainedFocus
    end
    # A character was entered (subtype of `TextEvent`)
    struct TextEntered < TextEvent
      @_type = Event::EventType::TextEntered
    end
    # A key was pressed (subtype of `KeyEvent`)
    struct KeyPressed < KeyEvent
      @_type = Event::EventType::KeyPressed
    end
    # A key was released (subtype of `KeyEvent`)
    struct KeyReleased < KeyEvent
      @_type = Event::EventType::KeyReleased
    end
    # The mouse wheel was scrolled (subtype of `MouseWheelEvent`) (deprecated)
    struct MouseWheelMoved < MouseWheelEvent
      @_type = Event::EventType::MouseWheelMoved
    end
    # The mouse wheel was scrolled (subtype of `MouseWheelScrollEvent`)
    struct MouseWheelScrolled < MouseWheelScrollEvent
      @_type = Event::EventType::MouseWheelScrolled
    end
    # A mouse button was pressed (subtype of `MouseButtonEvent`)
    struct MouseButtonPressed < MouseButtonEvent
      @_type = Event::EventType::MouseButtonPressed
    end
    # A mouse button was released (subtype of `MouseButtonEvent`)
    struct MouseButtonReleased < MouseButtonEvent
      @_type = Event::EventType::MouseButtonReleased
    end
    # The mouse cursor moved (subtype of `MouseMoveEvent`)
    struct MouseMoved < MouseMoveEvent
      @_type = Event::EventType::MouseMoved
    end
    # The mouse cursor entered the area of the window (no data)
    struct MouseEntered < Event
      @_type = Event::EventType::MouseEntered
    end
    # The mouse cursor left the area of the window (no data)
    struct MouseLeft < Event
      @_type = Event::EventType::MouseLeft
    end
    # A joystick button was pressed (subtype of `JoystickButtonEvent`)
    struct JoystickButtonPressed < JoystickButtonEvent
      @_type = Event::EventType::JoystickButtonPressed
    end
    # A joystick button was released (subtype of `JoystickButtonEvent`)
    struct JoystickButtonReleased < JoystickButtonEvent
      @_type = Event::EventType::JoystickButtonReleased
    end
    # The joystick moved along an axis (subtype of `JoystickMoveEvent`)
    struct JoystickMoved < JoystickMoveEvent
      @_type = Event::EventType::JoystickMoved
    end
    # A joystick was connected (subtype of `JoystickConnectEvent`)
    struct JoystickConnected < JoystickConnectEvent
      @_type = Event::EventType::JoystickConnected
    end
    # A joystick was disconnected (subtype of `JoystickConnectEvent`)
    struct JoystickDisconnected < JoystickConnectEvent
      @_type = Event::EventType::JoystickDisconnected
    end
    # A touch event began (subtype of `TouchEvent`)
    struct TouchBegan < TouchEvent
      @_type = Event::EventType::TouchBegan
    end
    # A touch moved (subtype of `TouchEvent`)
    struct TouchMoved < TouchEvent
      @_type = Event::EventType::TouchMoved
    end
    # A touch event ended (subtype of `TouchEvent`)
    struct TouchEnded < TouchEvent
      @_type = Event::EventType::TouchEnded
    end
    # A sensor value changed (subtype of `SensorEvent`)
    struct SensorChanged < SensorEvent
      @_type = Event::EventType::SensorChanged
    end
  end
  # Give access to the real-time state of the touches
  #
  # `SF::Touch` provides an interface to the state of the
  # touches. It only contains static functions, so it's not
  # meant to be instantiated.
  #
  # This module allows users to query the touches state at any
  # time and directly, without having to deal with a window and
  # its events. Compared to the `TouchBegan`, `TouchMoved`
  # and `TouchEnded` events, `SF::Touch` can retrieve the
  # state of the touches at any time (you don't need to store and
  # update a boolean on your side in order to know if a touch is down),
  # and you always get the real state of the touches, even if they
  # happen when your window is out of focus and no event is triggered.
  #
  # The position function can be used to retrieve the current
  # position of a touch. There are two versions: one that operates
  # in global coordinates (relative to the desktop) and one that
  # operates in window coordinates (relative to a specific window).
  #
  # Touches are identified by an index (the "finger"), so that in
  # multi-touch events, individual touches can be tracked correctly.
  # As long as a finger touches the screen, it will keep the same index
  # even if other fingers start or stop touching the screen in the
  # meantime. As a consequence, active touch indices may not always be
  # sequential (i.e. touch number 0 may be released while touch number 1
  # is still down).
  #
  # Usage example:
  # ```crystal
  # if SF::Touch.down?(0)
  #   # touch 0 is down
  # end
  #
  # # get global position of touch 1
  # global_pos = SF::Touch.get_position(1)
  #
  # # get position of touch 1 relative to a window
  # relative_pos = SF::Touch.get_position(1, window)
  # ```
  #
  # *See also:* `SF::Joystick`, `SF::Keyboard`, `SF::Mouse`
  module Touch
    # Check if a touch event is currently down
    #
    # * *finger* - Finger index
    #
    # *Returns:* True if *finger* is currently touching the screen, false otherwise
    def self.down?(finger : Int) : Bool
      SFMLExt.sfml_touch_isdown_emS(LibC::UInt.new(finger), out result)
      return result
    end
    # Get the current position of a touch in desktop coordinates
    #
    # This function returns the current touch position
    # in global (desktop) coordinates.
    #
    # * *finger* - Finger index
    #
    # *Returns:* Current position of *finger*, or undefined if it's not down
    def self.get_position(finger : Int) : Vector2i
      result = Vector2i.allocate
      SFMLExt.sfml_touch_getposition_emS(LibC::UInt.new(finger), result)
      return result
    end
    # Get the current position of a touch in window coordinates
    #
    # This function returns the current touch position
    # relative to the given window.
    #
    # * *finger* - Finger index
    # * *relative_to* - Reference window
    #
    # *Returns:* Current position of *finger*, or undefined if it's not down
    def self.get_position(finger : Int, relative_to : Window) : Vector2i
      result = Vector2i.allocate
      SFMLExt.sfml_touch_getposition_emSJRh(LibC::UInt.new(finger), relative_to, result)
      return result
    end
  end
  # VideoMode defines a video mode (width, height, bpp)
  #
  # A video mode is defined by a width and a height (in pixels)
  # and a depth (in bits per pixel). Video modes are used to
  # setup windows (`SF::Window`) at creation time.
  #
  # The main usage of video modes is for fullscreen mode:
  # indeed you must use one of the valid video modes
  # allowed by the OS (which are defined by what the monitor
  # and the graphics card support), otherwise your window
  # creation will just fail.
  #
  # `SF::VideoMode` provides a static function for retrieving
  # the list of all the video modes supported by the system:
  # `fullscreen_modes()`.
  #
  # A custom video mode can also be checked directly for
  # fullscreen compatibility with its `valid?()` function.
  #
  # Additionally, `SF::VideoMode` provides a static function
  # to get the mode currently used by the desktop: `desktop_mode()`.
  # This allows to build windows with the same size or pixel
  # depth as the current resolution.
  #
  # Usage example:
  # ```crystal
  # # Display the list of all the video modes available for fullscreen
  # SF::VideoMode.fullscreen_modes.each do |mode|
  #   puts "Mode ##{i}: #{mode.width}x#{mode.height} - #{mode.bits_per_pixel} bpp"
  # end
  #
  # # Create a window with the same pixel depth as the desktop
  # desktop = SF::VideoMode.desktop_mode
  # window.create(SF::VideoMode.new(1024, 768, desktop.bits_per_pixel), "SFML window")
  # ```
  struct VideoMode
    @width : LibC::UInt
    @height : LibC::UInt
    @bits_per_pixel : LibC::UInt
    # Default constructor
    #
    # This constructors initializes all members to 0.
    def initialize()
      @width = uninitialized UInt32
      @height = uninitialized UInt32
      @bits_per_pixel = uninitialized UInt32
      SFMLExt.sfml_videomode_initialize(to_unsafe)
    end
    # Construct the video mode with its attributes
    #
    # * *width* - Width in pixels
    # * *height* - Height in pixels
    # * *bits_per_pixel* - Pixel depths in bits per pixel
    def initialize(width : Int, height : Int, bits_per_pixel : Int = 32)
      @width = uninitialized UInt32
      @height = uninitialized UInt32
      @bits_per_pixel = uninitialized UInt32
      SFMLExt.sfml_videomode_initialize_emSemSemS(to_unsafe, LibC::UInt.new(width), LibC::UInt.new(height), LibC::UInt.new(bits_per_pixel))
    end
    # Get the current desktop video mode
    #
    # *Returns:* Current desktop video mode
    def self.desktop_mode() : VideoMode
      result = VideoMode.allocate
      SFMLExt.sfml_videomode_getdesktopmode(result)
      return result
    end
    # Retrieve all the video modes supported in fullscreen mode
    #
    # When creating a fullscreen window, the video mode is restricted
    # to be compatible with what the graphics driver and monitor
    # support. This function returns the complete list of all video
    # modes that can be used in fullscreen mode.
    # The returned array is sorted from best to worst, so that
    # the first element will always give the best mode (higher
    # width, height and bits-per-pixel).
    #
    # *Returns:* Array containing all the supported fullscreen modes
    def self.fullscreen_modes() : Array(VideoMode)
      SFMLExt.sfml_videomode_getfullscreenmodes(out result, out result_size)
      return Array.new(result_size.to_i) { |i| result.as(VideoMode*)[i] }
    end
    # Tell whether or not the video mode is valid
    #
    # The validity of video modes is only relevant when using
    # fullscreen windows; otherwise any video mode can be used
    # with no restriction.
    #
    # *Returns:* True if the video mode is valid for fullscreen mode
    def valid?() : Bool
      SFMLExt.sfml_videomode_isvalid(to_unsafe, out result)
      return result
    end
    @width : LibC::UInt
    # Video mode width, in pixels
    def width : UInt32
      @width
    end
    def width=(width : Int)
      @width = LibC::UInt.new(width)
    end
    @height : LibC::UInt
    # Video mode height, in pixels
    def height : UInt32
      @height
    end
    def height=(height : Int)
      @height = LibC::UInt.new(height)
    end
    @bits_per_pixel : LibC::UInt
    # Video mode pixel depth, in bits per pixels
    def bits_per_pixel : UInt32
      @bits_per_pixel
    end
    def bits_per_pixel=(bits_per_pixel : Int)
      @bits_per_pixel = LibC::UInt.new(bits_per_pixel)
    end
    # Overload of == operator to compare two video modes
    #
    # * *left* - Left operand (a video mode)
    # * *right* - Right operand (a video mode)
    #
    # *Returns:* True if modes are equal
    def ==(right : VideoMode) : Bool
      SFMLExt.sfml_operator_eq_asWasW(to_unsafe, right, out result)
      return result
    end
    # Overload of != operator to compare two video modes
    #
    # * *left* - Left operand (a video mode)
    # * *right* - Right operand (a video mode)
    #
    # *Returns:* True if modes are different
    def !=(right : VideoMode) : Bool
      SFMLExt.sfml_operator_ne_asWasW(to_unsafe, right, out result)
      return result
    end
    # Overload of &lt; operator to compare video modes
    #
    # * *left* - Left operand (a video mode)
    # * *right* - Right operand (a video mode)
    #
    # *Returns:* True if *left* is lesser than *right*
    def <(right : VideoMode) : Bool
      SFMLExt.sfml_operator_lt_asWasW(to_unsafe, right, out result)
      return result
    end
    # Overload of &gt; operator to compare video modes
    #
    # * *left* - Left operand (a video mode)
    # * *right* - Right operand (a video mode)
    #
    # *Returns:* True if *left* is greater than *right*
    def >(right : VideoMode) : Bool
      SFMLExt.sfml_operator_gt_asWasW(to_unsafe, right, out result)
      return result
    end
    # Overload of &lt;= operator to compare video modes
    #
    # * *left* - Left operand (a video mode)
    # * *right* - Right operand (a video mode)
    #
    # *Returns:* True if *left* is lesser or equal than *right*
    def <=(right : VideoMode) : Bool
      SFMLExt.sfml_operator_le_asWasW(to_unsafe, right, out result)
      return result
    end
    # Overload of &gt;= operator to compare video modes
    #
    # * *left* - Left operand (a video mode)
    # * *right* - Right operand (a video mode)
    #
    # *Returns:* True if *left* is greater or equal than *right*
    def >=(right : VideoMode) : Bool
      SFMLExt.sfml_operator_ge_asWasW(to_unsafe, right, out result)
      return result
    end
    # :nodoc:
    def to_unsafe()
      pointerof(@width).as(Void*)
    end
    # :nodoc:
    def initialize(copy : VideoMode)
      @width = uninitialized UInt32
      @height = uninitialized UInt32
      @bits_per_pixel = uninitialized UInt32
      SFMLExt.sfml_videomode_initialize_asW(to_unsafe, copy)
    end
    def dup() : VideoMode
      return VideoMode.new(self)
    end
  end
  # Enumeration of the window styles
  @[Flags]
  enum Style
    # Title bar + fixed border
    Titlebar = 1 << 0
    # Title bar + resizable border + maximize button
    Resize = 1 << 1
    # Title bar + close button
    Close = 1 << 2
    # Fullscreen mode (this flag and all others are mutually exclusive)
    Fullscreen = 1 << 3
    # Default window style
    Default = Titlebar | Resize | Close
  end
  # Window that serves as a target for OpenGL rendering
  #
  # `SF::Window` is the main class of the Window module. It defines
  # an OS window that is able to receive an OpenGL rendering.
  #
  # A `SF::Window` can create its own new window, or be embedded into
  # an already existing control using the create(handle) function.
  # This can be useful for embedding an OpenGL rendering area into
  # a view which is part of a bigger GUI with existing windows,
  # controls, etc. It can also serve as embedding an OpenGL rendering
  # area into a window created by another (probably richer) GUI library
  # like Qt or wx_widgets.
  #
  # The `SF::Window` class provides a simple interface for manipulating
  # the window: move, resize, show/hide, control mouse cursor, etc.
  # It also provides event handling through its `poll_event()` and wait_event()
  # functions.
  #
  # Note that OpenGL experts can pass their own parameters (antialiasing
  # level, bits for the depth and stencil buffers, etc.) to the
  # OpenGL context attached to the window, with the `SF::ContextSettings`
  # structure which is passed as an optional argument when creating the
  # window.
  #
  # On dual-graphics systems consisting of a low-power integrated GPU
  # and a powerful discrete GPU, the driver picks which GPU will run an
  # SFML application. In order to inform the driver that an SFML application
  # can benefit from being run on the more powerful discrete GPU,
  # #SFML_DEFINE_DISCRETE_GPU_PREFERENCE can be placed in a source file
  # that is compiled and linked into the final application. The macro
  # should be placed outside of any scopes in the global namespace.
  #
  # Usage example:
  # ```crystal
  # # Declare and create a new window
  # window = SF::Window.new(SF::VideoMode.new(800, 600), "SFML window")
  #
  # # Limit the framerate to 60 frames per second (this step is optional)
  # window.framerate_limit = 60
  #
  # # The main loop - ends as soon as the window is closed
  # while window.open?
  #   # Event processing
  #   while (event = window.poll_event)
  #     # Request for closing the window
  #     if event.is_a?(SF::Event::Closed)
  #       window.close
  #     end
  #   end
  #
  #   # Activate the window for OpenGL rendering
  #   window.active = true
  #
  #   # OpenGL drawing commands go here...
  #
  #   # End the current frame and display its contents on screen
  #   window.display
  # end
  # ```
  class Window
    @this : Void*
    # Default constructor
    #
    # This constructor doesn't actually create the window,
    # use the other constructors or call `create()` to do so.
    def initialize()
      SFMLExt.sfml_window_allocate(out @this)
      SFMLExt.sfml_window_initialize(to_unsafe)
    end
    # Construct a new window
    #
    # This constructor creates the window with the size and pixel
    # depth defined in *mode*. An optional style can be passed to
    # customize the look and behavior of the window (borders,
    # title bar, resizable, closable, ...). If *style* contains
    # Style::Fullscreen, then *mode* must be a valid video mode.
    #
    # The fourth parameter is an optional structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    #
    # * *mode* - Video mode to use (defines the width, height and depth of the rendering area of the window)
    # * *title* - Title of the window
    # * *style* - Window style, a bitwise OR combination of `SF::Style` enumerators
    # * *settings* - Additional settings for the underlying OpenGL context
    def initialize(mode : VideoMode, title : String, style : Style = Style::Default, settings : ContextSettings = ContextSettings.new())
      SFMLExt.sfml_window_allocate(out @this)
      SFMLExt.sfml_window_initialize_wg0bQssaLFw4(to_unsafe, mode, title.size, title.chars, style, settings)
    end
    # Construct the window from an existing control
    #
    # Use this constructor if you want to create an OpenGL
    # rendering area into an already existing control.
    #
    # The second parameter is an optional structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    #
    # * *handle* - Platform-specific handle of the control
    # * *settings* - Additional settings for the underlying OpenGL context
    def initialize(handle : WindowHandle, settings : ContextSettings = ContextSettings.new())
      SFMLExt.sfml_window_allocate(out @this)
      SFMLExt.sfml_window_initialize_rLQFw4(to_unsafe, handle, settings)
    end
    # Destructor
    #
    # Closes the window and frees all the resources attached to it.
    def finalize()
      SFMLExt.sfml_window_finalize(to_unsafe)
      SFMLExt.sfml_window_free(@this)
    end
    # Create (or recreate) the window
    #
    # If the window was already created, it closes it first.
    # If *style* contains `Style::Fullscreen`, then *mode*
    # must be a valid video mode.
    #
    # The fourth parameter is an optional structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    #
    # * *mode* - Video mode to use (defines the width, height and depth of the rendering area of the window)
    # * *title* - Title of the window
    # * *style* - Window style, a bitwise OR combination of `SF::Style` enumerators
    # * *settings* - Additional settings for the underlying OpenGL context
    def create(mode : VideoMode, title : String, style : Style = Style::Default, settings : ContextSettings = ContextSettings.new())
      SFMLExt.sfml_window_create_wg0bQssaLFw4(to_unsafe, mode, title.size, title.chars, style, settings)
    end
    # Shorthand for `window = Window.new; window.create(...); window`
    def self.new(*args, **kwargs) : self
      obj = new
      obj.create(*args, **kwargs)
      obj
    end
    # Create (or recreate) the window from an existing control
    #
    # Use this function if you want to create an OpenGL
    # rendering area into an already existing control.
    # If the window was already created, it closes it first.
    #
    # The second parameter is an optional structure specifying
    # advanced OpenGL context settings such as antialiasing,
    # depth-buffer bits, etc.
    #
    # * *handle* - Platform-specific handle of the control
    # * *settings* - Additional settings for the underlying OpenGL context
    def create(handle : WindowHandle, settings : ContextSettings = ContextSettings.new())
      SFMLExt.sfml_window_create_rLQFw4(to_unsafe, handle, settings)
    end
    # Shorthand for `window = Window.new; window.create(...); window`
    def self.new(*args, **kwargs) : self
      obj = new
      obj.create(*args, **kwargs)
      obj
    end
    # Close the window and destroy all the attached resources
    #
    # After calling this function, the `SF::Window` instance remains
    # valid and you can call `create()` to recreate the window.
    # All other functions such as `poll_event()` or display() will
    # still work (i.e. you don't have to test `open?()` every time),
    # and will have no effect on closed windows.
    def close()
      SFMLExt.sfml_window_close(to_unsafe)
    end
    # Tell whether or not the window is open
    #
    # This function returns whether or not the window exists.
    # Note that a hidden window (`visible=false`) is open
    # (therefore this function would return true).
    #
    # *Returns:* True if the window is open, false if it has been closed
    def open?() : Bool
      SFMLExt.sfml_window_isopen(to_unsafe, out result)
      return result
    end
    # Get the settings of the OpenGL context of the window
    #
    # Note that these settings may be different from what was
    # passed to the constructor or the `create()` function,
    # if one or more settings were not supported. In this case,
    # SFML chose the closest match.
    #
    # *Returns:* Structure containing the OpenGL context settings
    def settings() : ContextSettings
      result = ContextSettings.allocate
      SFMLExt.sfml_window_getsettings(to_unsafe, result)
      return result
    end
    # Pop the event on top of the event queue, if any, and return it
    #
    # This function is not blocking: if there's no pending event then
    # it will return false and leave *event* unmodified.
    # Note that more than one event may be present in the event queue,
    # thus you should always call this function in a loop
    # to make sure that you process every pending event.
    # ```crystal
    # while (event = window.poll_event)
    #   # process event...
    # end
    # ```
    #
    # * *event* - Event to be returned
    #
    # *Returns:* True if an event was returned, or false if the event queue was empty
    #
    # *See also:* `wait_event`
    def poll_event() : Event?
      SFMLExt.sfml_event_allocate(out event)
      SFMLExt.sfml_window_pollevent_YJW(to_unsafe, event, out result)
      if result
        case (event_id = event.as(Event::EventType*).value)
        when .closed?
          event.as(Event::Closed*).value
        when .resized?
          event.as(Event::Resized*).value
        when .lost_focus?
          event.as(Event::LostFocus*).value
        when .gained_focus?
          event.as(Event::GainedFocus*).value
        when .text_entered?
          event.as(Event::TextEntered*).value
        when .key_pressed?
          event.as(Event::KeyPressed*).value
        when .key_released?
          event.as(Event::KeyReleased*).value
        when .mouse_wheel_moved?
          event.as(Event::MouseWheelMoved*).value
        when .mouse_wheel_scrolled?
          event.as(Event::MouseWheelScrolled*).value
        when .mouse_button_pressed?
          event.as(Event::MouseButtonPressed*).value
        when .mouse_button_released?
          event.as(Event::MouseButtonReleased*).value
        when .mouse_moved?
          event.as(Event::MouseMoved*).value
        when .mouse_entered?
          event.as(Event::MouseEntered*).value
        when .mouse_left?
          event.as(Event::MouseLeft*).value
        when .joystick_button_pressed?
          event.as(Event::JoystickButtonPressed*).value
        when .joystick_button_released?
          event.as(Event::JoystickButtonReleased*).value
        when .joystick_moved?
          event.as(Event::JoystickMoved*).value
        when .joystick_connected?
          event.as(Event::JoystickConnected*).value
        when .joystick_disconnected?
          event.as(Event::JoystickDisconnected*).value
        when .touch_began?
          event.as(Event::TouchBegan*).value
        when .touch_moved?
          event.as(Event::TouchMoved*).value
        when .touch_ended?
          event.as(Event::TouchEnded*).value
        when .sensor_changed?
          event.as(Event::SensorChanged*).value
        else
          raise "Unknown SFML event ID #{event_id.value}"
        end
      end
    end
    # Wait for an event and return it
    #
    # This function is blocking: if there's no pending event then
    # it will wait until an event is received.
    # After this function returns (and no error occurred),
    # the *event* object is always valid and filled properly.
    # This function is typically used when you have a thread that
    # is dedicated to events handling: you want to make this thread
    # sleep as long as no new event is received.
    # ```crystal
    # if (event = window.wait_event)
    #   # process event...
    # end
    # ```
    #
    # * *event* - Event to be returned
    #
    # *Returns:* False if any error occurred
    #
    # *See also:* `poll_event`
    def wait_event() : Event?
      SFMLExt.sfml_event_allocate(out event)
      SFMLExt.sfml_window_waitevent_YJW(to_unsafe, event, out result)
      if result
        case (event_id = event.as(Event::EventType*).value)
        when .closed?
          event.as(Event::Closed*).value
        when .resized?
          event.as(Event::Resized*).value
        when .lost_focus?
          event.as(Event::LostFocus*).value
        when .gained_focus?
          event.as(Event::GainedFocus*).value
        when .text_entered?
          event.as(Event::TextEntered*).value
        when .key_pressed?
          event.as(Event::KeyPressed*).value
        when .key_released?
          event.as(Event::KeyReleased*).value
        when .mouse_wheel_moved?
          event.as(Event::MouseWheelMoved*).value
        when .mouse_wheel_scrolled?
          event.as(Event::MouseWheelScrolled*).value
        when .mouse_button_pressed?
          event.as(Event::MouseButtonPressed*).value
        when .mouse_button_released?
          event.as(Event::MouseButtonReleased*).value
        when .mouse_moved?
          event.as(Event::MouseMoved*).value
        when .mouse_entered?
          event.as(Event::MouseEntered*).value
        when .mouse_left?
          event.as(Event::MouseLeft*).value
        when .joystick_button_pressed?
          event.as(Event::JoystickButtonPressed*).value
        when .joystick_button_released?
          event.as(Event::JoystickButtonReleased*).value
        when .joystick_moved?
          event.as(Event::JoystickMoved*).value
        when .joystick_connected?
          event.as(Event::JoystickConnected*).value
        when .joystick_disconnected?
          event.as(Event::JoystickDisconnected*).value
        when .touch_began?
          event.as(Event::TouchBegan*).value
        when .touch_moved?
          event.as(Event::TouchMoved*).value
        when .touch_ended?
          event.as(Event::TouchEnded*).value
        when .sensor_changed?
          event.as(Event::SensorChanged*).value
        else
          raise "Unknown SFML event ID #{event_id.value}"
        end
      end
    end
    # Get the position of the window
    #
    # *Returns:* Position of the window, in pixels
    #
    # *See also:* `position=`
    def position() : Vector2i
      result = Vector2i.allocate
      SFMLExt.sfml_window_getposition(to_unsafe, result)
      return result
    end
    # Change the position of the window on screen
    #
    # This function only works for top-level windows
    # (i.e. it will be ignored for windows created from
    # the handle of a child window/control).
    #
    # * *position* - New position, in pixels
    #
    # *See also:* `position`
    def position=(position : Vector2|Tuple)
      position = SF.vector2i(position[0], position[1])
      SFMLExt.sfml_window_setposition_ufV(to_unsafe, position)
    end
    # Get the size of the rendering region of the window
    #
    # The size doesn't include the titlebar and borders
    # of the window.
    #
    # *Returns:* Size in pixels
    #
    # *See also:* `size=`
    def size() : Vector2u
      result = Vector2u.allocate
      SFMLExt.sfml_window_getsize(to_unsafe, result)
      return result
    end
    # Change the size of the rendering region of the window
    #
    # * *size* - New size, in pixels
    #
    # *See also:* `size`
    def size=(size : Vector2|Tuple)
      size = SF.vector2u(size[0], size[1])
      SFMLExt.sfml_window_setsize_DXO(to_unsafe, size)
    end
    # Change the title of the window
    #
    # * *title* - New title
    #
    # *See also:* `icon=`
    def title=(title : String)
      SFMLExt.sfml_window_settitle_bQs(to_unsafe, title.size, title.chars)
    end
    # Change the window's icon
    #
    # *pixels* must be an array of *width* x *height* pixels
    # in 32-bits RGBA format.
    #
    # The OS default icon is used by default.
    #
    # * *width* - Icon's width, in pixels
    # * *height* - Icon's height, in pixels
    # * *pixels* - Pointer to the array of pixels in memory. The
    # pixels are copied, so you need not keep the
    # source alive after calling this function.
    #
    # *See also:* `title=`
    def set_icon(width : Int, height : Int, pixels : UInt8*)
      SFMLExt.sfml_window_seticon_emSemS843(to_unsafe, LibC::UInt.new(width), LibC::UInt.new(height), pixels)
    end
    # Show or hide the window
    #
    # The window is shown by default.
    #
    # * *visible* - True to show the window, false to hide it
    def visible=(visible : Bool)
      SFMLExt.sfml_window_setvisible_GZq(to_unsafe, visible)
    end
    # Enable or disable vertical synchronization
    #
    # Activating vertical synchronization will limit the number
    # of frames displayed to the refresh rate of the monitor.
    # This can avoid some visual artifacts, and limit the framerate
    # to a good value (but not constant across different computers).
    #
    # Vertical synchronization is disabled by default.
    #
    # * *enabled* - True to enable v-sync, false to deactivate it
    def vertical_sync_enabled=(enabled : Bool)
      SFMLExt.sfml_window_setverticalsyncenabled_GZq(to_unsafe, enabled)
    end
    # Show or hide the mouse cursor
    #
    # The mouse cursor is visible by default.
    #
    # * *visible* - True to show the mouse cursor, false to hide it
    def mouse_cursor_visible=(visible : Bool)
      SFMLExt.sfml_window_setmousecursorvisible_GZq(to_unsafe, visible)
    end
    # Grab or release the mouse cursor
    #
    # If set, grabs the mouse cursor inside this window's client
    # area so it may no longer be moved outside its bounds.
    # Note that grabbing is only active while the window has
    # focus.
    #
    # * *grabbed* - True to enable, false to disable
    def mouse_cursor_grabbed=(grabbed : Bool)
      SFMLExt.sfml_window_setmousecursorgrabbed_GZq(to_unsafe, grabbed)
    end
    # Set the displayed cursor to a native system cursor
    #
    # Upon window creation, the arrow cursor is used by default.
    #
    # WARNING: The cursor must not be destroyed while in use by
    # the window.
    #
    # WARNING: Features related to Cursor are not supported on
    # iOS and Android.
    #
    # * *cursor* - Native system cursor type to display
    #
    # *See also:* `SF::Cursor.load_from_system`
    # *See also:* `SF::Cursor.load_from_pixels`
    def mouse_cursor=(cursor : Cursor)
      @_window_mouse_cursor = cursor
      SFMLExt.sfml_window_setmousecursor_Voc(to_unsafe, cursor)
    end
    @_window_mouse_cursor : Cursor? = nil
    # Enable or disable automatic key-repeat
    #
    # If key repeat is enabled, you will receive repeated
    # KeyPressed events while keeping a key pressed. If it is disabled,
    # you will only get a single event when the key is pressed.
    #
    # Key repeat is enabled by default.
    #
    # * *enabled* - True to enable, false to disable
    def key_repeat_enabled=(enabled : Bool)
      SFMLExt.sfml_window_setkeyrepeatenabled_GZq(to_unsafe, enabled)
    end
    # Limit the framerate to a maximum fixed frequency
    #
    # If a limit is set, the window will use a small delay after
    # each call to `display()` to ensure that the current frame
    # lasted long enough to match the framerate limit.
    # SFML will try to match the given limit as much as it can,
    # but since it internally uses `SF.sleep`, whose precision
    # depends on the underlying OS, the results may be a little
    # unprecise as well (for example, you can get 65 FPS when
    # requesting 60).
    #
    # * *limit* - Framerate limit, in frames per seconds (use 0 to disable limit)
    def framerate_limit=(limit : Int)
      SFMLExt.sfml_window_setframeratelimit_emS(to_unsafe, LibC::UInt.new(limit))
    end
    # Change the joystick threshold
    #
    # The joystick threshold is the value below which
    # no JoystickMoved event will be generated.
    #
    # The threshold value is 0.1 by default.
    #
    # * *threshold* - New threshold, in the range `0.0 .. 100.0`
    def joystick_threshold=(threshold : Number)
      SFMLExt.sfml_window_setjoystickthreshold_Bw9(to_unsafe, LibC::Float.new(threshold))
    end
    # Activate or deactivate the window as the current target
    # for OpenGL rendering
    #
    # A window is active only on the current thread, if you want to
    # make it active on another thread you have to deactivate it
    # on the previous thread first if it was active.
    # Only one window can be active on a thread at a time, thus
    # the window previously active (if any) automatically gets deactivated.
    # This is not to be confused with `request_focus()`.
    #
    # * *active* - True to activate, false to deactivate
    #
    # *Returns:* True if operation was successful, false otherwise
    def active=(active : Bool = true) : Bool
      SFMLExt.sfml_window_setactive_GZq(to_unsafe, active, out result)
      return result
    end
    # Request the current window to be made the active
    # foreground window
    #
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or mouse events.
    # If a window requests focus, it only hints to the operating
    # system, that it would like to be focused. The operating system
    # is free to deny the request.
    # This is not to be confused with `active=()`.
    #
    # *See also:* `focus?`
    def request_focus()
      SFMLExt.sfml_window_requestfocus(to_unsafe)
    end
    # Check whether the window has the input focus
    #
    # At any given time, only one window may have the input focus
    # to receive input events such as keystrokes or most mouse
    # events.
    #
    # *Returns:* True if window has focus, false otherwise
    # *See also:* `request_focus`
    def focus?() : Bool
      SFMLExt.sfml_window_hasfocus(to_unsafe, out result)
      return result
    end
    # Display on screen what has been rendered to the window so far
    #
    # This function is typically called after all OpenGL rendering
    # has been done for the current frame, in order to show
    # it on screen.
    def display()
      SFMLExt.sfml_window_display(to_unsafe)
    end
    # Get the OS-specific handle of the window
    #
    # The type of the returned handle is `SF::WindowHandle`,
    # which is a typedef to the handle type defined by the OS.
    # You shouldn't need to use this function, unless you have
    # very specific stuff to implement that SFML doesn't support,
    # or implement a temporary workaround until a bug is fixed.
    #
    # *Returns:* System handle of the window
    def system_handle() : WindowHandle
      SFMLExt.sfml_window_getsystemhandle(to_unsafe, out result)
      return result
    end
    include GlResource
    include NonCopyable
    # :nodoc:
    def to_unsafe()
      @this
    end
    # :nodoc:
    def inspect(io)
      to_s(io)
    end
  end
  SFMLExt.sfml_window_version(out major, out minor, out patch)
  if SFML_VERSION != (ver = "#{major}.#{minor}.#{patch}")
    STDERR.puts "Warning: CrSFML was built for SFML #{SFML_VERSION}, found SFML #{ver}"
  end
end
