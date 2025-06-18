using Test
using SafeTestsets


@safetestset "Rigol" begin include("rigol_tests.jl") end

