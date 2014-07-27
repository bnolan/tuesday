class Site < ActiveRecord::Base
  belongs_to :user
  has_many :pages, :order => 'position'
  belongs_to :theme
  validates_uniqueness_of :subdomain

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
