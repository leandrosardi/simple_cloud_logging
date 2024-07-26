require_relative '../lib/simple_cloud_logging.rb'
require_relative './assertion7a.rb'

BlackStack::Logger.set(
    nesting_assertion: true,
)

# create a logger
l = BlackStack::LocalLogger.new("assertion.log")

begin
    l.blank_line
    l.logs "Looking for number 3... "

    numbers = [0, 1, 2, 3, 4, 5]

    numbers.each do |i|
        l.logs "#{i}... " 

        check_number(i, logger: l)
        i += 1

        l.done
    end

    l.done
rescue => e
    l.error(e)
end
