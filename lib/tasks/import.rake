require 'csv'

namespace :import do
  task :import_foods => :environment do


    csv_data = CSV.open("#{Rails.root}/lib/data/foodlist.csv")
    csv_data.each do |row|
      food_name = Food.find_by(:name => row[0]).present?
      if food_name
        food = Food.find_by(:name => row[0])
        puts food.name + ' already exist'
        # food.name =  = row[0]
        # food.save

      else
        #binding.pry
        food = Food.new
        food.name = row[0]
        food.save
      end

    end

    puts 'Finished Importing Food List'

  end
end


# run:
# rake import:import_foods
