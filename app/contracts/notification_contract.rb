class NotificationContract < Dry::Validation::Contract
  params do
    required(:start_at).filled(:string)
    required(:end_at).filled(:string)
    required(:text).filled(:string)
    required(:filter).filled(:string)
  end

  rule(:start_at, :end_at) do
    unless /^\d{4}-\d{2}-\d{2}\w\d{2}:\d{2}:\d{2}\+\d{2}:\d{2}$/.match?(value)
      key.failure('Invalid datetime format')
    end
  end
end