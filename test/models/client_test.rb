require "test_helper"

class ClientTest < ActiveSupport::TestCase
  def setup
    @client= clients(:one)
  end
  
  test 'invalid without cuild' do
    @client.cuil= nil
    refute @client.valid?, 'client is valid without a cuil'
    assert_not_nil @client.errors[:cuil], 'no validation error for cuil'
  end

  test 'invalid without nombre' do
    @client.nombre= nil
    refute @client.valid?, 'client is valid without a nombre'
    assert_not_nil @client.errors[:nombre], 'no validation error for nombre'
  end

  test 'invalid without iva' do
    @client.condicion= nil
    refute @client.valid?, 'client is valid without a condicion'
    assert_not_nil @client.errors[:condicion], 'no validation error for condicion'
  end

  test 'invalid without mail' do
    @client.email= nil
    refute @client.valid?, 'client is valid without a email'
    assert_not_nil @client.errors[:email], 'no validation error for email'
  end

  test 'add phones to client' do
    @client.add_phones(2213523452)
    @client.add_phones(2213523452)
    assert_equal 2,@client.phones.count
  end
end