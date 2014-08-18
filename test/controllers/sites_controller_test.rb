require 'test_helper'

class SitesControllerTest < ActionController::TestCase

  test "create" do
    sign_in users(:ben)
    post :create, :site => { :name => "Test", :subdomain => "testing" }

    site = Site.last
    assert_redirected_to site, site.pages.first

    assert_equal "Test", site.name
    assert_equal 1, site.pages.length
  end

  test "create duplicate name" do
    sign_in users(:ben)
    post :create, :site => { :name => 'About', :subdomain => 'About' }
    assert_response :success
    assert assigns(:site).errors.present?
    assert_equal 1, Site.count
  end

end
