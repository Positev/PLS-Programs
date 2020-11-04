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
    @tokens = make_tokens(get_all_in_from_stdin)
    @tokens.push(Token.new('', -2))
    @cur_token = 0
  end

  def next_token
    token = @tokens[@cur_token]
    @cur_token = @cur_token + 1
    return token
  end

  def get_all_in_from_stdin
    ins = []
    input = gets
    until input.nil?
      ins.push(input)
      input = gets
    end
    return ins.join()
  end

  def make_tokens(all_text)
    list_of_token_texts = []
    tokens = []
    unwanted_characters = /([\s+,\t+,\n+,\r+])/
    regexp_for_split = Regexp.union(@@regs[2,13])
    all_text.split(regexp_for_split).each do |text_segment|
      possible_token = text_segment.gsub(unwanted_characters, '')
      list_of_token_texts.push(possible_token)
    end
    list_of_token_texts = list_of_token_texts.reject{ |n| n.empty?}
    list_of_token_texts.each do |text|
      make_token(text).each do |token|
        tokens.push(token)
      end
    end
    return tokens
  end

  def make_token(token_text)
    if is_token(token_text)
      return [Token.new(token_text, get_token_type(token_text))]
    else
      return handle_illegal_characters(token_text)
    end
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
end
