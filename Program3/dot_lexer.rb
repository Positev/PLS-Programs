require_relative 'token'

# Author: Trevor Keegan
# Date: 11/6/2020
# The dot lexer will serve as a lexer for the dot language, Given an input of a file written in dot language, expect an
# output as a list of categorized lexical units.

class DotLexer
  @@regs = [ #https://regex101.com/ used heavily for this section for testing.
      /^[a-zA-Z0-9]*$/,          #ID => 1
      /(^[0-9][0-9]?)/,          #INT => 2
      /("[^"]*?")/,              #STRING => 3
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
      /(\s)/                     #WS => 14
  ]


  # Initialize the DotLexer class,
  # Read in all text from the stdin, parse the text and make a list of tokens.
  # Add an end of file token after finished reading the input.
  # Initialize the iterator value to zero
  def initialize
    @tokens = make_tokens(get_all_in_from_stdin)
    @tokens.push(Token.new('', Token::EOF))
    @cur_token = 0
  end

  # Get the next token that has been parsed.
  def next_token
    token = @tokens[@cur_token]
    @cur_token += 1
    token
  end

  # Read all text available in stdin and join it together into s single string
  # @return [String] with all text available in console, joined at line break
  def get_all_in_from_stdin
    ins = []
    input = gets
    until input.nil?
      ins.push(input)
      input = gets
    end
    ins.join()
  end

  # Take in a string of text, split it into a set of tokens and non-tokens using the union of the lower 12 regex
  # expressions in @@regs. This takes advantage of the decreasing match scope with each index in the list. After
  # spitting the text into possible tokens, check each token for invalid characters, and build the token object.
  # @param [String] all_text -> full input from stdin to be split and categorized into tokens
  def make_tokens(all_text)
    list_of_token_texts = []
    tokens = []
    unwanted_characters = /([\s+,\t+,\n+,\r+])/ # Characters that should be removed after splitting
    regexp_for_split = Regexp.union(@@regs[2,13])
    all_text.split(regexp_for_split).each do |text_segment|
      possible_token = text_segment.gsub(unwanted_characters, '')
      list_of_token_texts.push(possible_token)
    end
    list_of_token_texts = list_of_token_texts.reject{ |n| n.empty?}
    list_of_token_texts.each do |text|
      tokens.concat make_token(text)

    end
    tokens
  end

  # Build the token object if the text is a valid token, otherwire defer to handle_illegal_characters if something
  # is wrong with the text. return a list of tokens either way. Not uncommon to receive a list including a single token
  # but simpler to minimize the difference in output under varying conditions.
  def make_token(token_text)
    if is_token(token_text)
      [Token.new(token_text, get_token_type(token_text))]
    else
      handle_illegal_characters(token_text)
    end
  end

  # Recursively get all valid tokens and invalid tokens in the token text.
  # @param [String] token_text, text from the input that has not matched any categorization
  # @return [List<Token>] - All invalid and valid tokens available in the provided TOKEN_TEXT
  def handle_illegal_characters(token_text)
    return [] if token_text.length == 0

    return [Token.new(token_text, get_token_type(token_text))] if is_token(token_text)

    (0...token_text.length).each do |index_under_evaluation|
      sub_token = token_text[0, index_under_evaluation]
      next if is_token(sub_token)

      tokens = []
      valid_text = token_text[0, index_under_evaluation - 1]
      if valid_text.length > 0
        valid_token = Token.new(valid_text, get_token_type(valid_text))
        tokens.push(valid_token)
      end
      invalid_text = token_text[index_under_evaluation - 1]
      invalid_token = Token.new(invalid_text, Token::INVALID)
      tokens.push(invalid_token)
      remaining_tokens = handle_illegal_characters(token_text[index_under_evaluation..-1])
      return tokens.concat(remaining_tokens)
    end

    end

  # @param [String] text -> text that should be evaluated and categorized if applicable, true if text is valid token
  # @return [Boolean] True if TEXT is a valid token
  def is_token(text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      return true if text.match regex_pattern
    end
    false
  end

  # get the type of token that can categorize the input text, return false if text is not a token.
  def get_token_type(text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      return i + 1 if text.match regex_pattern
    end
    false
  end
end
