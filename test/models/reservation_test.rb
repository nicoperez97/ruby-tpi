require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  def setup
    @reservation= reservations(:one)
    @product = products(:one)
  end
  
  test 'invalid without user_id' do
    @reservation.user_id= nil
    refute @reservation.valid?, 'reservation is valid without a user_id'
    assert_not_nil @reservation.errors[:user_id], 'no validation error for user_id'
  end

  test 'invalid without client_id' do
    @reservation.client_id= nil
    refute @reservation.valid?, 'reservation is valid without a client_id'
    assert_not_nil @reservation.errors[:client_id], 'no validation error for client_id'
  end

  test 'invalid without fecha' do
    @reservation.fecha= nil
    refute @reservation.valid?, 'reservation is valid without a fecha'
    assert_not_nil @reservation.errors[:fecha], 'no validation error for fecha'
  end


  test 'add items to reservation' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    @reservation.add_items(@product.codigo,2)
    assert_equal 2, @reservation.reservation_items.count()
  end

  test 'monto total' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    @reservation.add_items(@product.codigo,2)
    assert_equal (@product.montoU + @product.montoU), @reservation.monto_total 
  end

  test 'cancel' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    @reservation.add_items(@product.codigo,2)
    assert_equal 2, @reservation.reservation_items.count()
    @reservation.cancelar
    assert_equal 0, @reservation.reservation_items.count()
  end


end