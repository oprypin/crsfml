#include <voidcsfml/window.h>
#include <SFML/Window.hpp>
using namespace sf;
void contextsettings_initialize_emSemSemSemSemSemSGZq(void* self, unsigned int depth, unsigned int stencil, unsigned int antialiasing, unsigned int major, unsigned int minor, unsigned int attributes, unsigned char s_rgb) {
    new(self) ContextSettings((unsigned int)depth, (unsigned int)stencil, (unsigned int)antialiasing, (unsigned int)major, (unsigned int)minor, (unsigned int)attributes, (bool)s_rgb);
}
void contextsettings_setdepthbits_emS(void* self, unsigned int depth_bits) {
    ((ContextSettings*)self)->depthBits = (unsigned int)depth_bits;
}
void contextsettings_setstencilbits_emS(void* self, unsigned int stencil_bits) {
    ((ContextSettings*)self)->stencilBits = (unsigned int)stencil_bits;
}
void contextsettings_setantialiasinglevel_emS(void* self, unsigned int antialiasing_level) {
    ((ContextSettings*)self)->antialiasingLevel = (unsigned int)antialiasing_level;
}
void contextsettings_setmajorversion_emS(void* self, unsigned int major_version) {
    ((ContextSettings*)self)->majorVersion = (unsigned int)major_version;
}
void contextsettings_setminorversion_emS(void* self, unsigned int minor_version) {
    ((ContextSettings*)self)->minorVersion = (unsigned int)minor_version;
}
void contextsettings_setattributeflags_saL(void* self, uint32_t attribute_flags) {
    ((ContextSettings*)self)->attributeFlags = (Uint32)attribute_flags;
}
void contextsettings_setsrgbcapable_GZq(void* self, unsigned char s_rgb_capable) {
    ((ContextSettings*)self)->sRgbCapable = (bool)s_rgb_capable;
}
void contextsettings_initialize_Fw4(void* self, void* copy) {
    new(self) ContextSettings(*(ContextSettings*)copy);
}
void context_initialize(void* self) {
    new(self) Context();
}
void context_finalize(void* self) {
    ((Context*)self)->~Context();
}
void context_setactive_GZq(void* self, unsigned char active, unsigned char* result) {
    *(bool*)result = ((Context*)self)->setActive((bool)active);
}
void context_getsettings(void* self, void* result) {
    *(ContextSettings*)result = ((Context*)self)->getSettings();
}
void context_isextensionavailable_Yy6(char* name, unsigned char* result) {
    *(bool*)result = Context::isExtensionAvailable(name);
}
void context_getactivecontext(void** result) {
    *(Context**)result = const_cast<Context*>(Context::getActiveContext());
}
void context_initialize_Fw4emSemS(void* self, void* settings, unsigned int width, unsigned int height) {
    new(self) Context(*(ContextSettings*)settings, (unsigned int)width, (unsigned int)height);
}
void joystick_identification_initialize(void* self) {
    new(self) Joystick::Identification();
}
void joystick_identification_getname(void* self, uint32_t** result) {
    static String str;
    str = ((Joystick::Identification*)self)->name;
    *result = const_cast<uint32_t*>(str.getData());
}
void joystick_identification_setname_Lnu(void* self, size_t name_size, uint32_t* name) {
    ((Joystick::Identification*)self)->name = String::fromUtf32(name, name+name_size);
}
void joystick_identification_getvendorid(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Joystick::Identification*)self)->vendorId;
}
void joystick_identification_setvendorid_emS(void* self, unsigned int vendor_id) {
    ((Joystick::Identification*)self)->vendorId = (unsigned int)vendor_id;
}
void joystick_identification_getproductid(void* self, unsigned int* result) {
    *(unsigned int*)result = ((Joystick::Identification*)self)->productId;
}
void joystick_identification_setproductid_emS(void* self, unsigned int product_id) {
    ((Joystick::Identification*)self)->productId = (unsigned int)product_id;
}
void joystick_identification_initialize_ISj(void* self, void* copy) {
    new(self) Joystick::Identification(*(Joystick::Identification*)copy);
}
void joystick_isconnected_emS(unsigned int joystick, unsigned char* result) {
    *(bool*)result = Joystick::isConnected((unsigned int)joystick);
}
void joystick_getbuttoncount_emS(unsigned int joystick, unsigned int* result) {
    *(unsigned int*)result = Joystick::getButtonCount((unsigned int)joystick);
}
void joystick_hasaxis_emSHdj(unsigned int joystick, int axis, unsigned char* result) {
    *(bool*)result = Joystick::hasAxis((unsigned int)joystick, (Joystick::Axis)axis);
}
void joystick_isbuttonpressed_emSemS(unsigned int joystick, unsigned int button, unsigned char* result) {
    *(bool*)result = Joystick::isButtonPressed((unsigned int)joystick, (unsigned int)button);
}
void joystick_getaxisposition_emSHdj(unsigned int joystick, int axis, float* result) {
    *(float*)result = Joystick::getAxisPosition((unsigned int)joystick, (Joystick::Axis)axis);
}
void joystick_getidentification_emS(unsigned int joystick, void* result) {
    *(Joystick::Identification*)result = Joystick::getIdentification((unsigned int)joystick);
}
void joystick_update() {
    Joystick::update();
}
void keyboard_iskeypressed_cKW(int key, unsigned char* result) {
    *(bool*)result = Keyboard::isKeyPressed((Keyboard::Key)key);
}
void keyboard_setvirtualkeyboardvisible_GZq(unsigned char visible) {
    Keyboard::setVirtualKeyboardVisible((bool)visible);
}
void mouse_isbuttonpressed_Zxg(int button, unsigned char* result) {
    *(bool*)result = Mouse::isButtonPressed((Mouse::Button)button);
}
void mouse_getposition(void* result) {
    *(Vector2i*)result = Mouse::getPosition();
}
void mouse_getposition_JRh(void* relative_to, void* result) {
    *(Vector2i*)result = Mouse::getPosition(*(Window*)relative_to);
}
void mouse_setposition_ufV(void* position) {
    Mouse::setPosition(*(Vector2i*)position);
}
void mouse_setposition_ufVJRh(void* position, void* relative_to) {
    Mouse::setPosition(*(Vector2i*)position, *(Window*)relative_to);
}
void sensor_isavailable_jRE(int sensor, unsigned char* result) {
    *(bool*)result = Sensor::isAvailable((Sensor::Type)sensor);
}
void sensor_setenabled_jREGZq(int sensor, unsigned char enabled) {
    Sensor::setEnabled((Sensor::Type)sensor, (bool)enabled);
}
void sensor_getvalue_jRE(int sensor, void* result) {
    *(Vector3f*)result = Sensor::getValue((Sensor::Type)sensor);
}
void event_sizeevent_initialize(void* self) {
    new(self) Event::SizeEvent();
}
void event_sizeevent_setwidth_emS(void* self, unsigned int width) {
    ((Event::SizeEvent*)self)->width = (unsigned int)width;
}
void event_sizeevent_setheight_emS(void* self, unsigned int height) {
    ((Event::SizeEvent*)self)->height = (unsigned int)height;
}
void event_sizeevent_initialize_isq(void* self, void* copy) {
    new(self) Event::SizeEvent(*(Event::SizeEvent*)copy);
}
void event_keyevent_initialize(void* self) {
    new(self) Event::KeyEvent();
}
void event_keyevent_setcode_cKW(void* self, int code) {
    ((Event::KeyEvent*)self)->code = (Keyboard::Key)code;
}
void event_keyevent_setalt_GZq(void* self, unsigned char alt) {
    ((Event::KeyEvent*)self)->alt = (bool)alt;
}
void event_keyevent_setcontrol_GZq(void* self, unsigned char control) {
    ((Event::KeyEvent*)self)->control = (bool)control;
}
void event_keyevent_setshift_GZq(void* self, unsigned char shift) {
    ((Event::KeyEvent*)self)->shift = (bool)shift;
}
void event_keyevent_setsystem_GZq(void* self, unsigned char system) {
    ((Event::KeyEvent*)self)->system = (bool)system;
}
void event_keyevent_initialize_wJ8(void* self, void* copy) {
    new(self) Event::KeyEvent(*(Event::KeyEvent*)copy);
}
void event_textevent_initialize(void* self) {
    new(self) Event::TextEvent();
}
void event_textevent_setunicode_saL(void* self, uint32_t unicode) {
    ((Event::TextEvent*)self)->unicode = (Uint32)unicode;
}
void event_textevent_initialize_uku(void* self, void* copy) {
    new(self) Event::TextEvent(*(Event::TextEvent*)copy);
}
void event_mousemoveevent_initialize(void* self) {
    new(self) Event::MouseMoveEvent();
}
void event_mousemoveevent_setx_2mh(void* self, int x) {
    ((Event::MouseMoveEvent*)self)->x = (int)x;
}
void event_mousemoveevent_sety_2mh(void* self, int y) {
    ((Event::MouseMoveEvent*)self)->y = (int)y;
}
void event_mousemoveevent_initialize_1i3(void* self, void* copy) {
    new(self) Event::MouseMoveEvent(*(Event::MouseMoveEvent*)copy);
}
void event_mousebuttonevent_initialize(void* self) {
    new(self) Event::MouseButtonEvent();
}
void event_mousebuttonevent_setbutton_Zxg(void* self, int button) {
    ((Event::MouseButtonEvent*)self)->button = (Mouse::Button)button;
}
void event_mousebuttonevent_setx_2mh(void* self, int x) {
    ((Event::MouseButtonEvent*)self)->x = (int)x;
}
void event_mousebuttonevent_sety_2mh(void* self, int y) {
    ((Event::MouseButtonEvent*)self)->y = (int)y;
}
void event_mousebuttonevent_initialize_Tjo(void* self, void* copy) {
    new(self) Event::MouseButtonEvent(*(Event::MouseButtonEvent*)copy);
}
void event_mousewheelevent_initialize(void* self) {
    new(self) Event::MouseWheelEvent();
}
void event_mousewheelevent_setdelta_2mh(void* self, int delta) {
    ((Event::MouseWheelEvent*)self)->delta = (int)delta;
}
void event_mousewheelevent_setx_2mh(void* self, int x) {
    ((Event::MouseWheelEvent*)self)->x = (int)x;
}
void event_mousewheelevent_sety_2mh(void* self, int y) {
    ((Event::MouseWheelEvent*)self)->y = (int)y;
}
void event_mousewheelevent_initialize_Wk7(void* self, void* copy) {
    new(self) Event::MouseWheelEvent(*(Event::MouseWheelEvent*)copy);
}
void event_mousewheelscrollevent_initialize(void* self) {
    new(self) Event::MouseWheelScrollEvent();
}
void event_mousewheelscrollevent_setwheel_yiC(void* self, int wheel) {
    ((Event::MouseWheelScrollEvent*)self)->wheel = (Mouse::Wheel)wheel;
}
void event_mousewheelscrollevent_setdelta_Bw9(void* self, float delta) {
    ((Event::MouseWheelScrollEvent*)self)->delta = (float)delta;
}
void event_mousewheelscrollevent_setx_2mh(void* self, int x) {
    ((Event::MouseWheelScrollEvent*)self)->x = (int)x;
}
void event_mousewheelscrollevent_sety_2mh(void* self, int y) {
    ((Event::MouseWheelScrollEvent*)self)->y = (int)y;
}
void event_mousewheelscrollevent_initialize_Am0(void* self, void* copy) {
    new(self) Event::MouseWheelScrollEvent(*(Event::MouseWheelScrollEvent*)copy);
}
void event_joystickconnectevent_initialize(void* self) {
    new(self) Event::JoystickConnectEvent();
}
void event_joystickconnectevent_setjoystickid_emS(void* self, unsigned int joystick_id) {
    ((Event::JoystickConnectEvent*)self)->joystickId = (unsigned int)joystick_id;
}
void event_joystickconnectevent_initialize_rYL(void* self, void* copy) {
    new(self) Event::JoystickConnectEvent(*(Event::JoystickConnectEvent*)copy);
}
void event_joystickmoveevent_initialize(void* self) {
    new(self) Event::JoystickMoveEvent();
}
void event_joystickmoveevent_setjoystickid_emS(void* self, unsigned int joystick_id) {
    ((Event::JoystickMoveEvent*)self)->joystickId = (unsigned int)joystick_id;
}
void event_joystickmoveevent_setaxis_Hdj(void* self, int axis) {
    ((Event::JoystickMoveEvent*)self)->axis = (Joystick::Axis)axis;
}
void event_joystickmoveevent_setposition_Bw9(void* self, float position) {
    ((Event::JoystickMoveEvent*)self)->position = (float)position;
}
void event_joystickmoveevent_initialize_S8f(void* self, void* copy) {
    new(self) Event::JoystickMoveEvent(*(Event::JoystickMoveEvent*)copy);
}
void event_joystickbuttonevent_initialize(void* self) {
    new(self) Event::JoystickButtonEvent();
}
void event_joystickbuttonevent_setjoystickid_emS(void* self, unsigned int joystick_id) {
    ((Event::JoystickButtonEvent*)self)->joystickId = (unsigned int)joystick_id;
}
void event_joystickbuttonevent_setbutton_emS(void* self, unsigned int button) {
    ((Event::JoystickButtonEvent*)self)->button = (unsigned int)button;
}
void event_joystickbuttonevent_initialize_V0a(void* self, void* copy) {
    new(self) Event::JoystickButtonEvent(*(Event::JoystickButtonEvent*)copy);
}
void event_touchevent_initialize(void* self) {
    new(self) Event::TouchEvent();
}
void event_touchevent_setfinger_emS(void* self, unsigned int finger) {
    ((Event::TouchEvent*)self)->finger = (unsigned int)finger;
}
void event_touchevent_setx_2mh(void* self, int x) {
    ((Event::TouchEvent*)self)->x = (int)x;
}
void event_touchevent_sety_2mh(void* self, int y) {
    ((Event::TouchEvent*)self)->y = (int)y;
}
void event_touchevent_initialize_1F1(void* self, void* copy) {
    new(self) Event::TouchEvent(*(Event::TouchEvent*)copy);
}
void event_sensorevent_initialize(void* self) {
    new(self) Event::SensorEvent();
}
void event_sensorevent_settype_jRE(void* self, int type) {
    ((Event::SensorEvent*)self)->type = (Sensor::Type)type;
}
void event_sensorevent_setx_Bw9(void* self, float x) {
    ((Event::SensorEvent*)self)->x = (float)x;
}
void event_sensorevent_sety_Bw9(void* self, float y) {
    ((Event::SensorEvent*)self)->y = (float)y;
}
void event_sensorevent_setz_Bw9(void* self, float z) {
    ((Event::SensorEvent*)self)->z = (float)z;
}
void event_sensorevent_initialize_0L9(void* self, void* copy) {
    new(self) Event::SensorEvent(*(Event::SensorEvent*)copy);
}
void touch_isdown_emS(unsigned int finger, unsigned char* result) {
    *(bool*)result = Touch::isDown((unsigned int)finger);
}
void touch_getposition_emS(unsigned int finger, void* result) {
    *(Vector2i*)result = Touch::getPosition((unsigned int)finger);
}
void touch_getposition_emSJRh(unsigned int finger, void* relative_to, void* result) {
    *(Vector2i*)result = Touch::getPosition((unsigned int)finger, *(Window*)relative_to);
}
void videomode_initialize(void* self) {
    new(self) VideoMode();
}
void videomode_initialize_emSemSemS(void* self, unsigned int width, unsigned int height, unsigned int bits_per_pixel) {
    new(self) VideoMode((unsigned int)width, (unsigned int)height, (unsigned int)bits_per_pixel);
}
void videomode_getdesktopmode(void* result) {
    *(VideoMode*)result = VideoMode::getDesktopMode();
}
void videomode_getfullscreenmodes(void** result, size_t* result_size) {
    static std::vector<VideoMode> objs;
    objs = const_cast<std::vector<VideoMode>&>(VideoMode::getFullscreenModes());
    *result_size = objs.size();
    *result = &objs[0];
}
void videomode_isvalid(void* self, unsigned char* result) {
    *(bool*)result = ((VideoMode*)self)->isValid();
}
void videomode_setwidth_emS(void* self, unsigned int width) {
    ((VideoMode*)self)->width = (unsigned int)width;
}
void videomode_setheight_emS(void* self, unsigned int height) {
    ((VideoMode*)self)->height = (unsigned int)height;
}
void videomode_setbitsperpixel_emS(void* self, unsigned int bits_per_pixel) {
    ((VideoMode*)self)->bitsPerPixel = (unsigned int)bits_per_pixel;
}
void operator_eq_asWasW(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator==(*(VideoMode*)left, *(VideoMode*)right);
}
void operator_ne_asWasW(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator!=(*(VideoMode*)left, *(VideoMode*)right);
}
void operator_lt_asWasW(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<(*(VideoMode*)left, *(VideoMode*)right);
}
void operator_gt_asWasW(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>(*(VideoMode*)left, *(VideoMode*)right);
}
void operator_le_asWasW(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator<=(*(VideoMode*)left, *(VideoMode*)right);
}
void operator_ge_asWasW(void* left, void* right, unsigned char* result) {
    *(bool*)result = operator>=(*(VideoMode*)left, *(VideoMode*)right);
}
void videomode_initialize_asW(void* self, void* copy) {
    new(self) VideoMode(*(VideoMode*)copy);
}
void window_initialize(void* self) {
    new(self) Window();
}
void window_initialize_wg0bQssaLFw4(void* self, void* mode, size_t title_size, uint32_t* title, uint32_t style, void* settings) {
    new(self) Window(*(VideoMode*)mode, String::fromUtf32(title, title+title_size), (Uint32)style, *(ContextSettings*)settings);
}
void window_initialize_rLQFw4(void* self, WindowHandle handle, void* settings) {
    new(self) Window((WindowHandle)handle, *(ContextSettings*)settings);
}
void window_finalize(void* self) {
    ((Window*)self)->~Window();
}
void window_create_wg0bQssaLFw4(void* self, void* mode, size_t title_size, uint32_t* title, uint32_t style, void* settings) {
    ((Window*)self)->create(*(VideoMode*)mode, String::fromUtf32(title, title+title_size), (Uint32)style, *(ContextSettings*)settings);
}
void window_create_rLQFw4(void* self, WindowHandle handle, void* settings) {
    ((Window*)self)->create((WindowHandle)handle, *(ContextSettings*)settings);
}
void window_close(void* self) {
    ((Window*)self)->close();
}
void window_isopen(void* self, unsigned char* result) {
    *(bool*)result = ((Window*)self)->isOpen();
}
void window_getsettings(void* self, void* result) {
    *(ContextSettings*)result = ((Window*)self)->getSettings();
}
void window_pollevent_YJW(void* self, void* event, unsigned char* result) {
    *(bool*)result = ((Window*)self)->pollEvent(*(Event*)event);
}
void window_waitevent_YJW(void* self, void* event, unsigned char* result) {
    *(bool*)result = ((Window*)self)->waitEvent(*(Event*)event);
}
void window_getposition(void* self, void* result) {
    *(Vector2i*)result = ((Window*)self)->getPosition();
}
void window_setposition_ufV(void* self, void* position) {
    ((Window*)self)->setPosition(*(Vector2i*)position);
}
void window_getsize(void* self, void* result) {
    *(Vector2u*)result = ((Window*)self)->getSize();
}
void window_setsize_DXO(void* self, void* size) {
    ((Window*)self)->setSize(*(Vector2u*)size);
}
void window_settitle_bQs(void* self, size_t title_size, uint32_t* title) {
    ((Window*)self)->setTitle(String::fromUtf32(title, title+title_size));
}
void window_seticon_emSemS843(void* self, unsigned int width, unsigned int height, uint8_t* pixels) {
    ((Window*)self)->setIcon((unsigned int)width, (unsigned int)height, (Uint8 const*)pixels);
}
void window_setvisible_GZq(void* self, unsigned char visible) {
    ((Window*)self)->setVisible((bool)visible);
}
void window_setverticalsyncenabled_GZq(void* self, unsigned char enabled) {
    ((Window*)self)->setVerticalSyncEnabled((bool)enabled);
}
void window_setmousecursorvisible_GZq(void* self, unsigned char visible) {
    ((Window*)self)->setMouseCursorVisible((bool)visible);
}
void window_setmousecursorgrabbed_GZq(void* self, unsigned char grabbed) {
    ((Window*)self)->setMouseCursorGrabbed((bool)grabbed);
}
void window_setkeyrepeatenabled_GZq(void* self, unsigned char enabled) {
    ((Window*)self)->setKeyRepeatEnabled((bool)enabled);
}
void window_setframeratelimit_emS(void* self, unsigned int limit) {
    ((Window*)self)->setFramerateLimit((unsigned int)limit);
}
void window_setjoystickthreshold_Bw9(void* self, float threshold) {
    ((Window*)self)->setJoystickThreshold((float)threshold);
}
void window_setactive_GZq(void* self, unsigned char active, unsigned char* result) {
    *(bool*)result = ((Window*)self)->setActive((bool)active);
}
void window_requestfocus(void* self) {
    ((Window*)self)->requestFocus();
}
void window_hasfocus(void* self, unsigned char* result) {
    *(bool*)result = ((Window*)self)->hasFocus();
}
void window_display(void* self) {
    ((Window*)self)->display();
}
void window_getsystemhandle(void* self, WindowHandle* result) {
    *(WindowHandle*)result = ((Window*)self)->getSystemHandle();
}
void sfml_window_version(int* major, int* minor, int* patch) {
    *major = SFML_VERSION_MAJOR;
    *minor = SFML_VERSION_MINOR;
    *patch = SFML_VERSION_PATCH;
}
