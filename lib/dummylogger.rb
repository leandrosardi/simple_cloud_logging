module BlackStack
  class DummyLogger < BaseLogger

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

  end # class LocalLogger
end # module BlackStack