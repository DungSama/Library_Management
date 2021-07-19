namespace :request do
  desc "TODO"
  task Request: :environment do

  	Reserve.where(request: 'Request').each do |res|
  		if Book.where('title LIKE = ?', res.name )
  				res.update(request: 'Added')
  		end
  	end
	 end

end