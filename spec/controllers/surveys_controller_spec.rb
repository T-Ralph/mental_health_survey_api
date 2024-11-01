require 'rails_helper'

RSpec.describe "Surveys", type: :request do
  describe "POST /surveys" do
    let(:valid_params) do
      {
        survey: {
          feeling: "Good",
          stress: 3,
          comments: "No comments"
        }
      }
    end

    context "with valid parameters" do
      it "creates a new survey and returns the survey data as JSON" do
        expect {
          post "/surveys", params: valid_params, as: :json
        }.to change(Survey, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json_response = JSON.parse(response.body)
        expect(json_response["feeling"]).to eq(valid_params[:survey][:feeling])
        expect(json_response["stress"]).to eq(valid_params[:survey][:stress])
        expect(json_response["comments"]).to eq(valid_params[:survey][:comments])
      end

      it "creates a new survey and allows comments to be nil" do
        params_with_nil_comments = valid_params.deep_merge(survey: { comments: nil })

        expect {
          post "/surveys", params: params_with_nil_comments, as: :json
        }.to change(Survey, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json_response = JSON.parse(response.body)
        expect(json_response["feeling"]).to eq(params_with_nil_comments[:survey][:feeling])
        expect(json_response["stress"]).to eq(params_with_nil_comments[:survey][:stress])
        expect(json_response["comments"]).to be_nil
      end
    end

    context "with invalid parameters" do
      it "does not create a new survey and returns an error message for missing feeling" do
        invalid_params = valid_params.deep_merge(survey: { feeling: nil })

        expect {
          post "/surveys", params: invalid_params, as: :json
        }.to_not change(Survey, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Feeling can't be blank")
      end

      it "does not create a new survey and returns an error message for stress out of range" do
        invalid_params = valid_params.deep_merge(survey: { stress: 0 })

        expect {
          post "/surveys", params: invalid_params, as: :json
        }.to_not change(Survey, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Stress must be between 1 and 5")
      end

      it "does not create a new survey and returns an error message for stress exceeding range" do
        invalid_params = valid_params.deep_merge(survey: { stress: 6 })

        expect {
          post "/surveys", params: invalid_params, as: :json
        }.to_not change(Survey, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Stress must be between 1 and 5")
      end
    end
  end
end
