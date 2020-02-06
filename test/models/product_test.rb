require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product= products(:one)
  end
  
  test 'invalid without detalle' do
    @product.detalle= nil
    refute @product.valid?, 'product is valid without a detalle'
    assert_not_nil @product.errors[:detalle], 'no validation error for detalle'
  end

  test 'invalid without codigo' do
    @product.codigo= nil
    refute @product.valid?, 'product is valid without a codigo'
    assert_not_nil @product.errors[:codigo], 'no validation error for codigo'
  end

  test 'invalid without descripcion' do
    @product.descripcion= nil
    refute @product.valid?, 'product is valid without a descripcion'
    assert_not_nil @product.errors[:descripcion], 'no validation error for descripcion'
  end

  test 'invalid without montoU' do
    @product.montoU= nil
    refute @product.valid?, 'product is valid without a montoU'
    assert_not_nil @product.errors[:montoU], 'no validation error for montoU'
  end

  test 'add items to product' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    assert_equal 2,@product.items_disponibles.count
  end

  test 'devolver items' do
    Item.create(product_id: @product.id, estado: 'disponible')
    Item.create(product_id: @product.id, estado: 'disponible')
    assert_equal 2,@product.devolver_items(2).count
  end

end