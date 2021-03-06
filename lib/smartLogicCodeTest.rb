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

      def convert_data_to_hashes(data)
        data = remove_extra_characters(data)

        # checking if the length of the data array is divisible by 5
        if data.length % 5 == 0

          # splitting data into 5 equal arrays
          array = data.each_slice(5).to_a

          array_of_hashes = []

          array.map do | person |
            person_hash = {}
            person_hash["last_name"] = person[0]
            person_hash["first_name"] = person[1]
            person_hash["gender"] = person[2]
            person_hash["birth"] = person[4]
            person_hash["color"] = person[3]
            array_of_hashes.push(person_hash)
          end

        # checking if the length of the data array is divisible by 6
        elsif data.length % 6 == 0

          # splitting data into 6 equal arrays
          array = data.each_slice(6).to_a

          array_of_hashes = []

          array.map do | person |
            person_hash = {}
            person_hash["last_name"] = person[0]
            person_hash["first_name"] = person[1]
            person_hash["middle_name"] = person[2]
            person_hash["gender"] = person[3]

            # checking if the item at index 5 contains an integer
            if person[5] =~ /\d/
              person_hash["birth"] = person[5]
              person_hash["color"] = person[4]
            else
              person_hash["birth"] = person[4]
              person_hash["color"] = person[5]
            end
            array_of_hashes.push(person_hash)
          end
        end
        return array_of_hashes
      end

      def get_data()
        endpoints = ["space", "comma", "pipe"]
        array = []
        endpoints.map do | endpoint |
          data = convert_data_to_hashes(parseUrl("https://smartlogic.io/about/community/apprentice/code-test/#{endpoint}.txt"))
          array.concat(data)
        end
        return array
      end

      def sort_by_last_name_ascending(data)
        return data.sort_by {| person | person["last_name"]}
      end

      def sort_by_last_name_descending(data)
        return convert_output_to_string(sort_by_last_name_ascending(data).reverse)
      end


      def sort_by_gender(data)
        women = []
        men = []
        data.map do | person | 
          if person["gender"] == "F" || person["gender"] == "Female"
            person["gender"] = "Female"
            women.push(person)
          elsif person["gender"] == "M" || person["gender"] == "Male"
            person["gender"] = "Male"
            men.push(person)
          end
        end
        sorted_by_gender = []
        return convert_output_to_string(sorted_by_gender.concat(sort_by_last_name_ascending(women), sort_by_last_name_ascending(men)))
      end

      def sort_by_birthdate(data)
        sorted = data.sort_by { | person, v | 
        [if person["birth"].include?("-")
          person["birth"].split('-')[2].to_i
        elsif person["birth"].include?("/")
          person["birth"].split("/")[2].to_i
        end, person["last_name"]]}
        return convert_output_to_string(sorted)
      end

     

      def convert_output_to_string(data)
        array = []
        data.map do | person |
          person_string = ''
          if person["birth"].include?("-")
            person["birth"] = person["birth"].split("-").join("/")
          end
          person_string = person["last_name"] + " " +  person["first_name"] + " " +  person["gender"] + " " +  person["birth"] + " " +  person["color"]
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