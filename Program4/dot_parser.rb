require_relative 'lexical_unit_iterator'
require_relative 'token'
class DotParser
  def initialize(lexer)
    super()
    @iterator = LexicalUnitIterator.new(lexer) #pointers for next and current with sometimes needing prev?
    # no thx ill just make iterator :)
  end

  #graph -> ('digraph' | 'DIGRAPH') [id] '{' stmt_list '}'

  def graph
    init('digraph')
    restore_point = @iterator.current_index

    syntax_before_stmt_list_valid = [
      @iterator.current.type == Token::DIGRAPH,
      @iterator.next.type == Token::ID,
      @iterator.next.type == Token::LCURLY
    ]
    return fail(restore_point) unless syntax_before_stmt_list_valid.all?
    return fail(restore_point) unless stmt_list
    return fail(restore_point) unless @iterator.next.is(Token::RCURLY)


    pass('digraph')

  end

  #stmt_list -> {stmt [';']}
  def stmt_list

    loop do
      restore_point = init('cluster')

      return fail(restore_point) unless stmt and @iterator.current.is(Token::SEMI)

    end

    pass('cluster')
  end

  #stmt -> edge_stmt | id '=' id | subgraph
  def stmt

    restore_point = init('property')

    return pass('property') if edge_stmt
    return pass('property') if [
        @iterator.current.is(Token::ID),
        @iterator.next.is(Token::EQUALS),
        @iterator.next.is(Token::ID)
    ].all?
    return pass('property') if subgraph


    fail(restore_point)
  end

  #edge_stmt -> (id | subgraph) edge edgeRHS ['['attr_list']'] attr_list -> id ['=' id] {',' id ['=' id]}
  def edge_stmt

    restore_point = init('statement')

    return fail(restore_point) unless @iterator.current.is(Token::ID) or subgraph

    return fail(restore_point) unless edge

    return fail(restore_point) unless edgeRHS

    if @iterator.current.is(Token::LBRACK)
      return fail(restore_point) unless attr_list and @iterator.current.is(Token::RBRACK)
    end

    return fail(restore_point) unless [
        attr_list,
        @iterator.current.is(Token::ARROW),
        @iterator.next.is(Token::ID)
    ].all?

    return fail(restore_point) if @iterator.next.is(Token::EQUALS) and not @iterator.next.is(Token::ID)

    loop do
      break unless [@iterator.next.is(Token::COMMA), @iterator.next.is(Token::ID)].all?
      break if @iterator.next.is(Token::EQUALS) and not @iterator.next.is(Token::ID)
    end

    restore_point = @iterator.current_index
    fail(restore_point) unless

    pass('statement')
  end

  #edgeRHS -> (id | subgraph) {edge (id | subgraph)}
  def edgeRHS



    restore_point = init('')

    return fail(restore_point) unless @iterator.current.is(Token::ID) or subgraph

    pass('')
  end

  #edge -> '->' | '--'
  def edge
    restore_point = init('')

    pass('')
    end

  #subgraph -> ('subgraph' | 'SUBGRAPH') [id] '{' {stmt_list} '}' id -> ID | STRING | INT
  def subgraph
    restore_point = init('subgraph')

    pass('subgraph')
  end




  def fail(restore_point)
    @iterator.current_index = restore_point
    false
  end

  def is_vowel(word)
    ['a','e','i','o','u'].include? word[0].downcase
  end

  def pass(rule)

    if rule != ''
      indef_art =  is_vowel(rule) ? 'a' : 'an'
      puts "Finish recognizing #{indef_art} #{rule}"
    end
    @iterator.next
    true
  end

  def init(rule)
    if rule != ''
      indef_art =  is_vowel(rule) ? 'a' : 'an'
      puts "Start recognizing #{indef_art} #{rule}"
    end
    @iterator.current_index
  end

end

