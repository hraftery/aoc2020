require "graphlb"
# OMG, is this really what's necessary?
require "graphlb/src/graphlb/algorithms/breadth_first_search.cr"

filename = "day7/input.txt"
#filename = "day7/input_example.txt"
#filename = "day7/input_example2.txt"

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
node = containsGraph.vertices.find { |n| n.name == "shiny gold" }
#node = containedByGraph.vertices.find { |n| n.name == "mirrored magenta" }
if node.nil?
  puts "No such bag."
else
  puts sum_tree(containsGraph, node)
  #puts prev[containsGraph.vertices.find { |n| n.name == "dark olive" }]
  #puts bfs.run(containsGraph, node)
  #puts bfs.run(containsGraph, node).size - 1

  #node.edges.each { |n,weight| puts n.name + " " + weight.to_s }
end


def find_or_create_node(name : String, graph : DirectedGraph) : Node
  node = graph.vertices.find { |n| n.name == name }
  if ! node
    node = graph.add_vertex(name)
  end
  return node
end


def sum_tree(graph, source)
  vertex_set = [] of Node
  vertices = graph.get_vertices
  prev = {} of Node => Node | Nil
  i = 0
  size = vertices.size
  while i < size
    prev[vertices[i]] = nil
    vertex_set << vertices[i]
    i = i + 1
  end
  treeRoot = TreeNode.new(source.name)
  treeNode = nil
  visitedQueue = Stack(String).new
  queue = Stack(Tuple(Node,Float64,Int32)).new
  branchCounts = [] of Float64
  branchSum = -1.0 # don't include the source
  queue.push({source, 1.0, 0})
  while !queue.empty?
    vertexTuple = queue.pop
    if vertexTuple.nil?
      raise "No vertex available in stack"
    else
      vertex, count, depth = vertexTuple
      branchCounts = branchCounts.first(depth)
      branchCounts.push(count)
      branchSum += branchCounts.product
      puts branchCounts
      puts branchSum
      vertex.edges.keys.each do |neighbour|
        queue.push({neighbour, vertex.edges[neighbour], depth+1})
      end
    end
  end
  return branchSum
end
