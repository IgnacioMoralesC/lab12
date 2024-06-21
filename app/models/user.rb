class User < ApplicationRecord
    has_many :posts
    has_many :comments
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
  
  
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  end
  
  