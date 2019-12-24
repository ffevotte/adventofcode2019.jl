module Day06
export both_parts

mutable struct Node
    name     :: String
    parent   :: String
    children :: Vector{String}

    orbits_count :: Int
end

Node(name::String) = Node(name, "COM", [], -1)

mutable struct Tree
    nodes        :: Dict{String, Node}
    orbits_count :: Int
end

Base.getindex(t::Tree, name::String) = get(t.nodes, name, Node(name))
Base.setindex!(t::Tree, val, name::String) = t.nodes[name]=val
function Base.show(io::IO, t::Tree)
    for (name, node) in t.nodes
        print(io, "$(node.orbits_count) $name:\t")
        for child in node.children
            print(io, "  $child")
        end
        println(io)
    end
end

Tree() = Tree(Dict(), 0)
function Tree(edges)
    t = Tree()
    for (name1, name2) in edges
        node1 = t[name1]
        node2 = t[name2]

        node2.parent = name1
        push!(node1.children, name2)

        t[name1] = node1
        t[name2] = node2
    end
    t
end

function count!(tree)
    todo = ["COM"]
    while length(todo) > 0
        name = pop!(todo)
        node = tree[name]
        node.orbits_count  = tree[node.parent].orbits_count + 1
        tree.orbits_count += node.orbits_count
        for c in node.children
            push!(todo, c)
        end
    end
end

function read_input(fname)
    open(fname) do f
        map(readlines(f)) do line
            (name1, name2) = split(line, ")")
            (String(name1), String(name2))
        end
    end
end

function ancestors(tree, name)
    res = String[]
    node = tree[name]
    while node.name != "COM"
        parent = node.parent
        push!(res, parent)
        node = tree[parent]
    end
    res
end

function orbital_transfers(tree, n1, n2)
    a1 = ancestors(tree, n1)
    a2 = ancestors(tree, n2)
    @inbounds for i in 1:length(a1)
        j = findnext(x->x==a1[i], a2, 1)
        if j != nothing
            return i+j-2
        end
    end
end

function both_parts()
    tree = Tree(read_input("input06.dat"))
    count!(tree)
    (tree.orbits_count,
     orbital_transfers(tree, "SAN", "YOU"))
end

end
