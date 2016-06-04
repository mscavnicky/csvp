require 'spec_helper'
require 'ostruct'

describe 'csvp' do
  it 'prints openstruct' do
    expect { csvp(OpenStruct.new(a: 1, b: 2)) }.to output("a,1\nb,2\n").to_stdout
  end

  it 'prints array of openstructs' do
    expect { csvp([OpenStruct.new(a: 1, b: 2), OpenStruct.new(a: 3, b: 4)]) }.to output("a,b\n1,2\n3,4\n").to_stdout
  end
end
