using Test
using AdventOfCode.TestUtils

TestUtils.init()

using Jive
@testset "AdventOfCode" begin
    include("day01.jl")
    include("day02.jl")
    include("day03.jl")
    include("day04.jl")
    include("day05.jl")
    include("day06.jl")
end

TestUtils.output("perfs.md")
