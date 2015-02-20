class Item < ActiveRecord::Base
  belongs_to :list

  def days_left
    (DateTime.now.beginning_of_day.to_date - created_at.beginning_of_day.to_date).to_i
  end
end
