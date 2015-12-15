class PlaceholderImage < ActiveRecord::Base
  attr_reader :image_remote_url
  has_attached_file :image

  before_save :sanitize_slug

  enum image_category: { people: 0, places: 1, things: 2, ideas: 3 }

  scope :person, -> { where(image_category: PlaceholderImage.image_categories[:people]) }
  scope :place, -> { where(image_category: PlaceholderImage.image_categories[:places]) }
  scope :thing, -> { where(image_category: PlaceholderImage.image_categories[:things]) }
  scope :idea, -> { where(image_category: PlaceholderImage.image_categories[:ideas]) }

  validates :native_width, presence: true
  validates :native_height, presence: true
  validates :slug, presence: true, uniqueness: true
  validates_attachment :image, presence: true,
    content_type: { content_type: /\Aimage\/(gif|jpg|jpeg|png)/ }

  def self.closest_to_size(w:, h:)
    # http://stackoverflow.com/questions/4949550
    w = w.to_i
    h = h.to_i
    order("ABS(native_width - #{w}) + ABS(native_height - #{h})")
  end

  def image_remote_url=(url)
    self.image = URI.parse(url)
    @image_remote_url = url
  end

private
  def sanitize_slug
    self.slug = slug.downcase.parameterize
  end
end
