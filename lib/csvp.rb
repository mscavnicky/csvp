require 'csv'

# Prints Enumerable in CSV format on the best effort basis.
#
# @param enum [Enumerable] Enumberable to print.
# @param options [Hash] Options described in Ruby CSV module.
#
# Example:
#   ?> csvp [{a: 1, b: 2}, {a: 3, b: 4} ]
#   a,b
#   1,2
#   3,4
#
# This implementation attempts to follow https://tools.ietf.org/html/rfc4180
def csvp(enum, options = {})
  return if enum.nil?

  # Case rules encapsulated as procs.
  open_struct = proc { |obj| defined?(OpenStruct) && OpenStruct === obj }
  active_record_base = proc { |obj| defined?(ActiveRecord::Base) && ActiveRecord::Base === obj }
  active_record_relation = proc { |obj| defined?(ActiveRecord::Relation) && ActiveRecord::Relation === obj }
  not_enumerable = proc { |obj| !obj.is_a?(Enumerable) }

  # Vectorize scalar values into Enumerables to avoid multiple codepaths.
  enum = case enum
    when Struct then enum.to_h
    when open_struct then enum.to_h
    when active_record_base then enum.attributes
    when active_record_relation then enum.to_a
    when not_enumerable then [enum]
    else enum
  end

  # Try to determine the header row.
  first = enum.first
  columns = case first
    when Hash then first.keys
    when Struct then first.members
    when open_struct then first.instance_variable_get("@table").keys
    when active_record_base then first.attributes.keys
  end

  CSV($stdout, options) do |csv|
    csv << columns if columns

    enum.each do |row|
      csv << case row
        when Hash then row.values
        when open_struct then row.instance_variable_get("@table").values
        when active_record_base then row.attributes.values
        when Enumerable then row
        else [row]
      end
    end
  end

  nil
end

def tsvp(enum)
  csvp enum, col_sep: "\t"
end

def qcsvp(enum)
  csvp enum, quote_char: "\"", force_quotes: true
end
