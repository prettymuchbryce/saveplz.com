class AppController < ApplicationController

	def show
		app = App.where("name = ?", params[:app])[0]

		if app != nil
			json = JSON.parse("{}")
			list = []
			app.collections.each do |collection|
				list.push(collection.name)
			end
			render :json => list
			return
		else
			render :nothing => true, :status => 501 #Not Implemented
			return
		end
	end

	def delete
		#Check if the app exists, and if it doesnt create it.
		app = App.where("name = ?", params[:app])[0]

		if app == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		else
			app.collections.each do |collection|
				collection.records.each do |record|
					record.delete
				end
				collection.delete
			end
			app.delete
			render :nothing => true
			return
		end
	end
end
