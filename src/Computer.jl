module Computer
export Program, read_program, run_program!, step_program!, reset!


struct Memory
    vect :: Vector{Int}
    dict :: Dict{Int, Int}
end

Memory(v::Vector{Int}) = Memory(v, Dict())

function Base.getindex(m::Memory, i::Int)
    if i <= length(m.vect)
        @inbounds m.vect[i]
    else
        get(m.dict, i, 0)
    end
end

function Base.setindex!(m::Memory, val::Int, i::Int)
    if i <= length(m.vect)
        @inbounds m.vect[i] = val
    else
        m.dict[i] = val
    end
end

mutable struct Program
    mem      :: Memory
    pointer  :: Int
    code     :: Int
    rel_base :: Int

    input    :: Int
    output   :: Int
end

Program(p) = Program(Memory(p), 0,0,0,0,0) |> reset!

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
            $x = prog.mem[prog.pointer]
            if     $param == 0
                $r = $x
                $x = prog.mem[1+$r]
            elseif $param == 1
                $r = -1
            elseif $param == 2
                $r = $x + prog.rel_base
                $x = prog.mem[1+$r]
            end
            prog.pointer += 1
        end |> esc
        push!(ret.args, block)
    end
    ret
end

function run_program!(p::Vector{Int}, inputs=(0))
    p = Program(p)
    run_program!(p, inputs)
    p
end

function run_program!(prog::Program, inputs=(0))
    outputs = Int[]
    for input in inputs
        prog.input = input
        while true
            step_program!(prog)
            if     prog.code == 3
                break # feed next input
            elseif prog.code == 4
                push!(outputs, prog.output)
            elseif prog.code == 99
                return outputs
            else
                error("unexpected program stopping code: $(prog.code)")
            end
        end
    end
end

function step_program!(prog::Program)
    input_available = true

    while true
        pointer_reset = prog.pointer
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
            @assert r_3 != -1
            prog.mem[1+r_3] = x_1 + x_2
            continue
        end

        # Mul
        if prog.code == 2
            @read_args 3
            @assert r_3 != -1
            prog.mem[1+r_3] = x_1 * x_2
            continue
        end

        # Input
        if prog.code == 3
            @read_args 1
            @assert r_1 != -1
            if input_available
                prog.mem[1+r_1] = prog.input
                input_available = false
            else
                prog.pointer = pointer_reset
                return prog
            end
            continue
        end

        # Output
        if prog.code == 4
            @read_args 1
            prog.output = x_1
            return prog
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
            @assert r_3 != -1
            prog.mem[1+r_3] = x_1<x_2 ? 1 : 0
            continue
        end

        # Equals
        if prog.code == 8
            @read_args 3
            @assert r_3 != -1
            prog.mem[1+r_3] = x_1==x_2 ? 1 : 0
            continue
        end

        # Adjust relative base
        if prog.code == 9
            @read_args 1
            prog.rel_base += x_1
            continue
        end

        # Exit
        @assert prog.code == 99
        return prog
    end

    nothing
end

function reset!(dest::Program, src::Program)
    copy!(dest.mem.vect, src.mem.vect)
    copy!(dest.mem.dict, src.mem.dict)
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
