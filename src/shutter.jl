struct Shutter{T} <: LabDevice 
  port::T
end
 

function get_position(s::Shutter)
  drop_previous_input(s)
  write(s, "POS:SET?")
  parse(Int, read_ascii(s))
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
