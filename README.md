# csvp

[![Build Status](https://travis-ci.org/mscavnicky/csvp.svg?branch=master)](https://travis-ci.org/mscavnicky/csvp)
[![codecov](https://codecov.io/gh/mscavnicky/csvp/branch/master/graph/badge.svg)](https://codecov.io/gh/mscavnicky/csvp)

`csvp` helps you effortlessly print enumerables as CSV.

Inspired by `awesome_print` and useful for getting your data from Ruby console to Excel or Slack.

Give it an `Enumerable` of objects and they will be printed as CSV on best effort basis. It will even determine the header if possible. Within your enumerable, you can not only use standard Ruby objects like `Array`, `Hash`, `Struct` or `OpenStruct` but also `ActiveRecord` objects from Rails.

## Installation

```
$ gem install csvp
```

## Usage

First, require `csvp` in your program

```
> require 'csvp'
```

Then print an `Array` of `Array`-s


```
> csvp [['Alice', 'Bob'],['Chuck', 'Donald']]
Alice,Bob
Chuck,Donald
```

or an `Array` of `Hash`-es

```
> csvp [{'Alice': 1, 'Bob': 2}, {'Alice': 3, 'Bob': 4}]
Alice,Bob
1,2
3,4
```

or some `ActiveRecord` objects

```
> csvp User.all
email,name,age
alice@csvp.com,Alice,29
bob@csvp.com,Bob,43
```

## Options

All of the options supported by Ruby CSV module can be used.

So you can choose the column separator

```
> csvp [['Alice', 'Bob'],['Chuck', 'Donald']], col_sep: "\t"
Alice	Bob
Chuck	Donald
```

or the quote character

```
> csvp [['Alice', 'Bob'],['Chuck', 'Donald']], quote_char: "\"", force_quotes: true
"Alice","Bob"
"Chuck","Donald"
```

Conveniently, the two options above are wrapped in their own method - `tsvp` and `qcsvp` respectively.

## Other CSV goodies

* [q](http://harelba.github.io/q/) is a command line tool that allows direct execution of SQL-like queries on CSVs/TSVs

* [conformist](https://github.com/tatey/conformist) allows to bend CSVs to your will with declarative schemas
