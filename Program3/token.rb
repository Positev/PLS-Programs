
class Token

  attr_accessor :type
    @@EOF = -2
    @@INVALID = -1

    def initialize (text, id)
        super()
        @text = text
        @type = id
    end

    def to_s()
        if @type != -1
            return "[#{@text}:#{@type}]"
        else
            return "illegal char: #{@text}"
        end
    end

end