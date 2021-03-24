class User < ActiveRecord::Base
    has_secure_password
    has_many :posts
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