require 'rails_helper'

feature "Person maintenance" do
  before do
    log_in_as 'test.user@digital.justice.gov.uk'
  end

  scenario "Creating a person" do
    given_name = 'Toby'
    surname = 'Privett'
    email = 'toby.privett@example.com'
    phone = '+44-208-123-4567'
    mobile = '07777777777'
    location = 'MOJ / Petty France / London'
    description = 'Lorem ipsum dolor sit amet...'
    keywords = 'contractor digital services'

    visit new_person_path
    fill_in 'Given name', with: given_name
    fill_in 'Surname', with: surname
    fill_in 'Email', with: email
    fill_in 'Phone', with: phone
    fill_in 'Mobile', with: mobile
    fill_in 'Location', with: location
    fill_in 'Description', with: description
    fill_in 'Keywords', with: keywords
    uncheck('Works Monday')
    uncheck('Works Friday')
    click_button "Create Person"

    person = Person.find_by_surname(surname)
    expect(person.given_name).to eql(given_name)
    expect(person.surname).to eql(surname)
    expect(person.email).to eql(email)
    expect(person.phone).to eql(phone)
    expect(person.mobile).to eql(mobile)
    expect(person.location).to eql(location)
    expect(person.description).to eql(description)
    expect(person.keywords).to eql(keywords)
    expect(person.works_monday).to be false
    expect(person.works_tuesday).to be true
    expect(person.works_wednesday).to be true
    expect(person.works_thursday).to be true
    expect(person.works_friday).to be false
  end

  scenario 'Creating an invalid person' do
    visit new_person_path
    click_button "Create Person"
    expect(page).to have_text('Please review the problems')
    within('div.person_surname') do
      expect(page).to have_text('can\'t be blank')
    end
  end

  scenario 'Deleting a person softly' do
    membership = create(:membership)
    person = membership.person
    visit edit_person_path(person)
    click_link('Delete this record')

    expect { Person.find(person) }.to raise_error(ActiveRecord::RecordNotFound)
    expect { Membership.find(membership) }.to raise_error(ActiveRecord::RecordNotFound)

    expect(Person.with_deleted.find(person)).to eql(person)
    expect(Membership.with_deleted.find(membership)).to eql(membership)
  end
end
