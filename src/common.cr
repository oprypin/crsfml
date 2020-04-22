require "./version"

module SF
  # Raised in shorthand class methods if initialization or resource loading fails
  class InitError < Exception
  end

  private module Util
    # Copy all constants from the namespace into the current namespace
    macro extract(from)
      {% for c in from.resolve.constants %}
        # :nodoc:
        {{c}} = {{from}}::{{c}}{% if c.id.ends_with? "Count" %}.value{% end %}
      {% end %}
    end
  end
end

lib SFMLExt
  {% if flag?(:windows) || flag?(:macosx) %}
    type WindowHandle = Void*
  {% else %}
    type WindowHandle = LibC::ULong
  {% end %}
end
