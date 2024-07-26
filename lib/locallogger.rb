module BlackStack
  class LocalLogger < BaseLogger

    # call the parent class to set the attributes
    # call the save method to store the new attributes into the data file
    def reset()
      super
      BlackStack::LocalLoggerFactory::save(self.filename, self)
    end

    def log(s, datetime=nil)
      ltext = super(s, datetime)
      File.open(self.filename, 'a') { |file| file.write(ltext) }
      ltext
    end
  
    # 
    def logs(s, datetime=nil)
      ltext = super(s, datetime)
      File.open(self.filename, 'a') { |file| file.write(ltext) }
      ltext
    end # def logs
  
    # 
    def logf(s, datetime=nil)      
      ltext = super(s, datetime)
      File.open(self.filename, 'a') { |file| file.write(ltext) }
      ltext
    end # def logf

    # 
    def release()
      BlackStack::LocalLoggerFactory.release(self.filename)
    end

  end # class LocalLogger
end # module BlackStack