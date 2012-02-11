require 'spec_helper'

describe PostsController do

  describe "GET 'ajax_add'" do
    it "returns http success" do
      get 'ajax_add'
      response.should be_success
    end
  end

end
