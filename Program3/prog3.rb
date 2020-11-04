# This is the main class for program3, which was provided by the instructor.
# The only modification is the commented out line used for input files when debugging.
# Author:: Joshua Yue

require_relative 'dot_lexer'

# Uncomment this line for debugging. Must place Prog3.in with desired input
# in the same folder as your ruby files.
$stdin.reopen('Prog3.in')

lexer = DotLexer.new

t = lexer.next_token

while Token.EOF != t.type
  puts t
  t = lexer.next_token
end

puts 'Lexical analysis is finished!'
