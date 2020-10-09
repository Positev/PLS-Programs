#Document this file as described here and in the syllabus.
class CFGrammar
  def initialize
    @cfg_rules = Array.new
    @count_rules = 0
    @max_len = 0
    @hash_words = Hash.new
    @nonterminals = Array.new
  end
  # read in rules and the last 2 lines
  # and chomp off the newline character. Check out method chomp
  def read_rules

    blank_lines = 0
    while line = gets do

      line.chomp!()
      puts blank_lines
      if blank_lines == ''
        blank_lines += 1
      else
        puts line
      end

      arr = line.split(' -> ') #Split by arrow. Expect list of size 2. 0th is key, 1st is value
      if not @hash_words[arr[0]]
        @hash_words[arr[0]] = []
      end
      @hash_words[arr[0]].push(arr[1])


      end
    puts @hash_words

    end
    # put last value of @cfg_rules into @max_len and
    # remove last two elements of @cfg_rules
end # read_rules


CFGrammar.new().read_rules()