require_relative 'lexical_unit_iterator'
require_relative 'token'

$log = []


class DotParser
  def clear_log()
    $log = []
  end

  def get_log()
    $log.each do |m|
      puts m
    end
    return $log.join('\n')
  end

  def initialize(lexer)
    super()
    @iterator = LexicalUnitIterator.new(lexer)
    @restore_point = 0
    @log_save = []
  end

  def log (str)
    puts str
    $log.push(str.chomp)
  end

  #graph -> ('digraph' | 'DIGRAPH') [id] '{' stmt_list '}'

  def graph
    def parse
      accept Token::DIGRAPH
      begin
        drop_breadcrumb
        id
      rescue SyntaxError
        consume_breadcrumb
      end
      if should_accept(Token::LCURLY)
        accept Token::LCURLY
        stmt_list
        accept Token::RCURLY
      end
    end

    log "Start recognizing a digraph"
    output = parse
    log "Finish recognizing a digraph"
  end

  #stmt_list -> {stmt [';']}
  def stmt_list
    def parse
      loop do
        begin
          drop_breadcrumb
          stmt
          if should_accept Token::SEMI
            accept Token::SEMI
          end

          if should_accept Token::RCURLY
            return
          end
        rescue SyntaxError
          consume_breadcrumb
          return
        end

      end
    end

    log "Start recognizing a cluster"
    output = parse
    log "Finish recognizing a cluster"
  end

  #stmt -> edge_stmt | id '=' id | subgraph
  def stmt
    def parse

      drop_breadcrumb
      begin id
        #edge or property
        if should_accept Token::EQUALS
          consume_breadcrumb
          property
          return
        else
          consume_breadcrumb
          edge_stmt
          return
        end
      rescue SyntaxError
        if should_accept Token::SUBGRAPH
          #edge or subgraph
          @iterator.next
          hasID = false
          begin
            id
            hasID = true
          rescue
            end
            if hasID and should_accept Token::LCURLY
              consume_breadcrumb
              subgraph
              return
            else
              consume_breadcrumb
              edge_stmt
              return
            end
          end
      end

      error('')
    end

    puts "Enter Stmt"
    parse
    puts "Exit Stmt"
  end

  # id = id
  def property
    def parse
      id
      accept Token::EQUALS
      id
    end

    log "Start recognizing a property"
    output = parse
    log "Finish recognizing a property"
  end

  #edge_stmt -> (id | subgraph) edge edgeRHS ['['attr_list']']
  def edge_stmt
    def parse

      id_or_subgraph
      edge
      edgeRHS
      if should_accept Token::LBRACK
        accept Token::LBRACK
        attr_list
        accept Token::RBRACK
      end
    end

    log "Start recognizing an edge statement"
    output = parse
    log "Finish recognizing an edge statement"
  end


  #attr_list -> id ['=' id] {',' id ['=' id]}
  def attr_list
    def parse
      id

      if should_accept Token::EQUALS
        @iterator.prev
        property
      end

      while should_accept Token::COMMA

        begin
          drop_breadcrumb
          accept Token::COMMA
          id

          if should_accept Token::EQUALS
            @iterator.prev
            property
          end
          if should_accept Token::RBRACK
            return
          end
        rescue SyntaxError
          consume_breadcrumb
          return
        end
      end
    end
    parse
  end

  #edgeRHS -> (id | subgraph) {edge (id | subgraph)}
  def edgeRHS
    def parse
    id_or_subgraph
    loop do
      begin
        drop_breadcrumb
        edge
        id_or_subgraph
      rescue SyntaxError
        consume_breadcrumb
        return
      end
    end
    end

    puts "Enter EDGE RHS"
    parse
    puts "Exit EDGE RHS"
  end

  #edge -> '->' | '--'
  def edge
    puts "Enter Edge "
    accept(Token::ARROW)
    puts "Exit Edge "
  end

  #subgraph -> ('subgraph' | 'SUBGRAPH') [id] '{' {stmt_list} '}'
  def subgraph
    def parse
      accept Token::SUBGRAPH
      begin
        drop_breadcrumb
        id
      rescue SyntaxError
        consume_breadcrumb
      end
      accept Token::LCURLY
      loop do
        begin
          drop_breadcrumb
          stmt_list
          if should_accept Token::RCURLY
            break
          end
        rescue SyntaxError
          consume_breadcrumb
        end
      end
      accept Token::RCURLY
      return true
    end

    log "Start recognizing a subgraph"
    output = parse
    log "Finish recognizing a subgraph"
  end

  #id -> ID | STRING | INT
  def id
    accepted = [Token::ID, Token::STRING, Token::INT]
    accepted.each do |type|
      if should_accept(type)
        lex
        return

      end
    end
    error("Expecting Id String or Int but found #{@iterator.peek_next.text}")

  end


  def id_or_subgraph
    either = false
    begin
      drop_breadcrumb
      id
      either = true
    rescue SyntaxError
      consume_breadcrumb
    end

    if not either
      begin
        drop_breadcrumb
        subgraph
        either = true
      rescue SyntaxError
        consume_breadcrumb
      end
    end

    return either
  end

  def allowed_to_fail
    begin
      drop_breadcrumb
      yield
    rescue  SyntaxError
      consume_breadcrumb
    end
    z
  end

  def error(msg)
    puts msg
    raise SyntaxError
  end

  def consume_breadcrumb
    puts("Consuming breadcrumb #{@restore_point}")
    @iterator.current_index = @restore_point
    $log = @log_save.map(&:clone)
  end

  def drop_breadcrumb
    puts("Dropping breadcrumb #{ @iterator.current_index}")
    @restore_point = @iterator.current_index
    @log_save = $log.map(&:clone)
  end

  def accept(type)
    if should_accept(type)

      lex
    else
      error "Error parsing #{@iterator.peek_next}, Expecting #{type}"
    end
  end

  def should_accept(type)
    return @iterator.peek_next.is(type)
  end

  def lex()
    @iterator.next
    #puts "Next #{@iterator.current}"
  end


end

