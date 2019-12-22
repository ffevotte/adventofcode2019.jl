using SafeTestsets

@safetestset "Day03" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Day03

    @testset "intersection" begin
        using AdventOfCode.Day03: closest_intersection
        @test closest_intersection("R8,U5,L5,D3", "U7,R6,D4,L4") == 6
        @test closest_intersection("R75,D30,R83,U83,L12,D49,R71,U7,L72",
                                   "U62,R66,U55,R34,D71,R55,D58,R83") == 159
        @test closest_intersection("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
                                   "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7") == 135
    end

    @testset "intersection" begin
        using AdventOfCode.Day03: fastest_intersection
        @test fastest_intersection("R8,U5,L5,D3", "U7,R6,D4,L4") == 30
        @test fastest_intersection("R75,D30,R83,U83,L12,D49,R71,U7,L72",
                                   "U62,R66,U55,R34,D71,R55,D58,R83") == 610
        @test fastest_intersection("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
                                   "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7") == 410
    end

    btest("3.1") do
        part1() == 855
    end

    btest("3.2") do
        part2() == 11238
    end
end
