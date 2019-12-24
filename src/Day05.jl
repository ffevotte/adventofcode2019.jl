module Day05
export part1, part2

using AdventOfCode.Computer

function part1()
    prog = read_program("input05.dat")
    run_program!(prog, 1)
    prog.output
end

function part2()
    prog = read_program("input05.dat")
    run_program!(prog, 5)
    prog.output
end

end
