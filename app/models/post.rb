# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category, required: false

  validates :title, :body, presence: true

  has_reputation :likes, source: :user, aggregated_by: :sum

  def increment
    self.visits ||= 0
    self.visits += 1
    save
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.find_each do |post|
        csv << post.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      user.posts.create! row.to_h
    end
  end
end
