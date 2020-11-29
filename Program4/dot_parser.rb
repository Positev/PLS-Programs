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

    restore_point = init('cluster')
    loop do


      if stmt and @iterator.current.is(Token::SEMI)
        pass('cluster')
      else
        return fail(restore_point)
      end

    end
    @iterator.next
    pass('cluster')
  end

  #stmt -> edge_stmt | id '=' id | subgraph
  def stmt
    passes = []
    restore_point = init('property')

    is_assignment = [
        @iterator.next.is(Token::ID),
        @iterator.next.is(Token::EQUALS),
        @iterator.next.is(Token::ID)
    ]
    if is_assignment.all?
      passes.push pass('property')
    else
      fail(restore_point)
    end

     passes.push pass('property') if subgraph
     passes.push pass('property') if edge_stmt

    unless passes.any?
      fail(restore_point)
    else
      true
    end
  end

  #edge_stmt -> (id | subgraph) edge edgeRHS ['['attr_list']']

  def edge_stmt

    restore_point = init('edge statement')

    if @iterator.peek_next.is(Token::ID)
      @iterator.next
    elsif subgraph
      @iterator.next
    else return fail(restore_point)
    end

     unless edge
       return fail(restore_point)
     end

    unless edgeRHS
      return fail(restore_point)
    end

    if @iterator.current.is(Token::LBRACK)
      unless attr_list and @iterator.current.is(Token::RBRACK)
        return fail(restore_point)
      end
    end


    pass('edge statement')
  end


  #attr_list -> id ['=' id] {',' id ['=' id]}
  def attr_list
    restore_point = init('')

    return fail(restore_point) if not @iterator.next.is(Token::ID)
    return fail(restore_point) if @iterator.next.is(Token::EQUALS) and not @iterator.next.is(Token::ID)

    loop do
      unless [@iterator.next.is(Token::COMMA), @iterator.next.is(Token::ID)].all?
        break
      end
      if @iterator.next.is(Token::EQUALS) and not @iterator.next.is(Token::ID)
        break
      end
    end

    pass('')
  end

  #edgeRHS -> (id | subgraph) {edge (id | subgraph)}
  def edgeRHS



    restore_point = init('')

    unless subgraph or @iterator.current.is(Token::ID)
      return fail(restore_point)
    end

    loop do
      temp_restore_point = @iterator.current_index
      unless edge and (subgraph or @iterator.current.is(Token::ID) )
        fail(temp_restore_point)
        break
      end
    end

    pass('')
  end

  #edge -> '->' | '--'
  def edge
    restore_point = init('')

    return fail(restore_point) unless @iterator.current.is(Token::ARROW)

    pass('')
    end

  #subgraph -> ('subgraph' | 'SUBGRAPH') [id] '{' {stmt_list} '}' id -> ID | STRING | INT
  def subgraph
    restore_point = init('subgraph')

    unless @iterator.next.is(Token::SUBGRAPH)
      return fail(restore_point)
    end
    if @iterator.peek_next.is(Token::ID)
      @iterator.next
    else
      return fail(restore_point)
    end
    unless @iterator.next.is(Token::LCURLY)
      return fail(restore_point)
    end
    loop do
      temp_restore_point = @iterator.current_index
      unless stmt_list
        break
      end
    end

    unless @iterator.next.is(Token::RCURLY)
      return fail(restore_point)
    end
    unless @iterator.next.is(Token::ID)
      return fail(restore_point)
    end
    unless @iterator.next.is(Token::ARROW)
      return fail(restore_point)
    end


    return fail(restore_point) unless [
        @iterator.peek_next.is(Token::ID),
        @iterator.peek_next.is(Token::STRING),
        @iterator.peek_next.is(Token::INT),
    ].any?
    @iterator.next

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
      indef_art =  is_vowel(rule) ? 'an' : 'a'
      puts "Finish recognizing #{indef_art} #{rule}"
    end
    @iterator.next
    true
  end

  def init(rule)
    if rule != ''
      indef_art =  is_vowel(rule) ? 'an' : 'a'
      puts "Start recognizing #{indef_art} #{rule}"
    end
    @iterator.current_index
  end

end

