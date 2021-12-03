class ApplicationService
  # Constructor to initialize object and invoke #call method of service.
  #
  # @param args [Hash]
  # @yieldparam [optional]
  #
  # @return [void]
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
