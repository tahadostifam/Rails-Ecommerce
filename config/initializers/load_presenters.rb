Dir[Rails.root.join("app/presenters/*.rb")].each { |file| require file }
