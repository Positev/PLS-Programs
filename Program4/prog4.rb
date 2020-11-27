# This is the main class for program4, which was provided by the instructor.
# Author:: Joshua Yue

require_relative "dot_lexer"
require_relative "dot_parser"

# Uncomment this line for debugging.
$stdin.reopen("Prog4.in")

lexer = DotLexer.new

parser = DotParser.new(lexer)

parser.graph()


