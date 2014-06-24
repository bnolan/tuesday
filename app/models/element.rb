class Element < ActiveRecord::Base
  belongs_to :page
  validates_format_of :content, :with => /^<.+>$/, :multiline => true
end
