class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_attached_file :avatar, styles: { original: ["140x140#", :png] }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\//
has_many :posts

  def self.from_omniauth(auth)
    find_or_create_by(email: auth.info.email).tap do |user|
      user.full_name = auth.info.name
      user.picture_url = auth.info.image
      user.save
    end
  end

  def picture_url
    read_attribute(:picture_url) || avatar.url
  end
end
