require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'validations' do
    subject { Survey.new(feeling: feeling, stress: stress, comments: comments) }

    let(:feeling) { "Okay" }
    let(:stress) { 3 }
    let(:comments) { "Okay comments" }

    context 'when all attributes are valid' do
      it 'is valid with valid attributes' do
        expect(subject).to be_valid
      end

      it 'is valid with optional comments' do
        subject.comments = nil
        expect(subject).to be_valid
      end
    end

    context 'when feeling is missing' do
      let(:feeling) { nil }

      it 'is not valid without a feeling' do
        expect(subject).to_not be_valid
        expect(subject.errors[:feeling]).to include("can't be blank")
      end
    end

    context 'when stress is missing' do
      let(:stress) { nil }

      it 'is not valid without a stress value' do
        expect(subject).to_not be_valid
        expect(subject.errors[:stress]).to include("can't be blank")
      end
    end

    context 'when stress is out of range' do
      it 'is not valid when stress is greater than 5' do
        subject.stress = 6
        expect(subject).to_not be_valid
        expect(subject.errors[:stress]).to include("must be between 1 and 5")
      end

      it 'is not valid when stress is less than 1' do
        subject.stress = 0
        expect(subject).to_not be_valid
        expect(subject.errors[:stress]).to include("must be between 1 and 5")
      end
    end
  end

  describe 'UUID generation' do
    it 'generates a UUID before creating a survey' do
      survey = Survey.create(feeling: "Good", stress: 3)
      expect(survey.id).to be_present
    end
  end
end
