class Post < ApplicationRecord
  attribute :title, :string
  attribute :content, :text

  validates_presence_of :title, :content

  def previous
    Post.where('created_at < ?', created_at)
        .order(created_at: :desc)
        .limit(1)
        .last
  end

  def next
    Post.where('created_at > ?', created_at)
        .order(:created_at)
        .limit(1)
        .last
  end
end
