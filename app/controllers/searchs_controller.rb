class SearchsController < ApplicationController
     
     def search
		@model = params[:range]
		@content = params[:word]
		@method = params[:search]
		if @model == '1'
			@user = User.search_for(@content, @method)
		else
			@book = Book.search_for(@content, @method)
		end
	end

     
end     