# - How to find out from which line number the method was called in Ruby?
# - Referneces:
#   - https://stackoverflow.com/questions/37564928/how-to-find-out-from-which-line-number-the-method-was-called-in-ruby
#   - https://ruby-doc.org/core-2.2.3/Thread/Backtrace/Location.html

require 'pry'

# caller_locations.rb
def a()
    puts "Hola!"
    puts "This method has been called from: #{caller_locations(0..1).last}."
end

a()