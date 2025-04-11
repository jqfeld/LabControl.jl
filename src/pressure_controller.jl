export PressureController
export set_pressure, cur_pressure, scale, set_pid, get_pid

struct PressureController{T} <: LabDevice
  port::T
end

function set_pressure(p::PressureController)
  drop_previous_input(p.port)
  write(p, "PRE:SET?")
  parse(Int, readline(p.port))
end

function set_pressure(p::PressureController, pressure)
  drop_previous_input(p.port)
  write(p, "PRE:SET $pressure")
  return nothing
end

function cur_pressure(p::PressureController)
  drop_previous_input(p.port)
  write(p, "PRE:CUR?")
  parse(Int, readline(p.port))
end

function scale(p::PressureController)
  drop_previous_input(p.port)
  write(p.port, "SYST:PRE:SCAL?\n")
  parse(Float64, readline(p.port))
end

function scale(p::PressureController, scale)
  drop_previous_input(p.port)
  write(p.port, "SYST:PRE:SCAL $scale\n")
  nothing
end

function get_pid(pc::PressureController)
  drop_previous_input(pc.port)
  write(pc.port, "SYST:PID:P?\n")
  p = parse(Float64, readline(pc.port))
  write(pc.port, "SYST:PID:I?\n")
  i = parse(Float64, readline(pc.port))
  write(pc.port, "SYST:PID:D?\n")
  d = parse(Float64, readline(pc.port))
  return (P = p, I = i, D = d)
end

function set_pid(pc::PressureController; 
                 P = nothing,
                 I = nothing,
                 D = nothing
                 )
  if !isnothing(P)
    write(pc.port, "SYST:PID:P $P\n")
  end
  if !isnothing(I)
    write(pc.port, "SYST:PID:I $I\n")
  end
  if !isnothing(D)
    write(pc.port, "SYST:PID:D $D\n")
  end

end

# TODO: implement some live view over WGLMakie?
# export live_view
# live_view() = error("Load WGLMakie")
