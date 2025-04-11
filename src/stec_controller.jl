export HoribaSTECController
export set_flow, scale

struct HoribaSTECController{T} <: LabDevice
  port::T
end

function HoribaSTECController(port::String) 
  if idn(port) != "HoribaSTECController" 
    error("Port $port is not a HoribaSTECController!")
  end
 HoribaSTECController(LibSerialPort.open(port, 9600)) 
end

function set_flow(p::HoribaSTECController)
  drop_previous_input(p.port)
  write(p, "FLOW:SET?")
  parse(Int, readline(p.port))
end

function set_flow(p::HoribaSTECController, flow)
  drop_previous_input(p.port)
  write(p, "FLOW:SET $flow")
  return nothing
end

# function cur_flow(p::HoribaSTECController)
#   drop_previous_input(p.port)
#   write(p, "FLOW:CUR?")
#   parse(Int, readline(p.port))
# end

function scale(p::HoribaSTECController)
  drop_previous_input(p.port)
  write(p.port, "SYST:FLOW:SCAL?\n")
  parse(Float64, readline(p.port))
end

function scale(p::HoribaSTECController, scale)
  drop_previous_input(p.port)
  write(p.port, "SYST:FLOW:SCAL $scale\n")
  nothing
end
