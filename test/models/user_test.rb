require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "the truth" do
   us=User.new
    assert !us.save
   end
   
  test "should not save post without title" do
  us = User.new
  assert_not us.save, "Saved the post without a title"
end
end
