RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :deletion
  end

  config.before do
    DatabaseCleaner[:mongoid].start
  end

  config.after do
    DatabaseCleaner[:mongoid].clean
  end
end
