require "spec_helper"

describe String do
  context ".camelize" do
    it "should transform _l to L" do
      "foo_bar".camelize.should == "FooBar"
    end

    it "should do the same on lower case" do
      "foo_bar".camelize(:lower).should == "fooBar"
    end
  end
end
