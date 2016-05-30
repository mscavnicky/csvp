# csvp

[![Build Status](https://travis-ci.org/mscavnicky/csvp.svg?branch=master)](https://travis-ci.org/mscavnicky/csvp)

`csvp` helps you effortlessly print enumerables as CSV. Supports basic Ruby (Array, Hash, Set, Struct, OpenStruct) and ActiveRecord (Base, Relation) structures.

## Installation

```
$ gem install csvp
```

## Usage

```
$ require 'csvp'
$ csvp [ { a: 1, b: 2 }, { a: 3, b: 4 } ]
a,b
1,2
3,4
```
