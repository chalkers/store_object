require "yaml"

class StoreObject
  attr_accessor :name

  def initialize(name)
    raise RuntimeError if self.instance_of? StoreObject
  end

  def self.all
      files = File.join("#{store}", class_store, "*.yaml")
      Dir.glob(files).collect {|file| YAML.load(File.open(file))}
  end

  def self.find(name)
    location = "#{store}/#{class_store}/#{name}.yaml"
    YAML.load(File.open(location)) if File.exists?(location)
  end

  def self.class_store
    class_store = self.name.downcase
    class_store_location = store + "/" + self.name.downcase
    FileUtils.mkdir_p(class_store_location) if !File.exist?(class_store_location)
    class_store
  end

  def class_store
    self.class.class_store
  end

  def save
    raise RuntimeError if name.blank?
    File.open("#{store}/#{class_store}/#{name}.yaml", "w") {|file| YAML.dump(self,file) }
  end

  def self.store  
    store ||= ENV["storeobject_location"] ||= "store"
    FileUtils.mkdir_p(store) if !File.exist?(store)
    store
  end

  def store
    self.class.store
  end

end