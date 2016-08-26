lib VoidCSFML
  {% if flag?(:windows) || flag?(:macosx) %}
    type WindowHandle = Void*
  {% else %}
    type WindowHandle = LibC::ULong
  {% end %}
end
