class Contact < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :project_type, inclusion: { in: %w[new_project consulting long_term_contract], allow_nil: true }
  validates :company, length: { maximum: 100 }, allow_blank: true
  validates :ip_address, presence: true

  before_create :sanitize_inputs

  # Prevent spam: only allow 5 submissions per IP per hour
  scope :recent_from_ip, ->(ip) { where(ip_address: ip).where("created_at > ?", 1.hour.ago) }

  def self.spam?
    false # You can add rate limiting logic here
  end

  private

  def sanitize_inputs
    self.name = name&.strip&.truncate(100)
    self.email = email&.strip&.downcase
    self.company = company&.strip&.truncate(100)
    self.message = message&.strip&.truncate(5000)
  end
end
