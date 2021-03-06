require 'spec_helper'

describe PostsController, :type => :controller do
	render_views
	fixtures :posts
	fixtures :categories
	
	before(:each) do
		@post = posts(:one)
	end
  	
	it "shows all posts when index is called" do
		get :index
		assigns(:posts).should eq(Post.all)
	end
	
	it "renders with an empty new post" do
		get :new
		response.should be_success
	end
	
	it "renders with desired post for editing" do
		get :edit, id: @post.id
		response.should be_success
	end
	  
	context "creating a new post" do
		it "should redirect to saved post with a notice on successful save" do
			post 'create', :post => {:name => "nitin", :title => "rspec test", :description => "kjdsgf", :category_id => 1}
			flash[:notice].should_not be_nil
			response.should be_redirect
		end

		it "should re-render new template on failed save" do
		  post 'create'
		  flash[:notice].should be_nil
		  response.should render_template('new')
		end
	end
	
	context "updating a new post" do
		it "should redirect to updated post with a notice on successful update" do
			put 'update', :id => @post.id
			flash[:notice].should_not be_nil
			response.should be_redirect
		end
	end
	
	context "destroying a post" do
		it "should render the index template on post destroys" do
			delete 'destroy', :id => @post.id
			response.should redirect_to(posts_path)
		end
	end
end	
