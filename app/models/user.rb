class User < ActiveRecord::Base
	# Before Adding any field for User to fill out, don't forget to add the
	# params.require(user).permit
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	PREFER_LANGUAGE_TYPES = ["Mandarin","English","English and Mandarin"]
	ROLE_TYPES = ["Admin","Mentee","Mentor"]

	validates :name, presence: true, 
	                 length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
	                  format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: { case_sensitive: false }
	                  
 	validates :language, :inclusion => PREFER_LANGUAGE_TYPES
 	validates :role, :inclusion => ROLE_TYPES

	has_secure_password
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

     	def create_remember_token
    		self.remember_token = User.encrypt(User.new_remember_token)
   		end
end
