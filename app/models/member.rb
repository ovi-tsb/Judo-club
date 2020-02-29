class Member < ApplicationRecord
  enum status: {  inactive: 0, 
                    active: 1
                  }

  enum pay_status: {  unpaid: 0, 
                      paid: 1
                    }


  belongs_to :user, optional: true

  filterrific(
     default_filter_params: { sorted_by: 'created_at_desc' },
     available_filters: [
       :sorted_by,
       :search_query,
       :with_created_at,
       :with_member_first_name,
       :with_user_first_name,
       :with_status,
       :with_pay_status,
       :with_user_id
     ]
   )


  ###### filteriffic 
  self.per_page = 20
  ########  searching
  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 4
    where(
      terms.map {
        or_clauses = [
          "LOWER(members.first_name) LIKE ?",
          "LOWER(members.last_name) LIKE ?",
          "LOWER(users.first_name) LIKE ?",
          "LOWER(users.last_name) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }
  
  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("users.created_at #{ direction }")
    when /^pay_status_/
      order("members.pay_status #{ direction }")
    when /^status_/
      order("members.status #{ direction }")
    when /^member_first_name_/
      order("members.first_name #{ direction }")
    when /^user_first_name_/
      order("users.first_name #{ direction }")
      # order("LOWER(members.last_name) #{direction}, LOWER(members.first_name) #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  
  scope :with_status, lambda { |status|
      where(:status => [*status])
    }
  scope :with_pay_status, lambda { |pay_status|
      where(:pay_status => [*pay_status])
    }
  scope :with_created_at, lambda { |ref_date|
    where('users.created_at::date = ?', ref_date)
  }
  # scope :with_date, lambda { |ref_date|
  #   where('jobs.date::date = ?', ref_date)
  # }
  # scope :with_user_id, lambda { |user_ids|
  #   where(user_id: [*user_ids]) }

  # scope :with_customer_name, lambda { |customer_name|
  #   where(customer: { name: customer_name }).joins(:customer)
  # }

  delegate :name, :to => :status, :prefix => true
  delegate :name, :to => :pay_status, :prefix => true

  def self.options_for_sorted_by
    [
      ['Order date (newest first)', 'created_at_desc'],
      ['Order date (oldest first)', 'created_at_asc'],
      ['Member (a-z)', 'member_first_name_asc'],
      ['Member (z-a)', 'member_first_name_desc']
    ]
  end


  def decorated_created_at
    created_at.to_date.to_s(:long)
  end
  
  def self.options_for_select
    [
      ['Active', 'active'],
      ['Inactive', 'inactive']
    ]
    # order('LOWER(customer_name)').map { |e| [e.customer_name, e.id] }    
  end
  def self.options_for_select_2
    [
      ['Paid', 'paid'],
      ['Unpaid', 'unpaid']
    ]
  end
  # filteriffic 
end
