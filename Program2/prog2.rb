# This is the main class for program2, which was provided by the instructor.
# The only modification is the commented out line used for input files when
# debugging.

# Author:: Joshua Yue

require_relative 'cf_grammer.rb'
# Uncomment this line for debugging. Must place prog2.in with desired input
# in the same folder as context_free_grammar.rb.
#$stdin.reopen("prog2.in")


cfg = CFGrammar.new
cfg.read_rules
cfg.run