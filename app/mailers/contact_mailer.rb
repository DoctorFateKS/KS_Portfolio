class ContactMailer < ApplicationMailer
  default from: ENV["CONTACT_FROM_EMAIL"] || "noreply@portfolio.com"
  layout "mailer"

  def submit_contact(contact)
    @contact = contact
    @portfolio_email = ENV["PORTFOLIO_EMAIL"] || "contact@portfolio.com"

    mail(
      to: @portfolio_email,
      subject: "🚀 New Contact Submission: #{@contact.name}",
      cc: ENV["PORTFOLIO_EMAIL_CC"]
    )
  end

  def confirmation_email(contact)
    @contact = contact

    mail(
      to: @contact.email,
      subject: "Thanks for reaching out! 🙌"
    )
  end
end
