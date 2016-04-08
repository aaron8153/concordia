class Library < ActiveRecord::Base
  has_many :books, :dependent => :destroy
  has_many :records, :dependent => :destroy
end
