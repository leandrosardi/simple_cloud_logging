module BlackStack
  class BaseLogger
    NEWLINE = "\n\r"
    attr_accessor :filename, :level, :level_children_lines

    def initialize_attributes()
      self.level = 0
      self.level_children_lines = {}      
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
      print ltext
      ltext
    end
  
    def blank_line
      self.log('')
    end

    def logs(s, datetime=nil)
      t = !datetime.nil? ? datetime : Time.now 
      ltime = t.strftime("%Y-%m-%d %H:%M:%S (level #{self.level})").to_s.blue
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
                  
      #File.open(self.filename, 'a') { |file| file.write(ltext) }
      print ltext
      
      #
      ltext
    end

    def logf(s, datetime=nil)
      ltext = ""

      # if the parent level has children
      if self.level_children_lines[self.level-1].to_i > 0
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

      self.level -= 1
      ltext = s + NEWLINE 
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