class Session < ApplicationRecord
  belongs_to :from, class_name: 'CadSystem', foreign_key: 'from_id', required: true
  belongs_to :to, class_name: 'CadSystem', foreign_key: 'to_id', required: true
end
