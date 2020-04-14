require 'csv'
require 'httparty'
require 'json'

class Etl
    include HTTParty

    base_uri "https://api.github.com"

    def unstar
        CSV.open("./repos.csv", "wb") do |csv|
            begin
                data = self.class.get("/users/:USERNAME/starred?per_page=100",
                                        :headers => {'Content-Type' => 'application/json'})
                data.each do |line|
                    begin
                        nameV = line['name']
                        owner = line['owner']['login'] 
                        csv << [nameV,owner]
                    rescue=>e
                        puts e
                        break
                    end 
                end
            rescue=>e
                puts e
            end
        end
    end
end

etl = Etl.new
etl.unstar

