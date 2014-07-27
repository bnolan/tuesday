class Site < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  belongs_to :theme

  def home_page
    pages.first
  end

  def full_url
    "http://#{subdomain}.localhost:4000/"
  end

  def compile!
    Compiler.new(self)
  end

  def to_liquid
    {
      'name' => name
    }
  end
  
end
