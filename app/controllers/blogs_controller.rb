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

  end

  # POST /blogs
  def create

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
end
