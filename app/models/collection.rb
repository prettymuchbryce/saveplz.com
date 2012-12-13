class Collection < ActiveRecord::Base
  attr_accessible :name, :current_id
  has_many :records
  belongs_to :app
end