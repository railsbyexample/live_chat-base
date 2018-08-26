class Account < ApplicationRecord
  validates :subdomain, presence: true, uniqueness: true, url_safe: true
end
