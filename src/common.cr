require "./sizes"

module SF
  VERSION = "2.4.2"
  SFML_VERSION = "2.4.0"

  # Raised in shorthand class methods if initialization or resource loading fails
  class InitError < Exception
  end
end

# :nodoc:
macro _sf_enum(from)
  {% for c in from.resolve.constants %}
    # :nodoc:
    {{c}} = {{from}}::{{c}}{% if c.id.ends_with? "Count" %}.value{% end %}
  {% end %}
end
