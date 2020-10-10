require_relative 'cf_grammer'
def newCFG

  cfg = CFGrammar.new

  rules = [
      'program -> statements',
      'statements -> singleStatement ;',
      'statements -> singleStatement ; statements',
      'singleStatement -> variable = expression',
      'expression -> term',
      'expression -> term + expression',
      'expression -> term - expression',
      'term -> factor',
      'term -> factor * term',
      'term -> factor / term',
      'factor -> variable',
      'factor -> const',
      'variable -> a',
  ]

  rules.each do |rule|
    cfg.read_rule(rule)
  end

  puts cfg.generate_sentences

  cfg
end

newCFG