require 'spec_helper'
require 'active_record'

describe 'csvp' do
  before do
    ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

    ActiveRecord::Schema.define do
      self.verbose = false

      create_table :tests, force: true do |t|
        t.string :a
        t.string :b
      end
    end

    class Test < ActiveRecord::Base; end
  end

  it 'prints ActiveRecord object' do
    expect { csvp(Test.new(id: 1, a: 2, b: 3)) }.to output("id,1\na,2\nb,3\n").to_stdout
  end

  it 'prints array of ActiveRecord objects' do
    expect { csvp([Test.new(id: 1, a: 2, b: 3), Test.new(id: 4, a: 5, b: 6)]) }.to output("id,a,b\n1,2,3\n4,5,6\n").to_stdout
  end

  it 'prints ActiveRecord::Relation object' do
    Test.create!(id: 1, a: 2, b: 3)
    Test.create!(id: 4, a: 5, b: 6)
    expect { csvp(Test.all) }.to output("id,a,b\n1,2,3\n4,5,6\n").to_stdout
  end
end
