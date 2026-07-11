class BlogsController < ApplicationController
    http_basic_authenticate_with name: Rails.application.credentials.admin_username,
                                password: Rails.application.credentials.admin_password,
                                except: [:index, :show]

  include Pagy::Backend

  def index
    scope = params[:tag].present? ? Blog.where("LOWER(tags) LIKE ?", "%#{params[:tag].downcase}%") : Blog.all
    @pagy, @blogs = pagy(scope.order(created_at: :desc), limit: 6)
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to @blog, notice: "Article publié avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Article mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "Article supprimé."
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :jp_title, :content, :tags)
  end
end
