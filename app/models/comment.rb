class Comment < ApplicationRecord
   belongs_to :post
   belongs_to :parent, class_name: 'Comment', optional: true
   belongs_to :user

   has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
   def can_be_deleted_by?(current_user)
      current_user.present? &&  current_user == user
   end
end


