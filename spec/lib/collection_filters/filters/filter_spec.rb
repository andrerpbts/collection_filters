require 'rails_helper'

RSpec.describe CollectionFilters::Filters::Filter do
  describe '#apply' do
    let(:collection) { Document.all }

    context 'when the inherited class did not implement the apply method' do
      let(:config) do
        {}
      end

      subject(:filter) do
        CollectionFilters::Filters::DummyDateFilter
          .new(config)
          .apply(collection, '')
      end

      it { expect { filter }.to raise_error(NotImplementedError) }
    end

    context 'when the inherited class implements the apply method' do
      let(:config) do
        {
          column_name: 'name',
          table_name: 'documents'
        }
      end

      let(:expected) do
        %{
          column_name: name
          column: documents.name
          value: foobar
        }.strip_heredoc
      end

      subject(:filter) do
        CollectionFilters::Filters::DummyStringFilter
          .new(config)
          .apply(collection, 'foobar')
      end

      it { expect(filter).to eq(expected) }
    end
  end
end
