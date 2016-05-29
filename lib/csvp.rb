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

def csvp(enum, separator: ',', quote: "")
  return if enum.nil?

  enum = enum.to_h if enum.is_a?(Struct) || enum.is_a?(OpenStruct)
  enum = enum.attributes if defined?(ActiveRecord::Base) && enum.is_a?(ActiveRecord::Base)
  enum = enum.to_a if defined?(ActiveRecord::Base) && enum.is_a?(ActiveRecord::Relation)
  # Convert all scalars to Array, so we do not need to special treat them.
  enum = [enum] if !enum.is_a?(Enumerable)

  add_quotes = lambda { |str| "#{quote}#{str.gsub(quote, quote*2)}#{quote}" }

  columns = case enum.first
    when Hash then enum.first.keys
    when OpenStruct then enum.first.instance_variable_get("@table").keys
    when -> (obj) { defined?(ActiveRecord::Base) && ActiveRecord::Base === obj } then enum.first.attributes.keys
    when Struct then enum.first.members
  end
  puts columns.map(&:to_s).map(&add_quotes).join(separator) if columns

  enum.each do |row|
    values = case row
      when Hash then row.values
      when OpenStruct then row.instance_variable_get("@table").values
      when -> (obj) { defined?(ActiveRecord::Base) && ActiveRecord::Base === obj } then row.attributes.values
      when Enumerable then row
      else [row]
    end

    puts values.map(&:to_s).map(&add_quotes).join(separator)
  end

  nil
end

def tsvp(enum)
  csvp enum, separator: "\t"
end

def qcsvp(enum)
  csvp enum, quote: "\""
end
