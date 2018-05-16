class Oleg < ApplicationRecord
	include OlegsHelper
  belongs_to :user
	#validates :answer, :presence => true
	validate :right_answer
	
	private

  	#validates the size of an uploaded picture
  	def right_answer
  		if !(answer == $answer)
  			errors.add(:picture, "should be less than 5MB")
        p answer
  		end
  	end
#
end
