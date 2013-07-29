require "issues-to-care/version"
require "issues-to-care/configuration"

module IssuesToCare
  def self.configuration
    @configuration ||= IssuesToCare::Configuration.new
  end

  def self.configuration=(new_configuration)
    @configuration = new_configuration
  end

  def self.configure
    yield configuration if block_given?
  end

  def self.reset
    @configuration = nil
    @rest_client   = nil

    @initialized = false
  end

  private

  def self.setup
  end
end
