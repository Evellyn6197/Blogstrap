class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :confirmable,
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :validatable
        :trackable
end
