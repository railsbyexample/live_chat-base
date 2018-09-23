class Contact < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :unconfirmed, -> { where(confirmed_at: nil) }

  def confirm
    return false unless confirmable?
    self.confirmed_at = Time.zone.now
    save
  end

  private

  def confirmed?
    confirmed_at.present?
  end

  def confirmable?
    !confirmed? && valid?
  end
end
