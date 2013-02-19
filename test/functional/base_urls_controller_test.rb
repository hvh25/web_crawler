require 'test_helper'

class BaseUrlsControllerTest < ActionController::TestCase
  setup do
    @base_url = base_urls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_url" do
    assert_difference('BaseUrl.count') do
      post :create, base_url: { base: @base_url.base, common_url: @base_url.common_url, page_url: @base_url.page_url }
    end

    assert_redirected_to base_url_path(assigns(:base_url))
  end

  test "should show base_url" do
    get :show, id: @base_url
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @base_url
    assert_response :success
  end

  test "should update base_url" do
    put :update, id: @base_url, base_url: { base: @base_url.base, common_url: @base_url.common_url, page_url: @base_url.page_url }
    assert_redirected_to base_url_path(assigns(:base_url))
  end

  test "should destroy base_url" do
    assert_difference('BaseUrl.count', -1) do
      delete :destroy, id: @base_url
    end

    assert_redirected_to base_urls_path
  end
end
