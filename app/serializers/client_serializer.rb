class ClientSerializer < ActiveModel::Serializer
	attributes :nombre ,:condicion ,:email ,:cuil ,:phones

	def phones
        object.phones.collect{|phone|phone.number}
    end
end