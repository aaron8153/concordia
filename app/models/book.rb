class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :library
  has_many :records, :dependent => :destroy

end
