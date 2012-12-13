class CollectionController < ApplicationController
	def show
		app = App.where("name = ?", params[:app])[0]

		if app == nil
			render :nothing => true, :status => 501 #Not Implemented
			return
		end

		collection = Collection.where("name = ? AND app_id = ?", params[:collection], app.id)[0]

		if collection == nil
			render :nothing => true, :status => 501 #Not Implemented
		else
			json = JSON.parse("{}")
			list = []
			#collection["collection"] = params[:collection]
			collection.records.each do |record|
				data = JSON.parse(record.data)
				data["id"] = record.record_id
				list.push(data)
			end

			json[collection.name] = list

			render :json => json
		end
	end

	def create
		#Handle case of no data
		if params.length == 0
	      render :nothing => true, :status => 400 #Bad request
	      return
		end

		#Check if the app exists, and if it doesnt create it.
		app = App.where("name = ?", params[:app])[0]

		if app == nil
			app = App.new
			app.name = params[:app]
			app.save
		end

		#Check if the collection exists, and if it doesn't create it.
		collection = Collection.where("app_id = ? AND name = ?",app.id,params[:collection])[0]

		if collection == nil
			collection = Collection.new
			collection.name = params[:collection]
			collection.app = app
			collection.save
		end

		json = JSON.parse("{}")

		params.each do |key, value|
			if key != "collection" && key != "id" && key != "app" && key != "controller" && key != "action"
				json[key] = value
			end
		end

		record = Record.new
		record.data = json.to_json
		record.collection = collection
		record.record_id = collection.current_id
		collection.current_id+=1
		collection.save
		record.save

		render :json => collection.current_id-1
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
		else
			collection.records.each do |record|
				record.delete
			end
			collection.delete

			if app.collections.length == 0
				app.delete
			end

			render :nothing => true
			return
		end
	end
end