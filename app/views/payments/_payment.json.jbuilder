json.extract! payment, :id, :description, :amount, :type, :user_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
