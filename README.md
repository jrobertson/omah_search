# Introducing the Omah_search gem

## Example

    os = OmahSearch.new '/home/james/email/headers.db'
    result = os.search('weather')
    puts result

## Output

<pre>
| date       | from                        | to                          | subject                                                                                                        |
|:-----------|:----------------------------|:----------------------------|:---------------------------------------------------------------------------------------------------------------|
| 2016-05-11 | xxxxx@xxxjohnlewis.com | xxxxx@jamesrobertson.eu    | Whatever the weather                                                                                           |
| 2016-04-27 | info@twitter.com            | xxxxxx@gmail.com | littleBits tweeted: Use #arduino to teach students how to monitor current and forecasted weather data #MakerEd |
| 2016-03-25 | xxxx@raspberrypi.org      | xxxx@jamesrobertson.eu     | Raspberry Pi Weekly Issue #145 - Weather
</pre>                            

Notes:

* The results are sorted in reverse chronological order
* The results are limited to a maximum of 10 records
* The table is in Markdown format which can conveniently be rendered to HTML.

## Resources

* omah_search https://rubygems.org/gems/omah_search

omah_search omah search email sqlite
