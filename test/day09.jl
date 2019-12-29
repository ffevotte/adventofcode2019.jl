using SafeTestsets

@safetestset "Day09" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Computer
    using AdventOfCode.Day09

    @testset "quine" begin
        quine = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
        outputs = run_program!(Program(quine))
        @test quine == outputs
    end

    @testset "large numbers" begin
        @test run_program!([1102,34915192,34915192,7,4,7,99,0]).output == 1219070632396864
        @test run_program!([104,1125899906842624,99]).output == 1125899906842624
    end

    btest("9.1") do
        part1() == 2494485073
    end

    btest("9.2") do
        part2() == 44997
    end
end
