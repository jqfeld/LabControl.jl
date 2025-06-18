export Shutter, open_shutter, close_shutter, set_position, get_position
struct Shutter{T} <: LabDevice
  port::T
end

function Shutter(port::String)
  if idn(port) != "ArduinoShutter"
    error("Port $port is not a shutter")
  end
  Shutter(LibSerialPort.open(port, 9600))
end


function get_position(s::Shutter)
  drop_previous_input(s)
  write(s, "POS:SET?")
  try
    return parse(Int, read_ascii(s))
  catch e
    @warn "An error occured while reading position, returning -1" e
    return -1
  end
end

function set_position(s::Shutter, pos)
  if pos < 0 || pos > 180
    error("Position must be between 0 and 180.")
  end
  drop_previous_input(s)
  write(s, "POS:SET $pos")
end


function open_shutter(s::Shutter)
  drop_previous_input(s)
  write(s, "POS:OPEN")
end

function close_shutter(s::Shutter)
  drop_previous_input(s)
  write(s, "POS:CLOSE")
end
