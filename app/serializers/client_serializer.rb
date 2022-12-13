class ClientSerializer < ActiveModel::Serializer
  attributes :id, :phone_number, :operator_code, :tag, :timezone
end
