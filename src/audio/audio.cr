require "./obj"

module SF
  class Music
    struct Span(T)
      # The beginning offset of the time range
      property offset : T
      # The length of the time range
      property length : T

      def initialize(@offset = T.zero, @length = T.zero)
      end

      # :nodoc:
      def to_unsafe()
        pointerof(@offset).as(Void*)
      end
    end

    alias TimeSpan = Span(Time)
  end
end
