class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  has_attached_file :image, :styles => { :medium => "640x640>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
