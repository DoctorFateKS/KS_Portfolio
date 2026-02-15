class Blog < ApplicationRecord
  has_one_attached :banner

  validates :title, presence: true, uniqueness: true, length: { minimum: 5, maximum: 200 }
  validates :excerpt, presence: true, length: { minimum: 20, maximum: 500 }
  validates :content, presence: true, length: { minimum: 100 }
  validates :category, presence: true, inclusion: {
    in: %w[Performance Architecture Tutorial Deep-Dive Testing Database Refactoring DevOps Security Other],
    message: "%{value} is not a valid category"
  }

  # Scopes
  scope :published, -> { where(published: true) }
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :search, ->(query) {
    where("title LIKE ? OR excerpt LIKE ? OR content LIKE ? OR tags LIKE ?",
          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%") if query.present?
  }
  scope :recent, -> { order(created_at: :desc) }
  scope :featured, -> { published.recent.limit(10) }

  before_save :calculate_reading_time
  after_find :increment_view_count

  def tags_list
    tags.to_s.split(",").map(&:strip).reject(&:blank?)
  end

  def tags_list=(value)
    self.tags = value.is_a?(Array) ? value.join(", ") : value
  end

  def reading_time_minutes
    word_count = content.split.length
    (word_count / 200).ceil
  end

  def excerpt_display
    excerpt.present? ? excerpt : content.truncate(200, separator: " ")
  end

  def published_date
    created_at.strftime("%B %d, %Y") if created_at
  end

  private

  def calculate_reading_time
    # This is used in the view with reading_time_minutes method
  end

  def increment_view_count
    unless view_count.present?
      self.view_count = 0
    end
  end
end
