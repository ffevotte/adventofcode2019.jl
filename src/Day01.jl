module Day01
export part1, part2

fuel1(m) = m÷3 - 2

function fuel2(m)
    acc = fuel1(m)
    f = acc
    while true
        f = fuel1(f)
        f <= 0 && return acc

        acc += f
    end
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

part1(input) = main(input, fuel1)
part2(input) = main(input, fuel2)

end # module
