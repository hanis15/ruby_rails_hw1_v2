class TagStringsController < ApplicationController
  def index
    @tags = TagString.all
  end
end
