require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get searches" do
    get search_searches_url
    assert_response :success
  end
end
