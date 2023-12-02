class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments

  validates :username, length: {in: 3..15}, uniqueness: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 5}
end
