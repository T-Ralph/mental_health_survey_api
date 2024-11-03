require 'rails_helper'

RSpec.describe AnalysisController, type: :controller do
  describe 'GET #index' do
    before do
      create_list(:survey, survey_count, stress: average_stress) if survey_count > 0
    end

    context 'when there are no surveys' do
      let(:survey_count) { 0 }
      let(:average_stress) { 0 }

      it 'returns count as 0 and average as 0' do
        get :index
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['count']).to eq(0)
        expect(json_response['average']).to eq(0)
      end
    end

    context 'when there are surveys' do
      let(:survey_count) { 5 }
      let(:average_stress) { 3 }

      it 'returns the correct count and average' do
        get :index
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['count']).to eq(5)
        expect(json_response['average']).to eq(3)
      end
    end
  end
end
