module BlackStack
  class BaseLogger
    METHOD_LOG = 'log'
    METHOD_LOGS = 'logs'
    METHOD_LOGF = 'logf'  
    METHODS = [METHOD_LOG, METHOD_LOGS, METHOD_LOGF]

    attr_accessor :filename, :level, :level_opened_lines

    def initialize_attributes()
      self.level = 0
      self.level_opened_lines = {}      
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
      ltext = ltime + ": " + s + "\n\r"
      print ltext
      ltext
    end
  
    def blank_line
      self.log('')
    end

    def logs(s, datetime=nil)
      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S").to_s

      ltext = ""
      self.level += 1
      self.level_opened_lines[self.level] = 0
      
      ltext += "\n"
      ltext += ltime + ": "

      i=1
      while (i<self.level)
        ltext += ">"
        i+=1
      end
    
      ltext += s
                  
      #File.open(self.filename, 'a') { |file| file.write(ltext) }
      print ltext
      
      #
      ltext
    end

    def logf(s, datetime=nil)
      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S").to_s

      ltext = ''
      
      if self.level_opened_lines[self.level] > 0
        ltext = ltime + ": "
        
        i=1
        while (i<self.level)
          ltext += ">"
          i+=1
        end
      end # if self.level_opened_lines == 0
      
      self.level_opened_lines[self.level] -= 1
      self.level -= 1

      ltext += s + "\n"

      print ltext
      
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