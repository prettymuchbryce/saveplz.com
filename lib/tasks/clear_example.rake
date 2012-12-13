require 'net/http'

task :clear_example => :environment do
	url = URI.parse('http://www.saveplz.com/example_application')
	req = Net::HTTP::Delete.new(url.path)
	res = Net::HTTP.start(url.host, url.port) {|http|
	  http.request(req)
	}
	puts res.body
end