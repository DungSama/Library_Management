set :chronic_options, hours24: true

every 1.day, at: '0:00' do
	rake "batch:Out_of_date"
	rake "request:Request"
end