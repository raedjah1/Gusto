class TransactionService
  class TransactionError < StandardError; end

  def self.process_transaction(chef_profile:, amount:, transaction_type:)
    ActiveRecord::Base.transaction do
      # For withdrawals, validate sufficient funds and make amount negative
      if transaction_type == 'withdrawal'
        if chef_profile.wallet_balance < amount
          raise TransactionError, 'Insufficient funds for withdrawal'
        end
        amount = -amount # Make withdrawal amounts negative
      end

      # Create the transaction
      transaction = chef_profile.transactions.build(
        amount: amount,
        transaction_type: transaction_type
      )

      unless transaction.save
        raise TransactionError, "Failed to create transaction: #{transaction.errors.full_messages.join(', ')}"
      end

      transaction
    end
  rescue ActiveRecord::RecordInvalid => e
    raise TransactionError, "Invalid transaction: #{e.message}"
  end
end
