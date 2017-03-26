class Availability < ApplicationRecord
  belongs_to :car

  DAYS = [I18n.t('days.monday'), I18n.t('days.tuesday'), I18n.t('days.wednesday'), I18n.t('days.thursday'), I18n.t('days.friday'), I18n.t('days.saturday'), I18n.t('days.sunday')].freeze

end
