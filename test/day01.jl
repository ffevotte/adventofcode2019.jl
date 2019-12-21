using SafeTestsets

@safetestset "Day01" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Day01
    using AdventOfCode.Day01: fuel1, fuel2

    @testset "fuel1" begin
        @test fuel1(12) == 2
        @test fuel1(14) == 2
        @test fuel1(1969) == 654
        @test fuel1(100756) == 33583
    end

    @testset "fuel2" begin
        @test fuel2(14) == 2
        @test fuel2(1969) == 966
        @test fuel2(100756) == 50346
    end

    btest("1.1") do
        part1("input01.dat") == 3348909
    end

    btest("1.2") do
        part2("input01.dat") == 5020494
    end
end
