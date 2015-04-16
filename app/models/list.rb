class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :title, presence: true, length: {minimum: 2}
  validates_associated :items
end
