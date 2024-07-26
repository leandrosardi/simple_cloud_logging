module BlackStack

  module Logger
    DEFAULT_MIN_SIZE = 10*1024*1024
    DEFAULT_MAX_SIZE = 20*1024*1024
    DEFAULT_SHOW_NESTING_LEVEL = false
    DEFAULT_SHOW_NESTING_CALLER = false
    DEFAULT_COLORIZE = true
    DEFAULT_NESTING_ASSERTION = true

    @@min_size = DEFAULT_MIN_SIZE
    @@max_size = DEFAULT_MAX_SIZE
    @@show_nesting_level = DEFAULT_SHOW_NESTING_LEVEL
    @@show_nesting_caller = DEFAULT_SHOW_NESTING_CALLER
    @@colorize = DEFAULT_COLORIZE
    @@nesting_assertion = DEFAULT_NESTING_ASSERTION

    def self.set(
      min_size: DEFAULT_MIN_SIZE,
      max_size: DEFAULT_MAX_SIZE,
      show_nesting_level: DEFAULT_SHOW_NESTING_LEVEL,
      show_nesting_caller: DEFAULT_SHOW_NESTING_CALLER,
      colorize: DEFAULT_COLORIZE,
      nesting_assertion: DEFAULT_NESTING_ASSERTION
    )
      err = []

      # min_size must be a positive integer
      err << "min_byes must be apositive integer." if !min_size.is_a?(Integer) || min_size.to_i < 0
      err << "max_byes must be apositive integer." if !max_size.is_a?(Integer) || max_size.to_i < 0
      err << "min_byes must be lower than max_size." if min_size.is_a?(Integer) && max_size.is_a?(Integer) && !(min_size < max_size)
      err << "show_nesting_level must be a boolean." if ![true, false].include?(show_nesting_level)
      err << "show_nesting_caller must be a boolean." if ![true, false].include?(show_nesting_caller)
      err << "colorize must be a boolean." if ![true, false].include?(colorize)
      err << "nesting_assertion must be a boolean." if ![true, false].include?(nesting_assertion)

      @@min_size = min_size
      @@max_size = max_size
      @@show_nesting_level = show_nesting_level
      @@show_nesting_caller = show_nesting_caller
      @@colorize = colorize  
      @@nesting_assertion = nesting_assertion

      if !colorize
        # overwrite the instance methods green, red, blue and yellow of the class String from inside the constructor of another class, to make them non-effect.
        String.class_eval do
          define_method(:green) do
            self
          end
    
          define_method(:red) do
            self
          end
    
          define_method(:blue) do
            self
          end
    
          define_method(:yellow) do
            self
          end
        end
      end
    end

    def self.min_size()
      @@min_size
    end

    def self.max_size()
      @@max_size
    end

    def self.show_nesting_level()
      @@show_nesting_level
    end

    def self.show_nesting_caller()
      @@show_nesting_caller
    end

    def self.colorize()
      @@colorize
    end

    def self.nesting_assertion()
      @@nesting_assertion
    end
  end # module Logger

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
    attr_accessor :filename, :level, :level_children_lines, :level_open_callers

    def initialize_attributes()
      self.level = 0
      self.level_children_lines = {}      
      self.level_open_callers = {}
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
      ltime = t.strftime("%Y-%m-%d %H:%M:%S").to_s
      ltime += " - level #{self.level.to_s.blue}" if Logger.show_nesting_level
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
      
      # Get the file and line from where this method logs was called
      # - References: 
      #   - https://github.com/leandrosardi/simple_cloud_logging/issues/6
      #
      callers = caller_locations(0..).to_a
      prev_caller = callers.select { |c| c.to_s.include?('locallogger.rb') }.last
      prev_index = callers.index(prev_caller)
      caller = callers[prev_index+1].to_s

      # if the parent level was called from the same line, I am missing to close the parent.
      if self.level_open_callers[self.level-1].to_s == caller.to_s
        if Logger.nesting_assertion
          raise LogNestingError.new("Log nesting assertion: You missed to close the log-level that you opened at #{caller.to_s}.")
        end
      else
        self.level_open_callers[self.level] = caller.to_s
      end

      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S").to_s
      ltime += " - level #{self.level.to_s.blue}" if Logger.show_nesting_level
      ltime += " - caller #{caller.to_s.blue}" if Logger.show_nesting_caller

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

      # clear the caller who opened the level that I am closing
      self.level_open_callers[self.level-1] = nil
      
      # if the parent level has children
      if self.level_children_lines[self.level].to_i > 0
        t = !datetime.nil? ? datetime : Time.now 
        ltime = t.strftime("%Y-%m-%d %H:%M:%S").to_s
        ltime += " - level #{self.level.to_s.blue}" if Logger.show_nesting_level
  
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
        if Logger.nesting_assertion
          raise LogNestingError.new("Log nesting assertion: You are closing 2 times the level started, or you missed to open that lavel, or you closed the another level in the middle 2 times.") 
        end
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