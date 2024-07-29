module BlackStack
  class LocalLogger < BaseLogger

    # call the parent class to set the attributes
    # call the save method to store the new attributes into the data file
    def reset()
      super
    end

    # store the min allowed bytes in the variable min
    # store the max allowed bytes in the variable max
    # get number of bytes of filename and store it the variable n
    # if number of bytes (n) is higer than max, then truncate the first (max-min) bytes in the file.
    # finally, add the text into the variable s at the end of the file.
    def write(s)
      # store the min allowed bytes in the variable min
      min = Logger.min_size
      # store the max allowed bytes in the variable max
      max = Logger.max_size
      # get number of bytes of filename and store it the variable n
      n = File.exists?(self.filename) ? File.size(self.filename) : 0
      # if number of bytes (n) is higer than max, then truncate the first (max-min) bytes in the file.
      if n > max
        # Read the content of the file
        content = File.read(self.filename)
        # Calculate the number of bytes to truncate
        truncate_bytes = n - (max - min)
        # Truncate the first (max-min) bytes in the file
        truncated_content = content[truncate_bytes..-1]
        # Write the truncated content back to the file
        File.open(self.filename, 'w') { |file| file.write(truncated_content) }
      end
      #
      File.open(self.filename, 'a') { |file| file.write(s) }
    end

    def log(s, datetime=nil)
      ltext = super(s, datetime)
      self.write(ltext)
      ltext
    end
  
    # 
    def logs(s, datetime=nil)
      ltext = super(s, datetime)
      self.write(ltext)
      ltext
    end # def logs
  
    # 
    def logf(s, datetime=nil)      
      ltext = super(s, datetime)
      self.write(ltext)
      ltext
    end # def logf

  end # class LocalLogger
end # module BlackStack