class User < ApplicationRecord
  attr_accessor :image
  has_many :books
  accepts_nested_attributes_for :books
  has_secure_password
  validates :name, :email, presence: true, uniqueness: true
end
