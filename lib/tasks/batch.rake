namespace :batch do
  desc "TODO"
  task Out_of_date: :environment do
  	@borroweds = Borrowed.where('borrowed_date < ?', Date.today - 10)
  	@borroweds.where('status LIKE ?', 'Reading').update_all(status: 'Out of date')

  	@borrowed = Borrowed.where('borrowed_date == ?', Date.today - 9)
  	@borrowed.where('status LIKE ?', 'Reading').update_all(status: 'About to expire')

  	@borroweds.where('status LIKE ?', 'About to expire').update_all(status: 'Out of date')

  	@borroweds.each do |b|
  		@day = (Date.today - b.borrowed_date - 10).to_i
  		b.update(debt: @day)
  	end
  	
  end

end
