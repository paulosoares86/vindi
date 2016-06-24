module Vindi
  # A charge is sent to a customer so he can pay and maintain its subscription
  # A charge can have multiple transactions
  class Charge < Base
    include Vindi::API::Create
    include Vindi::API::List
    include Vindi::API::Delete
    include Vindi::API::Update
    include Vindi::API::Get

    def self.paid_charges_per_users
      ret = {}
      all.each do |charge|
        next if charge.status != 'paid'
        user_email = charge.customer.email
        ret[user_email] ||= []
        ret[user_email] << charge
      end
      ret
    end
  end
end
