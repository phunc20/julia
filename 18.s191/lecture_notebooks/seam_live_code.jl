
function brightness(px::AbstractRGB)
  mean(px.r + px.g + px.b)
end

function find_energy(img)
  energy_x = imfilter(brightness.(img), Kernel.sobel()[2])
  energy_y = imfilter(brightness.(img), Kernel.sobel()[1])
  return sqrt.(energy_x.^2 + energy_y.^2)
end


