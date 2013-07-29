require "spec_helper"

describe Analytics::Report do
  context '.get' do
    before :each do
      @report = Analytics::Report.new('1', '2')
      @report.stubs(:get).returns(:bar)
    end
    it "should forwarsd to get with a metrics name" do
      r = @report.visits(Date.today - 5, Date.today).should == :bar
    end

    it "should forwards with multiples metrics" do
      r = @report.visits_and_visitors(Date.today - 5, Date.today).should == :bar
    end

    it "should forwards to get with metrics and dimensions" do
      r = @report.visits_by_country(Date.today - 5, Date.today).should == :bar
    end
  end
end
