module BlackStack
  require_relative './baselogger'
  class DummyLogger < BlackStack::BaseLogger

    # call the parent class to set the attributes
    # call the save method to store the new attributes into the data file
    def reset()
      super
    end

    def log(s, datetime=nil)
    end
  
    # 
    def logs(s, datetime=nil)
    end # def logs
  
    # 
    def logf(s, datetime=nil)      
    end # def logf

    # 
    def release()
    end

  end # class LocalLogger
end # module BlackStack