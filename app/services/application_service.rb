require 'net/http'
require 'json'

class ApplicationService
  def self.call(*arg, &block)
    new(*args, &block).call
  end
end
