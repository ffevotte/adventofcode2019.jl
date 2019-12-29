module Day09
using AdventOfCode.Computer
export part1, part2

function part1()
    p = read_program("input09.dat")
    run_program!(p, (1,))
    p.output
end

function part2()
    p = read_program("input09.dat")
    run_program!(p, (2,))
    p.output
end

end
