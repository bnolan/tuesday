class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :large => "640x640>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
