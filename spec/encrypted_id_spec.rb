require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'EncryptedId' do
  ModelDescription = Struct.new(:model, :test_ids)

  [
    ModelDescription.new(User,
      { 15 => '1e8644f924812bec506b116ff14368c8', 8 => 'da9f98cd7c3eb2b0f0e88cc8daeb222c' }
    ),
    ModelDescription.new(Animal,
      { 15 => '2f71ba22a8e6975db0f13b7e3db6d9cd', 8 => '6916a1adba452d3fffde6e444ae1ad3a' }
    )
  ].each do |description|
    describe "in the #{description.model}.name model" do
      before(:each) do
        @model = description.model
        @test_ids = description.test_ids
        @entity = @model.new
      end

      it 'should give us the encrypted ID via to_param' do
        @entity.id = 15
        @entity.to_param.should == @test_ids[15]
      end

      it 'should be possible to find an entry by the encrypted id' do
        @entity.id = 8
        @entity.save!
        @model.find(@test_ids[8]).id.should == 8
      end

      it 'should throw an exception if we try to find an entry by the real ID' do
        @entity.id = 1
        @entity.save!
        expect { @model.find 1 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
