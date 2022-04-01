require 'blackstack_commons'
require_relative './dummylogger'
require_relative './locallogger'
require_relative './remotelogger'

module BlackStack



  class LocalLoggerFactory  
    def self.lock()
      @@fd.flock(File::LOCK_EX)
    end
  
    def self.release()
      @@fd.flock(File::LOCK_UN)
    end

    # 
    def self.create(filename)
      data_filename = "#{filename}.data" 
      ret = BlackStack::LocalLogger.new(filename)
      if File.exist?(data_filename)
        f = File.open(data_filename,"r")
        data = f.read.split(/,/)
        ret.nest_level = data[0].to_i
        ret.number_of_lines_in_current_level = data[1].to_i 
        ret.current_nest_level = data[2].to_i
        f.close
      end
      ret
    end

    # 
    def self.save(filename, locallogger)
      data_filename = "#{filename}.data" 
      ret = BlackStack::LocalLogger.new(filename)
      f = File.open(data_filename,"w")
      f.write "#{locallogger.nest_level.to_s},#{locallogger.number_of_lines_in_current_level.to_s},#{locallogger.current_nest_level.to_s}"
      f.close
    end

    # 
    def self.release(filename)
      data_filename = "#{filename}.data"
      File.delete(data_filename) if File.exist?(data_filename) 
    end
    
  end # class LocalLoggerFactory
    
end # module BlackStack