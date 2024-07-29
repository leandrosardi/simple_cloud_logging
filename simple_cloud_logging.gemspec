Gem::Specification.new do |s|
  s.name        = 'simple_cloud_logging'
  s.version     = '1.2.7'
  s.date        = '2024-07-29'
  s.summary     = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Easy library to write log files in the cloud, watch them anywhere, and enbed the log in any website. The remote-logging feature is still being written."
  s.description = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Find documentation here: https://github.com/leandrosardi/simple_cloud_logging."
  s.authors     = ["Leandro Daniel Sardi"]
  s.email       = 'leandro.sardi@expandedventure.com'
  s.files       = [
    "README.md",
    "lib/simple_cloud_logging.rb",
    "lib/baselogger.rb",
    "lib/dummylogger.rb",
    "lib/locallogger.rb",
    "examples/assertion1.rb",
    "examples/assertion2.rb",
    "examples/assertion3.rb",
    "examples/assertion4.rb",
    "examples/examples.rb",
    "examples/max_size.rb",
    "examples/no-colors.rb",
    "examples/show_caller.rb",
    "examples/show_level.rb",
  ]
  s.homepage    = 'https://rubygems.org/gems/simple_cloud_logging'
  s.license     = 'MIT'
  s.add_runtime_dependency 'colorize', '~> 0.8.1', '>= 0.8.1'
  s.add_runtime_dependency 'blackstack-core', '~> 1.2.16', '>= 1.2.16'
end