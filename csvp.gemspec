Gem::Specification.new do |s|
  s.name        = 'csvp'
  s.version     = '0.1.0'
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'CSV Print'
  s.description = 'Print enumerables as CSV effortlessly.'
  s.authors     = ['Martin Scavnicky']
  s.email       = 'martin.scavnicky@gmail.com'
  s.files       = ['lib/csvp.rb']
  s.homepage    = 'https://github.com/mscavnicky/csvp'
  s.license     = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.4.0'
  s.add_development_dependency 'pry', '~> 0.10.3'
  s.add_development_dependency 'pry-byebug', '~> 3.3.0'
  s.add_development_dependency 'activerecord', '~> 4.2.6'
  s.add_development_dependency 'sqlite3', '~> 1.3.11'
  s.add_development_dependency 'codecov', '~> 0.1.4'
end
