class User < ActiveRecord::Base
  has_many :books
  has_many :reviews
  has_many :borroweds
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end