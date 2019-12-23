using SafeTestsets

@safetestset "Day02" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Day02

    @testset "run_program!" begin
        using AdventOfCode.Day02: run_program!
        @test run_program!([1,9,10,3,2,3,11,0,99,30,40,50]).mem == [
            3500,9,10,70,
            2,3,11,0,
            99,
            30,40,50
        ]

        @test run_program!([1,0,0,0,99]).mem == [2,0,0,0,99]
        @test run_program!([2,3,0,3,99]).mem == [2,3,0,6,99]
        @test run_program!([2,4,4,5,99,0]).mem == [2,4,4,5,99,9801]
        @test run_program!([1,1,1,4,99,5,6,0,99]).mem == [30,1,1,4,2,5,6,0,99]
    end

    btest("2.1") do
        part1() == 2782414
    end

    btest("2.2") do
        part2(19690720) == 9820
    end
end
