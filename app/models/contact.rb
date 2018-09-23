class Contact < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  has_many :messages, dependent: :destroy

  scope :confirmed, -> { where.not(confirmed_at: nil) }
  scope :unconfirmed, -> { where(confirmed_at: nil) }
  scope :sent_by, lambda { |user| where(sender: user) }
  scope :received_by, lambda { |user| where(receiver: user) }


  def last_message
    messages.includes(:user).last
  end

  def confirm
    return false unless confirmable?
    self.confirmed_at = Time.zone.now
    save
  end

  def confirmed?
    confirmed_at.present?
  end

  private

  def confirmable?
    !confirmed? && valid?
  end
end
