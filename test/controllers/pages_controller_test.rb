require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in(users(:ben))
  end

  test "show" do
    get :show, :id => pages(:home), :site_id => sites(:about)
    assert_template 'show'
    assert_equal assigns(:page), pages(:home)
  end

  test "new" do
    get :new, :site_id => sites(:about)
    assert_template 'new'
    assert assigns(:page).new_record?
  end

  test "update" do
    post :update, :id => pages(:home), :site_id => sites(:about), :page => { :content => "<p>hello werld!</p>" }
    assert_redirected_to [sites(:about), pages(:home)]
    assert_equal "<p>hello werld!</p>", pages(:home).reload.content
  end

  test "destroy" do
    post :destroy, :id => pages(:support), :site_id => sites(:about)
    assert_redirected_to sites(:about)
    assert_raise ActiveRecord::RecordNotFound do pages(:support).reload end
  end


end
