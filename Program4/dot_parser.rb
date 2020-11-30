require_relative 'lexical_unit_iterator'
require_relative 'token'

$log = []


class DotParser
  def clear_log()
    $log = []
  end

  def get_log()
    puts $log.join('\n')
    return $log.join('\n')
  end

  def initialize(lexer)
    super()
    @iterator = LexicalUnitIterator.new(lexer)
  end

  def log (str)
    $log.push(str.chomp)
  end

  #graph -> ('digraph' | 'DIGRAPH') [id] '{' stmt_list '}'

  def graph
    init('digraph')

    if @iterator.current.is(Token::DIGRAPH)
      @iterator.next
    else

      fail_and_exit("Expected digraph but found #{@iterator.current.text}")

    end

    if id(true)
      @iterator.next
    end

    if @iterator.peek_next.is(Token::LCURLY)
      @iterator.next
    else
      fail_and_exit("Expected { but found #{@iterator.current.text}")
    end

    stmt_list

    if @iterator.peek_next.is(Token::RCURLY)
      @iterator.next
    else
      fail_and_exit("Expected } but found #{@iterator.current.text}")
    end

    pass('digraph')
  end

  #stmt_list -> {stmt [';']}
  def stmt_list
    restore_point = init('cluster')

    while true
      if stmt
        if (@iterator.current.is(Token::SEMI))
          @iterator.next
        else
          fail_and_exit("Expected ; but found #{@iterator.current.text}")
        end
      else
        break
      end
    end

    pass('cluster')
  end

  #stmt -> edge_stmt | id '=' id | subgraph
  def stmt

    if id and property
    elsif edge_stmt
      return true
    elsif @iterator.peek_next.is(Token::SUBGRAPH)
      if subgraph
        return true
      end
    else
      fail_and_exit('')
    end
  end


  def property
    if id
      init('property')
      if (@iterator.next.is(Token::EQUALS))
        @iterator.next
        if id
          pass('property')
          return true
        else
          fail_and_exit("Expected ID but found #{@iterator.current.text}")
        end
      else
        return false
      end
    else
      return false
      end

    return true
    end

    #edge_stmt -> (id | subgraph) edge edgeRHS ['['attr_list']']

  def possibly_edge_stmt
      if id
      elsif @iterator.current.is(Token::SUBGRAPH)
      else
        return false
      end
      true
  end

    def edge_stmt

      if id(true)
        @iterator.next
        init('edge statement')
      elsif @iterator.peek_next.is(Token::SUBGRAPH)
        init('edge statement')
        subgraph
      else
        return false
      end

      edge
      edgeRHS

      if @iterator.current.is(Token::LBRACK)
        @iterator.next
        attr_list
        if not @iterator.current.is(Token::RBRACK)
          fail_and_exit("Expected ] but found #{@iterator.current.text}")
        end
      end

      pass('edge statement')
    end


    #attr_list -> id ['=' id] {',' id ['=' id]}
    def attr_list
      restore_point = init('')

      if id and @iterator.peek_next.is(Token::EQUALS)

        stmt
      elsif id
        @iterator.next
      end


      while @iterator.peek_next.is(Token::COMMA)

        if id and @iterator.peek_next.is(Token::EQUALS)
          stmt
        elsif id
          @iterator.next
        else
          fail_and_exit("msg 157")
        end

      end

      true
    end

    #edgeRHS -> (id | subgraph) {edge (id | subgraph)}
    def edgeRHS
      restore_point = init('')

      if id(true)
        @iterator.next
      elsif @iterator.peek_next.is(Token::SUBGRAPH)
        subgraph
      else
        fail_and_exit("")
      end

      while @iterator.peek_next.is(Token::ARROW)
        edge

        if id(true)
          @iterator.next
        elsif @iterator.peek_next.is(Token::SUBGRAPH)
          subgraph
        else
          fail_and_exit("")
        end

      end

      true
    end

    #edge -> '->' | '--'
    def edge
      restore_point = init('')

      if not @iterator.current.is(Token::ARROW)
        fail_and_exit("Expected -> but got #{@iterator.peek_next.text}")
      end

      pass('')
    end

    #subgraph -> ('subgraph' | 'SUBGRAPH') [id] '{' {stmt_list} '}'
    def subgraph
      restore_point = init('subgraph')

      if @iterator.peek_next.is(Token::SUBGRAPH)
        @iterator.next
      else
        fail_and_exit("Expected subgraph but found #{@iterator.current.text}")
      end

      if id(true)
        @iterator.next
      end

      if @iterator.peek_next.is(Token::LCURLY)
        @iterator.next
      else
        fail_and_exit("Expected { but found #{@iterator.current.text}")
      end

      stmt_list

      if @iterator.peek_next.is(Token::RCURLY)
        @iterator.next
      else
        fail_and_exit("Expected } but found #{@iterator.current.text}")
      end


      pass('subgraph')
    end

    #id -> ID | STRING | INT
    def id(soft = false)
      if @iterator.current.is(Token::ID)
      elsif @iterator.current.is(Token::STRING)
      elsif @iterator.current.is(Token::INT)
      else
        if soft
          return false
        else
          fail_and_exit('')
        end
      end
      true
    end

    def fail_and_exit(msg)
      log msg
      exit()
    end

    def fail_and_restore(restore_point)
      @iterator.current_index = restore_point
      false
    end

    def is_vowel(word)
      ['a', 'e', 'i', 'o', 'u'].include? word[0].downcase
    end

    def pass(rule)

      if rule != ''
        indef_art = is_vowel(rule) ? 'an' : 'a'
        log "Finish recognizing #{indef_art} #{rule}"
      end
      @iterator.next
      true
    end

    def init(rule)
      if rule != ''
        indef_art = is_vowel(rule) ? 'an' : 'a'
        log "Start recognizing #{indef_art} #{rule}"
      end
      @iterator.current_index
    end

  end

