require 'test_helper'
class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category =Category.create(name:'sports')
    @user = User.create(username:"Jamies", email:"jamies@gmail.com", password:"123", admin:true)
  end
  test "Should get categories index" do
    get :index
    assert_response :success
  end
  test "should get new" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end
  test "show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  test 'should not allow create if not admin' do
    assert_no_difference 'Category.count' do
      post :create, category: {name:'sports'}
    end
    assert_redirected_to categories_path
  end

end
