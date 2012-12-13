class App < ActiveRecord::Base
  attr_accessible :name
  has_many :collections
end
