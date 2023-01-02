json.extract! story, :id, :title, :description, :outcomes, :source, :created_at, :updated_at
json.url story_url(story, format: :json)
