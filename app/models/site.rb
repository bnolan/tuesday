class Site < ActiveRecord::Base
  belongs_to :user
  has_many :pages
  belongs_to :theme

  def compile!
    Compiler.new(self)
  end
  
  def to_liquid
    {
      'name' => name
    }
  end
  
end
