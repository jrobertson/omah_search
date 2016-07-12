#!/usr/bin/env ruby

# file: omah_search.rb

require "sqlite3"
require 'dynarex'


class OmahSearch

  def initialize(db_file='headers.db')

    @db = SQLite3::Database.new db_file
    @db.results_as_hash = true

  end

  def search(keyword)

    r = @db.query( "select date, from_x, to_x, subject from headers " + 
          "where from_x like '%#{keyword}%' " + 
          "or subject like '%#{keyword}%' order by id desc limit 10" )

    dx = Dynarex.new
    a = r.to_a.map {|row| row[0].slice!(/T[^T]+$/); row}

    dx.import a
    table = dx.to_table      
    table.labels = %w(date from to subject )
    table.markdown = true
    table
  end

end
