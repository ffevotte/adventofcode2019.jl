using SafeTestsets

@safetestset "Day05" begin
    using AdventOfCode.TestUtils
    using AdventOfCode.Day05

    @testset "run_program" begin
        using AdventOfCode.Computer
        @test run_program!([1002,4,3,4,33]).mem == [1002,4,3,4,99]

        p = Program([3,0,4,0,99])
        run_program!(p, [42])
        @test p.output == 42

        function equals8(i)
            p = Program([3,9,8,9,10,9,4,9,99,-1,8])
            run_program!(p, i)
            p.output==1
        end
        @test !equals8(7)
        @test  equals8(8)
        @test !equals8(9)

        function lessthan8(i)
            p = Program([3,9,7,9,10,9,4,9,99,-1,8])
            run_program!(p, i)
            p.output == 1
        end
        @test  lessthan8(7)
        @test !lessthan8(8)

        function equals8_(i)
            p = Program([3,3,1108,-1,8,3,4,3,99])
            run_program!(p, i)
            p.output == 1
        end
        @test !equals8_(7)
        @test  equals8_(8)
        @test !equals8_(9)

        function lessthan8_(i)
            p = Program([3,3,1107,-1,8,3,4,3,99])
            run_program!(p, i)
            p.output == 1
        end
        @test  lessthan8_(7)
        @test !lessthan8_(8)

        function non_zero(i)
            p = Program([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9])
            run_program!(p, i)
            p.output
        end
        @test non_zero(0) == 0
        @test non_zero(1) == 1
        @test non_zero(2) == 1

        function non_zero_(i)
            p = Program([3,3,1105,-1,9,1101,0,0,12,4,12,99,1])
            run_program!(p, i)
            p.output
        end
        @test non_zero_(0) == 0
        @test non_zero_(1) == 1
        @test non_zero_(2) == 1

        function cmp8(i)
            p = Program([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
                         1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
                         999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99])
            run_program!(p,i)
            p.output
        end
        @test cmp8(7) ==  999
        @test cmp8(8) == 1000
        @test cmp8(9) == 1001
    end

    btest("5.1") do
        part1() == 13787043
    end

    btest("5.2") do
        part2() == 3892695
    end
end
