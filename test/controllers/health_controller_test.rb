require "test_helper"

class HealthControllerTest < ActionDispatch::IntegrationTest
  # Test for successful health check
  test "should get index and return ok" do
    get health_url
    assert_response :success
    assert_equal '{"status":"ok"}', @response.body
  end

  # Test for failed health check (optional, depending on your implementation)
  test "should get index and return error" do
    # Here you can simulate a scenario that would make the health check fail.
    # For example, you could disconnect the database, but this is generally not recommended
    # for real-world applications.

    # Your code to simulate failure here

    get health_url
    assert_response :internal_server_error
    assert_equal '{"status":"error"}', @response.body
  end
end
