class Api::V1::DriverController < ActionController::Base
	skip_before_action :verify_authenticity_token
	def register
		@driver = Driver.new(driver_params)
		if @driver.save
		response = {
            status: 201,
            body: 
            {
               id: @driver.id,
               name: @driver.name,
               email: @driver.email,
               phone_number: @driver.phone_number,
               license_number: @driver.license_number,
               car_number: @driver.car_number
            }
		}
        render status: response[:status], json: response[:body]
        else 
            
        	response = {
        		status: "failure",
        	}
        	render status: 400 ,:json =>  {:status => response[:status], :reason => @driver.errors.full_messages}
        end
	end
    
    def sendLocation
        @location = Location.new(location_params.merge(driver_id: driver.id))
     	if @location.save
      		response = {
        		body: {
        		    status: "success"
        		}
        	}
            respond_to do |format|
                format.json { render status: 202, json: response[:body] }
            end
        else
	        response = {
                body: {
	        		status: "failure",
                    reason:  @location.errors.full_messages
                }
	        }	
            respond_to do |format|
                format.json { render status: 400,json: response[:body] }
            end
        end
    end

    private

    def driver
      @driver = Driver.find(params[:driver_id])
    end

	def driver_params
		params.require(:driver).permit(:name,:email,:phone_number,:license_number,:car_number)
	end

	def location_params
		params.permit(:latitude, :longitude)
	end
end