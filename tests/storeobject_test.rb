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
    Dir.rmdir(ENV["storeobject_location"])
  end
  
  def test_initialize_store_object
    assert_raise ArgumentError, ArgumentError do
      StoreObject.new
    end

    assert_raise RuntimeError, RuntimeError do
      StoreObject.new(@name)
    end

    assert_raise ArgumentError, ArgumentError do
      StoreObject.new(@name, @name)      
    end

    assert_raise ArgumentError, ArgumentError do
      MockStoreObject.new
    end

    assert_raise ArgumentError, ArgumentError do
      MockStoreObject.new(@name, @name)
    end
    
    assert_instance_of(MockStoreObject, MockStoreObject.new(@name))

  end

  def test_store_location_values
    assert_equal( ENV["storeobject_location"], MockStoreObject.store )
    assert_equal( ENV["storeobject_location"], MockStoreObject.new(@name).store )  

  end

end