class ReservationSerializer < ActiveModel::Serializer
	attributes :id, :fecha, :client_id, :user_id, :monto_total ,:own_items

	def own_items
		@items = {}
		object.reservation_items.each{|ri|@items.merge!({"#{ri.item_id}": {"estado": "#{ri.item.estado}","product_id": "#{ri.item.product_id}","reservation_id": "#{ri.item.reservation_id}","sell_id": "#{ri.item.sell_id}","created_at": "#{ri.item.created_at}","updated_at": "#{ri.item.updated_at}"}})}
		@items
	end
	
	def monto_total
		@total=0
		object.reservation_items.each{|reservation_item|
		  @total = @total + reservation_item.valor}
		@total
	  end

end