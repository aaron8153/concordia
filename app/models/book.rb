class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :library
  has_many :records, :dependent => :destroy

  filterrific(
      default_filter_params: { sorted_by: 'name_asc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_library_id,
          :with_user_id
      ]
  )

  scope :search_query, lambda { |query|

     return nil  if query.blank?
     terms = nil
     # condition query, parse into individual keywords
     if !query.is_a?(Fixnum)
      terms = query.downcase.split(/\s+/)


     # replace "*" with "%" for wildcard searches,
     # append '%', remove duplicate '%'s
      terms = terms.map { |e|
        (e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
     # configure number of OR conditions for provision
     # of interpolation arguments. Adjust this if you
     # change the number of OR conditions.
     else
       terms = [query]
     end
     num_or_conds = 2
     where(
         terms.map { |term|
           "(LOWER(books.name) LIKE ? OR LOWER(books.isbn) LIKE ?)"
         }.join(' AND '),
         *terms.map { |e| [e] * num_or_conds }.flatten
     )
  }
  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        order("books.created_at #{ direction }")
      when /^name_/
        order("LOWER(books.name) #{ direction }")
      when /^isbn_/
        order("LOWER(books.isbn) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  scope :with_library_id, lambda { |library_ids|
    where(library_id: [*library_ids])
  }
  scope :with_user_id, lambda { |user_ids|
    where(user_id: [*user_ids])
  }

  # This method provides select options for the `sorted_by` filter select input.
  # It is called in the controller as part of `initialize_filterrific`.
  def self.options_for_sorted_by
    [
        ['Book Name (a-z)', 'name_asc'],
        ['Book Name (z-a)', 'name_desc'],
        ['Isbn Number (a-z)', 'isbn_asc'],
        ['Isbn Number (z-a)', 'isbn_desc'],
        ['Book date (newest first)', 'created_at_desc'],
        ['Book date (oldest first)', 'created_at_asc']

    ]
  end

end
