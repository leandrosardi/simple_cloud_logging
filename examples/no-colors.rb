# overwrite the instance methods green, red, blue and yellow of the class String to make them non-effect.
# if you require the colorize gem after the logger setup, colors will be activated again.

require_relative '../lib/simple_cloud_logging'

# create a logger
l = BlackStack::LocalLogger.new("no-colors.log")

BlackStack::Logger.set(
    colorize: false,
)

begin
    l.blank_line
    l.logs "Looking for number 3... "
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