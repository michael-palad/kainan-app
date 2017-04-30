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
    
    scenario 'View the page of a specific restaurant' do
      kainan_form.visit_page.login_user(user)
                .click('Tasyo Food', '.col-lg-8')
      
      expect(page).to have_content('Tasyo Food')
      expect(page).not_to have_content('Jollyboy sa Kanto')
      expect(page).not_to have_content("Gema's Eatery")
    end
    
    scenario 'Add a new restaurant' do
      kainan_form.visit_page.login_user(user)
                .click('Add Restaurant')
                .fill('Name': 'Happy Restaurant',
                      'Address': '1 Maligaya St. Cubao Quezon City',
                      'Telephone number': '02 111-4522')
                .select_option('Fastfood', 'restaurant_cuisine')
                .click('Add Restaurant', 'form')
    
      expect(page).to have_content('Happy Restaurant')
      expect(page).to have_content('1 Maligaya St. Cubao Quezon City')
      expect(page).to have_content('02 111-4522')
    end
    
    scenario 'Edit an existing restaurant' do
      create(:restaurant, name: "Bagong Pangalan Resto", 
          address: '100 Masagana St. Pasig City', telephone_number: '02 888-4522',
          cuisine: 'Korean', user: user)        
        
      kainan_form.visit_page.login_user(user)
                .click("Bagong Pangalan Resto", '.col-lg-8')
                .click('Edit Restaurant')
                .fill('Name': 'Binagong Pangalan Kainan',
                      'Telephone number': '02 555-2222')
                .click('Update Restaurant')
                
      expect(page).to have_content('Binagong Pangalan Kainan')
      expect(page).to have_content('02 555-2222')
      expect(page).not_to have_content('Bagong Pangalan Resto')
      expect(page).not_to have_content('02 888-4522')
    end
    
    scenario 'Delete an existing restaurant' do
      create(:restaurant, name: "Someone's Eatery", 
          address: '20 Somewhere Taguig City', telephone_number: '02 222-2322',
          cuisine: 'Fastfood', user: user)        
        
      kainan_form.visit_page.login_user(user)
                .click("Someone's Eatery", '.col-lg-8')
                .click('Delete Restaurant')
                
      expect(page).not_to have_content("Someone's Eatery")
      expect(page).not_to have_content('02 222-2322')
    end
    
    scenario 'Give a star to a restaurant' do
      kainan_form.visit_page.login_user(user)
                .click('Tasyo Food', '.col-lg-8')
      click_link('btn-give-star')          
    
      expect(page).to have_content('Tasyo Food')
      expect(page).to have_content('Take')
      expect(page).not_to have_content('Give')  
    end
    
    scenario 'Remove star from a restaurant' do
      create(:restaurant, name: 'Not an Eatery', 
        address: 'Somewhere St. Nowhere City',
        telephone_number: '02 222-4522', cuisine: 'Fastfood', user: user)
        
      kainan_form.visit_page.login_user(user)
                .click('Not an Eatery', '.col-lg-8')
      click_link('btn-take-star')          
    
      expect(page).to have_content('Not an Eatery')
      expect(page).to have_content('Give')
      expect(page).not_to have_content('Take')  
    end

  end  # 'A signed-in user should be able to'
  
end