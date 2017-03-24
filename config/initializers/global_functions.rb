def development?
  Rails.env.development?
end

def test?
  Rails.env.test?
end

def production?
  Rails.env.production?
end

def development_or_test?
  development? || test?
end

def development_or_production?
  development? || production?
end

def address_changed_and_development_or_production?
  address_changed? && development_or_production?
end

def ci?
  # [ENV['CODESHIP'], ENV['CI']].any? &:present?
end