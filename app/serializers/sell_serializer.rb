class SellSerializer < ActiveModel::Serializer
	attributes :id, :fecha, :client_id, :user_id, :monto_total, :own_items

	def own_items
		@items = {}
		object.sell_items.each{|si|@items.merge!({"#{si.item_id}": {"estado": "#{si.item.estado}","product_id": "#{si.item.product_id}","reservation_id": "#{si.item.reservation_id}","sell_id": "#{si.item.sell_id}","created_at": "#{si.item.created_at}","updated_at": "#{si.item.updated_at}"}})}
		@items
	end

	def monto_total
		@total=0
		object.sell_items.each{|sell_item|
		  @total = @total + sell_item.valor}
		@total
	  end
end