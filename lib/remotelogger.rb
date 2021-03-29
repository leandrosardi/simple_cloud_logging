module BlackStack
  require_relative './baselogger'
  class RemoteLogger < BlackStack::BaseLogger
    attr_accessor :api_protocol, :api_domain, :api_port, :api_key, :id_client
    
    def initialize(the_filename, the_api_protocol, the_api_domain, the_api_port, the_api_key, the_id_client=nil)
      super(the_filename)
      self.api_protocol = the_api_protocol
      self.api_domain = the_api_domain
      self.api_port = the_api_port
      self.api_key = the_api_key
      self.id_client = the_id_client
    end

    # call the parent class to set the attributes
    # call the save method to store the new attributes into the data file
    def reset()
      super
=begin
      url = "#{self.api_protocol}://#{self.api_domain}:#{self.api_port.to_s}/api1.4/scl/reset.json"
      res = BlackStack::Netting::api_call(url, {
        'api_key' => self.api_key,
        'filename' => self.filename,
        'id_client' => self.id_client,
      })
=end
    end

    def log(s, datetime=nil)
      ltext = super(s, datetime)
=begin
      url = "#{self.api_protocol}://#{self.api_domain}:#{self.api_port.to_s}/api1.4/scl/log.json"
      res = BlackStack::Netting::api_call(url, {
        'api_key' => self.api_key,
        'filename' => self.filename,
        'text' => s,
        'method' => BlackStack::BaseLogger::METHOD_LOG, 
        'id_client' => self.id_client,
      })
=end
      ltext
    end

    def logs(s, datetime=nil)
      ltext = super(s, datetime)
=begin
      url = "#{self.api_protocol}://#{self.api_domain}:#{self.api_port.to_s}/api1.4/scl/log.json"
      res = BlackStack::Netting::api_call(url, {
        'api_key' => self.api_key,
        'filename' => self.filename,
        'text' => s,
        'method' => BlackStack::BaseLogger::METHOD_LOGS, 
        'id_client' => self.id_client,
      })
=end
      ltext
    end

    def logf(s, datetime=nil)
      ltext = super(s, datetime)
=begin
      url = "#{self.api_protocol}://#{self.api_domain}:#{self.api_port.to_s}/api1.4/scl/log.json"
      res = BlackStack::Netting::api_call(url, {
        'api_key' => self.api_key,
        'filename' => self.filename,
        'text' => s,
        'method' => BlackStack::BaseLogger::METHOD_LOGF, 
        'id_client' => self.id_client,
      })
=end
      ltext
    end    

    def release()
=begin
      url = "#{self.api_url}:#{self.api_port.to_s}/api1.4/scl/release.json"
      res = BlackStack::Netting::api_call(url, {
        'api_key' => self.api_key,
        'filename' => self.filename, 
        'id_client' => self.id_client,
      })
=end
    end
  end
end # module BlackStack