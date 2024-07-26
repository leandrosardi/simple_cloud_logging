require_relative '../lib/simple_cloud_logging'

# create a logger
l = BlackStack::LocalLogger.new("examples.log")

l.blank_line
l.log "Example 1:"
l.logs "Calculate 1+1... "
n = 1 + 1
l.done

l.blank_line
l.log "Example 2:"
l.logs "Calculate 1+1... "
n = 1 + 1
l.done(details: n)

l.blank_line
l.log "Example 3:"
l.logs "Calculate 4/2... "
begin
    n = 4/2
    l.done(details: n)
rescue => e
    l.error(e)
end

l.blank_line
l.log "Example 4:"
l.logs "Calculate 4/0... "
begin
    n = 4/0
    l.done(details: n)
rescue => e
    l.error(e)
end

l.blank_line
l.log "Example 5:"
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

l.blank_line
l.log "Example 6:"
l.logs "Skipping odd numbers... "
i = 0
while i < 6
    l.logs "#{i}... "
    if i % 2 == 0
        l.ok
    else
        l.skip
    end
    i += 1
end
l.done

l.blank_line
l.log "Example 7:"
l.logs "Skipping odd numbers... "
i = 0
while i < 6
    l.logs "#{i}... "
    if i % 2 == 0
        l.ok
    else
        l.skip(details: 'it is an odd number')
    end
    i += 1
end
l.done