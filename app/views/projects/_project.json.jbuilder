json.extract! project, :id, :title, :tagline, :../.., :created_at, :updated_at
json.url project_url(project, format: :json)
