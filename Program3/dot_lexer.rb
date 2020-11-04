
l_bracket_pattern = /([\[])/
r_bracket_pattern = /([\]])/
digraph_pattern = /(DIGRAPH|digraph)/
subgraph_pattern = /(SUBGRAPH|subgraph)/
comma_pattern = /(,)/
string_pattern = /(\"[\w\s]+\")/
int_pattern = /([0-9])/
arrow_pattern = /(\->)/
equals_pattern = /(=)/
l_curly_pattern = /(\{)/
r_curly_pattern = /(\})/
semi_colon_pattern = /(;)/
unwanted_characters = /([\s+,\t+,\n+,\r+])/

full_pattern = Regexp.union(l_bracket_pattern,
                             r_bracket_pattern,
                             digraph_pattern,
                             subgraph_pattern,
                             string_pattern,
                             comma_pattern,
                             int_pattern,
                             arrow_pattern,
                             equals_pattern,
                             l_curly_pattern,
                             r_curly_pattern,
                             semi_colon_pattern,
                             )

class DotLexer
  def initialize

  end
end
ls = []
input.split(split_pattern).each do |m|
  ls.push(m.gsub(unwanted_characters, ''))
end

puts ls.reject{ |n| n.empty?}