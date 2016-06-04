require 'spec_helper'
require 'set'

describe 'csvp' do
  class Dummy < Struct.new(:a, :b); end

  it 'ignores nil' do
    expect { csvp(nil) }.to_not output.to_stdout
  end

  it 'prints scalar' do
    expect { csvp(5) }.to output("5\n").to_stdout
    expect { csvp('abcd') }.to output("abcd\n").to_stdout
  end

  it 'returns nil' do
    allow(STDOUT).to receive(:puts)
    expect(csvp(5)).to be nil
  end

  it 'prints array' do
    expect { csvp([1, 2, 3]) }.to output("1\n2\n3\n").to_stdout
    expect { csvp([1, nil, 3]) }.to output("1\n\n3\n").to_stdout
  end

  it 'prints hash' do
    expect { csvp({a: 1, b: 2}) }.to output("a,1\nb,2\n").to_stdout
  end

  it 'prints set' do
    expect { csvp(Set.new([1, 2, 3])) }.to output("1\n2\n3\n").to_stdout
  end

  it 'prints struct' do
    expect { csvp(Dummy.new(1, 2)) }.to output("a,1\nb,2\n").to_stdout
  end

  it 'prints array of arrays' do
    expect { csvp([[1],[2]]) }.to output("1\n2\n").to_stdout
    expect { csvp([[1,2],[3,4]]) }.to output("1,2\n3,4\n").to_stdout
  end

  it 'prints array of hashes' do
    expect { csvp([{a: 1}, {a: 2}]) }.to output("a\n1\n2\n").to_stdout
    expect { csvp([{a: 1, b: 2}, {a: 3, b: 4}]) }.to output("a,b\n1,2\n3,4\n").to_stdout
  end

  it 'prints array of sets' do
    expect { csvp([Set.new([1, 2]), Set.new([3, 4])]) }.to output("1,2\n3,4\n").to_stdout
  end

  it 'prints array of structs' do
    expect { csvp([Dummy.new(1, 2), Dummy.new(3, 4)]) }.to output("a,b\n1,2\n3,4\n").to_stdout
  end

  it 'uses specified separator' do
    expect { csvp([[1,2],[3,4]], separator: "\t") }.to output("1\t2\n3\t4\n").to_stdout
  end

  it 'uses quotes' do
    expect { csvp([[1,2],[3,4]], quote: "\"") }.to output("\"1\",\"2\"\n\"3\",\"4\"\n").to_stdout
  end

  it 'escapes quotes' do
    expect { csvp('"Hi!"', quote: "\"") }.to output("\"\"\"Hi!\"\"\"\n").to_stdout
  end
end

describe 'tsvp' do
  it 'prints tab-separated values' do
    expect { tsvp({a: 1, b: 2}) }.to output("a\t1\nb\t2\n").to_stdout
  end
end

describe 'qcsvp' do
  it 'prints comma-separated values with quotes' do
    expect { qcsvp({a: 1, b: 2}) }.to output("\"a\",\"1\"\n\"b\",\"2\"\n").to_stdout
  end
end
