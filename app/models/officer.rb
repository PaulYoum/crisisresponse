class Officer < ActiveRecord::Base
  include Analytics
  before_create :generate_analytics_token

  has_many :authored_response_plans,
    class_name: "ResponsePlan",
    foreign_key: :author_id,
    dependent: :destroy

  has_many :approved_response_plans,
    class_name: "ResponsePlan",
    foreign_key: :approver_id,
    dependent: :destroy
end
