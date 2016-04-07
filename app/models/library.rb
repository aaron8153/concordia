class Library < ActiveRecord::Base
  has_many :books
  has_many :records
end
