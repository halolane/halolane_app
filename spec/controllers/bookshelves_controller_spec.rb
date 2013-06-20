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

describe BookshelvesController do

  # This should return the minimal set of attributes required to create a valid
  # Bookshelf. As you add validations to Bookshelf, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BookshelvesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all bookshelves as @bookshelves" do
      bookshelf = Bookshelf.create! valid_attributes
      get :index, {}, valid_session
      assigns(:bookshelves).should eq([bookshelf])
    end
  end

  describe "GET show" do
    it "assigns the requested bookshelf as @bookshelf" do
      bookshelf = Bookshelf.create! valid_attributes
      get :show, {:id => bookshelf.to_param}, valid_session
      assigns(:bookshelf).should eq(bookshelf)
    end
  end

  describe "GET new" do
    it "assigns a new bookshelf as @bookshelf" do
      get :new, {}, valid_session
      assigns(:bookshelf).should be_a_new(Bookshelf)
    end
  end

  describe "GET edit" do
    it "assigns the requested bookshelf as @bookshelf" do
      bookshelf = Bookshelf.create! valid_attributes
      get :edit, {:id => bookshelf.to_param}, valid_session
      assigns(:bookshelf).should eq(bookshelf)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bookshelf" do
        expect {
          post :create, {:bookshelf => valid_attributes}, valid_session
        }.to change(Bookshelf, :count).by(1)
      end

      it "assigns a newly created bookshelf as @bookshelf" do
        post :create, {:bookshelf => valid_attributes}, valid_session
        assigns(:bookshelf).should be_a(Bookshelf)
        assigns(:bookshelf).should be_persisted
      end

      it "redirects to the created bookshelf" do
        post :create, {:bookshelf => valid_attributes}, valid_session
        response.should redirect_to(Bookshelf.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bookshelf as @bookshelf" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bookshelf.any_instance.stub(:save).and_return(false)
        post :create, {:bookshelf => {}}, valid_session
        assigns(:bookshelf).should be_a_new(Bookshelf)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bookshelf.any_instance.stub(:save).and_return(false)
        post :create, {:bookshelf => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bookshelf" do
        bookshelf = Bookshelf.create! valid_attributes
        # Assuming there are no other bookshelves in the database, this
        # specifies that the Bookshelf created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Bookshelf.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => bookshelf.to_param, :bookshelf => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested bookshelf as @bookshelf" do
        bookshelf = Bookshelf.create! valid_attributes
        put :update, {:id => bookshelf.to_param, :bookshelf => valid_attributes}, valid_session
        assigns(:bookshelf).should eq(bookshelf)
      end

      it "redirects to the bookshelf" do
        bookshelf = Bookshelf.create! valid_attributes
        put :update, {:id => bookshelf.to_param, :bookshelf => valid_attributes}, valid_session
        response.should redirect_to(bookshelf)
      end
    end

    describe "with invalid params" do
      it "assigns the bookshelf as @bookshelf" do
        bookshelf = Bookshelf.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Bookshelf.any_instance.stub(:save).and_return(false)
        put :update, {:id => bookshelf.to_param, :bookshelf => {}}, valid_session
        assigns(:bookshelf).should eq(bookshelf)
      end

      it "re-renders the 'edit' template" do
        bookshelf = Bookshelf.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Bookshelf.any_instance.stub(:save).and_return(false)
        put :update, {:id => bookshelf.to_param, :bookshelf => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bookshelf" do
      bookshelf = Bookshelf.create! valid_attributes
      expect {
        delete :destroy, {:id => bookshelf.to_param}, valid_session
      }.to change(Bookshelf, :count).by(-1)
    end

    it "redirects to the bookshelves list" do
      bookshelf = Bookshelf.create! valid_attributes
      delete :destroy, {:id => bookshelf.to_param}, valid_session
      response.should redirect_to(bookshelves_url)
    end
  end

end
