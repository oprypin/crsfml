--- SF::ContextSettings
+++ SF::ContextSettings
@@ -27,5 +27,5 @@
 context should follow the core or compatibility profile
-of all newer (&gt;= 3.2) OpenGL specifications. For versions
-3.0 and 3.1 there is only the core profile. By default
-a compatibility context is created. You only need to specify
+of all newer (>= 3.2) OpenGL specifications. For versions 3.0
+and 3.1 there is only the core profile. By default a
+compatibility context is created. You only need to specify
 the core flag if you want a core profile context to use with
@@ -46,5 +46,4 @@
 contexts are not supported. Further information is available on the
-&lt;a href="https://developer.apple.com/opengl/capabilities/index.html"&gt;
-OpenGL Capabilities Tables&lt;/a&gt; page. OS X also currently does
-not support debug contexts.
+[OpenGL Capabilities Tables](https://developer.apple.com/opengl/capabilities/index.html)
+page. OS X also currently does not support debug contexts.
 
@@ -55,2 +54,2 @@
 settings that the window actually used to create its context,
-with Window::settings().
+with Window.settings().
--- SF::GlResource
+++ SF::GlResource
@@ -1,5 +1 @@
-Base class for classes that require an OpenGL context
-
-This class is for internal use only, it must be the base
-of every class that requires a valid OpenGL context in
-order to work.
+Empty module that indicates the class requires an OpenGL context
--- SF::Joystick
+++ SF::Joystick
@@ -5,8 +5,8 @@
 meant to be instantiated. Instead, each joystick is identified
-by an index that is passed to the functions of this class.
+by an index that is passed to the functions of this module.
 
-This class allows users to query the state of joysticks at any
+This module allows users to query the state of joysticks at any
 time and directly, without having to deal with a window and
-its events. Compared to the JoystickMoved, JoystickButtonPressed
-and JoystickButtonReleased events, `SF::Joystick` can retrieve the
+its events. Compared to the `JoystickMoved`, `JoystickButtonPressed`
+and `JoystickButtonReleased` events, `SF::Joystick` can retrieve the
 state of axes and buttons of joysticks at any time
@@ -29,20 +29,20 @@
 window, or if you want to check joysticks state before creating one,
-you must call `SF::Joystick::update` explicitly.
+you must call `SF::Joystick.update` explicitly.
 
 Usage example:
-```c++
-// Is joystick #0 connected?
-bool connected = sf::Joystick::isConnected(0);
+```
+# Is joystick #0 connected?
+connected = SF::Joystick.connected?(0)
 
-// How many buttons does joystick #0 support?
-unsigned int buttons = sf::Joystick::getButtonCount(0);
+# How many buttons does joystick #0 support?
+buttons = SF::Joystick.get_button_count(0)
 
-// Does joystick #0 define a X axis?
-bool hasX = sf::Joystick::hasAxis(0, sf::Joystick::X);
+# Does joystick #0 define a X axis?
+has_x = SF::Joystick.axis?(0, SF::Joystick::X)
 
-// Is button #2 pressed on joystick #0?
-bool pressed = sf::Joystick::isButtonPressed(0, 2);
+# Is button #2 pressed on joystick #0?
+pressed = SF::Joystick.button_pressed?(0, 2)
 
-// What's the current position of the Y axis on joystick #0?
-float position = sf::Joystick::getAxisPosition(0, sf::Joystick::Y);
+# What's the current position of the Y axis on joystick #0?
+position = SF::Joystick.get_axis_position(0, SF::Joystick::Y)
 ```
--- SF::Joystick.get_axis_position(joystick,axis)
+++ SF::Joystick.get_axis_position(joystick,axis)
@@ -7,2 +7,2 @@
 
-*Returns:* Current position of the axis, in range [-100 .. 100]
+*Returns:* Current position of the axis, in range `-100 .. 100`
--- SF::Keyboard
+++ SF::Keyboard
@@ -6,5 +6,5 @@
 
-This class allows users to query the keyboard state at any
+This module allows users to query the keyboard state at any
 time and directly, without having to deal with a window and
-its events. Compared to the KeyPressed and KeyReleased events,
+its events. Compared to the `KeyPressed` and `KeyReleased` events,
 `SF::Keyboard` can retrieve the state of a key at any time
@@ -17,15 +17,10 @@
 Usage example:
-```c++
-if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left))
-{
-    // move left...
-}
-else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right))
-{
-    // move right...
-}
-else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Escape))
-{
-    // quit...
-}
+```
+if SF::Keyboard.key_pressed?(SF::Keyboard::Left)
+  # move left...
+elsif SF::Keyboard.key_pressed?(SF::Keyboard::Right)
+  # move right...
+elsif SF::Keyboard.key_pressed?(SF::Keyboard::Escape)
+  # quit...
+end
 ```
--- SF::Mouse
+++ SF::Mouse
@@ -6,6 +6,6 @@
 
-This class allows users to query the mouse state at any
+This module allows users to query the mouse state at any
 time and directly, without having to deal with a window and
-its events. Compared to the MouseMoved, MouseButtonPressed
-and MouseButtonReleased events, `SF::Mouse` can retrieve the
+its events. Compared to the `MouseMoved`, `MouseButtonPressed`
+and `MouseButtonReleased` events, `SF::Mouse` can retrieve the
 state of the cursor and the buttons at any time
@@ -24,13 +24,12 @@
 Usage example:
-```c++
-if (sf::Mouse::isButtonPressed(sf::Mouse::Left))
-{
-    // left click...
-}
+```
+if SF::Mouse.button_pressed?(SF::Mouse::Left)
+  # left click...
+end
 
-// get global mouse position
-sf::Vector2i position = sf::Mouse::getPosition();
+# get global mouse position
+position = SF::Mouse.position
 
-// set mouse position relative to a window
-sf::Mouse::setPosition(sf::Vector2i(100, 200), window);
+# set mouse position relative to a window
+SF::Mouse.set_position(SF.vector2i(100, 200), window)
 ```
--- SF::Context
+++ SF::Context
@@ -21,11 +21,10 @@
 void threadFunction(void*)
-{
-   sf::Context context;
-   // from now on, you have a valid context
+   SF::Context context
+   # from now on, you have a valid context
 
-   // you can make OpenGL calls
-   glClear(GL_DEPTH_BUFFER_BIT);
-}
-// the context is automatically deactivated and destroyed
-// by the sf::Context destructor
+   # you can make OpenGL calls
+   glClear(GL_DEPTH_BUFFER_BIT)
+end
+# the context is automatically deactivated and destroyed
+# by the SF::Context destructor
 ```
--- SF::Sensor
+++ SF::Sensor
@@ -6,5 +6,5 @@
 
-This class allows users to query the sensors values at any
+This module allows users to query the sensors values at any
 time and directly, without having to deal with a window and
-its events. Compared to the SensorChanged event, `SF::Sensor`
+its events. Compared to the `SensorChanged` event, `SF::Sensor`
 can retrieve the state of a sensor at any time (you don't need to
@@ -15,3 +15,3 @@
 the availability of a sensor before trying to read it, with the
-`SF::Sensor::available?` function.
+`SF::Sensor.available?` function.
 
@@ -27,3 +27,3 @@
 Because sensors consume a non-negligible amount of current, they are
-all disabled by default. You must call `SF::Sensor::enabled=` for each
+all disabled by default. You must call `SF::Sensor.enabled=` for each
 sensor in which you are interested.
@@ -31,13 +31,12 @@
 Usage example:
-```c++
-if (sf::Sensor::isAvailable(sf::Sensor::Gravity))
-{
-    // gravity sensor is available
-}
+```
+if SF::Sensor.available?(SF::Sensor::Gravity)
+  # gravity sensor is available
+end
 
-// enable the gravity sensor
-sf::Sensor::setEnabled(sf::Sensor::Gravity, true);
+# enable the gravity sensor
+SF::Sensor.set_enabled(SF::Sensor::Gravity, true)
 
-// get the current value of gravity
-sf::Vector3f gravity = sf::Sensor::getValue(sf::Sensor::Gravity);
+# get the current value of gravity
+gravity = SF::Sensor.get_value(SF::Sensor::Gravity)
 ```
--- SF::Touch
+++ SF::Touch
@@ -6,3 +6,3 @@
 
-This class allows users to query the touches state at any
+This module allows users to query the touches state at any
 time and directly, without having to deal with a window and
@@ -29,13 +29,12 @@
 Usage example:
-```c++
-if (sf::Touch::isDown(0))
-{
-    // touch 0 is down
-}
+```
+if SF::Touch.down?(0)
+  # touch 0 is down
+end
 
-// get global position of touch 1
-sf::Vector2i globalPos = sf::Touch::getPosition(1);
+# get global position of touch 1
+global_pos = SF::Touch.get_position(1)
 
-// get position of touch 1 relative to a window
-sf::Vector2i relativePos = sf::Touch::getPosition(1, window);
+# get position of touch 1 relative to a window
+relative_pos = SF::Touch.get_position(1, window)
 ```
--- SF::VideoMode
+++ SF::VideoMode
@@ -25,16 +25,11 @@
 Usage example:
-```c++
-// Display the list of all the video modes available for fullscreen
-std::vector<sf::VideoMode> modes = sf::VideoMode::getFullscreenModes();
-for (std::size_t i = 0; i < modes.size(); ++i)
-{
-    sf::VideoMode mode = modes[i];
-    std::cout << "Mode #" << i << ": "
-              << mode.width << "x" << mode.height << " - "
-              << mode.bitsPerPixel << " bpp" << std::endl;
-}
+```
+# Display the list of all the video modes available for fullscreen
+SF::VideoMode.fullscreen_modes.each do |mode|
+  puts "Mode ##{i}: #{mode.width}x#{mode.height} - #{mode.bits_per_pixel} bpp"
+end
 
-// Create a window with the same pixel depth as the desktop
-sf::VideoMode desktop = sf::VideoMode::getDesktopMode();
-window.create(sf::VideoMode(1024, 768, desktop.bitsPerPixel), "SFML window");
+# Create a window with the same pixel depth as the desktop
+desktop = SF::VideoMode.desktop_mode
+window.create(SF::VideoMode.new(1024, 768, desktop.bits_per_pixel), "SFML window")
 ```
--- SF::Window
+++ SF::Window
@@ -33,29 +33,27 @@
 Usage example:
-```c++
-// Declare and create a new window
-sf::Window window(sf::VideoMode(800, 600), "SFML window");
-
-// Limit the framerate to 60 frames per second (this step is optional)
-window.setFramerateLimit(60);
-
-// The main loop - ends as soon as the window is closed
-while (window.isOpen())
-{
-   // Event processing
-   sf::Event event;
-   while (window.pollEvent(event))
-   {
-       // Request for closing the window
-       if (event.type == sf::Event::Closed)
-           window.close();
-   }
-
-   // Activate the window for OpenGL rendering
-   window.setActive();
-
-   // OpenGL drawing commands go here...
-
-   // End the current frame and display its contents on screen
-   window.display();
-}
+```
+# Declare and create a new window
+window = SF::Window.new(SF::VideoMode.new(800, 600), "SFML window")
+
+# Limit the framerate to 60 frames per second (this step is optional)
+window.framerate_limit = 60
+
+# The main loop - ends as soon as the window is closed
+while window.open?
+  # Event processing
+  while (event = window.poll_event())
+    # Request for closing the window
+    if event.is_a?(SF::Event::Closed)
+      window.close()
+    end
+  end
+
+  # Activate the window for OpenGL rendering
+  window.active = true
+
+  # OpenGL drawing commands go here...
+
+  # End the current frame and display its contents on screen
+  window.display()
+end
 ```
--- SF::Window#framerate_limit=(limit)
+++ SF::Window#framerate_limit=(limit)
@@ -6,3 +6,3 @@
 SFML will try to match the given limit as much as it can,
-but since it internally uses `SF::sleep`, whose precision
+but since it internally uses `SF.sleep`, whose precision
 depends on the underlying OS, the results may be a little
--- SF::Window#joystick_threshold=(threshold)
+++ SF::Window#joystick_threshold=(threshold)
@@ -7,2 +7,2 @@
 
-* *threshold* - New threshold, in the range [0, 100]
+* *threshold* - New threshold, in the range `0.0 .. 100.0`
--- SF::Window#poll_event()
+++ SF::Window#poll_event()
@@ -7,8 +7,6 @@
 to make sure that you process every pending event.
-```c++
-sf::Event event;
-while (window.pollEvent(event))
-{
-   // process event...
-}
+```
+while (event = window.poll_event())
+  # process event...
+end
 ```
--- SF::Window#wait_event()
+++ SF::Window#wait_event()
@@ -9,8 +9,6 @@
 sleep as long as no new event is received.
-```c++
-sf::Event event;
-if (window.waitEvent(event))
-{
-   // process event...
-}
+```
+if (event = window.wait_event())
+  # process event...
+end
 ```
--- SF::Event
+++ SF::Event
@@ -4,3 +4,3 @@
 that just happened. Events are retrieved using the
-`SF::Window::poll_event` and `SF::Window::wait_event` functions.
+`SF::Window.poll_event` and `SF::Window.wait_event` functions.
 
@@ -18,20 +18,22 @@
 Usage example:
-```c++
-sf::Event event;
-while (window.pollEvent(event))
-{
-    // Request for closing the window
-    if (event.type == sf::Event::Closed)
-        window.close();
+```
+while (event = window.poll_event())
+  case event
+  # Request for closing the window
+  when SF::Event::Closed
+    window.close()
 
-    // The escape key was pressed
-    if ((event.type == sf::Event::KeyPressed) && (event.key.code == sf::Keyboard::Escape))
-        window.close();
+  # The escape key was pressed
+  when SF::Event::KeyPressed
+    if event.code == SF::Keyboard::Escape
+      window.close()
+    end
 
-    // The window was resized
-    if (event.type == sf::Event::Resized)
-        doSomethingWithTheNewSize(event.size.width, event.size.height);
+  # The window was resized
+  when SF::Event::Resized
+    do_something(event.width, event.height)
 
-    // etc ...
-}
+  # etc ...
+  end
+end
 ```
--- SF::Event::JoystickButtonEvent#button()
+++ SF::Event::JoystickButtonEvent#button()
@@ -1 +1 @@
-Index of the button that has been pressed (in range [0 .. Joystick::ButtonCount - 1])
+Index of the button that has been pressed (in range `0 ... Joystick::ButtonCount`)
--- SF::Event::JoystickButtonEvent#joystick_id()
+++ SF::Event::JoystickButtonEvent#joystick_id()
@@ -1 +1 @@
-Index of the joystick (in range [0 .. Joystick::Count - 1])
+Index of the joystick (in range `0 ... Joystick::Count`)
--- SF::Event::JoystickConnectEvent#joystick_id()
+++ SF::Event::JoystickConnectEvent#joystick_id()
@@ -1 +1 @@
-Index of the joystick (in range [0 .. Joystick::Count - 1])
+Index of the joystick (in range `0 ... Joystick::Count`)
--- SF::Event::JoystickMoveEvent#joystick_id()
+++ SF::Event::JoystickMoveEvent#joystick_id()
@@ -1 +1 @@
-Index of the joystick (in range [0 .. Joystick::Count - 1])
+Index of the joystick (in range `0 ... Joystick::Count`)
--- SF::Event::JoystickMoveEvent#position()
+++ SF::Event::JoystickMoveEvent#position()
@@ -1 +1 @@
-New position on the axis (in range [-100 .. 100])
+New position on the axis (in range `-100 .. 100`)
