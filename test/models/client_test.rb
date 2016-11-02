require 'test_helper'

class ClientTest < ActiveSupport::TestCase
   test "should client without no" do
     client=Client.new
     assert !client.save
   end
end
