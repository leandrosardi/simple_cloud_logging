require_relative '../lib/simple_cloud_logging'

BlackStack::Logger.set(
    nesting_assertion: true,
)

# create a logger
l = BlackStack::LocalLogger.new("assertion.log")

def check_number(number, logger: nill)
    l = logger || Blackstack::DummyLogger.new(nil)

    l.logs "Checking... "
    if number == 3
        l.yes 
    else
        l.no 
    end
end

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
