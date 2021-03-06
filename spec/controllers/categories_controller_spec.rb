require 'spec_helper'

describe CategoriesController, :type => :controller do
	render_views
	fixtures :categories
	
	before(:each) do
		@category = categories(:one)
	end
  	
	it "shows all categories when index is called" do
		get :index
		assigns(:categories).should eq(Category.all)
	end
	
	it "renders with an empty new category" do
		get :new
		response.should be_success
	end
	
	it "renders with desired category for editing" do
		get :edit, id: @category.id
		response.should be_success
	end
	
	context "creating a new category" do
		it "should redirect to categories list with a notice on successful save" do
			post 'create', :category => {:name => "rspec"}
			flash[:notice].should_not be_nil
			response.should redirect_to(categories_path)
		end

		it "should re-render new template on failed save" do
		  post 'create'
		  flash[:notice].should == "Category cannot be empty!"
			response.should redirect_to(new_category_path)
		end
	end
	
	context "updating a new category" do
		it "should redirect to categories list with a notice on successful update" do
			put 'update', category: {:id => 1, :name => "rspec"}, :id => "1"
			flash[:notice].should_not be_nil
			response.should redirect_to(categories_path)
		end
	end
	
	context "destroying a category" do
		it "should render the index template on category destroys" do
			delete 'destroy', :id => @category.id
			response.should redirect_to(categories_path)	
		end
	end
end
