class User < ApplicationRecord
  has_many :requested_friendships, class_name: 'Friendship', foreign_key: :requester_id
  has_many :received_friendships, class_name: 'Friendship', foreign_key: :receiver_id
  has_many :receivers, through: :requested_friendships, class_name: 'User'
  has_many :requesters, through: :received_friendships, class_name: 'User'

  has_many :movies

  def friends
    requesters + receivers
  end

end