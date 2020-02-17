class User < ApplicationRecord
  
  filterrific(
     default_filter_params: { sorted_by: 'created_at_desc' },
     available_filters: [
       :sorted_by,
       :search_query,
       :with_created_at,
       :with_date,
       :with_status,
       :with_user_id
     ]
   )

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates_presence_of :first_name, :last_name , optional: true
  
  has_many :posts 
  has_many :members, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :members, :reject_if => proc { |att| att[:first_name].blank? && att[:last_name].blank? && att[:birth_year].blank? }, allow_destroy: true

  ###### filteriffic 
  # self.per_page = 20
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
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          
          "LOWER(customers.customer_name) LIKE ?",
          "LOWER(jobs.description) LIKE ?"
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
      order("jobs.created_at #{ direction }")
    when /^date_/
      order("jobs.date #{ direction }")
    when /^status_/
      order("jobs.status #{ direction }")
    when /^customer_name_/
      order("customers.customer_name #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  
  scope :with_status, lambda { |status|
      where(:status => [*status])
    }
  scope :with_created_at, lambda { |ref_date|
    where('jobs.created_at::date = ?', ref_date)
  }
  scope :with_date, lambda { |ref_date|
    where('jobs.date::date = ?', ref_date)
  }
  scope :with_user_id, lambda { |user_ids|
    where(user_id: [*user_ids]) }

  scope :with_customer_name, lambda { |customer_name|
    where(customer: { name: customer_name }).joins(:customer)
  }

  delegate :name, :to => :status, :prefix => true

  def self.options_for_sorted_by
    [
      ['Order date (newest first)', 'created_at_desc'],
      ['Order date (oldest first)', 'created_at_asc'],
      ['Job date (Asc)', 'date_asc'],
      ['Job date (Desc)', 'date_desc'],
      ['Customer (a-z)', 'customer_name_asc'],
      ['Customer (z-a)', 'customer_name_desc']
    ]
  end


  def decorated_created_at
    created_at.to_date.to_s(:long)
  end
  
  def self.options_for_select
    [
          ['In Progress', 'in_progress'],
          ['Canceled', 'canceled'],
          ['Delayed', 'delayed'],
          ['Job done', 'job_done'],
          ['Job paid', 'paid']
        ]
    # order('LOWER(customer_name)').map { |e| [e.customer_name, e.id] }    
  end
  # filteriffic 



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :first_name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :email, :password, :password_confirmation, :current_password) }
  end     
end
