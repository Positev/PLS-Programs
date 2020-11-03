
class Token
    attr_reader :name, :id, :pattern

    def initialize (name, id, pattern)
        super()
        @name = name
        @id = id
        @pattern = pattern
    end

    def fits(str)
        return @pattern.matches(str)
    end
end