
class CFGrammar
  attr_accessor :hash_words
  def initialize
    @cfg_rules = Array.new
    @count_rules = 0
    @max_len = 6
    @hash_words = Hash.new
    @nonterminals = Array.new
  end

  def generate_sentences
    stack = []
    stack.push(@hash_words.values[0])
    while stack.length.positive? #while stack not empty
      rules = stack.pop #pop element off stack

      next unless rules.length <= @max_len #get length of words


      rules.each do |rule|

        non_term_index = index_of_left_most_nonterminal(rule)
        rule_copy = rule.dup
        if non_term_index >= 0 # found one nonterminal
          key = rule_copy[non_term_index]
          possible_replacements = @hash_words[key]
          possible_replacements.each do |replacement|
            replace_terminal(rule_copy, replacement, non_term_index)
            stack.push([rule_copy])
          end
        else
          puts rule_copy.join(' ')
        end
      end
    end
  end

  def index_of_left_most_nonterminal(rule)
    non_term_index = -1
    current_index = 0
    rule.each do |word| #loop to find the first nonterminal
    if @hash_words.keys.include? word
      non_term_index = current_index
      break
    else
      current_index += 1
    end
    end

    non_term_index
  end

  def replace_terminal(rule, replacement, index)

    replacing_index = index
    replacement.each do |word|
      if replacing_index == index
        rule[index] = word
      else
        rule.insert(replacing_index, word)
      end
      replacing_index += 1
    end

    rule
  end

  def read_rule(rule)
    @cfg_rules.push(rule)
    arr = rule.split(' -> ')
    rule_name = arr[0]
    rule_value = arr[1].split(' ')
    @hash_words[rule_name] = [] unless @hash_words[arr[0]]
    @hash_words[rule_name].push(rule_value)
    return rule_name, rule_value
  end

  def read_rules

    blank_lines = 0
    while (line = gets)
      line.chomp!
      if line == ''
        blank_lines += 1
      else
        puts read_rule(line)
      end
      break if blank_lines == 2
      end
  end
end


cfg = CFGrammar.new

rules = [
    "program -> statements",
    "statements -> singleStatement ;",
    "statements -> singleStatement ; statements",
    "singleStatement -> variable = expression",
    "expression -> term",
    "expression -> term + expression",
    "expression -> term - expression",
    "term -> factor",
    "term -> factor * term",
    "term -> factor / term",
    "factor -> variable",
    "factor -> const",
    "variable -> a",
]

rules.each do |rule|
  cfg.read_rule(rule)
end

puts cfg.replace_terminal(cfg.hash_words['program'], cfg.hash_words['statements'], 0)
