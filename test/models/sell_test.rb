require "test_helper"

class SellTest < ActiveSupport::TestCase
  def setup
    @sell= sells(:one)
    @reservation= reservations(:one)
    @product= products(:one)
  end
  
  test 'invalid without user_id' do
    @sell.user_id= nil
    refute @sell.valid?, 'sell is valid without a user_id'
    assert_not_nil @sell.errors[:user_id], 'no validation error for user_id'
  end

  test 'invalid without client_id' do
    @sell.client_id= nil
    refute @sell.valid?, 'sell is valid without a client_id'
    assert_not_nil @sell.errors[:client_id], 'no validation error for client_id'
  end

  test 'invalid without fecha' do
    @sell.fecha= nil
    refute @sell.valid?, 'sell is valid without a fecha'
    assert_not_nil @sell.errors[:fecha], 'no validation error for fecha'
  end

  test 'add items to sell' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    @sell.add_items(@product.codigo,2)
    assert_equal 2, @sell.sell_items.count()
  end

  test 'monto total' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    @sell.add_items(@product.codigo,2)
    assert_equal (@product.montoU + @product.montoU), @sell.monto_total 
  end

  test 'cancel' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    @sell.add_items(@product.codigo,2)
    assert_equal 2, @sell.sell_items.count()
    @sell.cancelar
    assert_equal 0, @sell.sell_items.count()
  end

  test 'add items of reservation' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    @reservation.add_items(@product.codigo,2)
    assert_equal 2, @reservation.reservation_items.count()
    @sell.add_items_reservation(@reservation.reservation_items)
    assert_equal 2, @sell.sell_items.count()
  end

end