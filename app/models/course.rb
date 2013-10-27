class Course < ActiveRecord::Base
	validates :name, presence: true, 
	                 length: { maximum: 50 }
	# Need to validate fee by using regex to be a number
end
