using SafeTestsets

@safetestset "Day04" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Day04

    @testset "digits" begin
        using AdventOfCode.Day04: digits

        @test digits(171309) == (-1, 1,7,1,3,0,9, 10)
    end

    @testset "is_valid1" begin
        using AdventOfCode.Day04: is_valid1

        @test  is_valid1((-1, 1,1,1,1,1,1, 10))
        @test !is_valid1((-1, 2,2,3,4,5,0, 10))
        @test !is_valid1((-1, 1,2,3,7,8,9, 10))
    end

    @testset "is_valid2" begin
        using AdventOfCode.Day04: is_valid2

        @test  is_valid2((-1, 1,1,2,2,3,3, 10))
        @test !is_valid2((-1, 1,2,3,4,4,4, 10))
        @test  is_valid2((-1, 1,1,1,1,2,2, 10))
    end

    btest("4.1") do
        part1(171309, 643603) == 1625
    end

    btest("4.2") do
        part2(171309, 643603) == 1111
    end
end
