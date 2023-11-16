module Api
    module V1
        class ReviewsController < ApplicationController
            protect_from_forgery with: :null_session # this is to prevent Rails from throwing an exception if the request doesn't have a CSRF token

            def create
                review = Review.new(review_params)

                if review.save
                    render json: ReviewSerializer.new(review).serialized_json
                else
                    render json: { error: review.errors.messages }, status: 422 # 422 is the status code for unprocessable entity
                end
            end

            def destroy
                review = Review.find(params[:id])

                if review.destroy
                    head :no_content
                else
                    render json: { error: review.errors.messages }, status: 422 # 422 is the status code for unprocessable entity
                end
            end

            private

            def review_params
                params.require(:review).permit(:title, :description, :score, :airline_id)
            end
        end
    end
end