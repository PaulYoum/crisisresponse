class Officer < ActiveRecord::Base
  has_many :authored_response_plans,
    class_name: "Person",
    foreign_key: :author_id,
    dependent: :destroy

  has_many :approved_response_plans,
    class_name: "Person",
    foreign_key: :approver_id,
    dependent: :destroy
end
