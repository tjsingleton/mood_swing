require "spec_helper"

describe Dog do
  context "the trigger has not been triggered" do
    it "does not howl" do
      Dog.new.bark.should == "woof"
    end

    it "does not howl if the breed doesn't howl" do
      Dog.new(:breed => "Lab").bark.should == "woof"
    end
  end

  context "triggering the trigger" do
    it "triggers when initialized" do
      Dog.new(:breed => "Hound").bark.should == "Hoooooowl"
    end

    it "triggers when found" do
      Dog.new(:breed => "Hound").save
      dog = Dog.where(:breed => "Hound").first
      dog.bark.should == "Hoooooowl"
      dog.destroy
    end

    it "triggers when assigned" do
      dog = Dog.new
      dog.breed = "Hound"
      dog.bark.should == "Hoooooowl"
    end
  end
end