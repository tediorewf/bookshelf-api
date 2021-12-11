require "test_helper"

class ReaderTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    reader_attributes = {
      user: @user,
      email: 'test-setup-email-73183214112@example.com',
      name: 'Test Setup Reader',
      phone: '73183214112'
    }
    @reader = Reader.new(reader_attributes)
  end

  test 'should be valid' do
    assert @reader.valid?
  end

  test 'email should not be nil' do
    @reader.email = nil

    assert_not @reader.valid?
  end

  test 'name should not be nil' do
    @reader.name = nil

    assert_not @reader.valid?
  end

  test 'phone should not be nil' do
    @reader.phone = nil

    assert_not @reader.valid?
  end

  test 'email should not be blank' do
    @reader.email = ' '

    assert_not @reader.valid?
  end

  test 'name should not be blank' do
    @reader.name = ' '

    assert_not @reader.valid?
  end

  test 'phone should not be blank' do
    @reader.phone = ' '

    assert_not @reader.valid?
  end

  test 'phone should has correct length' do
    @reader.phone = '123456789'
    assert_not @reader.valid?

    @reader.phone = '1234567890'
    assert @reader.valid?

    @reader.phone = '123456789010111'
    assert @reader.valid?

    @reader.phone = '1234567890101112'
    assert_not @reader.valid?
  end

  test 'phone should be numericality' do
    invalid_phones = %w[not-a-number j2j31d423da a_b_c_d_e_f_g]

    invalid_phones.each do |invalid_phone|
      @reader.phone = invalid_phone
      assert_not @reader.valid?
    end
  end
end
