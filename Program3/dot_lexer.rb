
split_pattern = /[\s,\n,\t,\r]/
input = '
digraph trees {
  subgraph t {
    0 -> "1" [label = "A"];
    0 -> "2" [label = "B"];
  }
  SUBGRAPH u {
    Animal -> Ca#t [label = "feline"];
    Animal -> Dog1 [label = "canine"];
  }
}
'
ls = []
input.split(split_pattern).each do |m|
  if(m != '')
    ls.push(m)
  end
end
puts ls
