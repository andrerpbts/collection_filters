module CollectionFilters
  class Query
    def initialize(collection:, available_filters: {})
      @collection = collection
      @available_filters = build_filters(available_filters.symbolize_keys)
    end

    def call(filters: {})
      apply_filters(filters)

      collection
    end

    private

    attr_reader :collection, :available_filters, :max_per_page

    def build_filters(available_filters)
      available_filters.map do |name, config|
        config = { filter: config } if config.is_a?(Symbol)
        config[:column_name] ||= name

        klazz = class_name_for(config[:filter]).constantize

        [name, klazz&.new(config)]
      end.compact.to_h
    end

    def apply_filters(filters)
      filters.each do |filter_name, value|
        filter = available_filters[filter_name.to_sym]

        @collection = filter.apply(collection, value) if filter
      end
    end

    def class_name_for(filter)
      "CollectionFilter::Filters::#{filter.to_s.camelize}Filter"
    end
  end
end
