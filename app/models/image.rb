class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  has_attached_file :image, :styles => { :medium => "640x640>" }, :default_url => "/images/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def friendly_name
    File.basename(image_file_name, extension).downcase.gsub(/[^a-z0-9]+/,'-').sub(/^-+/,'').sub(/-+$/,'')
  end

  def extension
    File.extname(image_file_name).slice(1,32)
  end
end
