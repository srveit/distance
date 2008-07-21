require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ZipCodesController do
  describe "handling GET /zip_codes" do

    before(:each) do
      @zip_code = mock_model(ZipCode)
      ZipCode.stub!(:paginate).and_return([@zip_code])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all zip_codes" do
      ZipCode.should_receive(:paginate).with({:page => nil}).and_return([@zip_code])
      do_get
    end
  
    it "should assign the found zip_codes for the view" do
      do_get
      assigns[:zip_codes].should == [@zip_code]
    end
  end

  describe "handling GET /zip_codes.xml" do

    before(:each) do
      @zip_codes = mock("Array of ZipCodes", :to_xml => "XML")
      ZipCode.stub!(:paginate).and_return(@zip_codes)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all zip_codes" do
      ZipCode.should_receive(:paginate).with({:page => nil}).and_return(@zip_codes)
      do_get
    end
  
    it "should render the found zip_codes as xml" do
      @zip_codes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /zip_codes/nearby" do

    before(:each) do
      @zip_code = mock_model(ZipCode)
      @latitude = 1
      @longitude = 2
      @radius = 3
      ZipCode.stub!(:find_nearby).and_return([@zip_code])
    end
  
    def do_get
      get :nearby, :latitude => @latitude, :longitude => @longitude, :radius => @radius
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('nearby')
    end
  
    it "should find all nearby zip_codes" do
      ZipCode.should_receive(:find_nearby).
        with(hash_including('latitude' => @latitude.to_s,
                            'longitude' => @longitude.to_s,
                            'radius' => @radius.to_s)).and_return([@zip_code])
      do_get
    end
  
    it "should assign the found zip_codes for the view" do
      do_get
      assigns[:zip_codes].should == [@zip_code]
    end
  end

  describe "handling GET /zip_codes/nearby.xml" do

    before(:each) do
      @zip_codes = mock("Array of ZipCodes", :to_xml => "XML")
      @latitude = 1
      @longitude = 2
      @radius = 3
      ZipCode.stub!(:find_nearby).and_return(@zip_codes)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :nearby, :latitude => @latitude, :longitude => @longitude, :radius => @radius
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all nearby zip_codes" do
      ZipCode.should_receive(:find_nearby).
        with(hash_including('latitude' => @latitude.to_s,
                            'longitude' => @longitude.to_s,
                            'radius' => @radius.to_s)).and_return(@zip_codes)
      do_get
    end
  
    it "should render the found zip_codes as xml" do
      @zip_codes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /zip_codes/1" do

    before(:each) do
      @zip_code = mock_model(ZipCode)
      ZipCode.stub!(:find).and_return(@zip_code)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the zip_code requested" do
      ZipCode.should_receive(:find).with("1").and_return(@zip_code)
      do_get
    end
  
    it "should assign the found zip_code for the view" do
      do_get
      assigns[:zip_code].should equal(@zip_code)
    end
  end

  describe "handling GET /zip_codes/1.xml" do

    before(:each) do
      @zip_code = mock_model(ZipCode, :to_xml => "XML")
      ZipCode.stub!(:find).and_return(@zip_code)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the zip_code requested" do
      ZipCode.should_receive(:find).with("1").and_return(@zip_code)
      do_get
    end
  
    it "should render the found zip_code as xml" do
      @zip_code.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /zip_codes/new" do

    before(:each) do
      @zip_code = mock_model(ZipCode)
      ZipCode.stub!(:new).and_return(@zip_code)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new zip_code" do
      ZipCode.should_receive(:new).and_return(@zip_code)
      do_get
    end
  
    it "should not save the new zip_code" do
      @zip_code.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new zip_code for the view" do
      do_get
      assigns[:zip_code].should equal(@zip_code)
    end
  end

  describe "handling GET /zip_codes/1/edit" do

    before(:each) do
      @zip_code = mock_model(ZipCode)
      ZipCode.stub!(:find).and_return(@zip_code)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the zip_code requested" do
      ZipCode.should_receive(:find).and_return(@zip_code)
      do_get
    end
  
    it "should assign the found ZipCode for the view" do
      do_get
      assigns[:zip_code].should equal(@zip_code)
    end
  end

  describe "handling POST /zip_codes" do

    before(:each) do
      @zip_code = mock_model(ZipCode, :to_param => "1")
      ZipCode.stub!(:new).and_return(@zip_code)
    end
    
    describe "with successful save" do
  
      def do_post
        @zip_code.should_receive(:save).and_return(true)
        post :create, :zip_code => {}
      end
  
      it "should create a new zip_code" do
        ZipCode.should_receive(:new).with({}).and_return(@zip_code)
        do_post
      end

      it "should redirect to the new zip_code" do
        do_post
        response.should redirect_to(zip_code_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @zip_code.should_receive(:save).and_return(false)
        post :create, :zip_code => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /zip_codes/1" do

    before(:each) do
      @zip_code = mock_model(ZipCode, :to_param => "1")
      ZipCode.stub!(:find).and_return(@zip_code)
    end
    
    describe "with successful update" do

      def do_put
        @zip_code.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the zip_code requested" do
        ZipCode.should_receive(:find).with("1").and_return(@zip_code)
        do_put
      end

      it "should update the found zip_code" do
        do_put
        assigns(:zip_code).should equal(@zip_code)
      end

      it "should assign the found zip_code for the view" do
        do_put
        assigns(:zip_code).should equal(@zip_code)
      end

      it "should redirect to the zip_code" do
        do_put
        response.should redirect_to(zip_code_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @zip_code.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /zip_codes/1" do

    before(:each) do
      @zip_code = mock_model(ZipCode, :destroy => true)
      ZipCode.stub!(:find).and_return(@zip_code)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the zip_code requested" do
      ZipCode.should_receive(:find).with("1").and_return(@zip_code)
      do_delete
    end
  
    it "should call destroy on the found zip_code" do
      @zip_code.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the zip_codes list" do
      do_delete
      response.should redirect_to(zip_codes_url)
    end
  end
end
