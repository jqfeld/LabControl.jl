module LabControl

"""
LabDevice

Every concrete implementation should have field `port`.
"""
abstract type LabDevice end


"""
drop_previous_input(p)

Drop previous input for port `p`.
"""
function drop_previous_input(p)
  while bytesavailable(p) > 0
    read(p)
  end
end

function drop_previous_input(dev::LabDevice)
  drop_previous_input(dev.port)
end



function Base.write(dev::T, str; termination="\n") where {T <: LabDevice}
  Base.write(dev.port, str * termination)
end

#TODO: add timeout with `Base.timedwait`
function read_ascii(dev::LabDevice)
  readline(dev.port)
end


function query_ascii(dev::LabDevice, query; termination="\n")
  write(dev, query; termination)
  return read_ascii(dev)
end




include("./wavemaster.jl")
include("./pressure_controller.jl")
include("./shutter.jl")
include("./stec_controller.jl")
include("./discover.jl")
include("./rigol.jl")

# Write your package code here.

end
