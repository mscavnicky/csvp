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
end
