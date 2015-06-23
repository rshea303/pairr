class User < ActiveRecord::Base
  validates :description, length: { maximum: 500 }

  def self.find_or_create_from_auth(data)
      user = User.find_or_create_by(provider: data.provider, uid: data.uid)

      user.nickname  = data.info.nickname
      user.image_url = data.info.image
      user.token     = data.credentials.token
      user.save 

      user
  end
end
