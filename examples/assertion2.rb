require_relative '../lib/simple_cloud_logging'

# create a logger
l = BlackStack::LocalLogger.new("assertion.log")

begin
    l.blank_line
    l.logs "Looking for number 3... "
    i = 0
    while i < 6
        #l.logs "#{i}... " # --> I missed to open the log.
        if i == 3
            l.yes 
        else
            l.no 
        end
        i += 1
    end
    l.done
rescue => e
    l.error(e)
end