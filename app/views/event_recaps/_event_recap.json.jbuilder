json.extract! event_recap, :id, :attendance, :description, :created_at, :updated_at
json.url event_recap_url(event_recap, format: :json)
