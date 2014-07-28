class Page < ActiveRecord::Base
  belongs_to :site
  before_create :set_content
  validates_uniqueness_of :path, :scope => :site

  def set_content
    self.content = "<h1>#{self.name.slice(0,20)}</h1><p>Tap this paragraph to edit.</p>"
  end

  def to_liquid
    {
      'name' => name,
      'content' => content,
      'path' => '/' + path,
      'position' => position
    }
  end
end
