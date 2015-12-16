class PlaceholderImage < ActiveRecord::Base
  attr_reader :image_remote_url
  has_attached_file :image
  before_save

  enum image_category: { people: 0, places: 1, things: 2, ideas: 3 }

  scope :person, -> { where(image_category: PlaceholderImage.image_categories[:people]) }
  scope :place, -> { where(image_category: PlaceholderImage.image_categories[:places]) }
  scope :thing, -> { where(image_category: PlaceholderImage.image_categories[:things]) }
  scope :idea, -> { where(image_category: PlaceholderImage.image_categories[:ideas]) }

  validates :native_width, presence: true
  validates :native_height, presence: true
  validates :url_hash, presence: true, uniqueness: true
  validates_attachment :image, presence: true,
    content_type: { content_type: /\Aimage\/(gif|jpg|jpeg|png)/ }

  def self.closest_to_size(w:, h:)
    # http://stackoverflow.com/questions/4949550
    w = w.to_i
    h = h.to_i
    order("ABS(native_width - #{w}) + ABS(native_height - #{h})")
  end

  def self.create_or_update_by_url_and_category!(url, category)
    url_hash = Digest::MD5.hexdigest(url)

    placeholder_image = find_or_initialize_by(url_hash: Digest::MD5.hexdigest(url))

    placeholder_image.image_category = :places

    placeholder_image.image_remote_url = url
    placeholder_image.url_hash = url_hash

    # pull out the actual image dimentions, to set the max random values
    image_geometry = Paperclip::Geometry.from_file(placeholder_image.image.queued_for_write[:original])
    actual_width = image_geometry.width
    actual_height = image_geometry.height

    # seed Kernel#rand based on the URL hash so we can always generate
    # the same "fake" native width/height
    srand url_hash[0...6].to_i(16)

    placeholder_image.native_width = rand(50..actual_width).to_i
    placeholder_image.native_height = (actual_height * (placeholder_image.native_width / actual_width)).to_i

    placeholder_image.save!
  end

  def image_remote_url=(url)
    self.image = URI.parse(url)
    @image_remote_url = url
  end
end
