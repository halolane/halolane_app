require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe LikememoriesController do

  # This should return the minimal set of attributes required to create a valid
  # Likememory. As you add validations to Likememory, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LikememoriesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all likememories as @likememories" do
      likememory = Likememory.create! valid_attributes
      get :index, {}, valid_session
      assigns(:likememories).should eq([likememory])
    end
  end

  describe "GET show" do
    it "assigns the requested likememory as @likememory" do
      likememory = Likememory.create! valid_attributes
      get :show, {:id => likememory.to_param}, valid_session
      assigns(:likememory).should eq(likememory)
    end
  end

  describe "GET new" do
    it "assigns a new likememory as @likememory" do
      get :new, {}, valid_session
      assigns(:likememory).should be_a_new(Likememory)
    end
  end

  describe "GET edit" do
    it "assigns the requested likememory as @likememory" do
      likememory = Likememory.create! valid_attributes
      get :edit, {:id => likememory.to_param}, valid_session
      assigns(:likememory).should eq(likememory)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Likememory" do
        expect {
          post :create, {:likememory => valid_attributes}, valid_session
        }.to change(Likememory, :count).by(1)
      end

      it "assigns a newly created likememory as @likememory" do
        post :create, {:likememory => valid_attributes}, valid_session
        assigns(:likememory).should be_a(Likememory)
        assigns(:likememory).should be_persisted
      end

      it "redirects to the created likememory" do
        post :create, {:likememory => valid_attributes}, valid_session
        response.should redirect_to(Likememory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved likememory as @likememory" do
        # Trigger the behavior that occurs when invalid params are submitted
        Likememory.any_instance.stub(:save).and_return(false)
        post :create, {:likememory => {}}, valid_session
        assigns(:likememory).should be_a_new(Likememory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Likememory.any_instance.stub(:save).and_return(false)
        post :create, {:likememory => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested likememory" do
        likememory = Likememory.create! valid_attributes
        # Assuming there are no other likememories in the database, this
        # specifies that the Likememory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Likememory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => likememory.to_param, :likememory => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested likememory as @likememory" do
        likememory = Likememory.create! valid_attributes
        put :update, {:id => likememory.to_param, :likememory => valid_attributes}, valid_session
        assigns(:likememory).should eq(likememory)
      end

      it "redirects to the likememory" do
        likememory = Likememory.create! valid_attributes
        put :update, {:id => likememory.to_param, :likememory => valid_attributes}, valid_session
        response.should redirect_to(likememory)
      end
    end

    describe "with invalid params" do
      it "assigns the likememory as @likememory" do
        likememory = Likememory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Likememory.any_instance.stub(:save).and_return(false)
        put :update, {:id => likememory.to_param, :likememory => {}}, valid_session
        assigns(:likememory).should eq(likememory)
      end

      it "re-renders the 'edit' template" do
        likememory = Likememory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Likememory.any_instance.stub(:save).and_return(false)
        put :update, {:id => likememory.to_param, :likememory => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested likememory" do
      likememory = Likememory.create! valid_attributes
      expect {
        delete :destroy, {:id => likememory.to_param}, valid_session
      }.to change(Likememory, :count).by(-1)
    end

    it "redirects to the likememories list" do
      likememory = Likememory.create! valid_attributes
      delete :destroy, {:id => likememory.to_param}, valid_session
      response.should redirect_to(likememories_url)
    end
  end

end
