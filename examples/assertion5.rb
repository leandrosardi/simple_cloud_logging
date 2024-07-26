require_relative '../lib/simple_cloud_logging'

BlackStack::Logger.set(
    nesting_assertion: true,
)

# create a logger
l = BlackStack::LocalLogger.new("assertion.log")

begin
    l.blank_line
    l.logs "Looking for number 3... "

    numbers = [0, 1, 2, 3, 4, 5]

    i = 0
    while i <= 5
        l.logs "#{i}... " 

        l.logs "Checking... "
        if i == 3
            l.yes 
        else
            l.no 
        end
        i += 1

        l.done
    end

    l.done
rescue => e
    l.error(e)
end

=begin
level: 2
level-1: 1
callers: {0=>"assertion5.rb:12:in `<main>'", 1=>"assertion5.rb:18:in `<main>'"}
caller: "assertion5.rb:20:in `<main>'"
=end

begin
    l.blank_line
    l.logs "Looking for number 3... "

    numbers = [0, 1, 2, 3, 4, 5]

    numbers.each do |i|
        l.logs "#{i}... " 

        l.logs "Checking... "
        if i == 3
            l.yes 
        else
            l.no 
        end
        i += 1

        l.done
    end

    l.done
rescue => e
    l.error(e)
end

=begin
level: 2
level-1: 1
callers: {0=>"assertion5.rb:45:in `<main>'", 1=>"assertion5.rb:49:in `<main>'"}
caller: "assertion5.rb:49:in `<main>'"
=end
