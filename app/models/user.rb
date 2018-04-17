class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :todo_lists, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_todo_lists, through: :favorites, source: :todo_list
  has_many :notifications, as: :recipient
end
