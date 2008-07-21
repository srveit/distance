require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ZipCodesController do
  describe "route generation" do

    it "should map { :controller => 'zip_codes', :action => 'index' } to /zip_codes" do
      route_for(:controller => "zip_codes", :action => "index").should == "/zip_codes"
    end
  
    it "should map { :controller => 'zip_codes', :action => 'nearby' } to /zip_codes/nearby" do
      route_for(:controller => "zip_codes", :action => "nearby").should == "/zip_codes/nearby"
    end
  
    it "should map { :controller => 'zip_codes', :action => 'new' } to /zip_codes/new" do
      route_for(:controller => "zip_codes", :action => "new").should == "/zip_codes/new"
    end
  
    it "should map { :controller => 'zip_codes', :action => 'show', :id => 1 } to /zip_codes/1" do
      route_for(:controller => "zip_codes", :action => "show", :id => 1).should == "/zip_codes/1"
    end
  
    it "should map { :controller => 'zip_codes', :action => 'edit', :id => 1 } to /zip_codes/1/edit" do
      route_for(:controller => "zip_codes", :action => "edit", :id => 1).should == "/zip_codes/1/edit"
    end
  
    it "should map { :controller => 'zip_codes', :action => 'update', :id => 1} to /zip_codes/1" do
      route_for(:controller => "zip_codes", :action => "update", :id => 1).should == "/zip_codes/1"
    end
  
    it "should map { :controller => 'zip_codes', :action => 'destroy', :id => 1} to /zip_codes/1" do
      route_for(:controller => "zip_codes", :action => "destroy", :id => 1).should == "/zip_codes/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'zip_codes', action => 'index' } from GET /zip_codes" do
      params_from(:get, "/zip_codes").should == {:controller => "zip_codes", :action => "index"}
    end
  
    it "should generate params { :controller => 'zip_codes', action => 'nearby' } from GET /zip_codes/nearby" do
      params_from(:get, "/zip_codes/nearby").should == {:controller => "zip_codes", :action => "nearby"}
    end
  
    it "should generate params { :controller => 'zip_codes', action => 'new' } from GET /zip_codes/new" do
      params_from(:get, "/zip_codes/new").should == {:controller => "zip_codes", :action => "new"}
    end
  
    it "should generate params { :controller => 'zip_codes', action => 'create' } from POST /zip_codes" do
      params_from(:post, "/zip_codes").should == {:controller => "zip_codes", :action => "create"}
    end
  
    it "should generate params { :controller => 'zip_codes', action => 'show', id => '1' } from GET /zip_codes/1" do
      params_from(:get, "/zip_codes/1").should == {:controller => "zip_codes", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'zip_codes', action => 'edit', id => '1' } from GET /zip_codes/1;edit" do
      params_from(:get, "/zip_codes/1/edit").should == {:controller => "zip_codes", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'zip_codes', action => 'update', id => '1' } from PUT /zip_codes/1" do
      params_from(:put, "/zip_codes/1").should == {:controller => "zip_codes", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'zip_codes', action => 'destroy', id => '1' } from DELETE /zip_codes/1" do
      params_from(:delete, "/zip_codes/1").should == {:controller => "zip_codes", :action => "destroy", :id => "1"}
    end
  end
end
