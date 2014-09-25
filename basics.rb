require 'sinatra'
require 'geocoder'
require 'geokit'
require 'timezone'

get '/' do
	erb :city

end

Timezone::Configure.begin do |c|
  c.username = 'vermilian_bio@hotmail.com'
end

post '/' do
	
	@city = params[:message]
	latlon = Geocoder.coordinates(@city)
	timezone = Timezone::Zone.new(:latlon => latlon)

	time = timezone.time Time.now
	@time = time.to_s.split(' ')
	clock = @time[1].split(':')
	hour = clock[0].to_i
	@hour = hour.to_s
	if(hour<10)
		@hour = "0"+@hour
	end
	minu = clock[1].to_i
	@minu = minu.to_s
	if(minu<10)
		@minu = "0"+@minu
	end
	sec = clock[2].to_i
	@sec = sec.to_s
	if (sec<10)
		@sec= "0"+@sec
	end
	if (hour>12)
		@hour-=12
		@ampm = " PM"
	else
		@ampm = " AM"
	end

	erb :form
end

# get '/form' do
# 	erb :form
# end

# post '/form' do
# 	first_name = params[:message]
# 	"Hey, form submission works now for, #{first_name}!"
# end

not_found do
	status 404
	'page not found'
end
