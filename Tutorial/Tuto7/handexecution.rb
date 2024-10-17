def include?(data, val)
    i = 0
    result = false
    while i < data.length
        return true if data[i] == val
        i += 1
    end
    return result
end

puts include?([2,6,-4,3,7], 3)
puts include?([-2,8,2,-5,9], 6)