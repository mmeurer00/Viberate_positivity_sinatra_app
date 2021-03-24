class User < ActiveRecord::Base
    has_secure_password

    has_many :posts

    has_many :follows

    has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow"
    has_many :followers, through: :follower_relationships, source: :follower

    has_many :following_relationships, foreign_key: :user_id, class_name: "Follow"
    has_many :following, through: :following_relationships, source: :following

    validates :user_name, presence: true
    validates :user_name, uniqueness: { case_sensitive: false }
    validates :email, presence: true

    def slug
      user_name.downcase.gsub(" ","-")
    end
  
    def self.find_by_slug(slug)
      User.all.find{|user| user.slug == slug}
    end
  
  end