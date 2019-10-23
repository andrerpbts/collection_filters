require 'collection_filters/engine'
require 'collection_filters/filters/filter'
require 'collection_filters/query'

module CollectionFilters
  def self.define(collection:, available_filters: {})
    Query.new(
      collection: collection,
      available_filters: available_filters
    )
  end
end
