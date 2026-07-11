class BlogsController < ApplicationController

  # GET /blogs
  def index
    scope = params[:tag].present? ? Blog.where("LOWER(tags) LIKE ?", "%#{params[:tag].downcase}%") : Blog.all
    @pagy, @blogs = pagy(scope.order(created_at: :desc))
  end

  # GET /blogs/:id
  def show
    @blog = Blog.find(params[:id])
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      redirect_to @blog
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /blogs/:id/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # PATCH/PUT /blogs/:id
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to @blog
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/:id
  def destroy

  end

  private

  def blog_params
    params.require(:blog).permit(:title, :jp_title, :tags, :content)
  end
end
