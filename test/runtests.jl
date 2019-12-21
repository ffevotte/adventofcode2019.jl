using Test
using AdventOfCode.TestUtils

TestUtils.init()

@testset "AdventOfCode" begin
    include("day01.jl")
end

TestUtils.output("perfs.md")
