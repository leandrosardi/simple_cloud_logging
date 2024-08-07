require_relative '../lib/simple_cloud_logging'

BlackStack::Logger.set(
    nesting_assertion: true,
)

# create a logger
l = BlackStack::LocalLogger.new("assertion.log")

begin
    l.blank_line
    l.logs "Looking for number 3... "
    i = 0
    while i < 6
        l.logs "#{i}... " 
        if i == 3
            l.yes 
            l.no # --> I closed the same level 2 times by mistake
        else
            l.no 
        end
        i += 1
    end
    l.done
rescue => e
    l.error(e)
end