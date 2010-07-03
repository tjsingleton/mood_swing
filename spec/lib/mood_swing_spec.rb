require "spec_helper"

describe Dog do
  context "when there is not an extension" do
    it "does not howl" do
      Dog.new.bark.should == "woof"
    end

    it "does not howl if the breed doesn't howl" do
      Dog.new(:breed => "Lab").bark.should == "woof"
    end
  end

  context "when there is an extension" do
    it "howls when the breed set at creation" do
      Dog.new(:breed => "Hound").bark.should == "Hoooooowl"
    end

    it "howls when the breed is set and the record is found" do
      Dog.new(:breed => "Hound").save
      dog = Dog.where(:breed => "Hound").first
      dog.bark.should == "Hoooooowl"
      dog.destroy
    end

    it "howls when the breed is set through the reader" do
      dog = Dog.new
      dog.breed = "Hound"
      dog.bark.should == "Hoooooowl"
    end
  end
end

# Test alternative writers, modules.