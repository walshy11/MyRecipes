require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "John", email: "john@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "chefname is not too long" do
    @chef.chefname = "a" * 40
    assert_not @chef.valid?
  end
  
  test "chefname is not too short" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test "email must be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email length should be within bounds" do
    @chef.email = "a" * 101 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid email addresses" do
    valid_addresses = %w[user@bbb.com R_TDO-DS@eee.hello.org user@example.com first.last@ddd.au laura+joe@dvg.co]
    valid_addresses.each do |t|
      @chef.email = t
      assert @chef.valid?, '#{t.inspect} should be valid'
    end
  end

  test "email validation should reject invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.com user.name@example, eee@i_am.com foo@ee+car.com]
    invalid_addresses.each do |t|
      @chef.email = t
      assert_not @chef.valid?, '#{t.inspect} should be invalid'
    end
  end

end