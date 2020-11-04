class Token


    def initialize (text, id)
        super()
        @text = text
        @id = id
    end

    def to_s()
        if @id != -1
            return "[#{@text}:#{@id}]"
        else
            return "illegal char: #{@text}"
        end
    end

end