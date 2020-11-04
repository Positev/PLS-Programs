require_relative 'token'
class DotLexer


  @@regs = [ #https://regex101.com/ used heavily for this section for testing.
      /^[a-zA-Z0-9]*$/, #ID => 1
      /(^[0-9][0-9]?)/,                  #INT => 2
      /("[^"]*?")/,           #STRING => 3
      /(\{)/,                    #LCURLY => 4
      /(\})/,                    #RCURLY => 5
      /(;)/,                     #SEMI => 6
      /([\[])/,                  #LBRACK => 7
      /([\]])/,                  #RBRACK => 8
      /(\->)/,                   #ARROW => 9
      /(=)/,                     #EQUALS => 10
      /(DIGRAPH|digraph)/,       #DIGRAPH => 11
      /(SUBGRAPH|subgraph)/,     #SUBGRAPH => 12
      /(,)/,                     #COMMA => 13
      /(\s)/                       #WS => 14
  ]




  def initialize
    ins = []
    input = gets
    until input.nil?
      ins.push(input)
      input = gets
    end
    @in = ins.join()
    make_tokens
  end

  def make_tokens
    ls = []
    unwanted_characters = /([\s+,\t+,\n+,\r+])/
    @in.split(Regexp.union(@@regs[2,13])).each do |m|
      ls.push(m.gsub(unwanted_characters, ''))
    end
    texts = ls.reject{ |n| n.empty?}

    tokens = []
    texts.each do |text|
      tokens.push(make_token(text))
    end
    puts tokens
  end

  def make_token(token_text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      if (token_text.match(regex_pattern))
        return Token.new(token_text,  i + 1).to_s
        end
      end
    return handle_illegal_characters(token_text)
  end

  def is_token(text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      if text.match regex_pattern
        return true
      end
    end
    false
  end

  def get_token_type(text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      if text.match regex_pattern
        return i + 1
      end
    end
    false
  end


  def handle_illegal_characters(token_text)
    tokens = []
    last_invalid_char_index = 0
    (1...token_text.length + 1 ).each do |sub_index|
      sub_string =  token_text[last_invalid_char_index,sub_index]
      if !is_token(sub_string)
        valid_token = token_text[last_invalid_char_index,sub_index - 1]
        tokens.push(Token.new(valid_token, get_token_type(valid_token) ))
        tokens.push(Token.new(sub_string[sub_index-1], -1))
        last_invalid_char_index = sub_index
      end
    end
    last_token_text = token_text[last_invalid_char_index,token_text.length]
    if(is_token(last_token_text))
      tokens.push(Token.new(last_token_text, get_token_type(last_token_text)))
    end
    return tokens
    end


end
