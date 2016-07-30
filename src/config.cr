lib VoidCSFML
  {% if flag?(:windows) || flag?(:macosx) %}
    type WindowHandle = Void*
  {% else %}
    type WindowHandle = LibC::ULong
  {% end %}

  alias GlFunctionPointer = ->

  {% if flag?(:windows) %}
    type SocketHandle = LibC::UInt*
  {% else %}
    type SocketHandle = LibC::Int
  {% end %}

  PATH = File.expand_path(__DIR__)
end
