require 'rails_helper'

RSpec.describe CollectionFilters::Query do
  describe '#call' do
    subject(:filter) do
      described_class.new(collection: collection, available_filters: available_filters)
    end

    let(:collection) { Document.all }

    let(:available_filters) do
      {
        created_at: { filter: :dummy_date },
        name: :dummy_string
      }
    end

    it 'calls each given filter properly' do
      filters = {
        name: 'FILTERED%',
        created_at: '2019-09-02'
      }

      filters.each do |filter_name, value|
        options = available_filters[filter_name]
        klazz_name = (options.try(:fetch, :filter) || options).to_s.camelize
        klazz = "CollectionFilters::Filters::#{klazz_name}Filter".constantize
        instance = double(apply: Document.none)

        expect(klazz)
          .to receive(:new)
          .with(column_name: filter_name, filter: options.try(:fetch, :filter) || options)
          .and_return(instance)

        expect(instance)
          .to receive(:apply)
          .with(a_kind_of(ActiveRecord::Relation), value)
      end

      filter.call(filters: filters)
    end
  end
end
