require 'test_helper'

class ProgramSlotsControllerTest < ActionController::TestCase
  setup do
    @program_slot = program_slots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_slots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_slot" do
    assert_difference('ProgramSlot.count') do
      post :create, program_slot: {  }
    end

    assert_redirected_to program_slot_path(assigns(:program_slot))
  end

  test "should show program_slot" do
    get :show, id: @program_slot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_slot
    assert_response :success
  end

  test "should update program_slot" do
    patch :update, id: @program_slot, program_slot: {  }
    assert_redirected_to program_slot_path(assigns(:program_slot))
  end

  test "should destroy program_slot" do
    assert_difference('ProgramSlot.count', -1) do
      delete :destroy, id: @program_slot
    end

    assert_redirected_to program_slots_path
  end
end
