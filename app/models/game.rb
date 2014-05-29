class Game < ActiveRecord::Base
  has_many :additions
  has_many :users, through: :additions

  validates :title,
    presence: true
end
