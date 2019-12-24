module Computer
export Program, read_program, run_program!, step_program!, reset!


mutable struct Program
    mem     :: Vector{Int}
    pointer :: Int
    code    :: Int

    input   :: Int
    output  :: Int
end

Program(p) = Program(p, 0,0,0,0) |> reset!

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
            $r = prog.mem[prog.pointer]
            $x = $param==1 ? $r : prog.mem[1+$r]
            prog.pointer += 1
        end |> esc
        push!(ret.args, block)
    end
    ret
end

run_program!(p::Vector{Int}, inputs=(0)) = run_program!(Program(p), inputs)

function run_program!(prog::Program, inputs=(0))
    for input in inputs
        prog.input = input
        step_program!(prog)
    end
    @assert prog.code == 99
    prog
end

function step_program!(prog::Program)
    input_available = true

    @inbounds while true
        instr = prog.mem[prog.pointer]
        (instr, prog.code) = divrem(instr, 100)
        Base.Cartesian.@nexprs 3 j -> begin
            (instr, param_j) = divrem(instr, 10)
        end

        if debug()
            @show prog.mem
            @show prog.code, param_1, param_2, param_3
            @show prog.pointer
            println()
        end

        prog.pointer += 1

        # Add
        if prog.code == 1
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1 + x_2
            continue
        end

        # Mul
        if prog.code == 2
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1 * x_2
            continue
        end

        # Input
        if prog.code == 3
            @read_args 1
            @assert param_1 == 0
            if input_available
                prog.mem[1+r_1] = prog.input
                input_available = false
            else
                prog.pointer -= 2
                return prog
            end
            continue
        end

        # Output
        if prog.code == 4
            @read_args 1
            prog.output = x_1
            continue
        end

        # Jump non-zero
        if prog.code == 5
            @read_args 2
            if x_1 != 0
                prog.pointer = 1+x_2
            end
            continue
        end

        # Jump zero
        if prog.code == 6
            @read_args 2
            if x_1 == 0
                prog.pointer = 1+x_2
            end
            continue
        end

        # Less than
        if prog.code == 7
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1<x_2 ? 1 : 0
            continue
        end

        # Equals
        if prog.code == 8
            @read_args 3
            @assert param_3 == 0
            prog.mem[1+r_3] = x_1==x_2 ? 1 : 0
            continue
        end

        # Exit
        @assert prog.code == 99
        return prog
    end

    nothing
end

function reset!(dest::Program, src::Program)
    dest.mem .= src.mem
    reset!(dest)
end

function reset!(dest::Program)
    dest.pointer = 1
    dest.code = 0

    dest.input  = typemin(Int)
    dest.output = typemax(Int)
    dest
end

end
