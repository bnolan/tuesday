class Page < ActiveRecord::Base
  has_many :elements
  belongs_to :site
end
