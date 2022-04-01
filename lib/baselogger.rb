module BlackStack
  class BaseLogger
    METHOD_LOG = 'log'
    METHOD_LOGS = 'logs'
    METHOD_LOGF = 'logf'  
    METHODS = [METHOD_LOG, METHOD_LOGS, METHOD_LOGF]

    attr_accessor :filename, :nest_level, :number_of_lines_in_current_level, :current_nest_level

    def initialize_attributes()
      self.nest_level = 0
      self.current_nest_level = 0
      self.number_of_lines_in_current_level = 0      
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
      ltext = ltime + ": " + s + "\r\n"
      print ltext
      ltext
    end
  
    def logs(s, datetime=nil)
      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S").to_s

      ltext = ""
      self.nest_level += 1
      self.number_of_lines_in_current_level = 0
      
      if self.current_nest_level != self.nest_level 
        ltext += "\n"
      end
      
      ltext += ltime + ": "

      i=1
      while (i<self.nest_level)
        ltext += " > "
        i+=1
      end
    
      ltext += s
                  
      #File.open(self.filename, 'a') { |file| file.write(ltext) }
      print ltext
      
      #
      self.current_nest_level = self.nest_level

      #
      ltext
    end

    def logf(s, datetime=nil)
      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S").to_s

      ltext = ''
      
      if self.number_of_lines_in_current_level > 0
        ltext = ltime + ": "
        
        i=1
        while (i<self.nest_level)
          ltext += " > "
          i+=1
        end
      end # if self.number_of_lines_in_current_level == 0
      
      self.nest_level -= 1
      self.number_of_lines_in_current_level += 1

      ltext += s + "\n"

      print ltext
      
      ltext
    end

    def release()
      raise "This is an abstract method."
    end

    def done()
      self.logf("done")
    end

    def error(e=nil)
      self.logf("error") if e.nil?
      self.logf("error: #{e.to_console}.") if !e.nil?
    end  

    def yes()
      self.logf("yes")
    end

    def no()
      self.logf("no")
    end
  end # class BaseLogger
end # module BlackStack