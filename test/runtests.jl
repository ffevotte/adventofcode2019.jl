using Test
using AdventOfCode.TestUtils

TestUtils.init()

@testset "AdventOfCode" begin
    include("day01.jl")
    include("day02.jl")
    include("day03.jl")
    include("day04.jl")
    include("day05.jl")
    include("day06.jl")
    include("day07.jl")
    include("day08.jl")
    include("day09.jl")
end

TestUtils.output("perfs.md")
