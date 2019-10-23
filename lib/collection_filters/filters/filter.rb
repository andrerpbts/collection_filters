module CollectionFilters
  module Filters
    class Filter
      def initialize(config)
        @config = config

        setup
      end

      def apply(_collection, _value)
        raise NotImplementedError
      end

      protected

      attr_reader :config

      def column_name
        config[:column_name].to_sym
      end

      def column
        return config[:column] unless config[:table_name]

        "#{config[:table_name]}.#{config[:column_name]}"
      end

      def table
        config[:table_name] && Arel::Table.new(config[:table_name].to_sym)
      end

      private

      def setup
        config[:column] = config[:column_name].to_s

        table, column = config[:column_name].to_s.split('.')

        return unless column.present?

        config[:column_name] = column
        config[:table_name] ||= table
      end
    end
  end
end
