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

      def convert_data_to_objects(data)
        data = remove_extra_characters(data)

        # checking if the length of the data array is divisible by 5
        if data.length % 5 == 0
          # splitting data into 5 equal arrays
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
            array_of_hashes.push(person_object)
            count += 1
          end

        # checking if the length of the data array is divisible by 6
        elsif data.length % 6 == 0

          # splitting data into 6 equal arrays
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
          data = convert_data_to_objects(parseUrl("https://smartlogic.io/about/community/apprentice/code-test/#{endpoint}.txt"))
          array.concat(data)
        end
        return array
      end

      def sort_by_last_name_ascending(data)
        return data.sort_by {|person| person["last_name"]}
      end

      def sort_by_last_name_descending(data)
        return convert_output_to_string(sort_by_last_name_ascending(data).reverse)
      end


      def sort_by_gender(data)
        women = []
        men = []
        data.map do |person| 
          if person["gender"] == "F" || person["gender"] == "Female"
            women.push(person)
          elsif person["gender"] == "M" || person["gender"] == "Male"
            men.push(person)
          end
        end
        sorted_by_gender = []
        return convert_output_to_string(sorted_by_gender.concat(sort_by_last_name_ascending(women), sort_by_last_name_ascending(men)))
      end

      def sort_by_birthdate(data)
        sorted = data.sort_by { |person, v| 
        [if person["birth"].include?("-")
          person["birth"].split('-')[2].to_i
        elsif person["birth"].include?("/")
          person["birth"].split("/")[2].to_i
        end, person["last_name"]]}
        return convert_output_to_string(sorted)
      end

     

      def convert_output_to_string(data)
        array = []
        data.map do |person|
          person_string = ''
          if person["birth"].include?("-")
            person["birth"] = person["birth"].split("-").join("/")
          end
          if person["gender"] == "F" || person["gender"] == "Female"
            person_string = person["last_name"] + " " +  person["first_name"] + " " +  "Female" + " " +  person["birth"] + " " +  person["color"]
          elsif person["gender"] == "M" || person["gender"] == "Male"
            person_string = person["last_name"] + " " +  person["first_name"] + " " +  "Male" + " " +  person["birth"] + " " +  person["color"]
          end
          array.push(person_string)
        end
        return array
      end


  data = get_data()

puts " "
puts "OUTPUT 1:"
puts sort_by_gender(data)
puts " "

puts "OUTPUT 2:"
puts sort_by_birthdate(data)
puts " "

puts "OUTPUT 3:"
puts sort_by_last_name_descending(data)