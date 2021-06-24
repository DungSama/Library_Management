namespace :batch do
  desc "TODO"
  task Out_of_date: :environment do
  	@borroweds = Borrowed.where('borrowed_date < ?', Date.today - 10)
  	@borroweds.where('status LIKE ?', 'Reading').update_all(status: 'Out of date')
  end

end
