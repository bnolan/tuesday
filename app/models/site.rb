class Site < ActiveRecord::Base
  belongs_to :user
  has_many :pages, -> { order 'position' }
  has_many :images
  belongs_to :theme
  validates_uniqueness_of :subdomain
  validates :subdomain, :format => { :with => /\A[a-z0-9]+\z/ }
  after_create :create_home_page
  after_save :compile!
  
  def preview_path
    full_url
  end

  def full_url
    if Rails.env.production?
      "http://#{subdomain}.tuesdayapp.com/"
    else
      "http://localhost:4000/"
    end
  end

  def paid?
    false
  end
  
  def home_page
    pages.first
  end

  def compile!(page = nil)
    Compiler.new(self).compile(page)
  end

  def to_liquid
    {
      'name' => name
    }
  end

  def create_home_page
    pages.create! :name => "Home", :path => "index"
  end  
end
