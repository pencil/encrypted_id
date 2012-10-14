require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'EncryptedId' do
  before(:each) do
    @user = User.new
  end

  it 'should give us the encrypted ID via to_param' do
    @user.id = 15
    @user.to_param.should == '1e8644f924812bec506b116ff14368c8'
  end

  it 'should be possible to find an entry by the encrypred id' do
    @user.id = 8
    @user.save!
    User.find('da9f98cd7c3eb2b0f0e88cc8daeb222c').id.should == 8
  end

  it 'should throw an exception if we try to find an entry by the real ID' do
    @user.id = 1
    @user.save!
    expect { User.find 1 }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
