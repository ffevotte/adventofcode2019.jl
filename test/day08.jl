using SafeTestsets

@safetestset "Day08" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Day08
    using AdventOfCode.Day08: checksum, decode

    @test checksum("123456789012", 3*2) == 1
    @test decode("0222112222120000", 2, 2) == [0 1; 1 0]

    btest("8.1") do
        part1() == 1320
    end

    btest("8.2") do
        part2() == ("OOO   OO  O   OO  O OOO  \n"*
                    "O  O O  O O   OO O  O  O \n"*
                    "O  O O     O O OO   O  O \n"*
                    "OOO  O      O  O O  OOO  \n"*
                    "O O  O  O   O  O O  O O  \n"*
                    "O  O  OO    O  O  O O  O \n")
    end
end
