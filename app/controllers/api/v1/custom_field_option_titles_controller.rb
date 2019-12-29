class Api::V1::CustomFieldOptionTitlesController < ApiController
  def index
    plan_durations = CustomFieldOptionTitle.all
    if plan_durations.present?
      get_plan_durations = GetPlanDurationSerializer.new(plan_durations).serializable_hash[:data].map{ |data| data[:attributes]}
      success_response_with_object(get_plan_durations,
        "Ok")
    else
      error_response_without_obj(
        HTTP_NOT_FOUND,
        I18n.t("#{get_controller}.index.plan_duration_not_found")
      )
    end
  end
end
