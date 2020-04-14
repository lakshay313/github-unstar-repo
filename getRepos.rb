require 'csv'
require 'httparty'

class Etl
    include HTTParty

    base_uri "https://api.github.com"

    def unstar
        CSV.open("./repos.csv", "a") do |csv|
            ans = []
            begin
                ans << self.class.get("/users/:user/starred",
                                        :headers => {'Content-Type' => 'application/json'}).to_s
            rescue=>e
                ans << e
            end
            csv << ans
        end
    end
end

etl = Etl.new
etl.unstar

