class CategorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :community_id, :sort_priority, :url, :created_at, :updated_at
end
