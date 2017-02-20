class Forum < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: :slugged

	def self.search(search)
		where("title LIKE ?", "%#{search}%")
	end
end
