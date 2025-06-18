using LibSerialPort

export idn, discover_devices

const baudrates = [9600, 19200, 115200]

idn(dev::LabDevice) = query_ascii(dev, "*IDN?")

function idn(serial_port::String)

  model = nothing
  baud = 9600
  p = LibSerialPort.open(serial_port, baud)

  sleep(1)
  drop_previous_input(p)
  sleep(0.1)

  write(p, "*IDN?\n")

  set_read_timeout(p, 5)
  try
    ret = LibSerialPort.readline(p)
    if contains(ret, "\$")
      echo, ret = split(ret, "\$")
    end
    model = split(ret, ",")[2]
    close(p)
    return model
  catch e
    # @info ret
    close(p)
    clear_read_timeout(p)
    error(e)
  end
  clear_read_timeout(p)

  if isopen(p)
    close(p)
  end

  return model
end



function discover_devices(; sources=[:serial_port])
  if :serial_port in sources
    for port in get_port_list()

      println(port)
      idn(port)
    end
  end
end
