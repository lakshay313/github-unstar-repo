require 'csv'
require 'httparty'
require 'base64'


$access_token = ':PERSONAL-ACCESS-TOKEN'
$username = ':USERNAME'
$limit = ':LIMIT'  # max-value = 100


$getRepoURI = '/users/' + $username + '/starred?per_page=' + $limit
$auth = 'Basic '+ Base64.strict_encode64($username + ':' + $access_token)

class Etl
    include HTTParty
    base_uri "https://api.github.com"

    def unstar        
        
        data = self.class.get($getRepoURI,
                                        :headers => {'Content-Type' => 'application/json'})
        
        begin
            CSV.open("./response.csv", "a") do |csv|          
                data.each do |row|
                    repo = row['name']
                    owner = row['owner']['login']
                    ans = []
                    ans << row
                    removeStarredRepoURI = '/user/starred/' + owner + '/' + repo
                    begin
                        ans << self.class.delete(removeStarredRepoURI,
                                                :headers => {'Content-Type' => 'application/json','Authorization' => $auth }).to_s
                    rescue=>e
                        ans << e
                    end
                    csv << ans
                end
            end
        rescue Exception => e
            puts e
        end 
    end
end

etl = Etl.new
etl.unstar

