module IssuesToCare
  # Stores runtime configuration information.
  #
  # Example settings
  #   IssuesToCare.configure do |c|
  #
  #		c.rcs       = :bitbucket | :github
  #
  #     c.repo_user = "vforge"
  #     c.repo_slug = "bitpot"
  #
  #     c.username = ""
  #     c.password = ""
  #   end
  class Configuration
    attr_accessor :rcs, :repo_user, :repo_slug, :username, :password

    # Set default settings
    def initialize
      @rcs       = nil

      @repo_user = nil
      @repo_slug = nil

      @repository = nil

      @username = nil
      @password = nil

    end
  end
end
