using SafeTestsets

@safetestset "Day06" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Day06

    @testset "orbits_count" begin
        using AdventOfCode.Day06: Tree, count!

        t = Tree([("COM", "B"),
                  ("B", "C"),
                  ("C", "D"),
                  ("D", "E"),
                  ("E", "F"),
                  ("B", "G"),
                  ("G", "H"),
                  ("D", "I"),
                  ("E", "J"),
                  ("J", "K"),
                  ("K", "L")])

        count!(t)
        @test t["COM"].orbits_count == 0
        @test t["D"].orbits_count == 3
        @test t["L"].orbits_count == 7
        @test t.orbits_count == 42
    end

    @testset "orbital_transfers" begin
        using AdventOfCode.Day06: Tree, orbital_transfers
        t = Tree([("COM", "B"),
                  ("B", "C"),
                  ("C", "D"),
                  ("D", "E"),
                  ("E", "F"),
                  ("B", "G"),
                  ("G", "H"),
                  ("D", "I"),
                  ("E", "J"),
                  ("J", "K"),
                  ("K", "L"),
                  ("K", "YOU"),
                  ("I", "SAN")])
        @test orbital_transfers(t, "SAN", "YOU") == 4
    end

    btest("6") do
         both_parts() == (140608, 337)
    end
end
