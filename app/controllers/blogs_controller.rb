class BlogsController < ApplicationController

  # GET /blogs
  def index
    @blogs = Blog.all
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

  end

  # PATCH/PUT /blogs/:id
  def update

  end

  # DELETE /blogs/:id
  def destroy

  end

  private

  def blog_params
    params.require(:blog).permit(:title, :jp_title, :tags, :content)
  end
end
