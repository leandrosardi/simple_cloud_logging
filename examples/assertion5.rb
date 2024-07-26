require_relative '../lib/simple_cloud_logging'

# create a logger
l = BlackStack::LocalLogger.new("examples.log")

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

        j = 0
        while j < 6
            l.logs "#{j}... " 
            if j == 3
                l.yes 
            else
                l.no 
            end
            j += 1
        end

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