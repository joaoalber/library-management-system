# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

FactoryBot.create(:user, role: "member", email: "member@mail.com", password: 123456)
FactoryBot.create(:user, role: "librarian", email: "admin@mail.com", password: 123456)

5.times { FactoryBot.create(:book) }
7.times { FactoryBot.create(:borrowing) }

borrowings = Borrowing.all

borrowings[0].update!(return_at: DateTime.now + 1.hour) # due today but not overdued yet
borrowings[1].update!(return_at: DateTime.now + 1.hour) # due today but not overdued yet
borrowings[2].update!(return_at: Date.yesterday) # overdue
borrowings[3].update!(return_at: Date.yesterday) # overdue
