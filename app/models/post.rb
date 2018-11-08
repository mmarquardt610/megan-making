class Post < ApplicationRecord
  attribute :title, :string
  attribute :content, :text

  validates_presence_of :title, :content
end
