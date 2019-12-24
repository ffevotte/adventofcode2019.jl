module Day07
using AdventOfCode.Computer
export part1, part2

function foreach_perm(fun, n)
    v = collect(0:n-1)
    c = ones(Int, n)
    foreach_perm!(fun, v, c)
end

function foreach_perm!(fun, A::Vector, c::Vector)
    fun(A)

    n = length(c)
    i = 1
    @inbounds while i <= n
        if  c[i] < i
            if i%2 == 1
                (A[i], A[1]) = (A[1], A[i])
            else
                (A[i], A[c[i]]) = (A[c[i]], A[i])
            end
            c[i] += 1
            i = 1

            fun(A)
        else
            c[i] = 1
            i += 1
        end
    end
end

test_phases(prog, phases) = test_phases!(deepcopy(prog), prog, phases)

function test_phases!(prog_tmp, prog, phases)
    input = 0
    for phase in phases
        reset!(prog_tmp, prog)
        run_program!(prog_tmp, (phase, input))
        input = prog_tmp.output
    end
    input
end

function max_signal(prog)
    max = 0
    prog_tmp = deepcopy(prog)

    foreach_perm(5) do phases
        m = test_phases!(prog_tmp, prog, phases)
        if m > max
            max = m
        end
    end
    max
end

part1() = max_signal(read_program("input07.dat"))


function test_feedback(prog, phases)
    progs = Tuple(deepcopy(prog) for i in 1:5)
    test_feedback!(progs, phases)
end

function test_feedback!(progs, phases)
    for i in 1:5
        progs[i].input = phases[i]
        step_program!(progs[i])
        @assert progs[i].code == 3
    end

    input = 0
    while progs[5].code != 99
        for i in 1:5
            progs[i].input = input
            step_program!(progs[i])
            input = progs[i].output
        end
    end
    input
end

function max_feedback(prog)
    max = 0
    progs = Tuple(deepcopy(prog) for i in 1:5)

    foreach_perm(5) do phases
        for i in 1:5
            reset!(progs[i], prog)
        end
        m = test_feedback!(progs, 5 .+ phases)
        if m > max
            max = m
        end
    end
    max
end

part2() = max_feedback(read_program("input07.dat"))

end
