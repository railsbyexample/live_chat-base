class UrlSafeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    parameterized = value.parameterize

    return if value == parameterized

    record.errors[attribute] << (options[:message] || "is not a valid subdomain, try with #{parameterized}")
  end
end
