require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
    sign_in(users(:ben))
  end

  test "show" do
    get :show, :id => pages(:home), :site_id => sites(:about)
    assert_template 'show'
    assert_equal assigns(:page), pages(:home)
  end
end
