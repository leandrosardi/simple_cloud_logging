Gem::Specification.new do |s|
  s.name        = 'simple_cloud_logging'
  s.version     = '1.2.3'
  s.date        = '2024-07-26'
  s.summary     = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Easy library to write log files in the cloud, watch them anywhere, and enbed the log in any website. The remote-logging feature is still being written."
  s.description = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Find documentation here: https://github.com/leandrosardi/simple_cloud_logging."
  s.authors     = ["Leandro Daniel Sardi"]
  s.email       = 'leandro.sardi@expandedventure.com'
  s.files       = [
    "lib/simple_cloud_logging.rb",
    "lib/baselogger.rb",
    "lib/dummylogger.rb",
    "lib/locallogger.rb",
    "lib/remotelogger.rb",
    "examples/example01.rb",
    "examples/example02.rb",
    "examples/example03.rb",
    "examples/example04.rb",
  ]
  s.homepage    = 'https://rubygems.org/gems/simple_cloud_logging'
  s.license     = 'MIT'
  s.add_runtime_dependency 'colorize', '~> 0.8.1', '>= 0.8.1'
  s.add_runtime_dependency 'blackstack-core', '~> 1.2.16', '>= 1.2.16'
end