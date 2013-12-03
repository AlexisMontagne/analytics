require "spec_helper"

describe Analytics::Request do
  let(:incorrect_token) { ::OAuth2::AccessToken.new(::OAuth2::Client.new('1','1'),'123') }
  let(:sample_request) { Analytics::Request.new('http://assets.up-fluence.com', 'test.json', incorrect_token) }
  
  context ".full_path" do 
    it "should render the normal fullpath" do
       sample_request.full_path.should == 'http://assets.up-fluence.com/test.json'
    end
  end

  context ".request" do
    it "should return a string with datas" do
      VCR.use_cassette('assets.up-fluence') do
        sample_request.request.should include('{"foo" => "bar"}')
      end
    end

    it "should throw an error if the oauth token is wrong" do
      VCR.use_cassette('assets.up-fluence/management/accounts') do
        expect { Analytics::Request.new(Analytics::BASE_URL, 'management/accounts', incorrect_token).request }.to raise_error(Analytics::Error::PermissionInsufficient)
      end
    end
  end

  context ".response" do
    it "should parse JSON" do
      sample_request.stubs(:request).returns(MANAGEMENT_ACCOUNTS)
      sample_request.response.fetch("kind").should == "analytics#accounts"
    end
  end
end
