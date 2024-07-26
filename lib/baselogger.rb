module BlackStack

  class LogNestingError < StandardError
    attr_reader :message

    def initialize(message)
      @message = message
    end
    def to_s
      @message
    end
  end


  class BaseLogger
    NEWLINE = "\n\r"
    attr_accessor :filename, :level, :level_children_lines, :level_open_callers #, :level_close_callers

    def initialize_attributes()
      self.level = 0
      self.level_children_lines = {}      
      self.level_open_callers = {}
      #self.level_close_callers = {}
  end
    
    def initialize(the_filename=nil)
      self.filename = the_filename
      self.initialize_attributes
    end
  
    def reset()
      self.initialize_attributes
    end
    
    def log(s, datetime=nil)
      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S (level #{self.level})").to_s.blue
      ltext = ltime + ": " + s + NEWLINE
      # print
      print ltext
      # return
      ltext
    end
  
    def blank_line
      self.log('')
    end

    def logs(s, datetime=nil)

      # Nesting assertion:
      # - How to find out from which line number the method was called in Ruby?
      # - Referneces:
      #   - https://stackoverflow.com/questions/37564928/how-to-find-out-from-which-line-number-the-method-was-called-in-ruby
      #   - https://ruby-doc.org/core-2.2.3/Thread/Backtrace/Location.html
#binding.pry if s == "Looking for number 3... "
      caller = caller_locations(0..).last
#binding.pry if s == '1... '
#binding.pry if s == '4... '
      # if the parent level was called from the same line, I am missing to close the parent.
      if self.level_open_callers[self.level-1].to_s == caller.to_s
        raise LogNestingError.new("Log nesting assertion: You missed to close the log-level that you opened at #{caller.to_s}.")
      else
        self.level_open_callers[self.level] = caller.to_s
      end

      # clean the caller who closed the level that I am opening
      #self.level_close_callers[self.level+1] = nil

      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S (level #{self.level} - caller: #{caller.to_s})").to_s.blue
#binding.pry if self.level>0
      # start in a new line, if this line is the first child of the parent level has opened lines
      ltext = ""
      ltext += NEWLINE if self.level > 0 && self.level_children_lines[self.level].to_i == 0
      ltext += ltime + ": "

      # increase the number of children of the parent level
      self.level_children_lines[self.level] = self.level_children_lines[self.level].to_i + 1

      self.level += 1

      i=1
      while (i<self.level)
        ltext += "> "
        i+=1
      end
    
      ltext += s
                  
      # print
      print ltext
      
      # return
      ltext
    end

    def logf(s, datetime=nil)
      ltext = ""
=begin
      caller = caller_locations(0..).last

      # if the level was closed from the same line, I am closing it 2 times
      if self.level_close_callers[self.level+1].to_s == caller.to_s
        self.level = 1
        raise LogNestingError.new("Log nesting assertion: You are closing the same level for a second time at #{caller.to_s}.")
      else
        self.level_close_callers[self.level] = caller.to_s
      end
=end
      # clear the caller who opened the level that I am closing
      self.level_open_callers[self.level-1] = nil
      
      # if the parent level has children
      if self.level_children_lines[self.level].to_i > 0
        t = !datetime.nil? ? datetime : Time.now 
        ltime = t.strftime("%Y-%m-%d %H:%M:%S (level #{self.level-1})").to_s.blue

        ltext += "#{ltime}: "

        i=1
        while (i<self.level)
          ltext += "> "
          i+=1
        end
  
      end

      # since I am closing a level, set the number of children to 0
      self.level_children_lines[self.level] = 0

      # nesting assertion
      if self.level <= 0
        # force the level to 2, so I can use the loger to trace the error after raising the exceptiopn.
        self.level = 1
        # raise the exception
        raise LogNestingError.new("Log nesting assertion: You are closing 2 times the level started, or you missed to open that lavel, or you closed the another level in the middle 2 times.") 
      end

      self.level -= 1
      ltext += s + NEWLINE 
            
      # print
      print ltext
      # return
      ltext
    end

    def done(details: nil)
      if details.nil?
        self.logf("done".green)
      else
        self.logf("done".green + " (#{details.to_s})")
      end
    end

    def skip(details: nil)
      if details.nil?
        self.logf("skip".yellow)
      else
        self.logf("skip".yellow + " (#{details.to_s})")
      end
    end

    def error(e=nil)
      self.logf("error".red) if e.nil?
      self.logf("error: #{e.to_console}.".red) if !e.nil?
    end  

    def yes()
      self.logf("yes".green)
    end

    def ok()
      self.logf("ok".green)
    end

    def no()
      self.logf("no".yellow)
    end
  end # class BaseLogger
end # module BlackStack