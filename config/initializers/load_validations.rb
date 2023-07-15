Dir[Rails.root.join("app/validations/*.rb")].each { |file| require file }
