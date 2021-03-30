module TextSentiment

class API

    def textanalysis(content)
        url = URI("https://text-sentiment.p.rapidapi.com/analyze")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url)
        request["content-type"] = 'application/x-www-form-urlencoded'
        request["x-rapidapi-key"] = ENV['API_KEY']
        request["x-rapidapi-host"] = 'text-sentiment.p.rapidapi.com'
        request.body = "text=#{content}"

        response = http.request(request)
        JSON.parse(response.read_body)
    end
end

end