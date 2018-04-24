json.extract! post, :id, :user_id, :image_name, :text_title, :text_about, :subject, :condition, :price, :place, :created_at, :updated_at
json.url post_url(post, format: :json)
