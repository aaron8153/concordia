class Library < ActiveRecord::Base
  has_many :books, :dependent => :destroy
  has_many :records, :dependent => :destroy

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
