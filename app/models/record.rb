class Record < ActiveRecord::Base
  belongs_to :library
  has_one :book


end
