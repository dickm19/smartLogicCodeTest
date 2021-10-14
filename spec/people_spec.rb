require "./lib/smartLogicCodeTest"

data = [
    {"last_name"=>"Kournikova", "first_name"=>"Anna", "middle_name"=>"F", "gender"=>"F", "birth"=>"6-3-1975", "color"=>"Red"},
    {"last_name"=>"Hingis", "first_name"=>"Martina", "middle_name"=>"M", "gender"=>"F", "birth"=>"4-2-1979", "color"=>"Green"},
    {"last_name"=>"Seles", "first_name"=>"Monica", "middle_name"=>"H", "gender"=>"F", "birth"=>"12-2-1973", "color"=>"Black"},
    {"last_name"=>"Abercrombie", "first_name"=>"Neil", "gender"=>"Male", "birth"=>"2/13/1943", "color"=>"Tan"},
    {"last_name"=>"Bishop", "first_name"=>"Timothy", "gender"=>"Male", "birth"=>"4/23/1967", "color"=>"Yellow"},
    {"last_name"=>"Kelly", "first_name"=>"Sue", "gender"=>"Female", "birth"=>"7/12/1959", "color"=>"Pink"},
    {"last_name"=>"Smith", "first_name"=>"Steve", "middle_name"=>"D", "gender"=>"M", "birth"=>"3-3-1985", "color"=>"Red"},
    {"last_name"=>"Bonk", "first_name"=>"Radek", "middle_name"=>"S", "gender"=>"M", "birth"=>"6-3-1975", "color"=>"Green"},
    {"last_name"=>"Bouillon", "first_name"=>"Francis", "middle_name"=>"G", "gender"=>"M", "birth"=>"6-3-1975", "color"=>"Blue"}
]


describe "sort_by_gender" do
    context "given an array of people" do
        it "returns an array of people sorted by gender, then by last name ascending" do
            expect(sort_by_gender(data)).to eq([
                "Hingis Martina Female 4/2/1979 Green",
                "Kelly Sue Female 7/12/1959 Pink",
                "Kournikova Anna Female 6/3/1975 Red",
                "Seles Monica Female 12/2/1973 Black",
                "Abercrombie Neil Male 2/13/1943 Tan",
                "Bishop Timothy Male 4/23/1967 Yellow",
                "Bonk Radek Male 6/3/1975 Green",
                "Bouillon Francis Male 6/3/1975 Blue",
                "Smith Steve Male 3/3/1985 Red"
            ])
        end
    end
end

describe "sort_by_birthdate" do
    context "given an array of people" do
        it "returns an array of people sorted by birthdate, then by last name ascending" do
            expect(sort_by_birthdate(data)).to eq([
                "Abercrombie Neil Male 2/13/1943 Tan",
                "Kelly Sue Female 7/12/1959 Pink",
                "Bishop Timothy Male 4/23/1967 Yellow",
                "Seles Monica Female 12/2/1973 Black",
                "Bonk Radek Male 6/3/1975 Green",
                "Bouillon Francis Male 6/3/1975 Blue",
                "Kournikova Anna Female 6/3/1975 Red",
                "Hingis Martina Female 4/2/1979 Green",
                "Smith Steve Male 3/3/1985 Red"
            ])
        end
    end
end


describe "sort_by_last_name_descending" do 
    context "given an array of people" do
        it "returns an array of people sorted by last name descending" do
            expect(sort_by_last_name_descending(data)).to eq([
                "Smith Steve Male 3/3/1985 Red",
                "Seles Monica Female 12/2/1973 Black",
                "Kournikova Anna Female 6/3/1975 Red",
                "Kelly Sue Female 7/12/1959 Pink",
                "Hingis Martina Female 4/2/1979 Green",
                "Bouillon Francis Male 6/3/1975 Blue",
                "Bonk Radek Male 6/3/1975 Green",
                "Bishop Timothy Male 4/23/1967 Yellow",
                "Abercrombie Neil Male 2/13/1943 Tan"
            ])
        end
    end
end