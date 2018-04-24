class Apply < ApplicationRecord
  belongs_to :post

  def user
    return User.find_by(id: self.user_id)
  end

  def post_user
    return User.find_by(id: self.post_user_id)
  end

  def post
    return Post.find_by(id: self.post_id)
  end
end
