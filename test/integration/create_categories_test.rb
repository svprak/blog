require 'test_helper'
class CreateCategoriesTest <ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username:"Jamies", email:"jamies@gmail.com", password:"123", admin:true)
  end
  test 'Get new category form and create category' do
    sign_in_as(@user, '123')
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count' , 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  test 'Invalid category submission results in failures' do
      sign_in_as(@user, '123')
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h3.panel-title'
    assert_select 'div.panel-body'
  end
end
