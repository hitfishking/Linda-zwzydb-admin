# encoding: utf-8
class Ke
	include Mongoid::Document
	include Mongoid::Attributes::Dynamic

	field :name, type: String

	has_many  :shus, dependent: :delete,  validate: false
end

