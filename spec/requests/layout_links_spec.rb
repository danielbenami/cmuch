require 'spec_helper'

describe "LayoutLinks" do

	it "should have a home page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end

	it "should have a contact page at '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end

	it "should have a about page at '/about'" do
		get '/about'
		response.should have_selector('title', :content => "About")
	end

	it "should have a help page at '/help'" do
		get '/help'
		response.should have_selector('title', :content => "Help")
	end
	
	it "should have a signup page at '/signup'" do
		get '/signup'
		response.should have_selector('title', :content => "Sign up")
	end

	it "should have a signin page at '/signin'" do
		get '/signin'
		response.should have_selector('title', :content => "Sign in")
	end

	it "should have the right links" do
		visit root_path
			response.should have_selector('title', :content => "Home")
			click_link "About"
			response.should have_selector('title', :content => "About")
			click_link "Contact"
			response.should have_selector('title', :content => "Contact")
			click_link "Home"
			response.should have_selector('title', :content => "Home")
			click_link "Sign up now!"
			response.should have_selector('title', :content => "Sign up")
			response.should have_selector('a[href="/"]>img')
	end


	describe "when not signed in" do
		it "should have a signin link" do
			visit root_path
			response.should have_selector("a", :href => signin_path, :content => "Sign in")
		end
	end

	describe "when signed in" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			visit signin_path
			fill_in :email, 	:with => @user.email
			fill_in :password, 	:with => @user.password
			click_button
		end

		it "should have a sign out link" do
			visit root_path
			response.should have_selector("a", :href => signout_path, :content => "Sign out")
		end
		
		it "should have a profile link" do
			visit root_path
			response.should have_selector("a", :href => user_path(@user), :content => "Profile")			
		end

		it "should have a setting link" do
			visit root_path
			response.should have_selector("a", :href => edit_user_path(@user), :content => "Setting")			
		end

		it "should have a users link" do
			visit root_path
			response.should have_selector("a", :href => users_path(@user), :content => "Users")			
		end

	end



end
