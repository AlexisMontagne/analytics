require "spec_helper"

describe Analytics::Renderer::Hashed do
  context ".apply!" do
     it "should push data in the correct column" do
       res = Analytics::Renderer::Hashed.apply!([1, 2, 3, 4], [:m1, :m2], [:m3, :m4])
       res[:m1].should == 3
       res[:m2].should == 4
       res[:m3].should == 1
       res[:m4].should == 2
     end
  end
  context ".render" do
    it "should return the data with it has only a metrics registred" do
      res = Analytics::Renderer::Hashed.render([1],[:m1],[])
      res.should == 1
    end
  end
end
