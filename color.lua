-- color.lua

function gradient (min, max, val)
   if (val > max) then val = max end
   if (val < min) then val = min end

   local v = val - min
   local d = (max - min) * 0.5
   local red, green

   if (v <= d) then
      red = (255 * v) / d
      green = 255
   else
      red = 255
      green = 255 - (255 * (v - d)) / (max - min -d)
   end

   return string.format("#%02x%02x00", math.floor(red), math.floor(green))
end

function gradient_color (color, to_color, min, max, value)
   local function color2dec(c)
      return tonumber(c:sub(2,3),16), tonumber(c:sub(4,5),16), tonumber(c:sub(6,7),16)
   end

   local factor = 0
   if (value >= max ) then
      factor = 1
   elseif (value > min ) then
      factor = (value - min) / (max - min)
   end

   local red, green, blue = color2dec(color)
   local to_red, to_green, to_blue = color2dec(to_color)

   red   = red   + (factor * (to_red   - red))
   green = green + (factor * (to_green - green))
   blue  = blue  + (factor * (to_blue  - blue))

   -- dec2color
   return string.format("#%02x%02x%02x", math.floor(red), math.floor(green), math.floor(blue))
end
