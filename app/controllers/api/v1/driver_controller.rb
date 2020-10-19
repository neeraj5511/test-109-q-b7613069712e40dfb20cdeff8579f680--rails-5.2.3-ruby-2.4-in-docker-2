class Api::V1::DriverController < ActionController::Base
	skip_before_action :verify_authenticity_token
	def register
		@driver = Driver.create(driver_params)
		if @driver.save
		response = {status: 201,body: 
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
        		status: "Failure",
        	}
        	return render :json =>  {:status => response[:status], :reason => @driver.errors.full_messages.first}
        end
	end
    
    def sendLocation
        @driver = Driver.find(params[:driver_id])
        @location = Location.create!(location_params.merge(driver_id: @driver.id))
     	if @location.save
      		response = {
        		status: "Success",
        		body: {
        			id: @location.id
        		}
        	}
       		render :show, status: response[:status]
        else
	        response = {
	        		status: "Failure"
	        	}	
	        return render :show, :json =>  {:status => response[:status], :reason => @driver.errors.full_messages.first}
        end
    end

    private

    # def driver
    # 	binding.pry
    #   Driver.find_by!(id: params[:id])
    # end

	def driver_params
		params.require(:driver).permit(:name,:email,:phone_number,:license_number,:car_number)
	end

	def location_params
		params.permit(:latitude, :longitude)
	end
end