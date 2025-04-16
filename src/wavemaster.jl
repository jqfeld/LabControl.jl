struct WaveMaster{T} <: LabDevice 
  port::T
end

export WaveMaster, get_value

function WaveMaster(port::String) 
  if idn(port) != "WaveMaster" 
    error("Port $port is not a WaveMaster!")
  end
 WaveMaster(LibSerialPort.open(port, 9600)) 
end

function get_value(d::WaveMaster)
  echo, ret = split(query_ascii(d, "VAL?"), "\$")
  ret = split(ret, ",") 
  return (
    timestamp = parse(Int,ret[1]),
    value = parse(Float64, ret[2])
  )
end

