module Api
    module V1
        class AirlinesController < ApplicationController
            protect_from_forgery with: :null_session # this is to prevent Rails from throwing an exception if the request doesn't have a CSRF token
            
            def index
                airlines = Airline.all

                render json: AirlineSerializer.new(airlines, options).serialized_json
            end

            def show
                airline = Airline.find_by(slug: params[:slug])

                render json: AirlineSerializer.new(airline).serialized_json
            end

            def create 
                airline = Airline.new(airline_params)

                if airline.save 
                    render json: AirlineSerializer.new(airline).serialized_json
                else 
                    render json: {error: airline.errors.messages}, status: 422 # 422 is the status code for unprocessable entity
                end
            end

            def update 
                airline = Airline.find_by(slug: params[:slug])

                if airline.update(airline_params)
                    render json: AirlineSerializer.new(airline, options).serialized_json
                else 
                    render json: {error: airline.errors.messages}, status: 422
                end
            end

            def destroy
                airline = Airline.find_by(slug: params[:slug])

                if airline.destroy
                    head :no_content
                else 
                    render json: {error: airline.errors.messages}, status: 422
                end
            end


            private 

            def airline_params 
                params.require(:airline).permit(:name , :image_url)
            end

            def options # this is a method that returns a hash of options that we can pass into our serializer to include the reviews
                @options ||= {include: %i[reviews]} # %i[reviews] is the same as [:reviews]
            end
        end
    end
end