class SearchesController < ApplicationController

def index
  result = PlacesService.new("").call
  #@coordinates = result["results"][0]["geometry"]["location"]

  @data = result["places"]
end


def search
end



end
