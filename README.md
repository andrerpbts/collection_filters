# CollectionFilters

[![Build Status](https://travis-ci.org/andrerpbts/collection_filters.svg?branch=master)](https://travis-ci.org/andrerpbts/collection_filters)

A tool to help you to add filter params in your APIs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'collection_filters'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install collection_filters
```

## Usage

To use it, just define a new collection filter set with the initial collection and the allowed filters you will accept in your API, then call it and retrieve the data, e.g (Rails app):

```ruby
def index
  filter = CollectionFilter.define(
    collection: current_user.documents.includes(:document_type),
    available_filters: {
      created_at: :date,
      archived_at: :date,
      status: {
        filter: :list,
        column_name: :aasm_state,
        accepted_values: %w[pending archived rejected]
      },
      document_type_code: {
        filter: :list,
        column_name: :code,
        table_name: :document_types
      }
    }
  )

  @documents = filter.call(filters: params)

  render json: @documents.per(50).page(params[:page]), status: :ok
end
```

In this example, we're instruction collection filter to get the initial collection `current_user.documents.includes(:document_type)` and for each param sent in `params`, we are just allowing `[:created_at, :archived_at, :status, :document_type_code]`. Please note when you have simple filters you can just set it using its name as symbol, otherwise you can configure it to tell it what is the table, column, or any other configuration needed. In these cases you must specify the filter name through `filter` config option.

Then, with the filters all set, we can just call it passing the proper received params. It'll return a collection, then you can apply any other command to the relation, like paginate, ordering, grouping, etc...

So, here are the filters available now:

#### Date filter

Date filter accepts a string with one or more dates which will coerce into date/datetime and filter the collection. Some examples are:

- '2019-10-01, 2019-10-03' will coerce into:
    [
      Date.new(2019, 10, 1).beginning_of_day..Date.new(2019, 10, 1).end_of_day,
      Date.new(2019, 10, 3).beginning_of_day..Date.new(2019, 10, 3).end_of_day
    ]

- '2019-10-01..2019-10-03' will coerce into:
    [
      Date.new(2019, 10, 1).beginning_of_day..Date.new(2019, 10, 3).end_of_day
    ]

- '2019-10-01T23:10:00..2019-10-03' will coerce into:
    [
      DateTime.new(2019, 10, 1, 23, 10, 0)..Date.new(2019, 10, 3).end_of_day
    ]

#### Integer filter

Integer filter accepts a string or an array wich will coerce to integer and filter the collection. Some examples are:

- '1,2,3' will coerce into:
    [1, 2, 3]

- '1..3' will coerce into:
    [1..3]

#### String Filter

String filters just accepts a string (with or without wildcards) and will filter the collection. Some examples are:

- 'test%' will filter the collection with `LIKE 'test%'
- 'foobar' will filter the collection with `LIKE 'foobar'

#### List Filter

This filter accepts a string or an array which can be (or not) validate through `accepted_values` config option. and, it filters the collection. Some examples are:

- 'pending, accepted' with empty `accepted_values` will coerce into:
  ['pending', 'accepted']

- 'pending, accepted' with `accepted_values` as `['pending']` will coerce into:
  ['pending']

## Contributing

* Fork it
* Make your implementations
* Send me a pull request

Thank you!

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
