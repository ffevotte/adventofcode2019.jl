module Day02
export part1, part2

macro opcode(code, op)
    quote
        if opcode == $code
            r1=p[i+1]
            r2=p[i+2]
            r3=p[i+3]
            p[1+r3] = $op(p[1+r1], p[1+r2])
            i += 4
            continue
        end
    end |> esc
end

function run_program(p)
    i = 1

    while true
        opcode = p[i]
        @opcode(1, +)
        @opcode(2, *)
        return p
    end

    nothing
end

read_program(fname) = open(fname) do f
    parse.(Int, split(readline(f), ","))
end

function part1()
    p = read_program("input02.dat")
    p[2] = 12
    p[3] = 02
    run_program(p)
    p[1]
end

function part2(output)
    p_orig = read_program("input02.dat")
    p = similar(p_orig)

    for i in 0:99
        for j in 0:99
            p .= p_orig
            p[2] = i
            p[3] = j
            run_program(p)
            if p[1] == output
                return 100*i+j
            end
        end
    end
end

end
