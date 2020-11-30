require 'minitest/autorun'

require_relative '../dot_lexer'
require_relative '../dot_parser'
class DotParserTest < MiniTest::Test
  def test_digraph

    expected_out = [
'Start recognizing a digraph',
'Start recognizing a cluster',
'Start recognizing a property',
'Finish recognizing a property',
'Start recognizing a subgraph',
'Start recognizing a cluster',
'Start recognizing an edge statement',
'Start recognizing a property',
'Finish recognizing a property',
'Finish recognizing an edge statement',
'Start recognizing an edge statement',
'Start recognizing a property',
'Finish recognizing a property',
'Finish recognizing an edge statement',
'Finish recognizing a cluster',
'Finish recognizing a subgraph',
'Start recognizing a subgraph',
'Start recognizing a cluster',
'Start recognizing an edge statement',
'Start recognizing a property',
'Finish recognizing a property',
'Start recognizing a property',
'Finish recognizing a property',
'Finish recognizing an edge statement',
'Start recognizing an edge statement',
'Start recognizing a property',
'Finish recognizing a property',
'Finish recognizing an edge statement',
'Finish recognizing a cluster',
'Finish recognizing a subgraph',
'Finish recognizing a cluster',
'Finish recognizing a digraph']

    input = 'digraph trees {
  rankdir=LR;
  subgraph t {
    0 -> "1" [label = "A"];
    0 -> "2" [label = "B"];
  }
  SUBGRAPH u {
    Animal -> Cat [label = "feline", shape="record"];
    Animal -> Dog1 [label = "canine"];
  }
}'
    lexer = DotLexer.new(input)

    parser = DotParser.new(lexer)

    parser.clear_log()

    begin
      parser.graph()
    rescue SystemExit
      end

    out = parser.get_log
    assert_equal( expected_out.join('\n'), out)

  end

  def test_property

    expected_out = ['Start recognizing a property','Finish recognizing a property']

    input = 'rankdir=LR;'
    lexer = DotLexer.new(input)

    parser = DotParser.new(lexer)
    parser.clear_log()

    begin
      parser.stmt()
    rescue SystemExit
    end
    out = parser.get_log
    assert_equal(expected_out.join('\n'), out )

  end

  def test_subgraph

    expected_out = [
        'Start recognizing a subgraph',
        'Start recognizing a cluster',
        'Start recognizing an edge statement',
        'Start recognizing a property',
        'Finish recognizing a property',
        'Finish recognizing an edge statement',
        'Start recognizing an edge statement',
        'Start recognizing a property',
        'Finish recognizing a property',
        'Finish recognizing an edge statement',
        'Finish recognizing a cluster',
        'Finish recognizing a subgraph',]

    input = '
  subgraph t {
    0 -> "1" [label = "A"];
    0 -> "2" [label = "B"];
  }'
    lexer = DotLexer.new(input)

    parser = DotParser.new(lexer)

    parser.clear_log()

    begin
      parser.subgraph()
    rescue SystemExit
    end

    out = parser.get_log
    assert_equal(out, expected_out.join('\n'))

  end

    def test_cluster
    expected_out = ['Start recognizing a cluster',
                    'Start recognizing an edge statement',
                    'Start recognizing a property',
                    'Finish recognizing a property',
                    'Finish recognizing an edge statement',
                    'Start recognizing an edge statement',
                    'Start recognizing a property',
                    'Finish recognizing a property',
                    'Finish recognizing an edge statement',
                    'Finish recognizing a cluster']

    input = '
    0 -> "1" [label = "A"];
    0 -> "2" [label = "B"];
  '
    lexer = DotLexer.new(input)

    parser = DotParser.new(lexer)

    parser.clear_log()




  begin
    parser.stmt_list()
  rescue SystemExit
  end
    assert_equal( expected_out.join('\n'),parser.get_log)
  end

  def test_edge_stmt
    expected_out = [
                    'Start recognizing an edge statement',
                    'Start recognizing a property',
                    'Finish recognizing a property',
                    'Finish recognizing an edge statement',]

    input = '0 -> "1" [label = "A"];'
    lexer = DotLexer.new(input)

    parser = DotParser.new(lexer)

    parser.clear_log()



    begin
      parser.edge_stmt()
    rescue SystemExit
    end
    assert_equal(parser.get_log, expected_out.join('\n'))
  end

  def test_ideqid
    expected_out = ['Start recognizing a property',
                    'Finish recognizing a property',]

    input = '
    label = "A"
  '
    lexer = DotLexer.new(input)

    parser = DotParser.new(lexer)

    parser.clear_log()



    begin
      parser.property()
    rescue SystemExit
    end

    puts parser.get_log
    puts expected_out.join('\n')
    assert_equal(parser.get_log, expected_out.join('\n'))
  end

  def test_cluster_1
    expected_out = ['Start recognizing a cluster',
                    'Start recognizing an edge statement',
                    'Start recognizing a property',
                    'Finish recognizing a property',
                    'Finish recognizing an edge statement',
                    'Start recognizing an edge statement',
                    'Start recognizing a property',
                    'Finish recognizing a property',
                    'Finish recognizing an edge statement',
                    'Finish recognizing a cluster']

    input = '
    0 -> "1" [label = "A"];
    0 -> "2" [label = "B"];
  '
    lexer = DotLexer.new(input)

    parser = DotParser.new(lexer)

    parser.clear_log()



    begin
      parser.stmt_list()
    rescue SystemExit
    end
    assert_equal(parser.get_log, expected_out.join('\n'))
  end

end

