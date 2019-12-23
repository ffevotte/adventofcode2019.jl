module Day04
export part1, part2

function digits(n)
    Base.Cartesian.@nexprs 6 i -> begin
        (n, d_i) = divrem(n, 10)
    end
    (-1, d_6, d_5, d_4, d_3, d_2, d_1, 10)
end

function is_valid(pred, n)
    pair = false
    (a,b,c) = (-4, -3, -2)
    for d in n
        pred(a,b,c,d) && (pair=true)
        c<=d          || return false
        (a,b,c) = (b,c,d)
    end
    pair
end

is_valid1(n) = is_valid(n) do a,b,c,d
    b == c
end

is_valid2(n) = is_valid(n) do a,b,c,d
    a < b == c < d
end

part1(b, e) = sum(b:e) do x
    Int(is_valid1(digits(x)))
end

part2(b, e) = sum(b:e) do x
    Int(is_valid2(digits(x)))
end

end
