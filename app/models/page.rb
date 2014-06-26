class Page < ActiveRecord::Base
  belongs_to :site
  before_create :set_content

  def set_content
    self.content = "<h1>#{self.title.slice(0,20)}</h1><p>Double tap this content to edit.</p>"
  end

end
