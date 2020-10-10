class CFGrammar
  attr_accessor :hash_words
  def initialize
    @cfg_rules = Array.new
    @count_rules = 0
    @max_len = 0
    @hash_words = Hash.new
    @nonterminals = Array.new
  end

  def run
    @cfg_rules.each do |rule|
      read_rule(rule)
    end

    key_count = @hash_words.keys.length
    puts "There are #{key_count} nonterminal symbols."
    rule_count = @cfg_rules.length
    puts "There are #{rule_count} rules in the CFG that follows."
    puts
    puts @cfg_rules
    puts
    puts "Sentences of length #{@max_len} or less are:"
    puts
    puts generate_sentences
  end

  def generate_sentences
    sentences = []
    stack = []
    stack.push(@hash_words.values[0][0].join(' '))
    while stack.length.positive? #while stack not empty
      rule = stack.pop #pop element off stack
      next unless rule.split(' ').length <= @max_len && !rule.nil?

      sentences.push(rule) if is_sentence(rule)
      generate_rule_permeutations(rule).each do |perm|
        stack.push(perm)
      end
    end
    sentences
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

  def is_sentence(rule)
    split_rule = rule.split(' ')
    return false if split_rule == []

    split_rule.each do |rule| #identify the left most non-terminal
      if @hash_words.keys.include? rule
        return false
        break
      end
    end
    true
  end

  # read rule as string and produce all possible permeutations by replacing first non-terminal from left to right
  # input rule as string, right side of arrow
  # if no non-terminals, return input
  # if any non-terminals, generate all permeuttation by applying rules
  def generate_rule_permeutations(rule)
    replace_index = -1
    current_index = 0
    split_rule = rule.split(' ')
    split_rule.each do |rule| #identify the left most non-terminal
      if @hash_words.keys.include? rule
        replace_index = current_index
        break
      else
        current_index += 1
      end
    end
    generated_permutations = []
    if replace_index >= 0 #if a non-terminal has been found, replace

      replacements = @hash_words[split_rule[replace_index]]
      replacements.each do |replacement|
        rule_copy = split_rule.dup
        replace_one_with_many(replacement, rule_copy, replace_index)
        joined_rule = rule_copy.dup.join(' ')
        generated_permutations.push(joined_rule)
      end
    end
    generated_permutations
  end

  def replace_one_with_many(repl, existing, index)

    replacement_index = index
    repl.each do |element|
      if replacement_index == index
        existing[index] = element
      else
        existing.insert(replacement_index, element)
      end
      replacement_index += 1
    end
  end

  def read_rule(rule)
    arr = rule.split(' -> ')
    rule_name = arr[0]
    rule_value = arr[1].split(' ')
    @hash_words[rule_name] = [] unless @hash_words[arr[0]]
    @hash_words[rule_name].push(rule_value)
    [rule_name, rule_value]
  end

  def read_rules
    read_len = false
    while (line = gets)
      line.chomp!
      if line == ''
        read_len ? return : read_len = true
      else
        read_len ? @max_len = line.to_i : @cfg_rules.push(line)
        end
      end
    end
  end

