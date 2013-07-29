require "issues-to-care_test"

class IssuesToCare::TestCase < Test::Unit::TestCase

  def test_single_configuration_object
    assert_equal IssuesToCare.configuration, IssuesToCare.configuration
  end

  def test_set_configuration_object
    configuration = IssuesToCare::Configuration.new
    IssuesToCare.configuration = configuration
    assert_equal IssuesToCare.configuration, configuration
  end

  def test_yields_current_configuration
    IssuesToCare.configure do |config|
      assert_equal config, IssuesToCare::configuration
    end
  end

end
