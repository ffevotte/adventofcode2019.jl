module Day02
export part1, part2

using AdventOfCode.Computer

function part1()
    p = read_program("input02.dat")
    p.mem[2] = 12
    p.mem[3] = 02
    run_program!(p)
    p.mem[1]
end

function part2(output)
    p_orig = read_program("input02.dat")
    p = Program(similar(p_orig.mem))

    for i in 0:99
        for j in 0:99
            reset!(p, p_orig)

            p.mem[2] = i
            p.mem[3] = j
            run_program!(p)
            if p.mem[1] == output
                return 100*i+j
            end
        end
    end
end

end
