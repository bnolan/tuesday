require 'test_helper'

class CompilerTest < ActiveSupport::TestCase
  test "compiles" do
    Compiler.new(sites(:about))
    assert File.exists?(Rails.root.join("public", "sites", "about", "index.html"))
  end
end
