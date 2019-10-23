module CollectionFilters
  module Filters
    class DummyDateFilter < Filter; end

    class DummyStringFilter < Filter
      def apply(_collection, value)
        %{
          column_name: #{column_name}
          column: #{column}
          value: #{value}
        }.strip_heredoc
      end
    end
  end
end
