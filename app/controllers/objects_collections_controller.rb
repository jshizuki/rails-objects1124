class ObjectsCollectionsController < ApplicationController
  def new
    @collection = ObjectsCollection.new
  end
end
