require "spec_helper"

describe Analytics::Profile do
  context ".report" do
    it "should forward methods to the report linked" do
      client = Analytics::Profile.new({
         "id" => 'foo',
         "name" => 'bar', 
         "accountId" => 'baz',
         "websiteUrl" => 'http://www.gmail.com',
         "webPropertyId" => 'b'},
         '1')
      client.report.stubs(:foo).returns(:bar)
      client.foo.should == :bar
    end
  end
end


