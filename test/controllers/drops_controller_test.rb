require 'test_helper'

class DropsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drop = drops(:one)
  end

  test "should get index" do
    get drops_url, as: :json
    assert_response :success
  end

  test "should create drop" do
    assert_difference('Drop.count') do
      post drops_url, params: { drop: { content: @drop.content } }, as: :json
    end

    assert_response 201
  end

  test "should show drop" do
    get drop_url(@drop), as: :json
    assert_response :success
  end

  test "should update drop" do
    patch drop_url(@drop), params: { drop: { content: @drop.content } }, as: :json
    assert_response 200
  end

  test "should destroy drop" do
    assert_difference('Drop.count', -1) do
      delete drop_url(@drop), as: :json
    end

    assert_response 204
  end
end
