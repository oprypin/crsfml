require "./lib"

module SF
  # A low-level window handle type, specific to each platform.
  alias WindowHandle = VoidCSFML::WindowHandle
end

require "./obj"

module SF
  enum Keyboard::Key
    # Same as `Enum#parse?` but with a workaround to skip duplicate names
    def self.parse?(string) : self?
      {% begin %}
        {% seen = [] of StringLiteral %}
        case string.camelcase.downcase
        {% for member in @type.constants %}
          {% member_snake = member.stringify.camelcase.downcase %}
          {% if !seen.includes? member_snake %}
            when {{member_snake}}
              {{@type}}::{{member}}
            {% seen << member_snake %}
          {% end %}
        {% end %}
        end
      {% end %}
    end
  end
end
