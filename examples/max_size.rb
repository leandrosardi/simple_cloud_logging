require_relative '../lib/simple_cloud_logging'

BlackStack::LoggerSetup.set(
    min_size: 6*1024, # 6K bytes
    max_size: 10*1024, # 10k bytes
    show_nesting_level: true,
    show_nesting_caller: true,
    colorize: true
)

# create a logger
l = BlackStack::LocalLogger.new("max_size.log")

i=0
while i<100000
    l.log "number:#{i}"
    i += 1
end
