class BaseIntr < ActiveInteraction::Base
  def supervise_api_call
    yield
  rescue ::StandardError => exception
    errors.add(:base, I18n.t('api.error', exception_class: exception.class.name, exception_cause: exception.cause))
  end
end
