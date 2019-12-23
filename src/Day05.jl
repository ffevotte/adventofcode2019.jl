module Day05
export part1, part2

using AdventOfCode.Computer

function part1()
    prog = read_program("input05.dat")
    prog.input = 1
    run_program!(prog)
    prog.output
end

function part2()
    prog = read_program("input05.dat")
    prog.input = 5
    run_program!(prog)
    prog.output
end

end
