# frozen_string_literal: true
require 'net/http'
require 'open-uri'
require 'json'



      def parseUrl(url)
        uri = URI.parse(url)
        res = Net::HTTP.get_response(uri).body.to_json
        names = JSON.parse(res)
        return names
      end
      space = parseUrl("https://smartlogic.io/about/community/apprentice/code-test/space.txt")
      comma = parseUrl("https://smartlogic.io/about/community/apprentice/code-test/comma.txt")
      pipe = parseUrl("https://smartlogic.io/about/community/apprentice/code-test/pipe.txt")



      def sort_by_gender(unsorted)
        
      end
      puts "S P A C E:"
      puts space
      puts "C O M M A:"
      puts comma
      puts "P I P E:"
      puts pipe
      

    
  