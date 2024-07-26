require_relative '../lib/simple_cloud_logging'

BlackStack::Logger.set(
    nesting_assertion: true,
)

# create a logger
l = BlackStack::LocalLogger.new("assertion.log")

begin
    l.blank_line
    #l.logs "Looking for number 3... " # --> I missed to open the log.
    i = 0
    while i < 6
        l.logs "#{i}... " 
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