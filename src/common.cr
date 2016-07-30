require "./sizes"

# :nodoc:
macro _sf_ptr_self
  pointerof(@{{@type.instance_vars[0].id}}).as {{@type.id}}*
end

# :nodoc:
macro _sf_enum(from)
  {% for c in from.resolve.constants %}
    # :nodoc:
    {{c}} = {{from}}::{{c}}{% if c.id.ends_with? "Count" %}.value{% end %}
  {% end %}
end
