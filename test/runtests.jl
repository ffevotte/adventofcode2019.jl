using Test
using AdventOfCode.TestUtils

TestUtils.init()

@testset "AdventOfCode" begin
    include("day01.jl")
    include("day02.jl")
end

TestUtils.output("perfs.md")
