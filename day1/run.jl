using Test

fuel1(m) = m÷3 - 2

@testset "fuel" begin
    @test fuel1(12) == 2
    @test fuel1(14) == 2
    @test fuel1(1969) == 654
    @test fuel1(100756) == 33583
end

function main(input, fuel)
    open(input) do f
        acc = 0
        for line in readlines(f)
            m = parse(Int, line)
            acc += fuel(m)
        end
        acc
    end
end

println("part1:", main("input.dat", fuel1))

function fuel2(m)
    acc = fuel1(m)
    f = acc
    while true
        f = fuel1(f)
        f <= 0 && return acc

        acc += f
    end
end

println("part1:", main("input.dat", fuel2))
