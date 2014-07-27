class Page < ActiveRecord::Base
  belongs_to :site
  before_create :set_content

  def name
    title
  end

  def set_content
    self.content = "<h1>#{self.title.slice(0,20)}</h1><p>Tap this content to edit.</p>"
  end

  def to_liquid
    {
      'name' => title,
      'title' => title,
      'content' => content,
      'path' => '/' + path,
      'position' => position
    }
  end
end
