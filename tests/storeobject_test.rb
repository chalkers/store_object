require "test/unit"

class MockStoreObject < StoreObject
end

class StoreObjectTest < Test::Unit::TestCase
  
  def setup
    ENV["storeobject_location"] = "tmp/store"
    FileUtils.mkdir_p ENV["storeobject_location"]
    @name = "test_name"
  end

  def teardown
    delete_store
  end

  def test_initialize_store_object
    assert_raise ArgumentError, ArgumentError do
      StoreObject.new
    end

    assert_raise RuntimeError, RuntimeError do
      StoreObject.new( @name )
    end

    assert_raise ArgumentError, ArgumentError do
      StoreObject.new( @name, @name )
    end

    assert_raise ArgumentError, ArgumentError do
      MockStoreObject.new
    end

    assert_raise ArgumentError, ArgumentError do
      MockStoreObject.new( @name, @name )
    end
    
    assert_instance_of(MockStoreObject, MockStoreObject.new( @name ))

  end

  def test_store_location_values
    assert_equal( ENV["storeobject_location"], MockStoreObject.store )
    assert( File.exist?(ENV["storeobject_location"]) )
    delete_store
    
    assert_equal( ENV["storeobject_location"], MockStoreObject.new( @name ).store )
    assert( File.exist?(ENV["storeobject_location"]) )
    delete_store

    assert_equal( MockStoreObject.name.downcase, MockStoreObject.class_store )
    assert( File.exist?(ENV["storeobject_location"] + "/" + MockStoreObject.name.downcase) )
    delete_store

    assert_equal( MockStoreObject.name.downcase, MockStoreObject.new( @name ).class_store )
    assert( File.exist?(ENV["storeobject_location"] + "/" + MockStoreObject.name.downcase) )
    delete_store
  end
  
  private
  def delete_store
    Dir.rmdir(ENV["storeobject_location"] + "/" + MockStoreObject.name.downcase) if File.exist?(ENV["storeobject_location"] + "/" + MockStoreObject.name.downcase)
    Dir.rmdir(ENV["storeobject_location"])  if File.exist?(ENV["storeobject_location"])    
  end
end