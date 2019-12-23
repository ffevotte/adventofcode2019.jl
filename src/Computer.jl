module Computer
export Program, read_program, run_program!


mutable struct Program
    mem     :: Vector{Int}
    input   :: Int
    output  :: Int
end

Program(p, input) = Program(p, input, 0)
Program(p) = Program(p, 0)

read_program(fname) = open(fname) do f
    parse.(Int, split(readline(f), ",")) |> Program
end

debug() = false

macro read_args(N)
    ret = Expr(:block)
    for i in 1:N
        r = Symbol("r_", i)
        x = Symbol("x_", i)
        param = Symbol("param_", i)
        block = quote
            $r = prog.mem[pointer]
            $x = $param==1 ? $r : prog.mem[1+$r]
            pointer += 1
        end |> esc
        push!(ret.args, block)
    end
    ret
end

run_program!(p::Vector{Int}) = run_program!(Program(p))

function run_program!(prog::Program)
    pointer = 1

    @inbounds while true
        instr = prog.mem[pointer]
        (instr, code) = divrem(instr, 100)
        Base.Cartesian.@nexprs 3 j -> begin
            (instr, param_j) = divrem(instr, 10)
        end

        if debug()
            @show prog.mem
            @show code, param_1, param_2, param_3
            @show pointer
            println()
        end

        pointer += 1
        if code == 1
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1 + x_2
            continue
        end

        if code == 2
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1 * x_2
            continue
        end

        if code == 3
            @read_args 1
            @assert param_1 == 0
            prog.mem[1+r_1] = prog.input
            continue
        end

        if code == 4
            @read_args 1
            prog.output = x_1
            continue
        end

        if code == 5
            @read_args 2
            if x_1 != 0
                pointer = 1+x_2
            end
            continue
        end

        if code == 6
            @read_args 2
            if x_1 == 0
                pointer = 1+x_2
            end
            continue
        end

        if code == 7
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1<x_2 ? 1 : 0
            continue
        end

        if code == 8
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1==x_2 ? 1 : 0
            continue
        end

        @assert code == 99
        return prog
    end

    nothing
end

end
