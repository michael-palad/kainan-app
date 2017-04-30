require 'rails_helper'
require_relative '../support/page_form'

RSpec.feature 'Signed-in Users', type: :feature do
  context 'A signed-in user should be able to' do
    let(:kainan_form) { PageForm.new }
    let(:user) { create(:user) }
    
    before do
      some_user = create(:user, email: 'someuser@email.com')
      another_user = create(:user, email: 'another@email.com')
        
      resto1 = create(:restaurant, name: "Resty's Resto", address: '211 Some St. Manila',
        telephone_number: '02 122-4567', cuisine: 'Filipino', user: some_user)    
      create(:restaurant, name: "Janet's Fine Dining", 
        address: '302 Awesome Ave. Pasig City', telephone_number: '02 123-4522',
        cuisine: 'Chinese', user: some_user)    
      create(:restaurant, name: 'Tasyo Food', 
        address: '2001 Somewhere Bldg. Marikina', telephone_number: '02 221-1567',
        cuisine: 'Filipino', user: some_user)    
      create(:restaurant, name: 'Jollyboy sa Kanto', 
        address: '802 Main Ave. cor. Side St. Manila', 
        telephone_number: '02 333-2261', cuisine: 'Fastfood', user: another_user)    
      create(:restaurant, name: "Gema's Eatery", address: '20 Tall Building Pasig',
        telephone_number: '02 555-4522', cuisine: 'Fastfood', user: another_user)
        
      resto1.starring_users << another_user    
    end
      
    scenario 'View the Home Page' do
      kainan_form.visit_page
                 .login_user(user)
                 .visit_page
      
      expect(page).to have_content('Kainan App')
    end      
    
    scenario 'See restaurants on the Home Page' do
      kainan_form.visit_page.login_user(user)
                 .click('Home')
      
      expect(page).to have_content("Resty's Resto")
      expect(page).to have_content("Gema's Eatery")
    end
    
    scenario 'List 3 Random restaurants' do
      kainan_form.visit_page.login_user(user)
                .click('Random')
      
      expect(page).to have_selector('.resto-title-link', count: 3)    
    end
    
    scenario 'View restaurants filtered by cuisines' do
      kainan_form.visit_page.login_user(user)
                .click('Filipino', '.dropdown-menu')
                            
      expect(page).to have_content("Resty's Resto")
      expect(page).to have_content('Tasyo Food')
      expect(page).not_to have_content("Janet's Fine Dining")
      expect(page).not_to have_content('Jollyboy sa Kanto')
      expect(page).not_to have_content("Gema's Eatery")
    end
    
    scenario 'View restaurants by popularity' do
      kainan_form.visit_page.login_user(user)
                .click('Most Popular')
      
      # test ordering via regular expression
      expect(page).to have_text(/Resty\'s Resto.+Tasyo Food/)
      expect(page).to have_text(/Resty\'s Resto.+Gema\'s Eatery/)
      expect(page).to have_text(/211 Some St\. Manila.+2001 Somewhere Bldg\./)
    end
    
    scenario 'View his/her starred restaurants' do
      create(:restaurant, name: "User Starred Resto One", 
          address: '303 Leaf Ave. Pasig City', telephone_number: '02 222-4522',
          cuisine: 'Filipino', user: user)    
      create(:restaurant, name: "User Starred Resto Two", 
          address: '100 Layag St. Malabon', telephone_number: '02 322-1522',
          cuisine: 'Chinese', user: user)        
      
      kainan_form.visit_page.login_user(user)
                .click('Starred Restaurants')
                
      expect(page).to have_content('User Starred Resto One')
      expect(page).to have_content('User Starred Resto Two')
      expect(page).not_to have_content("Janet's Fine Dining")
      expect(page).not_to have_content('Jollyboy sa Kanto')
      expect(page).not_to have_content("Gema's Eatery")
    end
    
  end  # 'A visitor should be able to'
  
end