class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :status, :created_at, :updated_at
end
