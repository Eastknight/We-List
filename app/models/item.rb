class Item < ActiveRecord::Base

  include ActionView::Helpers::DateHelper

  validates :name, presence: true, length: {minimum: 2}

  belongs_to :list

  def create_time
    time_ago_in_words(created_at)
  end
end
