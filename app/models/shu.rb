# encoding: utf-8
class Shu
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic

	field :name, type: String

	has_many :zhongs, dependent: :delete, validate: false
	belongs_to :ke

end

