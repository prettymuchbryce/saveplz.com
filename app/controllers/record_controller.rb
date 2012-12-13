class RecordController < ApplicationController
	def show
		#Check if the app exists, and if it doesnt create it.
		app = App.where("name = ?", params[:app])[0]

		if app == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		end

		collection = Collection.where("name = ? AND app_id = ?", params[:collection], app.id)[0]

		if collection == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		end

		record = Record.where("record_id = ? AND collection_id = ?",params[:record],collection.id)[0]

		if record == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		else
			json = JSON.parse(record.data)
			json["id"] = record.record_id
			render :json => json
			return
		end
	end

	def delete
		#Check if the app exists, and if it doesnt create it.
		app = App.where("name = ?", params[:app])[0]

		if app == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		end

		collection = Collection.where("name = ? AND app_id = ?", params[:collection], app.id)[0]

		if collection == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		end

		record = Record.where("record_id = ? AND collection_id = ?",params[:record],collection.id)[0]

		if record == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		else
			record.delete
			if collection.records.length == 0
				collection.delete
			end
			if app.collections.length == 0
				app.delete
			end
			render :nothing => true
			return
		end
	end
end
