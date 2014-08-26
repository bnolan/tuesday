require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in(users(:ben))
  end

  test "create" do
    post :create, :site => { :name => "Test", :subdomain => "testing" }

    site = Site.last
    assert_redirected_to site
    assert_equal "Test", site.name
    assert_equal 1, site.pages.length
  end

  test "create duplicate name" do
    assert_no_difference 'Site.count' do
      post :create, :site => { :name => 'About', :subdomain => 'About' }
      assert_response :success
      assert assigns(:site).errors.present?
    end
  end

  test 'show' do
    get :show, :id => sites(:about)
    assert_redirected_to [sites(:about), pages(:home)]
  end

  test 'new' do
    get :new
    assert_template "new"
    assert assigns(:site).new_record?
  end
end
