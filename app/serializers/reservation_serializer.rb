class ReservationSerializer < ActiveModel::Serializer
	attributes :id, :fecha, :client_id, :user_id, :monto_total,:venta_asociada ,:items

	def venta_asociada
		@sell = Sell.find_by(reservation_id: object.id)
	end

	def items
		@items = {}
		object.reservation_items.each{|ri|@items.merge!({"#{ri.item_id}": {"estado": "#{ri.item.estado}","product_id": "#{ri.item.product_id}","reservation_id": "#{ri.item.reservation_id}","sell_id": "#{ri.item.sell_id}","created_at": "#{ri.item.created_at}","updated_at": "#{ri.item.updated_at}"}})}
		@items
	end
	
	def monto_total
		object.monto_total
	  end

end