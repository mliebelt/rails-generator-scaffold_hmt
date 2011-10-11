require 'test_helper'

class AssembliesControllerTest < ActionController::TestCase
  setup do
    @assembly = assemblies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assemblies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assembly" do
    assert_difference('Assembly.count') do
      post :create, assembly: @assembly.attributes
    end

    assert_redirected_to assembly_path(assigns(:assembly))
  end

  test "should show assembly" do
    get :show, id: @assembly.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assembly.to_param
    assert_response :success
  end

  test "should update assembly" do
    put :update, id: @assembly.to_param, assembly: @assembly.attributes
    assert_redirected_to assembly_path(assigns(:assembly))
  end

  test "should destroy assembly" do
    assert_difference('Assembly.count', -1) do
      delete :destroy, id: @assembly.to_param
    end

    assert_redirected_to assemblies_path
  end
end
