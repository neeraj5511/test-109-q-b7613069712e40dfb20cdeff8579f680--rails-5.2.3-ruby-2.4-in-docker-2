class Api::V1::PassengerController < ActionController::Base
  skip_before_action :verify_authenticity_token
	def available_cab
		resp = []
		@location = Location.includes(:driver)
		if params.values_at(:latitude, :longitude).all?(&:present?)
			@location.each do |location| 
			  resp.push(location.driver) if haversine_distance([params[:latitude],params[:longitude]],[location.latitude,location.longitude]) <= 4
		  end
		end
	  list_of_cab = resp.map do |response|
	  	{
	  		name: response.name,
	  		phone_number: response.phone_number,
	  		car_number: response.car_number
	  	}
	  end
	  if list_of_cab.present?
		  render status: 200 ,:json =>  {:available_cab => list_of_cab}
	  elsif
	  	render status: 200 ,:json =>  {:message => "No cabs available!"}
	  else
	  	response = {
        status: "failure",
      }
	  	render status: 400 ,:json =>  {:status => response[:status], :reason => resp.errors.full_messages}
	  end
	end

	private 
	def haversine_distance(geo_a,geo_b)
		lat1, lon1 = geo_a
    lat2, lon2 = geo_b
    dLat = (lat2 - lat1) * Math::PI / 180
    dLon = (lon2 - lon1) * Math::PI / 180
    a = Math.sin(dLat / 2) * 
	      Math.sin(dLat / 2) +
	      Math.cos(lat1 * Math::PI / 180) * 
	      Math.cos(lat2 * Math::PI / 180) *
	      Math.sin(dLon / 2) * Math.sin(dLon / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = 6371 * c * 1
	end
end