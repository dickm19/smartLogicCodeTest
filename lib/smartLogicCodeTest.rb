# frozen_string_literal: true
require 'net/http'
require 'open-uri'
require 'json'



      def parseUrl(url)
        uri = URI.parse(url)
        res = Net::HTTP.get_response(uri).body.to_json
        data = JSON.parse(res).split
        return data
      end

      def remove_extra_characters(data)
        # puts "before", data
        data.map do | item |
          if item == "|"
            data.delete(item)
          elsif item.include?(",")
            index = data.find_index(item)
            data[index] = item.tr(',', '')
          end
        end
        # puts "after", data
        return data
      end

      def turn_data_into_objects(data)
        data = remove_extra_characters(data)
        if data.length % 5 == 0
          array = data.each_slice(5).to_a
        elsif data.length % 6 == 0
          array = data.each_slice(6).to_a
        end

        puts array[0]
      end

      def sort_by_gender(unsorted)
        # unsorted_array = unsorted.split
        # puts(unsorted_array)
        puts unsorted
      end


      space = parseUrl("https://smartlogic.io/about/community/apprentice/code-test/space.txt")
      comma = parseUrl("https://smartlogic.io/about/community/apprentice/code-test/comma.txt")
      pipe = parseUrl("https://smartlogic.io/about/community/apprentice/code-test/pipe.txt")

      # raw
      # puts "S P A C E:"
      # puts space
      # puts "C O M M A:"
      # puts comma
      # puts "P I P E:"
      # puts pipe

      # sorted by gender
      # puts "SPACE SORTED BY GENDER"
      # sort_by_gender(space)
      # puts "COMMA SORTED BY GENDER"
      # sort_by_gender(comma)
      # puts "PIPE SORTED BY GENDER"
      # sort_by_gender(pipe)


      # turn_data_into_objects(space)
      # turn_data_into_objects(comma)
      # turn_data_into_objects(pipe)

    # remove_extra_characters(comma)
  