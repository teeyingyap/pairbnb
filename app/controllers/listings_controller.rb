class ListingsController < ApplicationController

  def index
  	# @listings = current_user.listings
  	# flash[:error] = "You don't have any listings!" if @listings == []
   if params[:tag]
     @listings = current_user.listings.tagged_with(params[:tag])
   else
     @listings = current_user.listings
     flash[:error] = "You don't have any listings!" if @listings == []
   end
end





  def new
    @listing = Listing.new  #initialize an empty object for the form, so that we can fill in with details using the form.
    render template: "listings/new"
  end

  def create
   @listing = Listing.new(listing_from_params)
   @listing.user_id = current_user.id if current_user

     if @listing.save
       redirect_to @listing
     else
        render 'new'
     end
  end

   def show
    @listing = Listing.find(params[:id])
  end


  def listing_from_params
    params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :tag_list)
  end


end