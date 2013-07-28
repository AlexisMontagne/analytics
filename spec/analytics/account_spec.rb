require "spec_helper"

describe Analytics::Account do
  context ".web_properties" do
    it "should return a list of web properties" do
      client = Analytics::Account.new({
         "id" => 'foo',
         "name" => 'bar', 
         "username" => 'baz'},
         nil)
      Analytics::Request.any_instance.stubs(:request).returns(MANAGEMENT_WEB_PROPERTIES)
      client.web_properties.count.should == 2
      client.web_properties.first.class.should == Analytics::WebProperty
    end
  end
end

