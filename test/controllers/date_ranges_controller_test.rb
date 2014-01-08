require 'test_helper'

class DateRangesControllerTest < ActionController::TestCase
  setup do
    @date_range = date_ranges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:date_ranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create date_range" do
    assert_difference('DateRange.count') do
      post :create, date_range: { date_range: @date_range.date_range, description: @date_range.description, upload_id: @date_range.upload_id }
    end

    assert_redirected_to date_range_path(assigns(:date_range))
  end

  test "should show date_range" do
    get :show, id: @date_range
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @date_range
    assert_response :success
  end

  test "should update date_range" do
    patch :update, id: @date_range, date_range: { date_range: @date_range.date_range, description: @date_range.description, upload_id: @date_range.upload_id }
    assert_redirected_to date_range_path(assigns(:date_range))
  end

  test "should destroy date_range" do
    assert_difference('DateRange.count', -1) do
      delete :destroy, id: @date_range
    end

    assert_redirected_to date_ranges_path
  end
end
