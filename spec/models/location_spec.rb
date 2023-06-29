require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:too_big_image) { fixture_file_upload("spec/fixtures/cat_12mb.png", "image/png") }
  let(:text_file) { fixture_file_upload("spec/fixtures/file.txt", "txt") }
  subject { build(:location) }

   it "is not valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
   end

   it "is valid with name" do
    expect(subject).to be_valid
   end

   it "is not valid with too big image" do
    subject.image.attach(too_big_image)
    expect(subject).to_not be_valid
   end

   it "is not valid with image in invalid format" do
    subject.image.attach(text_file)
    expect(subject).to_not be_valid
   end
end
