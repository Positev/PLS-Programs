class Token
    

    def initialize (text, id)
        super()
        @text = text
        @id = id
    end

    def to_s()
        "[#{@text}:#{@id}]"
    end

end