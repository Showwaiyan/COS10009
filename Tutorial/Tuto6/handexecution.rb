def whatdoesthisfunctiondo? (data)
  result = 0;
  i = 0
  while i < data.length
    result = result + data[i]
    i = i + 1
  end

  return result
end

puts whatdoesthisfunctiondo?([6,-3,3,8,1])

puts whatdoesthisfunctiondo?([2,6,-2,3])
