require_relative 'token'
class DotLexer


  @@regs = [
      /^[a-zA-Z]([a-zA-Z0-9])?/, #ID => 1
      /^[0-9][0-9]?/,                  #INT => 2
      /(\".\")/,           #STRING => 3
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
      /\s/                       #WS => 14
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

    texts.each do |text|
      make_token(text)
    end
  end

  def make_token(token_text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      if (token_text.match(regex_pattern))
        puts(Token.new(token_text,  i+1).to_s)
        return
      end

    end
  end
end
