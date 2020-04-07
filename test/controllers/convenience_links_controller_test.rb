require 'test_helper'

class ConvenienceLinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @convenience_link = convenience_links(:one)
  end

  test "should get index" do
    get convenience_links_url
    assert_response :success
  end

  test "should get new" do
    get new_convenience_link_url
    assert_response :success
  end

  test "should create convenience_link" do
    assert_difference('ConvenienceLink.count') do
      post convenience_links_url, params: { convenience_link: { description: @convenience_link.description, is_public: @convenience_link.is_public, link: @convenience_link.link, name: @convenience_link.name } }
    end

    assert_redirected_to convenience_link_url(ConvenienceLink.last)
  end

  test "should show convenience_link" do
    get convenience_link_url(@convenience_link)
    assert_response :success
  end

  test "should get edit" do
    get edit_convenience_link_url(@convenience_link)
    assert_response :success
  end

  test "should update convenience_link" do
    patch convenience_link_url(@convenience_link), params: { convenience_link: { description: @convenience_link.description, is_public: @convenience_link.is_public, link: @convenience_link.link, name: @convenience_link.name } }
    assert_redirected_to convenience_link_url(@convenience_link)
  end

  test "should destroy convenience_link" do
    assert_difference('ConvenienceLink.count', -1) do
      delete convenience_link_url(@convenience_link)
    end

    assert_redirected_to convenience_links_url
  end
end
