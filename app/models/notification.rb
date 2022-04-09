class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :article, optional: true
  belongs_to :post_comment, optional: true
  
  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
  
  ACTION_VALUES = ["favorite", "comment", "follow"].freeze

  validates :visitor_id, presence: true
  validates :visited_id, presence: true
  validates :action,  presence: true, inclusion: { in: ACTION_VALUES }
  validates :checked, inclusion: { in: [true, false] }
end
