FactoryGirl.define do
	sequence :email do |n|
		"person-#{n}@example.com"
	end	
	factory :user do
		name     "Michael Hartl"
		email    "michael@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
	factory :micropost do
		content "Foo bar"
		association :user
	end
end
