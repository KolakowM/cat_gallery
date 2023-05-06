class Item < ApplicationRecord
    has_one_attached :cover_image
    belongs_to :user
end
