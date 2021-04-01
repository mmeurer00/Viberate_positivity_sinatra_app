class Post < ActiveRecord::Base
    belongs_to :user,  foreign_key: 'user_id', class_name: "User"
    validates :content, presence: true

    def positive_post?
        response = TextSentiment::API.new.textanalysis(content)
        response["pos"] + response["mid"] > response["neg"]
    end
end


