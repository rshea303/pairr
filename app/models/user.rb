class User < ActiveRecord::Base
  has_many :languages
  has_many :rejects
  has_many :selections
  has_many :matches
  has_many :pendings
  has_many :buds

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
