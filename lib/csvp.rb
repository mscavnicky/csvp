# Prints Enumerable in CSV format on the best effort basis.
# 
# @param enum [Enumerable]
# @param separator [String]
# @param quote [String]
#
# Example:
#   ?> csvp [{a: 1, b: 2}, {a: 3, b: 4} ]
#   a,b
#   1,2
#   3,4
#   
# This implementation attempts to follow https://tools.ietf.org/html/rfc4180

require 'set'

def csvp(enum, separator = ',', quote = "")
  unless enum.is_a?(Enumerable)
    raise ArgumentError, "#{enumerable.class} not an Enumerable."
  end
  
  if enum.first.is_a?(Hash)
    puts enum.first.keys.map { |o| "#{quote}#{o}#{quote}" }.join(separator)
  end

  enum.each do |element|
    if element.is_a?(Hash)
      puts element.values.map { |o| "#{quote}#{o}#{quote}" }.join(separator)
    elsif element.is_a?(Array) || element.is_a?(Set)
      puts element.map { |o| "#{quote}#{o}#{quote}" }.join(separator)
    else
      puts element.map { |o| "#{quote}#{o}#{quote}" }
    end
  end
end
