Gem::Specification.new do |s|
  s.name        = 'simple_cloud_logging'
  s.version     = '1.1.27'
  s.date        = '2021-11-01'
  s.summary     = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Easy library to write log files in the cloud, watch them anywhere, and enbed the log in any website. The remote-logging feature is still being written."
  s.description = "THIS GEM IS STILL IN DEVELOPMENT STAGE. Find documentation here: https://github.com/leandrosardi/simple_cloud_logging."
  s.authors     = ["Leandro Daniel Sardi"]
  s.email       = 'leandro.sardi@expandedventure.com'
  s.files       = [
    "lib/simple_cloud_logging.rb",
    "lib/baselogger.rb",
    "lib/locallogger.rb",
    "lib/remotelogger.rb",
    "examples/example01.rb",
    "examples/example02.rb",
    "examples/example03.rb",
    "examples/example04.rb",
  ]
  s.homepage    = 'https://rubygems.org/gems/simple_cloud_logging'
  s.license     = 'MIT'
  s.add_runtime_dependency 'blackstack_commons', '~> 1.1.45', '>= 1.1.45'
end