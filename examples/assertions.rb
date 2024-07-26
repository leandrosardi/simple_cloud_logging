require_relative '../lib/simple_cloud_logging'

# create a logger
l = BlackStack::LocalLogger.new("assertions.log")

#begin
    l.blank_line
    l.log "Example 5:"
    l.logs "Looking for number 3... "
    i = 0
    while i < 6
        l.logs "#{i}... "
        if i == 3
            l.yes # I missed to close the log line !
        else
            l.no # I missed to close the log line !
        end
        i += 1
    end
    l.done
#rescue => e
#    l.error(e)
#end