class ClientContract < Dry::Validation::Contract
  params do
    required(:phone_number).filled(:string)
    required(:operator_code).filled(:string)
    required(:tag).filled(:string)
    required(:timezone).filled(:string)
  end

  rule(:phone_number) do
    unless /^7[0-9]{10}$/.match?(value)
      key.failure('Invalid phone number format')
    end
  end

  rule(:timezone) do
    unless ActiveSupport::TimeZone[value].present?
      key.failure('Invalid timezone')
    end
  end
end