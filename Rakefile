task :default => :test

task :test do
    load "store_object.rb"
    Dir["tests/**/*.rb"].each { |test| load test }
end