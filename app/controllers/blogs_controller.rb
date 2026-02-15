class BlogsController < ApplicationController
  before_action :set_blog, only: [ :show, :edit, :update, :destroy ]

  PER_PAGE = 12

  # GET /blogs
  def index
    @search_query = params[:q].to_s.strip
    @category_filter = params[:category].to_s.strip
    @current_page = params[:page].to_i.positive? ? params[:page].to_i : 1

    @blogs = Blog.published.recent
    @blogs = @blogs.search(@search_query) if @search_query.present?
    @blogs = @blogs.by_category(@category_filter) if @category_filter.present?

    @total_count = @blogs.size
    @blogs = @blogs.limit(PER_PAGE).offset((@current_page - 1) * PER_PAGE)
    @total_pages = (@total_count.to_f / PER_PAGE).ceil

    # Get all published blogs for the sidebar
    @featured_blogs = Blog.featured
    @categories = Blog.published.distinct.pluck(:category).sort
  end

  # GET /blogs/:id
  def show
    @blog.increment!(:view_count)
    @related_blogs = Blog.published
      .where(category: @blog.category)
      .where.not(id: @blog.id)
      .limit(3)
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @categories = %w[Performance Architecture Tutorial Deep-Dive Testing Database Refactoring DevOps Security Other]
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      redirect_to @blog, notice: "Blog article was successfully created."
    else
      @categories = %w[Performance Architecture Tutorial Deep-Dive Testing Database Refactoring DevOps Security Other]
      flash.now[:alert] = @blog.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  # GET /blogs/:id/edit
  def edit
    @categories = %w[Performance Architecture Tutorial Deep-Dive Testing Database Refactoring DevOps Security Other]
  end

  # PATCH/PUT /blogs/:id
  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Blog article was successfully updated."
    else
      @categories = %w[Performance Architecture Tutorial Deep-Dive Testing Database Refactoring DevOps Security Other]
      flash.now[:alert] = @blog.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/:id
  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: "Blog article was successfully deleted."
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :excerpt, :content, :category, :tags, :published, :banner)
  end
end
