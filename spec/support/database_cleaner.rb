RSpec.configure do |conf|
  conf.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  conf.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  conf.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  conf.before(:each) do
    DatabaseCleaner.start
  end

  conf.after(:each) do
    DatabaseCleaner.clean
  end
end
