# - How to find out from which line number the method was called in Ruby?
# - Referneces:
#   - https://stackoverflow.com/questions/37564928/how-to-find-out-from-which-line-number-the-method-was-called-in-ruby
#   - https://ruby-doc.org/core-2.2.3/Thread/Backtrace/Location.html

require 'pry'

# caller_locations.rb
def a(skip)
    caller_locations(skip)
end

def b(skip)
    a(skip)
end

def c(skip)
    b(skip)
end

c(0..2).map do |call|
    puts call.to_s
end