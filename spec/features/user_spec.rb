require 'spec_helper'

feature 'User browsing the website' do
	before :each do
		stub_authorize_user!
	end

end