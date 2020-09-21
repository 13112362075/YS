json.extract! user, :id, :account, :password, :name, :address, :email, :telephone, :sex, :role, :department_id, :orgainize_id, :created_at, :updated_at
json.url user_url(user, format: :json)
