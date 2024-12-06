class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class


  # Common Scopes

  # Scope to retrieve records created in the last 'n' days
  scope :recent, ->(days = 7) { where('created_at >= ?', days.days.ago) }

  # Common instance methods

  # Returns the creation time in a more readable format
  def formatted_created_at
    created_at.strftime('%B %d, %Y at %I:%M %p')
  end

  # A method to archive a record if models have an `archived` attribute
  def archive
    update(archived: true) if self.respond_to?(:archived)
  end
end
