class PagesController < ApplicationController
  skip_forgery_protection only: [ :create_contact ] # For API requests if needed
  before_action :set_rate_limit, only: [ :create_contact ] unless Rails.env.test?

  def profil
  end

  def skills
  end

  def method
  end

  def contact
    @contact = Contact.new
  end

  def create_contact
    # Honeypot: if website field is filled, it's spam
    if params[:contact][:website].present?
      redirect_to pages_contact_path, notice: "Thanks for your message!" and return
    end

    # Rate limiting check
    if @rate_limited
      return render json: { error: "Too many requests. Please try again later." }, status: :too_many_requests
    end

    @contact = Contact.new(contact_params)
    @contact.ip_address = request.remote_ip

    if @contact.save
      # Send emails asynchronously
      ContactMailer.submit_contact(@contact).deliver_later
      ContactMailer.confirmation_email(@contact).deliver_later

      respond_to do |format|
        format.html { redirect_to pages_contact_path, notice: "Message sent successfully! I'll get back to you soon." }
        format.json { render json: { success: true, message: "Message sent successfully!" } }
      end
    else
      respond_to do |format|
        format.html { render :contact, status: :unprocessable_entity, locals: { contact: @contact } }
        format.json { render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :company, :project_type, :message)
  end

  def set_rate_limit
    recent_submissions = Contact.recent_from_ip(request.remote_ip)
    @rate_limited = recent_submissions.count >= 5
  end
end
