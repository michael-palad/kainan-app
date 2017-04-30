require 'rails_helper'
require_relative '../support/page_form'

RSpec.feature 'Site Visitors', type: :feature do
  context 'A visitor should be able to' do
    let(:kainan_form) { PageForm.new }
    
    before do
      some_user = create(:user)    
        
      create(:restaurant, name: "Resty's Resto", address: '211 Some St. Manila',
        telephone_number: '02 122-4567', cuisine: 'Filipino', user: some_user)    
      create(:restaurant, name: "Janet's Fine Dining", 
        address: '302 Awesome Ave. Pasig City', telephone_number: '02 123-4522',
        cuisine: 'Chinese', user: some_user)    
      create(:restaurant, name: 'Tasyo Food', 
        address: '2001 Somewhere Bldg. Marikina', telephone_number: '02 221-1567',
        cuisine: 'Filipino', user: some_user)    
      create(:restaurant, name: 'Jollyboy sa Kanto', 
        address: '802 Main Ave. cor. Side St. Manila', 
        telephone_number: '02 333-2261', cuisine: 'Fastfood', user: some_user)    
      create(:restaurant, name: "Gema's Eatery", address: '20 Tall Building Pasig',
        telephone_number: '02 555-4522', cuisine: 'Fastfood', user: some_user)    
    end
      
    scenario 'View the Home Page' do
      kainan_form.visit_page
      
      expect(page).to have_content('Kainan App')
    end      
    
    scenario 'Sign Up an account' do
      kainan_form.visit_page.click('Sign Up')
        .fill('Email': 'sample@example.com', 'Password': 'my_password2',
          'Password confirmation': 'my_password2')
        .click('Sign up', 'form')
        
      expect(page).to have_content('Starred Restaurants')
    end
    
    scenario 'See restaurants on the Home Page' do
      kainan_form.visit_page.click('Home')
      
      expect(page).to have_content("Resty's Resto")
      expect(page).to have_content("Gema's Eatery")
    end
    
  end  # 'A visitor should be able to'
  
  
  
end