class User < ApplicationRecord
  has_many :posts
  has_many :messages
  has_many :subscriptions
  has_many :chats, through: :subscriptions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_commontator

  def existing_chat_users
    existing_chat_users = []
    self.chats.each do |chat|
      existing_chat_users.concat(chat.subscriptions.where.not(user_id: self.id).map { |subscription| subscription.user })
    end

    existing_chat_users.uniq
  end

end
