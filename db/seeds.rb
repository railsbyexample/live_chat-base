# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Run the seeds according to the environment

load(Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb"))
