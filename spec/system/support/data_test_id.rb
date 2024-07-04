module DataTestId
  def find_by_data_test_id(id)
    find(data_test_id(id))
  end
  alias_method :find_dti, :find_by_data_test_id

  def data_test_id(id)
    "[data-test-id='#{id}']"
  end
  alias_method :dti, :data_test_id
end

RSpec.configure do |config|
  config.include DataTestId, type: :system
end
