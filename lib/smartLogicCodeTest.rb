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
        data.map do | item |
          if item == "|"
            data.delete(item)
          elsif item.include?(",")
            index = data.find_index(item)
            data[index] = item.tr(',', '')
          end
        end
        return data
      end

      def turn_data_into_objects(data)
        data = remove_extra_characters(data)
        if data.length % 5 == 0
          array = data.each_slice(5).to_a
          count = 0
          array_of_hashes = []
          while count < array.length do
            person_object = {}
            person_object["last_name"] = array[count][0]
            person_object["first_name"] = array[count][1]
            person_object["gender"] = array[count][2]
            person_object["birth"] = array[count][4]
            person_object["color"] = array[count][3]
            count += 1
            array_of_hashes.push(person_object)
          end
        elsif data.length % 6 == 0
          array = data.each_slice(6).to_a
          count = 0
          array_of_hashes = []
          while count < array.length do
            person_object = {}
            person_object["last_name"] = array[count][0]
            person_object["first_name"] = array[count][1]
            person_object["middle_name"] = array[count][2]
            person_object["gender"] = array[count][3]
            # checking if the item at index 5 contains an integer
            if array[count][5] =~ /\d/
              person_object["birth"] = array[count][5]
              person_object["color"] = array[count][4]
            else
              person_object["birth"] = array[count][4]
              person_object["color"] = array[count][5]
            end
            array_of_hashes.push(person_object)
            count += 1
          end
        end
        return array_of_hashes
      end

      def get_data()
        endpoints = ["space", "comma", "pipe"]
        array = []
        endpoints.map do |endpoint|
          data = turn_data_into_objects(parseUrl("https://smartlogic.io/about/community/apprentice/code-test/#{endpoint}.txt"))
          array.concat(data)
        end
        return array
      end

      def sort_by_last_name(array)
        return array.sort_by {|person| person["last_name"]}
      end

      def sort_by_gender(array)
        women = []
        men = []
        array.map do |person| 
          if person["gender"] == "F" || person["gender"] == "Female"
            women.push(person)
          elsif person["gender"] == "M" || person["gender"] == "Male"
            men.push(person)
          end
        end
        sorted_by_gender = []
        sorted_by_gender.concat(sort_by_last_name(women), sort_by_last_name(men) )
        return sorted_by_gender
      end

      def sort_by_birth_date(array)
        
      end


  data = get_data()
      
  
  sort_by_gender(data)

  puts sort_by_birth_date(data)