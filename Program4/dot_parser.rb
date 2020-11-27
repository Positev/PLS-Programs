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
    puts "Start recognizing a digraph"
    token = @iterator.current

    syntax_before_stmt_list_valid = [
      token.type == Token::DIGRAPH,
      @iterator.next.type == Token::ID,
      @iterator.next.type == Token::LCURLY
    ]

    print syntax_before_stmt_list_valid

    if  syntax_before_stmt_list_valid.all?
      @iterator.next
      stmt_list
      if not @iterator.next.type == Token::RBRACK
        exit(-1)
      end

  else
    exit(-1)
    end
  end

  #stmt_list -> {stmt [';']}

  def stmt_list
    puts "Start recognizing a cluster"

    while (@iterator.peek_next.type != Token::RBRACK)
      stmt
      if @iterator.next != Token::SEMI
        exit(-1)
      end
    end

    puts "Finish recognizing a cluster"
  end

  #stmt -> edge_stmt | id '=' id | subgraph

  def stmt
    puts "Start recognizing a property"

    restore_point = @iterator.current_index
    if edge_stmt
      puts "Finish recognizing a property"
      return true
    else
      @iterator.current_index = restore_point
    end

    if @iterator.current.type == Token::ID and @iterator.next.type == Token::EQUALS and @iterator.next.type == Token::ID
      puts "Finish recognizing a property"
      return true
    else
      @iterator.current_index = restore_point
    end

    if subgraph
      puts "Finish recognizing a property"
      return true
    else
      @iterator.current_index = restore_point
    end

    false
  end

  #edge_stmt -> (id | subgraph) edge edgeRHS ['['attr_list']'] attr_list -> id ['=' id] {',' id ['=' id]}

  def edge_stmt
    puts "Start recognizing an edge statement"
    if @iterator.current.type == Token::ID

    elsif subgraph

    else exit(-1)

    end
    edge
    edgeRHS
    puts "Finish recognizing an edge statement"
    true
  end

  #edgeRHS -> (id | subgraph) {edge (id | subgraph)}

  def edgeRHS

  end

  #edge -> '->' | '--'

  def edge

    true
  end

  #subgraph -> ('subgraph' | 'SUBGRAPH') [id] '{' {stmt_list} '}' id -> ID | STRING | INT
  def subgraph
    puts "Start recognizing a subgraph"
    puts "Finish recognizing a subgraph"
    true
  end
end

