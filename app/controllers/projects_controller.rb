class ProjectsController < ApplicationController
    http_basic_authenticate_with name: Rails.application.credentials.admin_username,
                                password: Rails.application.credentials.admin_password,
                                except: [:index, :show]
  def index
    @projects = if params[:tag].present?
      Project.where("LOWER(stack) LIKE ?", "%#{params[:tag].downcase}%")
    else
      Project.all
    end
  end

  def show
    @project = Project.find(params[:id])
    @related_projects = Project.where.not(id: @project.id).limit(2)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Réalisation créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: "Réalisation mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Réalisation supprimée."
  end

  private

  def project_params
    params.require(:project).permit(
      :title, :tagline, :role_description, :stack, :challenges,
      :github_url, :demo_url, :role_jp, :results, :cover_image
    )
  end
end
