module Day03
export part1, part2

function parse_move(s)
    (s[1], parse(Int, s[2:end]))
end

function parse_wire(s)
    parse_move.(split(s, ","))
end

function follow_wire!(path, f, wire)
    pos = (0,0)
    dist = 0

    for (dir, length) in wire
        (x, y) = (0, 0)
        dir == 'L' && (x=-1)
        dir == 'R' && (x=1)
        dir == 'U' && (y=1)
        dir == 'D' && (y=-1)

        for k = 1:length
            dist += 1
            pos = pos .+ (x, y)
            path[pos] = f(get(path, pos, 0), dist)
        end
    end
end

function closest_intersection(wire1, wire2)
    path = Dict{Tuple{Int64,Int64},Int64}()
    wire = parse_wire(wire1)
    follow_wire!(path, (x,_)->x|1, wire)

    wire = parse_wire(wire2)
    follow_wire!(path, (x,_)->x|2, wire)

    dist = typemax(Int)
    for (pos, cnt) in path
        if cnt == 3
            d = abs(pos[1]) + abs(pos[2])
            dist = min(dist, d)
        end
    end
    dist
end

function part1()
    open("input03.dat") do f
        wire1 = readline(f)
        wire2 = readline(f)
        closest_intersection(wire1, wire2)
    end
end


function fastest_intersection(wire1, wire2)
    update(x, y) = x == 0 ? y : x

    path1 = Dict{Tuple{Int, Int}, Int}()
    wire = parse_wire(wire1)
    follow_wire!(path1, update, wire)

    path2 = Dict{Tuple{Int, Int}, Int}()
    wire = parse_wire(wire2)
    follow_wire!(path2, update, wire)

    dist = typemax(Int)
    for (pos, dist1) in path1
        dist2 = get(path2, pos, 0)
        if dist2 > 0
            dist = min(dist, dist1+dist2)
        end
    end
    dist
end

function part2()
    open("input03.dat") do f
        wire1 = readline(f)
        wire2 = readline(f)
        fastest_intersection(wire1, wire2)
    end
end

end
