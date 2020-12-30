require "graphlb"
# OMG, is this really what's necessary?
require "graphlb/src/graphlb/algorithms/breadth_first_search.cr"

filename = "day7/input.txt"
#filename = "day7/input_example.txt"

d = File.read(filename)

containsGraph = DirectedGraph.new
# containedBy is just the transpose of contains, but will create it by hand anyway
# because the library seems to only allow traversing in the forward direction.
containedByGraph = DirectedGraph.new

d.each_line do |l|
  containerStr, containedStr = l.split(" bags contain ")
  
  containerNode   = find_or_create_node(containerStr, containsGraph)
  containerByNode = find_or_create_node(containerStr, containedByGraph)
  
  iter = containedStr.split(' ').each
  while ! (countStr = iter.next).is_a?(Iterator::Stop) # First comes the count, or "no"
    begin
      containedCount = countStr.to_i
      # Second comes the two word colour
      containedStr = iter.next.to_s + " " + iter.next.to_s
      # Add to / find in graph
      containedNode   = find_or_create_node(containedStr, containsGraph)
      containedByNode = find_or_create_node(containedStr, containedByGraph)
      # And create the relationship
      containsGraph.add_edge(containerNode, containedNode, containedCount.to_f)
      containedByGraph.add_edge(containedByNode, containerByNode, 1.0) # back the other way
    rescue
      #puts "no count"
      iter.next # "other"
    end

    iter.next # "bag,", "bags,", "bag." or "bags."
  end
end

# graphs are built, now traverse them.
bfs = Graphlb::Algorithms::BFS.new
node = containedByGraph.vertices.find { |n| n.name == "shiny gold" }
#node = containedByGraph.vertices.find { |n| n.name == "mirrored magenta" }
if node.nil?
  puts "No such bag."
else
  puts bfs.run(containedByGraph, node)
  puts bfs.run(containedByGraph, node).size - 1

  #node.edges.each { |n,weight| puts n.name + " " + weight.to_s }
end


def find_or_create_node(name : String, graph : DirectedGraph) : Node
  node = graph.vertices.find { |n| n.name == name }
  if ! node
    node = graph.add_vertex(name)
  end
  return node
end
