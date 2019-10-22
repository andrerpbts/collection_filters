module CollectionFilters
  class Document < ApplicationRecord
    validates :name, presence: true
  end
end
