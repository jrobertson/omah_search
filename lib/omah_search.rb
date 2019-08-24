#!/usr/bin/env ruby

# file: omah_search.rb

require 'dynarex'
require 'recordx_sqlite'


class OmahSearch

  def initialize(db_file='headers.db', url_base: nil, limit: 20)
    
    @rs = RecordxSqlite.new(db_file)
    @url_base = url_base
    @limit = limit

  end

  def search(keyword)

    @rs.query( "select date, from_x, to_x, subject, filepath from headers " + 
          "where from_x like '%#{keyword}%' " + 
          "or subject like '%#{keyword}%' order by id desc limit #{@limit}" +
          " COLLATE NOCASE")
    
    a = @rs.all.map do |x| 
      
      {
        date: x.date[/^[^T]+/], from: x.from_x, to: x.to_x, subject: x.subject,
        url: "[link](%s%s)" % [@url_base, x.filepath]
      }
        
    end
    
    dx = Dynarex.new
    dx.import a
    table = dx.to_table      
    table.labels = %w(date from to subject link)
    table.markdown = true
    table
  end
  
  def list_sender(to_x: '', group_by_domain: true)
    
    a = @rs.query "select from_x from headers where to_x like \"#{to_x}\"", 
        heading: false
    
    blk = group_by_domain ? ->(x){ x[/@[^$]+$/]} : ->(x){x}
    a2 =  a.flatten(1).group_by(&blk)
    a2.sort_by {|key, value| -value.length}.map {|x| [x[0], x[-1].length]}
    
  end

end
