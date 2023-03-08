require "test_helper"

class TrailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trail = trails(:one)
  end

  test "should get index" do
    get trails_url
    assert_response :success
  end

  test "should get new" do
    get new_trail_url
    assert_response :success
  end

  test "should create trail" do
    assert_difference("Trail.count") do
      post trails_url, params: { trail: { category: @trail.category, description: @trail.description, title: @trail.title, user_id: @trail.user_id } }
    end

    assert_redirected_to trail_url(Trail.last)
  end

  test "should show trail" do
    get trail_url(@trail)
    assert_response :success
  end

  test "should get edit" do
    get edit_trail_url(@trail)
    assert_response :success
  end

  test "should update trail" do
    patch trail_url(@trail), params: { trail: { category: @trail.category, description: @trail.description, title: @trail.title, user_id: @trail.user_id } }
    assert_redirected_to trail_url(@trail)
  end

  test "should destroy trail" do
    assert_difference("Trail.count", -1) do
      delete trail_url(@trail)
    end

    assert_redirected_to trails_url
  end
end
