task :default => :test

task :test do
    load "storeobject.rb"
    Dir["tests/**/*.rb"].each { |test| load test }
end