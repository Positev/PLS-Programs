require_relative 'cf_grammer'
require 'test/unit'

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

  cfg.generate_sentences

  cfg
end

class CF_Grammar_testing < Test::Unit::TestCase

  def test_generate_rule_permeutations
    cfg = newCFG
    rule = 'variable = expression'
    out = cfg.generate_rule_permeutations(rule)
    assert_equal(out, ['a = expression'])
  end

  def test_generate_rule_permeutations2
    cfg = newCFG
    rule = 'term'
    out = cfg.generate_rule_permeutations(rule)
    puts out
    assert_equal(out, ["factor","factor * term","factor / term"])
  end

  def test_generate_rule_permeutations3
    cfg = newCFG
    rule = 'statements'
    out = cfg.generate_rule_permeutations(rule)
    puts out
    assert_equal(out, ["singleStatement ;","singleStatement ; statements"])
  end
end