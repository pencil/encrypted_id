require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'EncryptedId' do
  describe 'in the User model' do
    before(:each) do
      @user = User.new
    end

    it 'should give us the encrypted ID via to_param' do
      @user.id = 15
      @user.to_param.should == '1e8644f924812bec506b116ff14368c8'
    end

    it 'should be possible to find an entry by the encrypted id' do
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

  describe 'in the Animal model' do
    before(:each) do
      @animal = Animal.new
    end

    it 'should give us the encrypted ID via to_param' do
      @animal.id = 15
      @animal.to_param.should == '2f71ba22a8e6975db0f13b7e3db6d9cd'
    end

    it 'should be possible to find an entry by the encrypted id' do
      @animal.id = 8
      @animal.save!
      Animal.find('6916a1adba452d3fffde6e444ae1ad3a').id.should == 8
    end

    it 'should throw an exception if we try to find an entry by the real ID' do
      @animal.id = 1
      @animal.save!
      expect { Animal.find 1 }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
