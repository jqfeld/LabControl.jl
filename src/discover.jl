using LibSerialPort

export idn, discover_devices, find_baud

const baudrates = [9600, 19200, 115200]

const model_dict = Dict(
  "HoribaSTECController" => HoribaSTECController,
  "ArduinoShutter" => Shutter, 
)

function idn(port)

  model = nothing
  baud = 9600
  p = LibSerialPort.open(port, baud)

  drop_previous_input(p)

  write(p, "*IDN?\n")
  
  set_read_timeout(p,5)
  try
    model = split(LibSerialPort.readline(p), ",")[2]
    close(p)
    return model
  catch e
    close(p)
    error("Timeout")
  clear_read_timeout(p)
  end
  clear_read_timeout(p)

  if isopen(p)
    close(p)
  end

  return model
end 



function discover_devices(;sources=[:serial_port])
  if :serial_port in sources
    for port in get_port_list()

      println(port)
      idn(port)
    end
  end
end
