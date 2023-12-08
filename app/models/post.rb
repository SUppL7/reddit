class Post < ApplicationRecord
  acts_as_commontable

  belongs_to :user

  #has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true


end
