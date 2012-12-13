class Record < ActiveRecord::Base
  attr_accessible :data, :record_id
  belongs_to :collection
end