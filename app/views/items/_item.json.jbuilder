json.extract! item, :id, :name, :title, :content, :publicznosc, :created_at, :updated_at
json.url item_url(item, format: :json)
