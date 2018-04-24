class Post < ApplicationRecord
  attr_accessor :image
  has_many :applies, dependent: :destroy
  validates :image, :text_title, :subject, :condition, :price, presence: true
  validates :text_about, length: {maximum: 1000}

  def self.search(search)
    if search
      where(['text_title LIKE ?', "%#{search}%"]).order(created_at: :desc)
    else
      all.order(created_at: :desc)
    end
  end

end
