require_relative '../lib/simple_cloud_logging'

def check_number(number, logger: nill)
    l = logger || Blackstack::DummyLogger.new(nil)

    l.logs "Checking... "
    if number == 3
        l.yes 
    else
        l.no 
    end
end
